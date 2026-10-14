+++
title = "knife bootstrap"
draft = false

[menu]
  [menu.workstation_26_2]
    title = "knife bootstrap"
    identifier = "workstation_26_2/tools/knife/reference/knife_bootstrap.md knife bootstrap"
    parent = "workstation_26_2/tools/knife/reference"
+++
<!-- markdownlint-disable-file MD036 MD046-->

Bootstrapping installs Chef Infra Client on a target system and configures it to communicate with a Chef Infra Server.

## Prerequisites

Before bootstrapping nodes:

- [Configure knife](/workstation/26.2/tools/knife/knife_configure/#configure-knife)
- For Chef Infra Client 18 or earlier, [configure your Progress Chef license with knife](/workstation/26.2/license)

Before bootstrapping Windows nodes with WinRM:

- Enable and configure Windows Remote Management (WinRM):

  ```powershell
  winrm quickconfig -q
  ```

- Set the execution policy to allow remote script execution:

  ```powershell
  Enable-PSRemoting -Force
  ```

- Configure Windows Firewall to allow WinRM traffic on port 5985 (HTTP) or 5986 (HTTPS)

## Bootstrap command syntax

This subcommand has the following syntax:

```bash
knife bootstrap FQDN_or_IP_ADDRESS (options)
```

## Bootstrap command options

### General connection options

`-U USERNAME`, `--connection-user USERNAME`

: Authenticate to the target host with this user account.

`-P PASSWORD`, `--connection-password PASSWORD`

: Authenticate to the target host with this password.

`-p PORT`, `--connection-port PORT`

: The port on the target node to connect to.

`-o PROTOCOL`, `--connection-protocol PROTOCOL`

: The protocol to use to connect to the target node. Options are `ssh` or `winrm`. `ssh` is default.

`-W SECONDS`, `--max-wait SECONDS`

: The maximum time to wait for the initial connection to be established.

`--session-timeout SECONDS`

: The number of seconds to wait for each connection operation to be acknowledged while running bootstrap.

### WinRM connection options

`--winrm-ssl-peer-fingerprint FINGERPRINT`

: SSL certificate fingerprint expected from the target.

`-f CA_TRUST_PATH`, `--ca-trust-file CA_TRUST_PATH`

: The Certificate Authority (CA) trust file used for SSL transport

`--winrm-no-verify-cert`

: Don't verify the SSL certificate of the target node for WinRM.

`--winrm-ssl`

: Use SSL in the WinRM connection.

`-w AUTH-METHOD`, `--winrm-auth-method AUTH-METHOD`

: The WinRM authentication method to use.

`--winrm-basic-auth-only`

: For WinRM basic authentication when using the 'ssl' auth method.

`-R KERBEROS_REALM`, `--kerberos-realm KERBEROS_REALM`

: The Kerberos realm used for authentication.

`-S KERBEROS_SERVICE`, `--kerberos-service KERBEROS_SERVICE`

: The Kerberos service used for authentication.

### SSH connection options

`-G GATEWAY`, `--ssh-gateway GATEWAY`

: The SSH tunnel or gateway that's used to run a bootstrap action on a machine that isn't accessible from the workstation.

`--ssh-gateway-identity SSH_GATEWAY_IDENTITY`

: The SSH identity file used for gateway authentication.

`-A`, `--ssh-forward-agent`

: Enable SSH agent forwarding.

`-i IDENTITY_FILE`, `--ssh-identity-file IDENTITY_FILE`

: The SSH identity file used for authentication. Key-based authentication is recommended.

`ssh_verify_host_key`, `--ssh-verify-host-key VALUE`

: Verify host key. Default is 'always'

### Chef installation options

`--bootstrap-version VERSION`

: The version of Chef Infra Client to install.

`--bootstrap-install-command COMMAND`

: Execute a custom installation command sequence for Chef Infra Client. This option may not be used in the same command with `--bootstrap-curl-options` or `--bootstrap-wget-options`.

`--bootstrap-curl-options OPTIONS`

: Arbitrary options to be added to the bootstrap command when using cURL. This option may not be used in the same command with `--bootstrap-install-command`.

`--bootstrap-wget-options OPTIONS`

: Arbitrary options to be added to the bootstrap command when using GNU Wget. This option may not be used in the same command with `--bootstrap-install-command`.

`--bootstrap-preinstall-command COMMANDS`

: Custom commands to run before installing Chef Infra Client.

`--bootstrap-url URL`

: The URL to a custom installation script.

`-m URL`, `--msi-url URL`

: Location of the Chef Infra Client MSI. The default templates will prefer to download from this location. The MSI will be downloaded from chef.io if not provided.

`--sudo`

: Execute a bootstrap operation with sudo.

`--sudo-preserve-home`

: Use to preserve the non-root user's `HOME` environment.

`--use-sudo-password`

: Perform a bootstrap operation with sudo; specify the password with the `-P` (or `--ssh-password`) option.

`-t TEMPLATE`, `--bootstrap-template TEMPLATE`

: The bootstrap template to use. This may be the name of a bootstrap template---`chef-full` for example---or it may be the full path to an Embedded Ruby (ERB) template that defines a custom bootstrap. Default value: `chef-full`, which installs Chef Infra Client using the Chef Infra installer on all supported platforms.

### Proxy options

`--bootstrap-no-proxy NO_PROXY_URL_or_IP`

: A URL or IP address that specifies a location that shouldn't be proxied during the bootstrap.

`--bootstrap-proxy PROXY_URL`

: The proxy server for the node that's the target of a bootstrap operation.

`--bootstrap-proxy-pass PROXY_PASS`

: The proxy authentication password for the node being bootstrapped.

`--bootstrap-proxy-user PROXY_USER`

: The proxy authentication username for the node being bootstrapped.

### Node options

`-N NAME`, `--node-name NAME`

: The unique identifier of the node.

    {{< note >}}

    This option is required for a validatorless bootstrap.

    {{< /note >}}

`-E ENVIRONMENT`, `--environment ENVIRONMENT`

: The name of the environment to be applied.

`-r RUN_LIST`, `--run-list RUN_LIST`

: A comma-separated list of roles and/or recipes to be applied.

`--secret SECRET`

: The encryption key that's used for values contained within a data bag item.

`--secret-file FILE`

: The path to the file that contains the encryption key.

`--hint HINT_NAME[=HINT_FILE]`

: An Ohai hint to be set on the bootstrap target. See the [Ohai](/client/latest/features/ohai/#hints) documentation for more information. `HINT_FILE` is the name of the JSON file. `HINT_NAME` is the name of a hint in a JSON file. Use multiple `--hint` options to specify multiple hints.

`-j JSON_ATTRIBS`, `--json-attributes JSON_ATTRIBS`

: A JSON string that's added to the first run of a Chef Infra Client.

`--json-attribute-file FILE`

: A JSON file to be added to the first run of Chef Infra Client.

`--[no-]fips`

: Allows OpenSSL to enforce FIPS-validated security during Chef Infra Client runs.

`--policy-group POLICY_GROUP`

: The name of a policy group that exists on Chef Infra Server.

`--policy-name POLICY_NAME`

: The name of a policy, as identified by the name setting in a Policyfile.rb file.

### chef-vault options

`--bootstrap-vault-file VAULT_FILE`

: The path to a JSON file that contains a list of vaults and items to be updated.

`--bootstrap-vault-item VAULT_ITEM`

: A single vault and item to update as `vault:item`.

`--bootstrap-vault-json VAULT_JSON`

: A JSON string that contains a list of vaults and items to be updated. For example, `--bootstrap-vault-json '{ "vault1": \["item1", "item2"\], "vault2": "item2" }'`

### Key verification options

`--[no-]host-key-verify`

: Use `--no-host-key-verify` to disable host key verification. Default setting: `--host-key-verify`.

`--[no-]node-verify-api-cert`

: Verify the SSL certificate on Chef Infra Server. When `true`, Chef Infra Client always verifies the SSL certificate. When `false`, Chef Infra Client uses the value of `ssl_verify_mode` to determine if the SSL certificate requires verification. If this option isn't specified, the setting for `verify_api_cert` in the configuration file is applied.

`--node-ssl-verify-mode MODE`

: Set the verify mode for HTTPS requests. Options: `none` or `peer`.

  Use `none` to do no validation of SSL certificates.

   Use `peer` to do validation of all SSL certificates, including the
   Chef Infra Server connections, S3 connections, and any HTTPS
   **remote_file** resource URLs used in a Chef Infra Client run. This
   is the recommended setting.

### Debug options

`-V -V`

: Run the initial Chef Infra Client run at the `debug` log-level (e.g. `chef-client -l debug`).

`-V -V -V`

: Run the initial Chef Infra Client run at the `trace` log-level (e.g. `chef-client -l trace`).

{{< note >}}

{{< readfile file="content/workstation/26.2/reusable/md/knife_common_see_all_config_options.md" >}}

{{< /note >}}

## Bootstrap nodes

<!--

### Bootstrap Chef Infra Client on Linux

To bootstrap Chef Infra Client on a Linux node, run the following command:

```sh
knife bootstrap <IP_ADDRESS> \
  -U <USERNAME> \
  -p <PASSWORD> \
  -N <NODE_NAME> \
  --sudo \
  --bootstrap-url "https://chef-hab-migration-tool-bucket.s3.amazonaws.com/Release-Candidate-3/workstation/install.sh?AWSAccessKeyId=AKIAW4FPVFT6PA6EXTHQ&Signature=IDDVNrOTeKZnc%2Bxa9611MkK%2BZ2o%3D&Expires=1780533412"
```

Replace the following:

- `<IP_ADDRESS>` with the node's IP address
- `<USERNAME>` with the SSH username
- `<PASSWORD>` with the SSH password
- `<NODE_NAME>` with a unique node name

The `--bootstrap-url` parameter installs a prerelease version of Chef Infra Client that's distributed through pre-signed URLs.

### Bootstrap Chef Infra Client on Windows

To bootstrap Chef Infra Client on a Windows node, run the following command:

```powershell
knife bootstrap <IP_ADDRESS> \
  -o winrm \
  -U <USERNAME> \
  -P <PASSWORD> \
  -N <NODE_NAME> \
  --winrm-port <PORT_NUMBER> \
  --bootstrap-url "https://chef-hab-migration-tool-bucket.s3.amazonaws.com/Release-Candidate-3/workstation/install.ps1?AWSAccessKeyId=AKIAW4FPVFT6PA6EXTHQ&Signature=4hQ0Ve5Rcd63oHZyTI7r%2FX9KltA%3D&Expires=1780533421"
```

Replace the following:

- `<IP_ADDRESS>` with the IP address of the Windows node
- `<USERNAME>` with the WinRM username
- `<PASSWORD>` with the WinRM password
- `<NODE_NAME>` with the Chef node name
- `<PORT_NUMBER>` with the WinRM communication port (default: `5985`)

To use HTTPS for WinRM on port 5986, use the `--winrm-ssl` option.

-->

### Bootstrap Chef Infra Client 18

To bootstrap Chef Infra Client 18.x, run the following command:

```sh
knife bootstrap <IP_ADDRESS> \
  -U <USERNAME> \
  -p <PASSWORD> \
  -N <NODE_NAME> \
  --sudo \
  --bootstrap-product chef
```

Replace the following:

- `<IP_ADDRESS>` with the node's IP address
- `<USERNAME>` with the SSH username
- `<PASSWORD>` with the SSH password
- `<NODE_NAME>` with a unique node name

The `--bootstrap-product chef` option directs knife to use Chef Infra Client 18.x from standard download channels.

<!--

### Bootstrap an AWS EC2 instance

The knife EC2 plugin integrates with AWS EC2 to create and provision EC2 instances.

To create an EC2 instance and bootstrap Chef Infra Client, run the following command:

```sh
knife ec2 server create \
  --sudo \
  -I <AMI_ID> \
  --ssh-key <SSH_KEY_NAME> \
  -f <INSTANCE_TYPE> \
  -N <NODE_NAME> \
  -U <SSH_USERNAME> \
  --ssh-identity-file ~/.ssh/<SSH_KEY_FILE> \
  -g <SECURITY_GROUP_ID> \
  --region <AWS_REGION> \
  --subnet <SUBNET_ID> \
  --aws-tag <TAG_KEY>=<TAG_VALUE>
  --bootstrap-url "<BOOTSTRAP_URL>"
```

Replace the following:

- `<AMI_ID>` with the Amazon Machine Image ID for the EC2 instance, for example, `ami-0c02fb55956c7d316`
- `<SSH_KEY_NAME>` with the Name of your AWS SSH key pair
- `<INSTANCE_TYPE>` with the Instance type specification, for example, `t3.medium`, `m5.xlarge`, or `c5.4xlarge`
- `<NODE_NAME>` with the Chef Infra node name for identification within Chef Infra Server
- `<SSH_USERNAME>` with the SSH username for the selected AMI, for example, `ec2-user`, `ubuntu`, or `centos`
- `<SSH_KEY_FILE>` with the Path to SSH private key for authentication
- `<SECURITY_GROUP_ID>` with the Security group ID for network access control, for example, `sg-0a1b2c3d4e5f67890`
- `<AWS_REGION>` with the AWS region for instance deployment, for example, `us-east-1` or `eu-west-1`
- `<SUBNET_ID>` with the VPC subnet ID for network placement, for example, `subnet-0123456789abcdef0`
- `<TAG_KEY>=<TAG_VALUE>` with the Resource tags for AWS compliance and management (repeatable). For example, `environment=production`
- `<BOOTSTRAP_URL>` with the RC3 installation script URL:

  For Windows nodes:

  ```text
  https://chef-hab-migration-tool-bucket.s3.amazonaws.com/Release-Candidate-3/workstation/install.ps1?AWSAccessKeyId=AKIAW4FPVFT6PA6EXTHQ&Signature=4hQ0Ve5Rcd63oHZyTI7r%2FX9KltA%3D&Expires=1780533421
  ```

  For Linux nodes:

  ```text
  https://chef-hab-migration-tool-bucket.s3.amazonaws.com/Release-Candidate-3/workstation/install.sh?AWSAccessKeyId=AKIAW4FPVFT6PA6EXTHQ&Signature=IDDVNrOTeKZnc%2Bxa9611MkK%2BZ2o%3D&Expires=1780533412
  ```

### Bootstrap a GCP Compute Engine instance

The knife-google plugin integrates with GCP Compute Engine to create and provision GCP instances.

To create a GCP instance and bootstrap Chef Infra Client:

```sh
knife google server create <INSTANCE_NAME> \
  --gce-project <GCP_PROJECT_ID> \
  --gce-zone <GCP_ZONE> \
  --gce-machine-type <MACHINE_TYPE> \
  --gce-image <IMAGE_NAME> \
  --gce-image-project <IMAGE_PROJECT> \
  --image-os-type <OPERATING_SYSTEM> \
  --connection-user <SSH_USERNAME> \
  --ssh-identity-file ~/.ssh/<SSH_KEY_FILE> \
  --connection-port 22 \
  --connection-protocol <PROTOCOL> \
  --gce-network <VPC_NETWORK> \
  --gce-subnet <SUBNET_NAME> \
  --gce-tags <TAG1>,<TAG2>,<TAG3> \
  --bootstrap-url "<BOOTSTRAP_URL>"
```

Replace the following:

- `<INSTANCE_NAME>` with the Name for the GCP instance
- `<GCP_PROJECT_ID>` with the Google Cloud project ID
- `<GCP_ZONE>` with the GCP availability zone, for example, `us-central1-a` or `europe-west1-b`
- `<MACHINE_TYPE>` with the Instance machine type, for example, `e2-standard-4` or `n1-highmem-8`
- `<IMAGE_NAME>` with the Operating system image name, for example, `ubuntu-2204-jammy-v20251102`
- `<IMAGE_PROJECT>` with the Source project containing the OS image, for example, `ubuntu-os-cloud` or `centos-cloud`
- `<OPERATING_SYSTEM>` with the Operating system type: `linux` or `windows`
- `<SSH_USERNAME>` with the SSH username
- `<SSH_KEY_FILE>` with the Filename of your SSH private key
- `<PROTOCOL>` with the Communication protocol: `ssh` or `winrm`
- `<VPC_NETWORK>` with the VPC network name
- `<SUBNET_NAME>` with the Subnet name within the VPC
- `<TAG1>,<TAG2>,<TAG3>` with the Comma-separated instance tags for organization and firewall rules (optional)
- `<BOOTSTRAP_URL>` with the Installation script URL:

  For Windows nodes:

  ```text
  https://chef-hab-migration-tool-bucket.s3.amazonaws.com/Release-Candidate-3/workstation/install.ps1?AWSAccessKeyId=AKIAW4FPVFT6PA6EXTHQ&Signature=4hQ0Ve5Rcd63oHZyTI7r%2FX9KltA%3D&Expires=1780533421
  ```

  For Linux nodes:

  ```text
  https://chef-hab-migration-tool-bucket.s3.amazonaws.com/Release-Candidate-3/workstation/install.sh?AWSAccessKeyId=AKIAW4FPVFT6PA6EXTHQ&Signature=IDDVNrOTeKZnc%2Bxa9611MkK%2BZ2o%3D&Expires=1780533412
  ```

### Bootstrap Chef Infra Client in an air-gapped environment

You can bootstrap Chef Infra Client 19 in an air-gapped environment.
The following are example steps for modifying the install scripts in an air-gapped environment.

1. On an internet-connected computer, download the Chef Infra Client 19 installation scripts and save them to an internal repository that's accessible to your target nodes. For example:

   ```sh
   wget https://chef-hab-migration-tool-bucket.s3.amazonaws.com/Release-Candidate-3/workstation/install.sh \
     -O /var/www/internal-repo/chef/rc3/install.sh

   wget https://chef-hab-migration-tool-bucket.s3.amazonaws.com/Release-Candidate-3/workstation/install.ps1 \
     -O /var/www/internal-repo/chef/rc3/install.ps1
   ```

1. Modify the installation scripts to reference your internal package locations. For example:

   ```sh
   sed -i 's|https://chef-hab-migration-tool-bucket.s3.amazonaws.com|https://internal-repo.example.com|g' \
     /var/www/internal-repo/chef/rc3/install.sh

   sed -i 's|https://chef-hab-migration-tool-bucket.s3.amazonaws.com|https://internal-repo.example.com|g' \
     /var/www/internal-repo/chef/rc3/install.ps1
   ```

1. Bootstrap Chef Infra Client 19 using the `--bootstrap-url` parameter to point to your internal resources:

   ```sh
   knife bootstrap <IP_ADDRESS> \
     -U <USERNAME> \
     -p <PASSWORD> \
     -N <NODE_NAME> \
     --sudo \
     --bootstrap-url "https://internal-repo.example.com/chef/rc3/install.sh"
   ```

-->

### Validatorless bootstrap

The `ORGANIZATION-validator.pem` is typically added to the `.chef` directory
on the workstation. When a node is bootstrapped from that workstation,
the `ORGANIZATION-validator.pem` is used to authenticate the newly-created
node to Chef Infra Server during the initial Chef Infra Client run.
It's possible to bootstrap a node using the `USER.pem` file instead of
the `ORGANIZATION-validator.pem` file. This is known as a _validatorless
bootstrap_.

To create a node using the `USER.pem` file, simply delete the
`ORGANIZATION-validator.pem` file on the workstation. For example:

```bash
rm -f /home/lamont/.chef/myorg-validator.pem
```

and then make the following changes in the `config.rb` file:

- Remove the `validation_client_name` setting
- Edit the `validation_key` setting to be something that isn't a path
    to an existent `ORGANIZATION-validator.pem` file. For example:
    `/non-exist`.

As long as a `USER.pem` is also present on the workstation from which the
validatorless bootstrap operation will be initiated, the bootstrap
operation will run and will use the `USER.pem` file instead of the
`ORGANIZATION-validator.pem` file.

When running a validatorless `knife bootstrap` operation, the output is
similar to:

```bash
desktop% knife bootstrap 10.1.1.1 -N foo01.acme.org \
  -E dev -r 'role[base]' -j '{ "foo": "bar" }' \
  --ssh-user vagrant --sudo
Node foo01.acme.org exists, overwrite it? (Y/N)
Client foo01.acme.org exists, overwrite it? (Y/N)
Creating new client for foo01.acme.org
Creating new node for foo01.acme.org
Connecting to 10.1.1.1
10.1.1.1 Starting first Chef Infra Client run...
[....etc...]
```

{{< note >}}

The `--node-name` option is required for a validatorless bootstrap.

{{< /note >}}

### FIPS Mode

Federal Information Processing Standards (FIPS) is a United States
government computer security standard that specifies security
requirements for cryptography. The current version of the standard is
FIPS 140-2. Chef Infra Client can be configured to allow OpenSSL to
enforce FIPS-validated security during a Chef Infra Client run. This
will disable cryptography that's explicitly disallowed in
FIPS-validated software, including certain ciphers and hashing
algorithms. Any attempt to use any disallowed cryptography will cause
Chef Infra Client to throw an exception during a Chef Infra Client run.

{{< note >}}

Chef uses MD5 hashes to uniquely identify files that are stored on the
Chef Infra Server. MD5 is used only to generate a unique hash identifier
and isn't used for any cryptographic purpose.

{{< /note >}}

Notes about FIPS:

- May be enabled for nodes running on Windows and Enterprise
    Linux platforms
- Should only be enabled for environments that require FIPS 140-2
    compliance

**Bootstrap a node using FIPS**

```bash
knife bootstrap 192.0.2.0 -P vanilla -x root -r 'recipe[apt],recipe[xfs],recipe[vim]' --fips
```

which shows something similar to:

```none
OpenSSL FIPS 140 mode enabled
...
192.0.2.0 Chef Infra Client finished, 12/12 resources updated in 78.942455583 seconds
```

## Custom bootstrap templates

The default `chef-full` template uses the Chef installer. For most
bootstrap operations, regardless of the platform on which the target
node is running, using the `chef-full` distribution is the best approach
for installing Chef Infra Client on a target node. In some situations, a
custom template may be required.

For example, the default bootstrap operation relies on an internet
connection to get the distribution to the target node. If a target node
can't access the internet, then a custom template can be used to define
a specific location for the distribution so that the target node may
access it during the bootstrap operation. The example below will show
you how to create a bootstrap template that uses a custom artifact store
for Chef packages and installation scripts, as well as a RubyGem mirror:

1. A custom bootstrap template file must be located in a `bootstrap/` directory, which is typically located within the `~/.chef/` directory on the local workstation. Navigate to the `.chef` directory, and create a `bootstrap` directory within it:

    ```bash
    mkdir bootstrap
    ```

2. Move to the `bootstrap` directory and create a blank template file; this example will use `template.erb` for the template name:

    ```bash
    touch template.erb
    ```

3. Still in the `bootstrap` directory, issue the following command to copy the `chef-full` configuration to your new template:

    ```bash
    find /opt/chef-workstation/embedded/lib/ruby -type f -name chef-full.erb -exec cat {} \; > template.erb
    ```

    This command searches for the `chef-full` template file under `/opt/chef-workstation/embedded/lib/ruby`, and then outputs the contents of the file to `template.erb`. If you used a different template file name, be sure to replace `template.erb` with the template file you created during the last step.

4. Update `template.erb` to replace `omnitruck.chef.io` with the URL of an `install.sh` script on your artifact store:

    ```ruby
    install_sh="<%= knife_config[:bootstrap_url] ? knife_config[:bootstrap_url] : "http://packages.example.com/install.sh" %>"
    ```

5. Still in your text editor, locate the following line near the bottom of your `template.erb` file:

    ```ruby
    cat > /etc/chef/client.rb <<'EOP'
    <%= config_content %>
    EOP
    ```

    Beneath it, add the following, replacing `gems.example.com` with the
    URL of your gem mirror:

    ```ruby
    cat >> /etc/chef/client.rb <<'EOP'
    rubygems_url "http://gems.example.com"
    EOP
    ```

    This appends the appropriate `rubygems_url` setting to the `/etc/chef/client.rb` file that's created during bootstrap, which ensures that your nodes use your internal gem mirror.

### Bootstrap with a custom template

You can use the `--bootstrap-template` option with the `knife bootstrap`
subcommand to specify the name of your bootstrap template file:

```bash
knife bootstrap 123.456.7.8 -x username -P password --sudo --bootstrap-template "template"
```

Alternatively, you can use the `knife[:bootstrap_template]` option
within `config.rb` to specify the template that `knife bootstrap` will
use by default when bootstrapping a node. It should point to your custom
template within the `bootstrap` directory:

```ruby
knife[:bootstrap_template] = "#{current_dir}/bootstrap/template.erb"
```

## Examples

The following examples show how to use this knife subcommand:

**Bootstrap a node**

```bash
knife bootstrap 192.0.2.0 -P vanilla -x root -r 'recipe[apt],recipe[xfs],recipe[vim]'
```

which shows something similar to:

```text
...
192.0.2.0 Chef Infra Client finished, 12/12 resources updated in 78.942455583 seconds
```

Use `knife node show` to verify:

```bash
knife node show debian-buster.int.domain.org
```

which returns something similar to:

```text
Node Name: debian-buster.int.domain.org
Environment: _default
FQDN:      debian-buster.int.domain.org
IP:        192.0.2.0
Run List:  recipe[apt], recipe[xfs], recipe[vim]
Roles:
Recipes:   apt, xfs, vim, apt::default, xfs::default, vim::default
Platform:  debian 10.0
Tags:
```

**Use an SSH password**

```bash
knife bootstrap 192.0.2.0 -x username -P PASSWORD --sudo
```

**Use a file that contains a private key**

```bash
knife bootstrap 192.0.2.0 -x username -i ~/.ssh/id_rsa --sudo
```

**Specify options when using cURL**

```bash
knife bootstrap --bootstrap-curl-options "--proxy http://myproxy.com:8080"
```

**Specify options when using GNU Wget**

```bash
knife bootstrap --bootstrap-wget-options "-e use_proxy=yes -e http://myproxy.com:8080"
```

**Specify a custom installation command sequence**

```bash
knife bootstrap --bootstrap-install-command "curl -l http://mycustomserver.com/custom_install_chef_script.sh | sudo bash -s --"
```

**Bootstrap a Windows node with WinRM using a run list and environment**

```bash
knife bootstrap -o winrm 123.456.7.8 -U username -P 'PASSWORD' --node-name NODE_NAME --run-list 'recipe[cookbook]' -E ENV_NAME
```

**Bootstrap a Windows node with WinRM using a Policyfile and policy group**

```bash
knife bootstrap -o winrm 123.456.7.8 -U username -P 'PASSWORD' --node-name NODE_NAME --policy-name PF_NAME --policy-group PG_NAME
```

**Bootstrap Windows node with shorthand syntax**

```bash
knife bootstrap winrm://username:PASSWORD@123.456.7.8 --run-list 'recipe[cookbook]' -E ENV_NAME
```
