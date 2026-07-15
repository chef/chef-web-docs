+++
title = "Uninstall Chef Workstation and its tools"

[menu.workstation_26_0]
title = "Uninstall"
identifier = "workstation_26_0/uninstall"
weight = 50
+++

The page documents how to uninstall Chef Workstation and its component tools.

## Uninstall Chef Workstation

To uninstall Chef Workstation, use the [`hab pkg uninstall`](/habitat/habitat_cli/#hab-pkg-uninstall) command:

```sh
hab pkg uninstall chef/chef-workstation
```

Uninstalling `chef/chef-workstation` removes all bundled component tools:

- `chef/berkshelf`
- `chef/chef-cli`
- `chef/chef-infra-client`
- `chef/chef-test-kitchen-enterprise`
- `chef/chef-vault`
- `chef/cookstyle`
- `chef/fauxhai`
- `chef/knife`
- `chef/ohai`
- `chef/inspec`

## Uninstall Chef Workstation Tools

If you installed a Workstation tool as a standalone application, you can uninstall it without uninstalling the entire Workstation package.

To uninstall a Workstation tool, use the [`hab pkg uninstall`](/habitat/habitat_cli/#hab-pkg-uninstall) command:

```sh
hab pkg uninstall <PACKAGE_IDENT>
```

Replace `<PACKAGE_IDENT>` with one of the following packages:

- `chef/berkshelf`
- `chef/chef-cli`
- `chef/chef-infra-client`
- `chef/chef-test-kitchen-enterprise`
- `chef/chef-vault`
- `chef/cookstyle`
- `chef/fauxhai`
- `chef/knife`
- `chef/ohai`

## Uninstall a specific package version

If you installed specific tool versions, you can uninstall a specific version without uninstalling all versions of the package.

To uninstall a specific package version, run the following command:

```sh
hab pkg uninstall <PACKAGE_IDENT>
```

Replace `<PACKAGE_IDENT>` with one of the following:

- the package and version, for example `chef/<PACKAGE>/<VERSION>`.
- the package version and build, for example `chef/<PACKAGE>/<VERSION>/<BUILD_TIMESTAMP>`
