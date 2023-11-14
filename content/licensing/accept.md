+++
title = "Accept the Chef License"
draft = false
gh_repo = "chef-web-docs"
aliases = ["/chef_license_accept.html", "/chef_license_accept/"]

[menu]
  [menu.overview]
    title = "Accept License"
    identifier = "overview/licensing/Accepting License"
    parent = "overview/licensing"
    weight = 20
+++

This document describes how to accept the End User License Agreement (EULA) and Master License and Services Agreement (MLSA).
For an overview of Chef's license, see the [Chef License](/licensing/) documentation.

Chef has two licenses: Master License and Services Agreement (MLSA) and End User License Agreement (EULA).

## Accept the Chef MLSA

You can accept the Chef MLSA using one of the following ways:

1. When running `chef-<PRODUCT-NAME>-ctl reconfigure` the Chef MLSA is printed. Type `yes` to accept it. Anything other than typing `yes` rejects the Chef MLSA, and the upgrade process will exit. Typing `yes` adds a `.license.accepted` file to the `/etc/chef/accepted_licenses/<PRODUCT-NAME>` file. As long as this file exists in this directory, the Chef MLSA is accepted and the reconfigure process won't prompt for `yes`.
2. Run the `chef-<PRODUCT-NAME>-ctl reconfigure` command using the `--chef-license=accept` option. This automatically types `yes` and skips printing the Chef MLSA.
3. Add a `.license.accepted` file to the `/var/opt/<PRODUCT-NAME>/` directory. The contents of this file don't matter. As long as this file exists in this directory, the Chef MLSA is accepted and the reconfigure process won't prompt for `yes`.

### Chef Automate

The Chef Automate reconfigure tool---`automate-ctl`---walks users through the install and setup of Chef Automate.
Accept the Chef MLSA after that in the browser. Follow the in-product prompts.

## Accept the Chef EULA

If no command line argument or environment variable is set, Chef products attempt to request acceptance through an interactive prompt. If the prompt can't be displayed, the product will fail with an exit code 172.

If the product attempts to persist the accepted license and fails, a message is sent to STDOUT but product invocation will continue successfully.
In a future invocation, you must accept the Chef License again.

See [License File Persistence](https://github.com/chef/license-acceptance#license-file-persistence) for details about persisted marker files.

### Chef Habitat

You can accept the Chef License using a `hab` CLI command or with an environment variable.

If the license isn't accepted through either of these methods, Chef Habitat will request that you accept the license through an interactive prompt.

#### Options

Chef Habitat accepts the following license acceptance options:

`accept`
: Accept the license and attempts to persist a marker file locally. Persisting these marker files means future invocations don't require accepting the license again.

`accept-no-persist`
: Accept the license silently but no marker file is persisted. Future invocation will require accepting the license again.

#### Command line option

You can use the `hab` CLI to accept the Chef License.

```sh
hab license <LICENSE_OPTION>
```

#### Environment variable

You can set an environment variable to accept the Chef License. For example:

```sh
export HAB_LICENSE="<LICENSE_OPTION>"
hab -V
```

Replace `<LICENSE_OPTION>` with one of the Chef License options.

#### CI environment

To accept the Chef License in CI or other automated environments:

- If your `hab` commands run as root, create an empty file on the filesystem at `/hab/accepted-licenses/habitat`.
- If your `hab` commands run as a user other than root, create an empty file at `$HOME/.hab/accepted-licenses/habitat`.
- For situations where `hab` commands run as multiple users, create both files.

#### Errors

If the Chef Habitat license prompt can't be displayed, then the product fails with an exit code 172.
If Chef Habitat can't persist the accepted license, it sends a message STDOUT but the product invocation will continue successfully.
You must accept the Chef License again in a future invocation.

#### Chef products as `hab` packages

Chef products are also distributed as `hab` packages.
When you install Chef products using Chef Habitat, those products also request license acceptance.

#### Chef server products as `hab` packages

The following Chef server products are distributed as `hab` packages that Chef Habitat runs as a supervisor:

- Chef Infra Server
- Chef Automate
- Chef Supermarket

Server products are typically installed and managed by some kind of process supervisor.
Chef server products don't allow interactive license acceptance because process supervisors don't allow interactivity.
Instead, accept the Chef License during the `reconfigure` command or `upgrade` command for the Omnibus ctl command.

##### Command line option

Accept the Chef License with the command line option. For example:

```sh
chef-server-ctl reconfigure --chef-license=<LICENSE_OPTION>
```

##### Environment variable

Accept the Chef License with an environment variable. For example:

```sh
CHEF_LICENSE="<LICENSE_OPTION>" supermarket-ctl reconfigure
```

##### Config file

You can also accept the Chef License using the omnibus configuration file.
Specify `chef_license 'accept'` in the `chef-server.rb` or `supermarket.rb` configuration.

### Chef Infra Client

Chef Infra Client accepts a license using a command line option, environment variable, or config file.

#### Options

Chef Infra Client accepts the following license acceptance options:

{{< readfile file="content/licensing/reusable/md/license_accept_options.md" >}}

#### Command line option

Accept the Chef License with a command line invocation.

```sh
chef-client --chef-license <LICENSE_OPTION>
```

#### Environment variable

Accept the Chef License by setting an environment variable. For example:

```sh
export CHEF_LICENSE="<LICENSE_OPTION>"
chef-client OPTION VALUE
```

#### Config file

You can accept the Chef License with the Chef Infra Client or Knife config files.

On a workstation, you can set this in the [`~/.chef/config.rb` or `~/.chef/knife.rb` files](/workstation/config_rb/), and on a node you can set this in the [`/etc/chef/client.rb`]({{< relref "/config_rb_client" >}}) file.

```ruby
chef_license "<LICENSE_OPTION>"
```

### Chef Infra Server

When installed as a system package, users accept the Chef License with the `chef-server-ctl` command or with the [`chef-server.rb`](/server/config_rb_server/) file.

#### Options

Chef Infra Server accepts the following license acceptance options:

{{< readfile file="content/licensing/reusable/md/license_accept_options.md" >}}

#### Command line option

You can accept the Chef License with the `chef-server-ctl` command.

```sh
chef-server-ctl reconfigure --chef-license=<LICENSE_OPTION>
```

#### Config file

You can accept the Chef License with the [`chef-server.rb`](/server/config_rb_server/) file.

```ruby
chef_license "<LICENSE_OPTION>"
```

#### Chef Habitat package

Chef Infra Server is also distributed as a `hab` package and run using the Chef Habitat Supervisor. In this mode, users accept the Chef License by setting the correct configuration values. The key is `chef_license.acceptance`.

For example, against a Supervisor running Chef Infra Server, run `echo "chef_license.acceptance = accept" | hab config apply server.default 100`.
See the [Chef Habitat config updates documentation]({{< relref "/habitat/service_updates" >}}) for more information about how to apply this configuration to a service group.

### Chef InSpec

Chef InSpec accepts a license using a command line option or environment variable.

#### Options

Chef InSpec accepts the following license acceptance options:

{{< readfile file="content/licensing/reusable/md/license_accept_options.md" >}}

#### Command line option

Accept the Chef License with a command line invocation.

```sh
inspec exec <INSPEC_PROFILE_NAME> --chef-license <LICENSE_OPTION>
```

#### Environment variable

Accept the Chef License by setting an environment variable. For example:

```sh
export CHEF_LICENSE="<LICENSE_OPTION>"
inspec exec <INSPEC_PROFILE_NAME>
```

### Chef Workstation

Chef Workstation is bundled with several Chef products.
When invoking the `chef` command line tool and accepting the Chef License, you must accept the license for all the embedded products as well.
The same license applies to all products, but each product must have its own license acceptance.

#### Options

Chef Workstation accepts the following license acceptance options:

{{< readfile file="content/licensing/reusable/md/license_accept_options.md" >}}

#### Command line option

Use the [`chef` executable](/workstation/ctl_chef/) to accept the Chef License for Chef Workstation, Chef Infra Client, and Chef InSpec.

```sh
chef <command> --chef-license <LICENSE_OPTION>
```

### Remote management products

If a user has accepted the appropriate product license locally, the following remote management products that can install or manage Chef products on a remote instance, will transfer the Chef License acceptance to the remote instance.

- Test Kitchen
- `knife bootstrap` in Chef Infra Client
- `chef-run` in Chef Workstation
- Packer
- Terraform Chef Provider (Deprecated)
- Vagrant

For example, if a user has accepted the Chef Infra Client license locally and converges a Test Kitchen instance with the Chef provisioner, it will succeed by copying the acceptance to the remote instance.
We aim to support this behavior so Workstation users don't have their workflow affected, but any differences from that behavior are documented below.

#### Test Kitchen

Test Kitchen isn't owned by or covered by the Chef License, but installing Chef Infra Client on a test instance is covered by the EULA. Without accepting the Chef License, the converge will fail on the test instance.

Users can set the `CHEF_LICENSE` environment variable or add `chef_license: accept` to their provisioner config in the [`kitchen.yml` file](/workstation/kitchen/#kitchenyml).
If you specify `accept`, Test Kitchen will attempt to persist the license acceptance locally.
If Test Kitchen detects a local license marker file, acceptance is automatically transferred to the test instance.

To disable this persistence, specify `accept-no-persist` on every test instance converge.

`kitchen-inspec` uses Chef InSpec as a library and isn't covered by the EULA when installed as a gem, but is covered by the EULA when packaged as part of the Chef Workstation installation.
Accept the license in a similar way to the Chef Infra Client license - specify the `CHEF_LICENSE` environment variable, specify the `chef_license` config under the verifier section in `kitchen.yml` or persist the acceptance locally.

#### `knife bootstrap`

You don't have to accept the EULA to use the `knife` executable, but a Chef Infra Client instance does require EULA acceptance. Using `knife bootstrap` to manage a Chef Infra Client instance will prompt a user to accept the license locally before allowing for bootstrapping the remote instance. Without this, `knife bootstrap` fails.

Usually with Chef Workstation, this license will already have been accepted and will transfer across transparently.
But if a user installs Chef Workstation and the first command they run is `knife bootstrap`, it will perform the same license acceptance flow as the Chef Infra Client product.

#### `chef-run`

To accept the Chef License using the [`chef-run` executable](/workstation/chef_run/), complete one of the following three tasks:

- Pass the `--chef-license` command line flag
- Set the `CHEF_LICENSE` environment variable
- Add the license acceptance to your `~/.chef-workstation/config.toml` file:

  ```toml
  [chef]
  chef_license = "accept"
  ```

#### Vagrant

You can accept the Chef License with the arguments API:

```ruby
config.vm.provision 'chef_zero' do |chef|
  chef.arguments = '--chef-license accept'
end
```

See the [Vagrant documentation](https://www.vagrantup.com/docs/provisioning/chef_common.html#arguments) for details.
