+++
title = "Chef InSpec install guide"
draft = false

[menu.inspec_7_2]
    title = "Install Chef InSpec"
    identifier = "install/install"
    parent = "install"
    weight = 10
+++

You can install Chef InSpec using a platform-native installer on:

- Windows
- Debian-based Linux distributions
- RPM-based Linux distributions

You can install the Chef InSpec Habitat package on:

- macOS
- Windows
- Debian-based Linux distributions
- RPM-based Linux distributions

## Install Chef InSpec using a platform-native installer

### Supported platforms

- Windows x86-64
- Linux x86-64
- Linux ARM64

### Prerequisites

This installation process has the following prerequisites:

- Chef InSpec, Chef Automate, and Chef Workstation aren't installed on the target system.

  If Chef InSpec is already installed, see the [Chef InSpec uninstall documentation](/inspec/7.2/manage/uninstall/).

- Windows systems have tar installed.
- Debian-based systems have the DPKG package manager installed.
- RPM-based systems have RPM and either DNF or YUM installed. Amazon Linux 2 systems use RPM and YUM.
- You have a valid Progress Chef license key.
- The target system has an internet connection.

### Install Chef InSpec on Debian-based systems

To install Chef InSpec on a Debian-based system, follow these steps:

1. Download the Debian-based installer using one of the following methods:

    - Download using `wget`:

      ```sh
      wget -O "inspec-enterprise-<VERSION>_<ARCHITECTURE>.deb" "https://chefdownload-commercial.chef.io/stable/inspec/download?eol=false&license_id=<LICENSE_ID>&m=<ARCHITECTURE>&p=linux&pm=deb&v=<VERSION>"
      ```

    - Download using `curl`:

      ```sh
      curl -o "inspec-enterprise-<VERSION>_<ARCHITECTURE>.deb" "https://chefdownload-commercial.chef.io/stable/inspec/download?eol=false&license_id=<LICENSE_ID>&m=<ARCHITECTURE>&p=linux&pm=deb&v=<VERSION>"
      ```

    Replace:

    - `<VERSION>` with the version number to install.
    - `<LICENSE_ID>` with your Chef license ID.
    - `<ARCHITECTURE>` with `x86_64` or `aarch64`.

1. Install Chef InSpec:

    ```sh
    sudo dpkg -i inspec-enterprise-<VERSION>_<ARCHITECTURE>.deb
    ```

    Replace:

    - `<VERSION>` with the version number of the downloaded package, for example `7.1.6`.
    - `<ARCHITECTURE>` with `x86_64` or `aarch64`.

1. Verify that Chef InSpec is installed:

    ```sh
    inspec version
    ```

    The output displays the installed Chef InSpec version.

1. [Accept the Chef EULA](license#accept-the-chef-eula).

### Install Chef InSpec on RPM-based systems

To install Chef InSpec on an RPM-based system, follow these steps:

1. Download the RPM-based installer using one of the following methods:

    - Download using `wget`:

      ```sh
      wget -O "inspec-enterprise-<VERSION>.<ARCHITECTURE>.rpm" "https://chefdownload-commercial.chef.io/stable/inspec/download?eol=false&license_id=<LICENSE_ID>&m=<ARCHITECTURE>&p=linux&pm=rpm&v=<VERSION>"
      ```

    - Download using `curl`:

      ```sh
      curl -o "inspec-enterprise-<VERSION>.<ARCHITECTURE>.rpm" "https://chefdownload-commercial.chef.io/stable/inspec/download?eol=false&license_id=<LICENSE_ID>&m=<ARCHITECTURE>&p=linux&pm=rpm&v=<VERSION>"
      ```

    Replace:

    - `<VERSION>` with the version number to install.
    - `<LICENSE_ID>` with your Chef license ID.
    - `<ARCHITECTURE>` with `x86_64` or `aarch64`.

1. Install Chef InSpec using one of the following methods:

    - Install using `rpm`:

      ```sh
      sudo rpm -Uvh inspec-enterprise-<VERSION>.<ARCHITECTURE>.rpm
      ```

    - Install using `dnf`:

      ```sh
      sudo dnf install ./inspec-enterprise-<VERSION>.<ARCHITECTURE>.rpm
      ```

    - For Amazon Linux 2 or systems using `yum`:

      ```sh
      sudo yum install ./inspec-enterprise-<VERSION>.<ARCHITECTURE>.rpm
      ```

    Replace:

    - `<VERSION>` with the version number of the downloaded package, for example `7.1.6`.
    - `<ARCHITECTURE>` with `x86_64` or `aarch64`.

1. Verify that Chef InSpec is installed:

    ```sh
    inspec version
    ```

    The output displays the installed Chef InSpec version.

1. [Accept the Chef EULA](license#accept-the-chef-eula).

### Install Chef InSpec on Windows

To install Chef InSpec on Windows, follow these steps:

1. Download the installer in an elevated PowerShell session:

      ```powershell
      Invoke-WebRequest -Uri "https://chefdownload-commercial.chef.io/stable/inspec/download?eol=false&license_id=<LICENSE_ID>&m=x86_64&p=windows&pm=msi&v=<VERSION>" -OutFile "inspec-enterprise-<VERSION>-x64.msi"
      ```

1. Install Chef InSpec using one of the following methods:

    - Run the following command in an elevated PowerShell or Command Prompt session:

      ```powershell
      msiexec /i inspec-enterprise-<VERSION>-x64.msi /qn
      ```

      Replace `<VERSION>` with the version number of the downloaded package, for example `inspec-enterprise-7.1.6-1-x64.msi`.

    - Double-click the `.msi` file and follow the on-screen installation wizard.

1. Verify that Chef InSpec is installed:

    ```sh
    inspec version
    ```

    The output displays the installed Chef InSpec version.

1. [Accept the Chef EULA](license#accept-the-chef-eula).

## Install the Chef InSpec Habitat package

### Supported platforms

- Windows x86-64
- Linux x86-64
- Linux ARM64
- macOS ARM64

### Prerequisites

- Chef Automate, and Chef Workstation aren't installed on the target system.
- [Chef Habitat is installed on your workstation](/habitat/install_habitat/).
- [You have a Chef Habitat Builder profile with a personal access token](/habitat/builder_profile/).
- You have a valid Progress Chef license key.
- The target system has an internet connection.

### Install Chef InSpec

To install the Chef InSpec Habitat package, follow these steps:

1. Install the Chef InSpec Habitat package:

    ```sh
    sudo hab pkg install chef/inspec --channel base-2025 --binlink --force --auth <HAB_BUILDER_TOKEN>
    ```

    For more information, see the [Habitat CLI documentation](/habitat/habitat_cli/#hab-pkg-install).

1. Verify that Chef InSpec is installed.

    ```sh
    inspec version
    ```

1. [Accept the Chef EULA](license#accept-the-chef-eula).

## See also

- [Chef Download API documentation](/download/)
- [Uninstall Chef InSpec](/inspec/7.2/manage/uninstall)
- [Upgrade Chef InSpec](/inspec/7.2/manage/upgrade)
