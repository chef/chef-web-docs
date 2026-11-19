+++
title = "The Chef way of GCP configuration management"
description = "Configure Compute Engine VMs with Chef Infra: install Chef Infra Client from a startup script, deliver a locked Policyfile from Cloud Storage, use instance metadata in recipes, and scale out with managed instance groups."
draft = false
gh_repo = "chef-web-docs"

[menu.overview]
  identifier = "overview/solutions/infra_management/gcp"
  parent = "overview/solutions/infra_management"
  title = "GCP configuration management"
  weight = 10
+++

Compute Engine creates VMs in seconds, but an image only captures the configuration it had when you built it.
Managed instance groups replace and add VMs on their own, and every VM needs the same packages, settings, and access the moment it starts serving.
Rebuilding images for every configuration change is slow, and changes made over SSH don't reach the next VM the group creates.

With Chef Infra, each VM configures itself at boot.
A Compute Engine startup script installs Chef Infra Client, downloads a locked Policyfile from Cloud Storage, and converges the VM.
Recipes read the VM's project, zone, and custom metadata through Ohai, so one cookbook adapts to each instance group.
A systemd timer reruns the policy so VMs stay in their configured state between reboots.

## How Chef Infra fits on Google Cloud

| Need | Google Cloud service | Chef Infra role |
| --- | --- | --- |
| Run setup at boot | [Startup scripts](https://cloud.google.com/compute/docs/instances/startup-scripts/linux) | Install Chef Infra Client and run the policy |
| Store the license key | [Secret Manager](https://cloud.google.com/secret-manager/docs/overview) | The startup script reads the key with the VM's service account |
| Deliver cookbooks | [Cloud Storage](https://cloud.google.com/storage/docs) | Holds the `chef export` archive of a locked Policyfile |
| Describe the VM | [VM metadata server](https://cloud.google.com/compute/docs/metadata/overview) | Ohai exposes it to recipes as `node['gce']` |
| Scale and replace VMs | [Instance templates and managed instance groups](https://cloud.google.com/compute/docs/instance-groups) | Every VM the group creates runs the same startup script |

This page uses local mode: each VM runs the exported policy without a server.
If you manage nodes from [Chef 360 Platform DSM](/360/latest/understand/dsm/) or [Chef Infra Server](/server/),
see [Use client-server mode instead](#use-client-server-mode-instead).

## What you'll build

You'll create a `gcp_base` cookbook with a baseline recipe and a `gcp` recipe, then:

- Publish the locked policy to a Cloud Storage bucket, with one path for each policy group.
- Store your Chef license key in Secret Manager.
- Create a service account that can read only that secret and that bucket.
- Write a startup script that installs Chef Infra Client 19 and converges the VM.
- Create a test VM, then a managed instance group that uses the same startup script.

## Before you begin

You need:

- [Chef Workstation](/workstation/latest/) 26 or later, which includes Test Kitchen and Chef InSpec.
- A [Chef license key](/licensing/license_key/).
- Docker or Podman on your workstation, for the Test Kitchen Dokken driver.
- A Google Cloud project with billing enabled and the Compute Engine and Secret Manager APIs turned on.
- The [Google Cloud CLI](https://cloud.google.com/sdk/docs/install), signed in with permission to create buckets, secrets, service accounts, IAM bindings, and VMs.

The commands use these placeholders:

- `<PROJECT_ID>`: Your Google Cloud project ID.
- `<REGION>` and `<ZONE>`: The region and zone for your resources, for example `us-central1` and `us-central1-a`.
- `<BUCKET>`: A globally unique Cloud Storage bucket name.
- `<CHEF_VERSION>`: The Chef Infra Client 19 version to install.

## Create the cookbook

Start with a cookbook that holds the baseline every VM needs.
The example recipe sets a time zone, installs packages, and sets a kernel parameter; replace it with your own settings.

1. Generate a cookbook.
   Chef Workstation creates a Policyfile and a Test Kitchen configuration with it:

   ```shell
   chef generate cookbook gcp_base
   cd gcp_base
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

## Add a GCP recipe

Ohai's GCE plugin reads the VM metadata server and stores the result in `node['gce']`.
The `instance` key holds VM data such as `zone`, `machineType`, and the custom metadata in `attributes`.
The `project` key holds `projectId`.
Compute Engine reports zone and machine type as resource paths, so the recipe keeps only the last segment.

1. In the `gcp_base` cookbook, create `recipes/gcp.rb`:

   ```ruby
   # Skip on systems that aren't Compute Engine VMs, such as Test Kitchen containers.
   return unless node['gce']

   instance = node['gce']['instance']
   zone = instance['zone'].split('/').last
   tier = instance['attributes']['app-tier'] || 'unassigned'

   file '/etc/motd' do
     content <<~MOTD
       Managed by Chef Infra
       Project: #{node['gce']['project']['projectId']}
       Zone:    #{zone}
       Tier:    #{tier}
     MOTD
     mode '0644'
   end

   systemd_unit 'chef-converge.service' do
     content <<~UNIT
       [Unit]
       Description=Reapply the Chef Infra policy from the startup script

       [Service]
       Type=oneshot
       ExecStart=/usr/bin/google_metadata_script_runner startup
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

   The timer reruns the startup script, so each run downloads the latest archive for the VM's policy group and corrects drift.
   Read the VM's role from custom metadata, such as `app-tier`, rather than from labels: the metadata server exposes custom metadata, but not labels.

1. Add the recipe to the run-list in `Policyfile.rb`:

   ```ruby
   run_list 'gcp_base::default', 'gcp_base::gcp'
   ```

1. Lint the cookbook, then converge and verify it:

   ```shell
   cookstyle .
   kitchen test
   ```

   The `gcp` recipe returns early in the container, so Test Kitchen checks the baseline.
   Test the `gcp` recipe itself on a Compute Engine VM, as described in [Create a test VM](#create-a-test-vm).

## Publish the policy to Cloud Storage

`chef export` writes a locked policy and all its cookbooks to a directory that Chef Infra Client can run in local mode.
Package that directory and upload it to a path for the policy group.

1. Create the bucket:

   ```shell
   gcloud storage buckets create gs://<BUCKET> \
     --location=<REGION> --uniform-bucket-level-access
   ```

1. Lock the policy, export it, and upload it to the `staging` path:

   ```shell
   chef install
   chef export Policyfile.rb ./export --force
   tar -czf gcp_base.tgz -C export .
   gcloud storage cp gcp_base.tgz gs://<BUCKET>/staging/gcp_base.tgz
   ```

When a change is ready for production, upload the same archive to `gs://<BUCKET>/production/gcp_base.tgz`.
Run these commands from your CI pipeline so that only reviewed and tested policies reach the bucket.

## Grant VMs access to the license key and policy

Create a dedicated service account for Chef-managed VMs instead of using the Compute Engine default service account.
Grant it read access to the one secret and the one bucket it needs.

1. Store the Chef license key in Secret Manager:

   ```shell
   printf '%s' '<LICENSE_KEY>' | gcloud secrets create chef-license-key --data-file=-
   ```

1. Create the service account:

   ```shell
   gcloud iam service-accounts create chef-node --display-name="Chef-managed VMs"
   ```

1. Grant the service account access to the secret and the bucket:

   ```shell
   SA=chef-node@<PROJECT_ID>.iam.gserviceaccount.com

   gcloud secrets add-iam-policy-binding chef-license-key \
     --member="serviceAccount:${SA}" --role=roles/secretmanager.secretAccessor

   gcloud storage buckets add-iam-policy-binding gs://<BUCKET> \
     --member="serviceAccount:${SA}" --role=roles/storage.objectViewer
   ```

## Write the startup script

Save the following script as `chef-converge.sh`.
It reads the policy location from the VM's `chef-policy-uri` metadata value, so one script serves every policy group.

```shell
#!/bin/bash
# Installs Chef Infra Client 19 if needed, then converges the VM with the exported policy.
set -euo pipefail

CHEF_VERSION="<CHEF_VERSION>"
POLICY_DIR=/var/chef/policy
MD=http://metadata.google.internal/computeMetadata/v1/instance/attributes
POLICY_URI="$(curl -fsS -H 'Metadata-Flavor: Google' "${MD}/chef-policy-uri")"

if ! command -v chef-client >/dev/null 2>&1; then
  CHEF_LICENSE_KEY="$(gcloud secrets versions access latest --secret=chef-license-key)"
  export CHEF_LICENSE_KEY
  if command -v dpkg >/dev/null 2>&1; then pm=deb; else pm=rpm; fi
  pkg="/tmp/chef-ice.${pm}"
  curl -fsSL -o "${pkg}" \
    "https://chefdownload-commercial.chef.io/stable/chef-ice/download?eol=false&license_id=${CHEF_LICENSE_KEY}&m=$(uname -m)&p=linux&pm=${pm}&v=${CHEF_VERSION}"
  if [ "${pm}" = deb ]; then dpkg -i "${pkg}"; else dnf install -y "${pkg}"; fi
fi

gcloud storage cp "${POLICY_URI}" /tmp/gcp_base.tgz
rm -rf "${POLICY_DIR}" && mkdir -p "${POLICY_DIR}"
tar -xzf /tmp/gcp_base.tgz -C "${POLICY_DIR}"
cd "${POLICY_DIR}"
chef-client --local-mode --chef-license accept
```

The script uses the [Chef Infra Client native installer](/client/latest/install/installer/), which validates the license key when it installs.
It installs Chef Infra Client only once, then reapplies the policy on every run.
Google-provided Ubuntu, Debian, and RHEL images include the Google Cloud CLI that the script uses.
If you build your own images, install the CLI in the image.

Compute Engine runs the script as root during every boot.
To inspect or rerun it on a VM, use `sudo journalctl -u google-startup-scripts.service` and `sudo google_metadata_script_runner startup`.

## Create a test VM

1. Create an Ubuntu 24.04 VM that uses the service account, startup script, and staging policy:

   ```shell
   gcloud compute instances create chef-test-1 \
     --zone=<ZONE> --machine-type=e2-small \
     --image-family=ubuntu-2404-lts-amd64 --image-project=ubuntu-os-cloud \
     --service-account=chef-node@<PROJECT_ID>.iam.gserviceaccount.com --scopes=cloud-platform \
     --metadata=app-tier=web,chef-policy-uri=gs://<BUCKET>/staging/gcp_base.tgz \
     --metadata-from-file=startup-script=chef-converge.sh
   ```

1. After the VM starts, check the Chef Infra Client output from the startup script:

   ```shell
   gcloud compute ssh chef-test-1 --zone=<ZONE> \
     --command='sudo journalctl -u google-startup-scripts.service --no-pager | tail -n 30'
   ```

   The output ends with a Chef Infra Client run summary.
   When you sign in to the VM, the message of the day shows the project, zone, and tier that Ohai reported.

1. Confirm the drift-correction timer is scheduled:

   ```shell
   gcloud compute ssh chef-test-1 --zone=<ZONE> --command='systemctl list-timers chef-converge.timer'
   ```

## Scale out with a managed instance group

An instance template stores the startup script and metadata, so every VM that a managed instance group creates converges the same way.

1. Create an instance template for the production web tier:

   ```shell
   gcloud compute instance-templates create chef-web-template \
     --machine-type=e2-small \
     --image-family=ubuntu-2404-lts-amd64 --image-project=ubuntu-os-cloud \
     --service-account=chef-node@<PROJECT_ID>.iam.gserviceaccount.com --scopes=cloud-platform \
     --metadata=app-tier=web,chef-policy-uri=gs://<BUCKET>/production/gcp_base.tgz \
     --metadata-from-file=startup-script=chef-converge.sh
   ```

1. Create the managed instance group:

   ```shell
   gcloud compute instance-groups managed create chef-web-mig \
     --zone=<ZONE> --template=chef-web-template --size=3
   ```

To change configuration, upload a new archive to the group's policy path.
Running VMs apply it on their next timer run, and new VMs apply it at first boot.
To change the startup script itself, create a new instance template and roll it out with a
[managed instance group update](https://cloud.google.com/compute/docs/instance-groups/updating-migs).

## Use client-server mode instead

Local mode keeps the cloud setup small, but there's no central record of each node.
To report every run to Chef Automate or manage policies centrally, have nodes download their policy from a server:

- **Chef 360 Platform**: Enroll each VM and store the policy in DSM.
  See [Enroll nodes with a Chef Infra cookbook](/360/latest/use/operators/node_enrollment/cookbook/).
- **Chef Infra Server**: Push the policy with `chef push`, then bootstrap each VM into a policy group with `knife bootstrap`.
  See [Bootstrap a node with Chef Infra](/client/latest/install/bootstrap/).
  Chef Infra Server reaches end of life in November 2026, so plan new deployments on Chef 360 Platform.

In either mode, the `gcp` recipe and the Secret Manager pattern still apply.
To send local-mode run data to Chef Automate, see [Data collection](/automate/data_collection/).

## Plan for production

- Build the archive in CI, and promote the same archive from the `staging` path to the `production` path.
- Grant each service account access only to the secret and bucket paths that its VMs need.
- Use the VM's custom metadata, not hardcoded hostnames, to choose per-group settings in recipes.
- Reapply policy on a schedule, as the timer does, so a manual change on a VM doesn't persist.
- For Windows VMs, use a `windows-startup-script-ps1` metadata key and the Chef Infra Client MSI installer.

## Related resources

- [Chef Infrastructure Management overview](/solutions/infra_management/)
- [Ohai](/client/latest/features/ohai/)
- [Policyfiles](/client/latest/policy/policyfile/)
- [Google Cloud: Use startup scripts on Linux VMs](https://cloud.google.com/compute/docs/instances/startup-scripts/linux)
