+++
title = "Install Chef Infra Client RC3 with a native installer"
linkTitle = "Native installer"

[menu.install]
title = "Install"
identifier = "install/installer/install"
parent = "install/installer"
weight = 10
+++

The Chef Infra Client native installers provide an efficient way to install Chef Infra Client on Windows, Debian, or RPM-based Linux distributions.
You can download and install the pre-built `.msi`, `.deb`, or `.rpm` packages using your existing package management tools, simplifying the deployment process for managing system configurations.

## Supported platforms

Chef Infra Client is supported on:

- Currently supported Linux distributions and versions running Linux kernel 2.6.32 and later
- Currently supported Windows versions greater than or equal to Windows 10

## Prerequisites

This installation process has the following prerequisites:

- Chef Workstation isn't installed on the target system.
- On Debian-based systems, the dpkg package manager is installed on the target system.
- On RPM-based systems, the RPM and either the DNF or Yum package managers are installed on the target system.

  For Amazon Linux 2, use the RPM and Yum package managers.

- You have a valid Progress Chef license key.
- The target system is connected to the internet.

## Install Chef Infra Client

To install Chef Infra Client , follow these steps:

1. Download the Chef Infra Client installer.

    {{< accordion-list data-allow-all-closed="true" >}}

    {{< accordion-item accordion-title="Download Debian-based installer" >}}

    For Debian-based distributions:

    - Using Wget:

      ```sh
      wget -O "chef-ice-<VERSION>-linux.deb" "https://chefdownload-commercial.chef.io/stable/chef-ice/download?eol=false&license_id=<LICENSE_ID>&m=x86_64&p=linux&pm=deb&v=<VERSION>"
      ```

    - Using curl:

      ```sh
      curl -o "chef-ice-<VERSION>-linux.deb" "https://chefdownload-commercial.chef.io/stable/chef-ice/download?eol=false&license_id=<LICENSE_ID>&m=x86_64&p=linux&pm=deb&v=<VERSION>"
      ```

    {{< /accordion-item >}}
    {{< accordion-item accordion-title="Download RPM-based installer" >}}

    For RPM-based distributions:

    - Using Wget:

      ```sh
      wget -O chef-ice-<VERSION>-linux.rpm "https://chefdownload-commercial.chef.io/stable/chef-ice/download?eol=false&license_id=<LICENSE_ID>&m=x86_64&p=linux&pm=rpm&v=<VERSION>"
      ```

    - Using curl:

      ```sh
      curl -o chef-ice-<VERSION>-linux.rpm "https://chefdownload-commercial.chef.io/stable/chef-ice/download?eol=false&license_id=<LICENSE_ID>&m=x86_64&p=linux&pm=rpm&v=<VERSION>"
      ```

    {{< /accordion-item >}}
    {{< accordion-item accordion-title="Download Windows installer" >}}

    For Windows:

    - Using curl:

      ```sh
      curl -o chef-ice-<VERSION>-windows.msi "https://chefdownload-commercial.chef.io/stable/chef-ice/download?eol=false&license_id=<LICENSE_ID>&m=x86_64&p=windows&pm=msi&v=<VERSION>"
      ```

    - Using PowerShell:

      ```ps1
      Invoke-WebRequest -Uri "https://chefdownload-commercial.chef.io/stable/chef-ice/download?eol=false&license_id=<LICENSE_ID>&m=x86_64&p=windows&pm=msi&v=<VERSION>" -OutFile "chef-ice-<VERSION>-windows.msi"
      ```

    {{< /accordion-item >}}
    {{< /accordion-list >}}

1. Go to the directory with the installer and install the package.

   {{< accordion-list data-allow-all-closed="true" >}}

   {{< accordion-item accordion-title="Install on Debian-based distributions" >}}

   For Debian-based distributions:

   ```sh
   sudo -E dpkg -i chef-ice-<VERSION>-linux.deb
   ```

   {{< /accordion-item >}}
   {{< accordion-item accordion-title="Install on RPM-based distributions" >}}

   For RPM-based distributions:

   ```sh
   sudo -E dnf install chef-ice-<VERSION>-linux.rpm -y
   ```

   or:

   ```sh
   sudo -E rpm -ivh chef-ice-<VERSION>-linux.rpm
   ```

   {{< /accordion-item >}}
   {{< accordion-item accordion-title="Install on Windows" >}}

   Install on Windows:

   - Double-click on the MSI package and install using Windows Package Manager.

   or:

   - Using Powershell:

     ```sh
     msiexec /i "chef-ice-<VERSION>-windows.msi"
     ```

   {{< /accordion-item >}}
   {{< /accordion-list >}}

1. Verify the installation:

    ```sh
    chef-client --version
    ```

## More information

- [Chef Download API documentation](https://docs.chef.io/download/)
