+++
title = "The Chef way of Azure configuration management"
description = "Configure Azure Linux VMs and scale sets with Chef Infra: install Chef Infra Client with cloud-init, read the license key from Key Vault with a managed identity, deliver a locked Policyfile from Blob Storage, and use instance metadata in recipes."
draft = false
gh_repo = "chef-web-docs"

[menu.overview]
  identifier = "overview/solutions/infra_management/azure"
  parent = "overview/solutions/infra_management"
  title = "Azure configuration management"
  weight = 20
+++

Azure virtual machine scale sets add and replace VMs on their own, and each new VM needs the same packages, settings, and access as the rest of the fleet.
Baking every change into a new image is slow, and changes made by hand or with one-off Run Command scripts don't reach the next VM the scale set creates.

With Chef Infra, each VM configures itself when it's created.
Cloud-init runs a script from the VM's custom data that installs Chef Infra Client, downloads a locked Policyfile from Blob Storage, and converges the VM.
A managed identity lets the script read your Chef license key from Key Vault without storing credentials on the VM.
Recipes read the VM's location, resource group, size, and tags through Ohai, and a systemd timer reruns the policy to correct drift.

## How Chef Infra fits on Azure

| Need | Azure service | Chef Infra role |
| --- | --- | --- |
| Run setup at first boot | [Custom data and cloud-init](https://learn.microsoft.com/azure/virtual-machines/custom-data) | Install Chef Infra Client and run the policy |
| Authenticate the VM | [Managed identities](https://learn.microsoft.com/entra/identity/managed-identities-azure-resources/overview) | Get tokens for Key Vault and Blob Storage without stored secrets |
| Store the license key | [Key Vault](https://learn.microsoft.com/azure/key-vault/general/overview) | The script reads the key at install time |
| Deliver cookbooks | [Blob Storage](https://learn.microsoft.com/azure/storage/blobs/storage-blobs-introduction) | Holds the `chef export` archive of a locked Policyfile |
| Describe the VM | [Instance Metadata Service (IMDS)](https://learn.microsoft.com/azure/virtual-machines/instance-metadata-service) | Ohai exposes it to recipes as `node['azure']` |
| Scale and replace VMs | [Virtual machine scale sets](https://learn.microsoft.com/azure/virtual-machine-scale-sets/overview) | Every VM the scale set creates runs the same custom data |

This page uses local mode: each VM runs the exported policy without a server.
If you manage nodes from [Chef 360 Platform DSM](/360/latest/understand/dsm/) or [Chef Infra Server](/server/),
see [Use client-server mode instead](#use-client-server-mode-instead).

## What you'll build

You'll create an `azure_base` cookbook with a baseline recipe and an `azure` recipe, then:

- Publish the locked policy to a Blob Storage container, with one path for each policy group.
- Store your Chef license key in Key Vault.
- Create a user-assigned managed identity that can read only that secret and that container.
- Write a cloud-init file that installs Chef Infra Client 19 and converges the VM.
- Create a test VM, then a scale set that uses the same cloud-init file.

## Before you begin

You need:

- [Chef Workstation](/workstation/latest/) 26 or later, which includes Test Kitchen and Chef InSpec.
- A [Chef license key](/licensing/license_key/).
- Docker or Podman on your workstation, for the Test Kitchen Dokken driver.
- An Azure subscription and the [Azure CLI](https://learn.microsoft.com/cli/azure/install-azure-cli), signed in with permission to create resource groups, Key Vaults, storage accounts, managed identities, role assignments, and VMs.
- The **Key Vault Secrets Officer** and **Storage Blob Data Contributor** roles for your own account, so you can write the secret and upload the policy.

The commands use these placeholders:

- `<LOCATION>`: The Azure region, for example `eastus`.
- `<VAULT>`: A globally unique Key Vault name.
- `<ACCOUNT>`: A globally unique storage account name.
- `<CHEF_VERSION>`: The Chef Infra Client 19 version to install.

## Create the cookbook

Start with a cookbook that holds the baseline every VM needs.
The example recipe sets a time zone, installs packages, and sets a kernel parameter; replace it with your own settings.

1. Generate a cookbook.
   Chef Workstation creates a Policyfile and a Test Kitchen configuration with it:

   ```shell
   chef generate cookbook azure_base
   cd azure_base
   ```

1. Replace `recipes/default.rb` with a baseline recipe:

   ```ruby
   timezone 'UTC'

   package %w(curl jq)

   sysctl 'vm.swappiness' do
     value 10
   end
   ```

1. Replace `test/integration/default/default_test.rb` with tests for the baseline:

   ```ruby
   describe package('jq') do
     it { should be_installed }
   end

   describe kernel_parameter('vm.swappiness') do
     its('value') { should eq 10 }
   end
   ```

1. Replace `kitchen.yml` with the following, so Test Kitchen converges the cookbook in an Ubuntu 24.04 container.
   For Chef Infra Client 19, Chef Test Kitchen Enterprise supports the [Dokken driver](/workstation/latest/tools/kitchen/run/).

   ```yaml
   ---
   driver:
     name: dokken
     privileged: true
     chef_version: <CHEF_VERSION>

   provisioner:
     name: dokken

   transport:
     name: dokken

   verifier:
     name: inspec

   platforms:
     - name: ubuntu-24.04
       driver:
         image: dokken/ubuntu-24.04
         pid_one_command: /bin/systemd

   suites:
     - name: default
       verifier:
         inspec_tests:
           - test/integration/default
   ```

## Add an Azure recipe

Ohai's Azure plugin detects Azure from the VM agent and reads IMDS.
It stores the compute metadata in `node['azure']['metadata']['compute']`, including `location`, `resourceGroupName`, `vmSize`, and `tagsList`.

1. In the `azure_base` cookbook, create `recipes/azure.rb`:

   ```ruby
   # Skip on systems that aren't Azure VMs, such as Test Kitchen containers.
   return unless node.dig('azure', 'metadata', 'compute')

   compute = node['azure']['metadata']['compute']
   tier_tag = (compute['tagsList'] || []).find { |tag| tag['name'] == 'app-tier' }
   tier = tier_tag ? tier_tag['value'] : 'unassigned'

   file '/etc/motd' do
     content <<~MOTD
       Managed by Chef Infra
       Resource group: #{compute['resourceGroupName']}
       Location:       #{compute['location']}
       Size:           #{compute['vmSize']}
       Tier:           #{tier}
     MOTD
     mode '0644'
   end

   systemd_unit 'chef-converge.service' do
     content <<~UNIT
       [Unit]
       Description=Reapply the Chef Infra policy

       [Service]
       Type=oneshot
       ExecStart=/usr/local/sbin/chef-converge
     UNIT
     action :create
   end

   systemd_unit 'chef-converge.timer' do
     content <<~UNIT
       [Unit]
       Description=Reapply the Chef Infra policy every 30 minutes

       [Timer]
       OnBootSec=30min
       OnUnitActiveSec=30min
       RandomizedDelaySec=5min

       [Install]
       WantedBy=timers.target
     UNIT
     action [:create, :enable, :start]
   end
   ```

   Azure runs custom data only on the first boot, so the timer calls the script that cloud-init installs.
   Each run downloads the latest archive for the VM's policy group and corrects drift.

1. Add the recipe to the run-list in `Policyfile.rb`:

   ```ruby
   run_list 'azure_base::default', 'azure_base::azure'
   ```

1. Lint the cookbook, then converge and verify it:

   ```shell
   cookstyle .
   kitchen test
   ```

   The `azure` recipe returns early in the container, so Test Kitchen checks the baseline.
   Test the `azure` recipe itself on an Azure VM, as described in [Create a test VM](#create-a-test-vm).

## Create the Azure resources

Create the resource group, Key Vault, storage account, and managed identity that the VMs use.

1. Create a resource group and a Key Vault that uses Azure RBAC, then store the license key:

   ```shell
   az group create --name chef-demo --location <LOCATION>

   az keyvault create --name <VAULT> --resource-group chef-demo \
     --location <LOCATION> --enable-rbac-authorization true

   az keyvault secret set --vault-name <VAULT> \
     --name chef-license-key --value '<LICENSE_KEY>'
   ```

1. Create a storage account and a private container for policy archives:

   ```shell
   az storage account create --name <ACCOUNT> --resource-group chef-demo \
     --location <LOCATION> --sku Standard_LRS --allow-blob-public-access false

   az storage container create --account-name <ACCOUNT> \
     --name chef-policies --auth-mode login
   ```

1. Create a user-assigned managed identity and grant it read access to the secret store and the storage account:

   ```shell
   az identity create --name chef-node --resource-group chef-demo

   PRINCIPAL_ID=$(az identity show -n chef-node -g chef-demo --query principalId -o tsv)

   az role assignment create --assignee-object-id "$PRINCIPAL_ID" \
     --assignee-principal-type ServicePrincipal --role "Key Vault Secrets User" \
     --scope "$(az keyvault show -n <VAULT> --query id -o tsv)"

   az role assignment create --assignee-object-id "$PRINCIPAL_ID" \
     --assignee-principal-type ServicePrincipal --role "Storage Blob Data Reader" \
     --scope "$(az storage account show -n <ACCOUNT> --query id -o tsv)"
   ```

   A user-assigned identity exists before any VM does, so its role assignments are in place when cloud-init runs.
   Role assignments can take several minutes to take effect.

1. Note the identity's client ID and resource ID for the next steps:

   ```shell
   az identity show -n chef-node -g chef-demo --query '{clientId:clientId, id:id}' -o table
   ```

## Publish the policy to Blob Storage

`chef export` writes a locked policy and all its cookbooks to a directory that Chef Infra Client can run in local mode.
Package that directory and upload it to a path for the policy group:

```shell
chef install
chef export Policyfile.rb ./export --force
tar -czf azure_base.tgz -C export .
az storage blob upload --account-name <ACCOUNT> --container-name chef-policies \
  --name staging/azure_base.tgz --file azure_base.tgz --auth-mode login --overwrite
```

When a change is ready for production, upload the same archive as `production/azure_base.tgz`.
Run these commands from your CI pipeline so that only reviewed and tested policies reach the container.

## Write the cloud-init file

Save the following as `cloud-init.yaml`.
Replace `<CLIENT_ID>` with the managed identity's client ID, and `<POLICY_GROUP>` with `staging` or `production`.

```yaml
#cloud-config
write_files:
  - path: /usr/local/sbin/chef-converge
    permissions: '0755'
    content: |
      #!/bin/bash
      # Installs Chef Infra Client 19 if needed, then converges the VM with the exported policy.
      set -euo pipefail

      CHEF_VERSION="<CHEF_VERSION>"
      CLIENT_ID="<CLIENT_ID>"
      POLICY_URL="https://<ACCOUNT>.blob.core.windows.net/chef-policies/<POLICY_GROUP>/azure_base.tgz"
      POLICY_DIR=/var/chef/policy

      # Get an access token for the managed identity from IMDS.
      token() {
        curl -fsS -H Metadata:true \
          "http://169.254.169.254/metadata/identity/oauth2/token?api-version=2018-02-01&client_id=${CLIENT_ID}&resource=$1" |
          python3 -c 'import json,sys; print(json.load(sys.stdin)["access_token"])'
      }

      if ! command -v chef-client >/dev/null 2>&1; then
        CHEF_LICENSE_KEY="$(curl -fsS -H "Authorization: Bearer $(token https%3A%2F%2Fvault.azure.net)" \
          "https://<VAULT>.vault.azure.net/secrets/chef-license-key?api-version=7.4" |
          python3 -c 'import json,sys; print(json.load(sys.stdin)["value"])')"
        export CHEF_LICENSE_KEY
        if command -v dpkg >/dev/null 2>&1; then pm=deb; else pm=rpm; fi
        pkg="/tmp/chef-ice.${pm}"
        curl -fsSL -o "${pkg}" \
          "https://chefdownload-commercial.chef.io/stable/chef-ice/download?eol=false&license_id=${CHEF_LICENSE_KEY}&m=$(uname -m)&p=linux&pm=${pm}&v=${CHEF_VERSION}"
        if [ "${pm}" = deb ]; then dpkg -i "${pkg}"; else dnf install -y "${pkg}"; fi
      fi

      curl -fsS -o /tmp/azure_base.tgz \
        -H "Authorization: Bearer $(token https%3A%2F%2Fstorage.azure.com%2F)" \
        -H "x-ms-version: 2020-04-08" "${POLICY_URL}"
      rm -rf "${POLICY_DIR}" && mkdir -p "${POLICY_DIR}"
      tar -xzf /tmp/azure_base.tgz -C "${POLICY_DIR}"
      cd "${POLICY_DIR}"
      chef-client --local-mode --chef-license accept
runcmd:
  - [/usr/local/sbin/chef-converge]
```

The script calls the Key Vault and Blob Storage REST APIs with `curl`, so the VM doesn't need the Azure CLI.
It uses the [Chef Infra Client native installer](/client/latest/install/installer/), which validates the license key when it installs.
It installs Chef Infra Client only once, then reapplies the policy on every run.

Custom data is limited to 64 KB.
Cloud-init writes the script's output to `/var/log/cloud-init-output.log`.

## Create a test VM

1. Create an Ubuntu 24.04 VM with the managed identity, the cloud-init file, and an `app-tier` tag:

   ```shell
   az vm create --resource-group chef-demo --name chef-test-1 \
     --image Ubuntu2404 --size Standard_B2s \
     --assign-identity <IDENTITY_RESOURCE_ID> \
     --custom-data cloud-init.yaml --tags app-tier=web \
     --admin-username azureuser --generate-ssh-keys
   ```

   Replace `<IDENTITY_RESOURCE_ID>` with the managed identity's resource ID.

1. Check the Chef Infra Client output from cloud-init:

   ```shell
   az vm run-command invoke --resource-group chef-demo --name chef-test-1 \
     --command-id RunShellScript --scripts 'tail -n 30 /var/log/cloud-init-output.log'
   ```

   The output ends with a Chef Infra Client run summary.
   When you sign in to the VM, the message of the day shows the resource group, location, size, and tier that Ohai reported.

1. Confirm the drift-correction timer is scheduled:

   ```shell
   az vm run-command invoke --resource-group chef-demo --name chef-test-1 \
     --command-id RunShellScript --scripts 'systemctl list-timers chef-converge.timer'
   ```

## Scale out with a scale set

A scale set passes the same custom data and identity to every VM it creates.
Before you create it, set `<POLICY_GROUP>` in `cloud-init.yaml` to `production`.

- Create a scale set for the production web tier:

  ```shell
  az vmss create --resource-group chef-demo --name chef-web-vmss \
    --image Ubuntu2404 --vm-sku Standard_B2s --instance-count 3 \
    --assign-identity <IDENTITY_RESOURCE_ID> \
    --custom-data cloud-init.yaml --tags app-tier=web \
    --admin-username azureuser --generate-ssh-keys
  ```

To change configuration, upload a new archive to the group's policy path.
Running VMs apply it on their next timer run, and new VMs apply it at first boot.
To change the cloud-init file itself, update the scale set model, then upgrade its instances to the latest model.

## Use client-server mode instead

Local mode keeps the cloud setup small, but there's no central record of each node.
To report every run to Chef Automate or manage policies centrally, have nodes download their policy from a server:

- **Chef 360 Platform**: Enroll each VM and store the policy in DSM.
  See [Enroll nodes with a Chef Infra cookbook](/360/latest/use/operators/node_enrollment/cookbook/).
- **Chef Infra Server**: Push the policy with `chef push`, then bootstrap each VM into a policy group with `knife bootstrap`.
  See [Bootstrap a node with Chef Infra](/client/latest/install/bootstrap/).
  Chef Infra Server reaches end of life in November 2026, so plan new deployments on Chef 360 Platform.
- **Azure Chef VM extension**: Registers VMs with Chef Infra Server from ARM templates, Bicep, or the Azure CLI.
  Pass your license key in the extension's protected settings.
  See [Chef VM extension for Linux and Windows](https://learn.microsoft.com/azure/virtual-machines/extensions/chef).

In any mode, the `azure` recipe and the Key Vault pattern still apply.
To send local-mode run data to Chef Automate, see [Data collection](/automate/data_collection/).

## Plan for production

- Build the archive in CI, and promote the same archive from the `staging` path to the `production` path.
- Grant each managed identity access only to the vault and storage account its VMs need.
- Use tags, not hardcoded hostnames, to choose per-group settings in recipes.
- Reapply policy on a schedule, as the timer does, so a manual change on a VM doesn't persist.
- For Windows VMs, install Chef Infra Client from the MSI installer with a Custom Script Extension or the Chef VM extension.

## Related resources

- [Chef Infrastructure Management overview](/solutions/infra_management/)
- [Ohai](/client/latest/features/ohai/)
- [Policyfiles](/client/latest/policy/policyfile/)
- [Azure: Custom data and cloud-init on Azure VMs](https://learn.microsoft.com/azure/virtual-machines/custom-data)
