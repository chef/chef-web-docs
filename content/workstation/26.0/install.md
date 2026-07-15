+++
title = "Install Chef Workstation"
draft = false


[menu]
  [menu.workstation_26_0]
    title = "Install"
    identifier = "workstation_26_0/install.md Install Chef Workstation"
    weight = 10
+++

{{< readfile file="/content/reusable/md/workstation_modularize.md" >}}

## System requirements

Chef Workstation has the following requirements:

- Linux and Windows x86-64 (64-bit) systems only
- Chef Habitat 1.6.0 or later installed
- Minimum 2GB available disk space for installation
- Internet connectivity for package downloads (or access to internal Habitat Builder)

## Prerequisites

We use Chef Habitat to distribute and install Chef Workstation and its components.

To install and configure Chef Habitat so you can install and manage Chef Workstation, follow these steps:

1. [Install Chef Habitat](/habitat/latest/install/)

1. [Create a personal access token in Habitat Builder](/habitat/builder/saas/builder_profile/#create-a-personal-access-token)

1. Run [`hab cli setup`](/habitat/latest/install/hab_setup/) and follow the instructions in the setup script and add your personal access token so you can authenticate with Habitat Builder.

## Install Chef Workstation

Chef Workstation supports several installation methods to accommodate different deployment scenarios.

### Install with binary linking (recommended)

The recommended installation method includes binary linking, which creates symbolic links to the package binaries in your system PATH. This allows you to execute the command directly without the full Habitat exec syntax:

```shell
hab pkg install chef/chef-workstation --binlink --force
```

This command uses the following options to binlink Workstation to your system's PATH:

- `--binlink` binlinks the package binary to your system PATH.
- `--force` overwrites existing binlinks.

### Install from the unstable channel

To install a pre-release version, install from the unstable channel:

```shell
hab pkg install chef/chef-workstation --channel unstable
```

### Install a specific version of Chef Workstation 26

If you need to install a particular version of Chef Workstation, specify the version and timestamp in the package identifier:

```shell
hab pkg install chef/chef-workstation/<VERSION>/<TIMESTAMP>
```

For example, to install version 26.0.15 with timestamp 20260320102857, run the following command:

```shell
hab pkg install chef/chef-workstation/26.0.15/20260320102857
```

### Install additional versions of Chef Workstation's component tools

You can install multiple versions of Chef Workstation's component tools side-by-side with the versions included with Chef Workstation, including Chef Infra Client.

To install an additional version of a Workstation component alongside the default version, run the following command:

```shell
hab pkg install <PACKAGE_IDENT_WITH_VERSION>
```

Replace `<PACKAGE_IDENT_WITH_VERSION>` with the full package identifier with the version, for example `chef/chef-infra-client/18.10.17`.

To execute the specific version, run the `hab pkg exec` command, specify the full package identifier including the package version, and the command you want to run:

```shell
hab pkg exec <PACKAGE_IDENT_WITH_VERSION> <COMMAND>
```

For example, to run Chef Infra Client 18.10.17:

```shell
hab pkg exec chef/chef-infra-client/18.10.17 chef-client
```

To run Chef Infra Client 19.2.12, run:

```shell
hab pkg exec chef/chef-infra-client/19.2.12 chef-client
```

To run the binlinked version:

```shell
chef-client
```

### Verify the installation

After installation, verify that Chef Workstation is installed correctly:

```shell
chef-workstation -v
```

or

```shell
chef -v
```

A successful installation displays the installed version of Chef Workstation and the versions of its component tools.

### Use the bundled tools

Chef Workstation provides two primary methods for executing the bundled tools.

#### Method 1: Use direct executables with binary linking

Binary linking creates symbolic links to package executables in a system-wide location, allowing you to invoke tools directly without the Habitat exec prefix. This method provides a more familiar command-line experience similar to traditional package installations.

To enable binary linking during installation, include the `--binlink` flag:

```shell
hab pkg install chef/chef-workstation --binlink
```

If you have already installed Chef Workstation without binary linking, you can enable it afterward:

```shell
hab pkg binlink chef/chef-workstation
```

Once binary linking is enabled, you can invoke tools directly from the command line:

```shell
kitchen -v
chef-cli -v
chef-client --version
berks -v
inspec version
knife -v
```

#### Method 2: Use Habitat exec

The `hab pkg exec` command provides explicit control over which package and version is used to run a command. Use this method when you need to ensure a specific version is used or when binary linking isn't available.

The general syntax is:

```shell
hab pkg exec <PACKAGE_IDENT> <COMMAND>
```

The following table provides examples of common tool invocations using the Habitat exec method:

| Tool              | Command                                                    | Version Command       |
|-------------------|------------------------------------------------------------|-----------------------|
| Test Kitchen      | hab pkg exec chef/chef-test-kitchen-enterprise kitchen     | kitchen -v            |
| Chef CLI          | hab pkg exec chef/chef-cli chef-cli                        | chef-cli -v           |
| Chef Infra Client | hab pkg exec chef/chef-infra-client chef-client            | chef-client --version |
| Berkshelf         | hab pkg exec chef/berkshelf berks                          | berks -v              |
| Ohai              | hab pkg exec chef/ohai ohai                                | ohai --version        |
| Cookstyle         | hab pkg exec chef/cookstyle cookstyle                      | cookstyle -v          |
| Chef Vault        | hab pkg exec chef/chef-vault chef-vault                    | chef-vault -v         |
| Fauxhai           | hab pkg exec chef/fauxhai fauxhai                          | fauxhai -v            |
| Chef InSpec       | hab pkg exec chef/inspec inspec                            | inspec version        |
| knife             | hab pkg exec chef/knife knife                              | knife -v              |

## Install Chef Workstation tools

The following applications are included with Chef Workstation but can also be installed as standalone applications.

To install a Workstation tool as a standalone application, follow these steps:

1. Install a package using [`hab pkg install`](/habitat/habitat_cli/#hab-pkg-install):

    ```sh
    hab pkg install <PACKAGE_IDENT> --binlink --force
    ```

    Replace `<PACKAGE_IDENT>` with the package identifier:

    - `chef/berkshelf`
    - `chef/chef-cli`
    - `chef/chef-infra-client`
    - `chef/chef-test-kitchen-enterprise`
    - `chef/chef-vault`
    - `chef/cookstyle`
    - `chef/fauxhai`
    - `chef/inspec`
    - `chef/knife`
    - `chef/ohai`

    The `--binlink --force` options overwrite any existing package symbolic links in the system's PATH directory with the new version so you can run it directly in the command line.

1. Verify that the correct version runs:

    ```sh
    berks -v
    chef-cli -v
    chef-client -v
    chef-vault <args>
    cookstyle -v
    fauxhai -v
    knife -v
    ohai -v
    ```

## Troubleshooting

### Binlinks not found

If commands aren't found after installation, verify that Chef Habitat created the binlinks:

```sh
ls -la /bin | grep chef
```

If binlinks are missing, recreate them:

```sh
hab pkg binlink --force chef/chef-workstation
```

### Permission errors

Ensure you're running installation commands with `sudo` for system-wide access.

### Habitat channel issues

If the package can't be found, verify channel availability:

```sh
hab pkg search chef/chef-workstation --channel unstable
```

## Next steps

- [Set up Workstation](set_up)
- [Add a license](license)
- Optional: [Get started with Chef Workstation](get_started)

## More information

- [Chef Habitat documentation](/habitat/)
- [Upgrade Chef Workstation and its components](upgrade)
