+++
title = "Chef Workstation install guide"
draft = false

[menu]
  [menu.workstation_26_1]
    title = "Install"
    identifier = "workstation_26_1/install.md Chef Workstation install guide"
    weight = 20
+++

{{< readfile file="content/workstation/26.1/reusable/md/workstation_modularize.md" >}}

The Chef Workstation native installers provide an efficient way to install Chef Workstation on Windows, Debian, RPM-based Linux distributions, and macOS.
You can download and install the pre-built `.msi`, `.deb`, `.rpm`, or `.dmg` packages using your existing package management tools, simplifying the deployment process for managing system configurations.

## Supported platforms

Chef Workstation is supported on:

- Currently supported Linux distributions and versions running Linux kernel 2.6.32 and later on x86-64 (amd64)
- Currently supported Windows versions greater than or equal to Windows 10 and Windows Server 2016
- macOS 14 (Sonoma) on Apple Silicon (ARM64/aarch64)

## Chef Workstation requirements

- **RAM**: Chef Workstation requires a minimum of 1 GB of RAM.
- **Disk space for binaries**:
  - Linux: The Chef Workstation binaries are stored in `/hab` and require a minimum of 2.8 GB of disk space.
  - Windows: The Chef Workstation binaries are stored in `C:\hab` and require a minimum of 3.3 GB of disk space.
  - macOS: The Chef Workstation binaries are stored in `/opt/hab` and require a minimum of 2.4 GB of disk space.

## Prerequisites

- Chef Infra Client isn't installed on your target system.
- On Debian-based systems, the `dpkg` package manager is installed on your target system.
- On RPM-based systems, the RPM and either the DNF or Yum package managers are installed on your target system.
- For Amazon Linux 2, use the RPM and Yum package managers.
- You have a valid Progress Chef license key.
- Your target system is connected to the internet.

## Install Chef Workstation

### Install Chef Workstation on Debian-based systems

To install Chef Workstation on a Debian-based system, follow these steps:

1. Download the Debian-based installer using one of the following methods:

   - Download using `wget`:

     ```shell
     wget -O "chef-workstation-enterprise-<VERSION>-linux.deb" "https://chefdownload-commercial.chef.io/stable/chef-workstation-enterprise/download?eol=false&license_id=<LICENSE_ID>&m=x86_64&p=linux&pm=deb&v=<VERSION>"
     ```

   - Download using `curl`:

     ```shell
     curl -o "chef-workstation-enterprise-<VERSION>-linux.deb" "https://chefdownload-commercial.chef.io/stable/chef-workstation-enterprise/download?eol=false&license_id=<LICENSE_ID>&m=x86_64&p=linux&pm=deb&v=<VERSION>"
     ```

   Replace:
   - `<VERSION>` with the version number to install.
   - `<LICENSE_ID>` with your Chef license ID.

1. Install Chef Workstation:

   ```shell
   sudo dpkg -i chef-workstation-enterprise-<VERSION>_amd64.deb
   ```

   Replace `<VERSION>` with the version number of the downloaded package, for example `chef-workstation-enterprise-26.1.0-1_amd64.deb`.

### Install Chef Workstation on RPM-based systems

To install Chef Workstation on an RPM-based system, follow these steps:

1. Download the RPM-based installer using one of the following methods:

   - Download using `wget`:

     ```shell
     wget -O "chef-workstation-enterprise-<VERSION>-linux.rpm" "https://chefdownload-commercial.chef.io/stable/chef-workstation-enterprise/download?eol=false&license_id=<LICENSE_ID>&m=x86_64&p=linux&pm=rpm&v=<VERSION>"
     ```

   - Download using `curl`:

     ```shell
     curl -o "chef-workstation-enterprise-<VERSION>-linux.rpm" "https://chefdownload-commercial.chef.io/stable/chef-workstation-enterprise/download?eol=false&license_id=<LICENSE_ID>&m=x86_64&p=linux&pm=rpm&v=<VERSION>"
     ```

   Replace:
   - `<VERSION>` with the version number to install.
   - `<LICENSE_ID>` with your Chef license ID.

1. Install Chef Workstation:

   ```shell
   sudo dnf install chef-workstation-enterprise-<VERSION>.x86_64.rpm
   ```

   Alternatively:

   ```shell
   sudo rpm -Uvh chef-workstation-enterprise-<VERSION>.x86_64.rpm
   ```

   Replace `<VERSION>` with the version number of the downloaded package, for example `chef-workstation-enterprise-26.1.0-1.x86_64.rpm`.

### Install Chef Workstation on Windows

To install Chef Workstation on Windows, follow these steps:

1. Download the installer in an elevated PowerShell session:

   ```powershell
   Invoke-WebRequest -Uri "https://chefdownload-commercial.chef.io/stable/chef-workstation-enterprise/download?eol=false&license_id=<LICENSE_ID>&m=x86_64&p=windows&pm=msi&v=<VERSION>" -OutFile "chef-workstation-enterprise-<VERSION>_x86_64.msi"
   ```

   Replace:
   - `<VERSION>` with the version number to install.
   - `<LICENSE_ID>` with your Chef license ID.

1. Install Chef Workstation using one of the following methods:

   - Run the following command in an elevated PowerShell or Command Prompt session:

     ```powershell
     msiexec /i chef-workstation-enterprise-<VERSION>_x86_64.msi
     ```

   - Double-click the `.msi` file and follow the on-screen installation wizard.

   Replace `<VERSION>` with the version number of the downloaded package, for example `chef-workstation-enterprise-26.1.0-1_x86_64.msi`.

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

   Replace:
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

   Replace `<VERSION>` with the version number of the downloaded package, for example `chef-workstation-enterprise-26.1.0-1`.

## Verify the installation

After installation, verify that Chef Workstation is installed correctly by running one of the following commands:

```shell
chef-workstation -v
```

Alternatively:

```shell
chef -v
```

The output displays the installed Chef Workstation version.

## Install individual components

The following tools are included with Chef Workstation but can also be installed individually using Chef Habitat.
If you only need specific tools rather than the full Workstation package, install them as standalone applications:

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

## Next steps

- [Set up Workstation](set_up)
- [Add a license](license)
- Optional: [Get started with Chef Workstation](get_started)

## See also

- [Chef Download API documentation](/download/)
- [Upgrade Chef Workstation](upgrade)
- [Uninstall Chef Workstation](uninstall)
- [Chef Workstation tools](tools)
