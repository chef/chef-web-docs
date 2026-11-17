+++
title = "Install or upgrade Chef Workstation"
draft = false

[menu]
  [menu.workstation_26_2]
    title = "Install or upgrade"
    identifier = "workstation_26_2/install/Workstation"
    parent = "workstation_26_2/install"
    weight = 10
+++

{{< readfile file="content/workstation/26.2/reusable/md/workstation_modularize.md" >}}

This guide explains how to install or upgrade Chef Workstation on Windows, Debian-based systems, or Linux distributions that use the RPM Package Manager (RPM).
To upgrade, install the newer version over the existing installation.
You don't need to uninstall Chef Workstation first.

## Requirements

- **RAM**: Chef Workstation requires a minimum of 1 GB of RAM.
- **Disk space for binaries**:
  - Linux: The Chef Workstation binaries are stored in `/hab` and require a minimum of 2.8 GB of disk space.
  - Windows: The Chef Workstation binaries are stored in `C:\hab` and require a minimum of 3.3 GB of disk space.
  - macOS: The Chef Workstation binaries are stored in `/opt/hab` and require a minimum of 2.4 GB of disk space.

- **Supported platforms**

  Chef Workstation is supported on:

  - Currently supported Linux distributions and versions running Linux kernel 2.6.32 and later on x86-64 (amd64) or ARM64 (aarch64)
  - Currently supported Windows versions greater than or equal to Windows 10 and Windows Server 2016
  - macOS 14 (Sonoma) on Apple Silicon (ARM64/aarch64)

## Prerequisites

- Chef Infra Client isn't installed on your target system.
- On Debian-based systems, the `dpkg` package manager is installed on your target system.
- On RPM-based systems, the RPM and either the DNF or Yum package managers are installed on your target system.
- For Amazon Linux 2, use the RPM and Yum package managers.
- You have a valid Progress Chef license key.
- Your target system is connected to the internet.

## Install

### Install on Debian-based systems

To install or upgrade Chef Workstation on a Debian-based system, follow these steps:

1. Download the installer for your system architecture.

   Download using `wget`:

   ```shell
   wget -O "chef-workstation-enterprise-<VERSION>-<ARCHITECTURE>.deb" "https://chefdownload-commercial.chef.io/stable/chef-workstation-enterprise/download?eol=false&license_id=<LICENSE_ID>&m=<ARCHITECTURE>&p=linux&pm=deb&v=<VERSION>"
   ```

   Or use `curl`:

   ```shell
   curl -o "chef-workstation-enterprise-<VERSION>-<ARCHITECTURE>.deb" "https://chefdownload-commercial.chef.io/stable/chef-workstation-enterprise/download?eol=false&license_id=<LICENSE_ID>&m=<ARCHITECTURE>&p=linux&pm=deb&v=<VERSION>"
   ```

   Replace the following:
   - `<VERSION>`: the version number to install.
   - `<LICENSE_ID>`: your Chef license ID.
   - `<ARCHITECTURE>`: `x86_64` for x86-64 (amd64) systems or `aarch64` for ARM64 (aarch64) systems.

1. Install Chef Workstation:

   ```shell
   sudo dpkg -i chef-workstation-enterprise-<VERSION>-<ARCHITECTURE>.deb
   ```

   Use the same `<VERSION>` and `<ARCHITECTURE>` values from the download command.

### Install with DNF or Yum

To install or upgrade Chef Workstation on an RPM-based system, follow these steps:

1. Download the installer for your system architecture.

   Download using `wget`:

   ```shell
   wget -O "chef-workstation-enterprise-<VERSION>.<ARCHITECTURE>.rpm" "https://chefdownload-commercial.chef.io/stable/chef-workstation-enterprise/download?eol=false&license_id=<LICENSE_ID>&m=<ARCHITECTURE>&p=linux&pm=rpm&v=<VERSION>"
   ```

   Or use `curl`:

   ```shell
   curl -o "chef-workstation-enterprise-<VERSION>.<ARCHITECTURE>.rpm" "https://chefdownload-commercial.chef.io/stable/chef-workstation-enterprise/download?eol=false&license_id=<LICENSE_ID>&m=<ARCHITECTURE>&p=linux&pm=rpm&v=<VERSION>"
   ```

   Replace the following:
   - `<VERSION>`: the version number to install.
   - `<LICENSE_ID>`: your Chef license ID.
   - `<ARCHITECTURE>`: `x86_64` for x86-64 (amd64) systems or `aarch64` for ARM64 (aarch64) systems.

1. Install Chef Workstation:

   - Install the package with `dnf`:

     ```shell
     sudo dnf install chef-workstation-enterprise-<VERSION>.<ARCHITECTURE>.rpm
     ```

     If you use Amazon Linux 2, replace `dnf` with `yum`.

   - Or install the package with `rpm`:

     ```shell
     sudo rpm -Uvh chef-workstation-enterprise-<VERSION>.<ARCHITECTURE>.rpm
     ```

   Replace the following:
   - `<VERSION>`: the version number of the downloaded package.
   - `<ARCHITECTURE>`: `x86_64` for x86-64 (amd64) systems or `aarch64` for ARM64 (aarch64) systems.

### Install on Windows

To install or upgrade Chef Workstation on Windows, follow these steps:

1. Download the installer in an elevated PowerShell session:

   ```powershell
   Invoke-WebRequest -Uri "https://chefdownload-commercial.chef.io/stable/chef-workstation-enterprise/download?eol=false&license_id=<LICENSE_ID>&m=x86_64&p=windows&pm=msi&v=<VERSION>" -OutFile "chef-workstation-enterprise-<VERSION>_x86_64.msi"
   ```

   Replace the following:
   - `<VERSION>`: the version number to install.
   - `<LICENSE_ID>`: your Chef license ID.

1. Install Chef Workstation using one of the following methods:

   - Double-click the downloaded `.msi` file and follow the installation wizard.

   - In an elevated PowerShell or Command Prompt session, run:

     ```powershell
     msiexec /i chef-workstation-enterprise-<VERSION>_x86_64.msi
     ```

     Replace `<VERSION>` with the version number of the downloaded package, for example `chef-workstation-enterprise-26.2.0-1`.

### Install Chef Workstation on macOS

To install Chef Workstation on macOS (Apple Silicon), follow these steps:

1. Download the installer using one of the following methods:

   - Download using `curl`:

    ```shell
    curl -o "chef-workstation-enterprise-<VERSION>-darwin.dmg" "https://chefdownload-commercial.chef.io/stable/chef-workstation-enterprise/download?eol=false&license_id=<LICENSE_ID>&m=aarch64&p=mac_os_x&pm=dmg&v=<VERSION>"
    ```

   - Download using `wget`:

    ```shell
    wget -O "chef-workstation-enterprise-<VERSION>-darwin.dmg" "https://chefdownload-commercial.chef.io/stable/chef-workstation-enterprise/download?eol=false&license_id=<LICENSE_ID>&m=aarch64&p=mac_os_x&pm=dmg&v=<VERSION>"
    ```

   Replace the following:
   - `<VERSION>` with the version number to install.
   - `<LICENSE_ID>` with your Chef license ID.

1. Install Chef Workstation using one of the following methods:

   - Double-click the `.dmg` file, then double-click the `.pkg` file inside and follow the on-screen installation wizard.

   - Run the following commands:

    ```shell
    hdiutil attach chef-workstation-enterprise-<VERSION>-darwin.dmg
    sudo installer -pkg "/Volumes/Chef Workstation Enterprise <VERSION>/chef-workstation-enterprise-<VERSION>-1_arm64.pkg" -target /
    hdiutil detach "/Volumes/Chef Workstation Enterprise <VERSION>"
    ```

   Use the same `<VERSION>` value as in the download command.

## Verify the installation

After you install Chef Workstation, run this command to verify the installation:

```shell
chef-workstation -v
```

Alternatively:

```shell
chef -v
```

The output displays the installed Chef Workstation version.

## Next steps

- [Set up Workstation](set_up)
- [Add a license](license)
- Optional: [Get started with Chef Workstation](get_started)

## See also

- [Install individual Chef Workstation tools](tools)
- [Chef Download API documentation](/download/)
- [Uninstall Chef Workstation](uninstall)
- [Chef Workstation tools](tools)
