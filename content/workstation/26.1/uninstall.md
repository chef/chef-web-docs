+++
title = "Uninstall Chef Workstation"
draft = false

[menu.workstation_26_1]
  title = "Uninstall"
  identifier = "workstation_26_1/uninstall"
  weight = 70
+++

Use these steps to remove Chef Workstation from Debian-based, RPM-based, Windows, or macOS systems.

## Uninstall Chef Workstation on Debian-based distributions

To uninstall Chef Workstation, follow these steps:

1. Remove the package:

   ```shell
   sudo apt-get purge chef-workstation-enterprise
   ```

1. Verify that the package has been removed:

   ```shell
   dpkg -l chef-workstation-enterprise
   ```

   The command returns no output if the package is removed successfully.

## Uninstall Chef Workstation on RPM-based distributions

To uninstall Chef Workstation, follow these steps:

1. Remove the package:

   ```shell
   sudo dnf remove chef-workstation-enterprise
   ```

1. Verify that the package has been removed:

   ```shell
   rpm -qa chef-workstation-enterprise
   ```

   The command returns no output if the package is removed successfully.

## Uninstall Chef Workstation on Windows

To uninstall using the Windows UI:

1. Open **Settings > Apps > Installed apps**.
1. Search for **Chef Workstation**.
1. Select **Uninstall**, then follow the on-screen prompts.

To uninstall from the command line, run the following command in an elevated PowerShell or Command Prompt session:

```powershell
msiexec /x chef-workstation-enterprise-<VERSION>_x86_64.msi
```

Replace `<VERSION>` with the version number of the currently installed package.

## Uninstall Chef Workstation on macOS

To uninstall Chef Workstation on macOS, run the uninstaller script:

```shell
sudo /opt/hab/chef-workstation/uninstall.sh
```

This script will:

- Remove all Chef Workstation binaries from `/usr/local/bin/`
- Remove the installation directory `/opt/hab/`
- Remove the PATH configuration from `/etc/paths.d/chef-workstation-enterprise`
- Remove the installation metadata from `/Library/Application Support/chef-workstation-enterprise/`
- Forget the package receipt using `pkgutil`

## See also

- [Install Chef Workstation](install)
- [Upgrade Chef Workstation](upgrade)
