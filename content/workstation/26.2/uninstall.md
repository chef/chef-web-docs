+++
title = "Uninstall Chef Workstation"
draft = false

[menu.workstation_26_2]
  title = "Uninstall"
  identifier = "workstation_26_2/uninstall"
  weight = 80
+++

This guide explains how to uninstall Chef Workstation from supported Debian-based, RPM-based, Windows, and macOS systems.

## Uninstall Chef Workstation on Debian-based distributions

To uninstall Chef Workstation, follow these steps:

1. Remove the package:

   ```shell
   sudo apt-get purge chef-workstation-enterprise
   ```

1. Verify that `apt-get` purged the package:

   ```shell
   dpkg-query -W -f='${db:Status-Status}\n' chef-workstation-enterprise
   ```

   If the purge succeeds, the command returns a `dpkg-query: no packages found matching chef-workstation-enterprise`.

## Uninstall Chef Workstation on RPM-based distributions

To uninstall Chef Workstation, follow these steps:

1. Remove the package:

   ```shell
   sudo dnf remove chef-workstation-enterprise
   ```

1. Verify that `dnf` removed the package:

   ```shell
   rpm -q chef-workstation-enterprise
   ```

   If the removal succeeds, `rpm -q` finds no installed package.

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

The script removes the following:

- Chef Workstation binaries from `/usr/local/bin/`
- The installation directory `/opt/hab/`
- The PATH configuration from `/etc/paths.d/chef-workstation-enterprise`
- The installation metadata from `/Library/Application Support/chef-workstation-enterprise/`
- The package receipt through `pkgutil`

## See also

- [Install or upgrade Chef Workstation](install)
