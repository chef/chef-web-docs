+++
title = "License Chef Workstation"

[menu.workstation_26_0]
title = "License"
identifier = "workstation_26_0/license"
weight = 30
+++

Chef Workstation requires a valid Progress Chef license for certain operations.
This page describes licensing requirements and how to configure a license for Chef Workstation components.

## Licensing requirements

Different Chef Workstation components have different licensing requirements:

- **knife 19**: Requires a license for bootstrapping Chef Infra Client 18 and earlier
- **Test Kitchen Enterprise**: Uses a license to execute tests but doesn't enforce licensing

## Get a license

You can use any license that includes Chef Workstation entitlement.
This includes free, trial, or commercial licenses.

If you'd like to evaluate Chef Workstation, you can [request a trial license](https://www.chef.io/license-generation-free-trial).

For more information, see Chef's licensing documentation [Chef licensing documentation](/licensing/).

## Add a license to Workstation

If you've set a license for Chef Workstation, Test Kitchen Enterprise and knife 19 automatically read and use it to execute tests or during bootstrap operations.

You can apply a license to Chef Workstation in two ways:

- Set the license key in an environment variable
- Save the license key in the `licenses.yml` file

### Set the license as an environment variable

To configure the license key in your shell:

```bash
export CHEF_LICENSE_KEY="<LICENSE_KEY>"
```

Replace `<LICENSE_KEY>` with your license key.

### Save the license in the `licenses.yml` file

You can add your license to the `~/.chef/licenses.yml` file. For example:

```yaml
---
:file_format_version: 4.0.0
:licenses:
- :license_key: <LICENSE_KEY>
  :license_type: :free
  :update_time: '2024-10-23T15:02:53+05:30'
  :license_server_url: https://services.chef.io/licensing
```

Replace `<LICENSE_KEY>` with your license key.

## Add a license to Test Kitchen Enterprise

Test Kitchen Enterprise doesn't enforce licensing, but it uses a license to execute tests.

### How Test Kitchen Enterprise uses licenses

During the converge phase, Test Kitchen Enterprise transfers the license to the virtual machine (VM) and adds it as an argument to Chef Infra Client.
Chef Infra Client validates the license and saves it on the provisioned VM for future use.

During the verification phase, the kitchen-inspec plugin transmits the license to Chef InSpec, which validates it with Chef's licensing service.

Chef Infra Client 19+ and Chef InSpec 7+ support optional licensing.
Test Kitchen Enterprise can prompt you for a license, activate it, and store it securely on disk.
The license can also be transmitted to the provisioned VM during the verification phase.

### Add a license

Test Kitchen Enterprise automatically reads the license that's configured for Chef Workstation through:

- The `~/.chef/licenses.yml` file
- The `CHEF_LICENSE_KEY` environment variable

You can also configure a license specifically for Test Kitchen Enterprise with:

- The `kitchen.yml` configuration file
- The `test-kitchen` CLI

#### Add a license with the kitchen.yml file

To include the license in your `kitchen.yml` file:

```yaml
provisioner:
  name: chef_infra
  product_name: chef
  chef_license: accept-no-persist
  chef_license_key: <LICENSE_KEY>
```

Replace `<LICENSE_KEY>` with your license key.

The `chef_license` setting indicates acceptance of the [End User License Agreement](/licensing/accept/#chef-workstation).

#### Add a license using the CLI

To add a license using the `test-kitchen` CLI:

1. Run the license command:

   ```sh
   kitchen license
   ```

1. At the first prompt, select **I already have a license ID**.

1. Enter your license key at the second prompt.

   Test Kitchen Enterprise validates the license and saves it to disk.

#### Verify your Test Kitchen Enterprise license

To verify that a valid license is saved on disk:

```sh
kitchen license
```

This command verifies that a license exists on disk, validates it with the licensing server, and displays the license details.
If there isn't a valid license, it prompts you to activate one.

To display details of all licenses stored on disk:

```sh
kitchen license list
```

## Add a license to knife

knife requires a license for bootstrapping Chef Infra Client 18 and earlier.
Chef Infra Client 19 and above doesn't require a license because it's distributed through pre-signed URLs.

### How knife uses licenses

During bootstrap operations, knife transfers the license to the target node and adds it as an argument to Chef Infra Client.
Chef Infra Client validates the license and saves it on the provisioned node for future use.

### Add a license

knife automatically reads a license that's configured locally for Chef Workstation through:

- The `~/.chef/licenses.yml` file
- The `CHEF_LICENSE_KEY` environment variable

You can also configure a license specifically for knife with:

- The `knife license` CLI command
- The `--chef-license-key` command line option

#### Add a license using the CLI

To add a license using the `knife license` CLI:

1. Run the license command:

   ```bash
   knife license
   ```

1. At the first prompt, select **I already have a license ID**.

1. Enter your license key at the second prompt.

knife validates the license and saves it to disk.

##### Verify your knife license

To verify that a valid license is saved on disk:

```bash
knife license
```

This command verifies that a license exists on disk, validates it with the licensing server, and displays the license details.
If there isn't a valid license, it prompts you to activate one.

To display details of all licenses stored on disk:

```bash
knife license list
```

#### Add a license key with a command line option

When bootstrapping a node, you can save the license key and pass it to Chef Infra Client with the `--chef-license-key` command line option. For example:

```sh
knife bootrap <URL> \
  --chef-license-key <LICENSE_KEY>
  ...
```

## More information

- [Chef licensing documentation](/licensing/).
- [Progress Chef community portal](https://community.progress.com/s/products/chef)
