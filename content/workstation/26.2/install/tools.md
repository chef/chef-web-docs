
+++
title = "Install individual Chef Workstation components"
draft = false

[menu]
  [menu.workstation_26_2]
    title = "Install individual components"
    identifier = "workstation_26_2/install/tools"
    parent = "workstation_26_2/install"
    weight = 20
+++

Chef Workstation includes tools that you can install individually with Chef Habitat.
If you only need specific tools rather than the full Workstation package, you can install them as standalone applications.

## Prerequisites

- [Chef Habitat is installed](/habitat/latest/install/)

## Install individual components

To install a Chef Workstation component, follow these steps:

1. Install a package using [`hab pkg install`](/habitat/habitat_cli/#hab-pkg-install):

   ```shell
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

1. Verify the installed component by running its version command:

   - Berkshelf (`chef/berkshelf`):

     ```shell
     berks -v
     ```

   - Chef CLI (`chef/chef-cli`):

     ```shell
     chef-cli -v
     ```

   - Chef Infra Client (`chef/chef-infra-client`):

     ```shell
     chef-client --version
     ```

   - Chef Test Kitchen Enterprise (`chef/chef-test-kitchen-enterprise`):

     ```shell
     kitchen -v
     ```

   - Chef Vault (`chef/chef-vault`):

     ```shell
     chef-vault -v
     ```

   - Cookstyle (`chef/cookstyle`):

     ```shell
     cookstyle -v
     ```

   - Fauxhai (`chef/fauxhai`):

     ```shell
     fauxhai -v
     ```

   - Chef InSpec (`chef/inspec`):

     ```shell
     inspec version
     ```

   - knife (`chef/knife`):

     ```shell
     knife -v
     ```

   - Ohai (`chef/ohai`):

     ```shell
     ohai --version
     ```

   Each command displays the installed component's version.

## See also

- [`hab pkg install` CLI command reference](/habitat/latest/reference/habitat_cli/#hab-pkg-install)
- [Chef Workstation tools](/workstation/26.2/tools)
