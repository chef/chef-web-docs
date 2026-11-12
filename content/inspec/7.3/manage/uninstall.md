+++
title = "Uninstall Chef InSpec"
draft = false

[menu.inspec_7_3]
title = "Uninstall Chef InSpec"
identifier = "manage/uninstall"
parent = "manage"
weight = 20
+++

## Uninstall Habitat-based Chef InSpec

If you installed Chef InSpec from a Habitat package, use the [`hab pkg uninstall`](/habitat/latest/reference/habitat_cli/#hab-pkg-uninstall) command:

```sh
sudo hab pkg uninstall chef/inspec
```

## Uninstall Chef InSpec on Debian-based distributions

To uninstall Chef InSpec, follow these steps:

1. Remove the package:

   ```sh
   sudo apt-get remove inspec
   ```

1. Verify that the package has been removed:

   ```sh
   dpkg -l inspec
   ```

   The command returns no output if the package is removed successfully.

## Uninstall Chef InSpec on RPM-based distributions

To uninstall Chef InSpec, follow these steps:

1. Remove the package.

    - Using `dnf`:

      ```sh
      sudo dnf remove inspec-enterprise
      ```

    - For Amazon Linux 2 or systems using `yum`:

      ```sh
      sudo yum remove inspec
      ```

1. Verify that the package has been removed:

   ```sh
   rpm -qa | grep inspec
   ```

   The command returns no output if the package is removed successfully.

## Uninstall Chef InSpec on Windows

To uninstall using the Windows UI:

1. Open **Settings > Apps > Installed apps**.
1. Search for **Chef InSpec**.
1. Select **Uninstall**, then follow the on-screen prompts.

To uninstall from the command line, run the following command in an elevated PowerShell or Command Prompt session:

```powershell
msiexec /x inspec-enterprise-<VERSION>-x64.msi /qn
```

Replace `<VERSION>` with the version number of the currently installed package.
