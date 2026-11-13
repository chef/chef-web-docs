+++
title = "Chef InSpec install guide"
draft = false

[menu.inspec_7_1]
    title = "Install Chef InSpec"
    identifier = "install/install"
    parent = "install"
    weight = 10
+++

<!-- cSpell:ignore -->

Chef InSpec 7 installers are available for Windows, Debian, and RPM-based Linux distributions.
You can download and install pre-built `.msi`, `.deb`, or `.rpm` packages using your existing package management tools.

## Supported platforms

Chef InSpec is supported on the following platforms:

- Windows x86-64
- Linux x86-64

## Prerequisites

This installation process has the following prerequisites:

- Chef InSpec, Chef Automate, and Chef Workstation aren't installed on the target system.

  If Chef InSpec is already installed, see the [Chef InSpec uninstall documentation](/inspec/7.1/uninstall/).

- On Windows systems, `tar` is installed.
- On Debian-based systems, the `dpkg` package manager is installed.
- On RPM-based systems, `rpm` and either `dnf` or `yum` are installed. For Amazon Linux 2, use `rpm` and `yum`.
- You have a valid Progress Chef license key.
- The target system is connected to the internet.

## Install Chef InSpec

### Install Chef InSpec on Debian-based systems

To install Chef InSpec on a Debian-based system, follow these steps:

1. Download the Debian-based installer using one of the following methods:

    - Download using `wget`:

      ```sh
      wget -O "inspec-enterprise-<VERSION>-linux.deb" "https://chefdownload-commercial.chef.io/stable/inspec/download?eol=false&license_id=<LICENSE_ID>&m=x86_64&p=linux&pm=deb&v=<VERSION>"
      ```

    - Download using `curl`:

      ```sh
      curl -o "inspec-enterprise-<VERSION>-linux.deb" "https://chefdownload-commercial.chef.io/stable/inspec/download?eol=false&license_id=<LICENSE_ID>&m=x86_64&p=linux&pm=deb&v=<VERSION>"
      ```

    Replace:

    - `<VERSION>` with the version number to install.
    - `<LICENSE_ID>` with your Chef license ID.

1. Install Chef InSpec:

    ```sh
    sudo dpkg -i inspec-enterprise-<VERSION>_amd64.deb
    ```

    Replace `<VERSION>` with the version number of the downloaded package, for example `inspec-enterprise-7.1.6-1_amd64.deb`.

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
      wget -O "inspec-enterprise-<VERSION>-linux.rpm" "https://chefdownload-commercial.chef.io/stable/inspec/download?eol=false&license_id=<LICENSE_ID>&m=x86_64&p=linux&pm=rpm&v=<VERSION>"
      ```

    - Download using `curl`:

      ```sh
      curl -o "inspec-enterprise-<VERSION>-linux.rpm" "https://chefdownload-commercial.chef.io/stable/inspec/download?eol=false&license_id=<LICENSE_ID>&m=x86_64&p=linux&pm=rpm&v=<VERSION>"
      ```

    Replace:

    - `<VERSION>` with the version number to install.
    - `<LICENSE_ID>` with your Chef license ID.

1. Install Chef InSpec using one of the following methods:

    - Install using `rpm`:

      ```sh
      sudo rpm -Uvh inspec-enterprise-<VERSION>.x86_64.rpm
      ```

    - Install using `dnf`:

      ```sh
      sudo dnf install ./inspec-enterprise-<VERSION>.x86_64.rpm
      ```

    - For Amazon Linux 2 or systems using `yum`:

      ```sh
      sudo yum install ./inspec-enterprise-<VERSION>.x86_64.rpm
      ```

    Replace `<VERSION>` with the version number of the downloaded package, for example `inspec-enterprise-7.1.6-1.amzn2.x86_64.rpm`.

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
      Invoke-WebRequest -Uri "https://chefdownload-commercial.chef.io/stable/inspec/download?eol=false&license_id=<LICENSE_ID>&m=x86_64&p=windows&pm=msi&v=<VERSION>" -OutFile "inspec-enterprise-<VERSION>-windows.msi"
      ```

1. Install Chef InSpec using one of the following methods:

    - Run the following command in an elevated PowerShell or Command Prompt session:

      ```powershell
      msiexec /i inspec-enterprise-<VERSION>-x64.msi /qn
      ```

      Replace `<VERSION>` with the version number of the downloaded package, for example `inspec-enterprise-7.1.6-1_x64.msi`.

    - Double-click the `.msi` file and follow the on-screen installation wizard.

1. Verify that Chef InSpec is installed:

    ```sh
    inspec version
    ```

    The output displays the installed Chef InSpec version.

1. [Accept the Chef EULA](license#accept-the-chef-eula).

## Upgrade Chef InSpec

To upgrade Chef InSpec to a newer version:

1. [Uninstall the current version](/inspec/7.1/uninstall/) using the steps for your platform.
1. Download and install the new version using the steps for your platform using the instruction on this page.

## More information

- [Chef Download API documentation](/download/)
