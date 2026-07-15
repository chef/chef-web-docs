+++
title = "Upgrade Chef Workstation and its components"

[menu.workstation_26_0]
title = "Upgrade"
identifier = "workstation_26_0/upgrade"
+++

Use the following command to upgrade Chef Workstation or one of its components:

```sh
hab pkg install --binlink --force <PACKAGE_IDENT>
```

Replace `<PACKAGE_IDENT>` with the package identifier.

To update to the latest version, specify the origin and package:

- `chef/chef-workstation`
- `chef/berkshelf`
- `chef/chef-cli`
- `chef/chef-infra-client`
- `chef/chef-test-kitchen-enterprise`
- `chef/chef-vault`
- `chef/cookstyle`
- `chef/fauxhai`
- `chef/knife`
- `chef/ohai`

To update to a specific package version, include the version. For example:

- `chef/<PACKAGE>/<VERSION>`

To update to specific release build, include the package version and build timestamp. For example:

- `chef/<PACKAGE/<VERSION>/<TIMESTAMP>`

The `--binlink --force` options overwrite existing package symbolic links in the system's PATH directory with the new version so you can run it directly in the command line.

If you omit `--binlink --force`, Chef Habitat installs the new version alongside existing versions. To execute this version, you'd have to invoke the package's file path, for example `/hab/bin/hab pkg exec chef/<PACKAGE> <COMMAND>`.
