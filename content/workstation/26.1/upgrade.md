+++
title = "Upgrade Chef Workstation and its components"

[menu.workstation_26_1]
title = "Upgrade"
identifier = "workstation_26_1/upgrade"
+++

Chef Workstation 26.1 and later uses native installers for Debian, RPM, and Windows.
To upgrade, install the latest version for your operating system.

## Upgrade on Debian-based systems

To upgrade Chef Workstation on a Debian-based system, follow these steps:

1. Download the latest Debian-based installer using one of the following methods:

   - Download using `wget`:

     ```shell
     wget -O "chef-workstation-enterprise-<VERSION>-linux.deb" "https://chefdownload-commercial.chef.io/stable/chef-workstation-enterprise/download?eol=false&license_id=<LICENSE_ID>&m=x86_64&p=linux&pm=deb&v=<VERSION>"
     ```

   - Download using `curl`:

     ```shell
     curl -o "chef-workstation-enterprise-<VERSION>-linux.deb" "https://chefdownload-commercial.chef.io/stable/chef-workstation-enterprise/download?eol=false&license_id=<LICENSE_ID>&m=x86_64&p=linux&pm=deb&v=<VERSION>"
     ```

   Replace:
   - `<VERSION>` with the version number to upgrade to.
   - `<LICENSE_ID>` with your Chef license ID.

1. Install the new version:

   ```shell
   sudo dpkg -i chef-workstation-enterprise-<VERSION>_amd64.deb
   ```

   Replace `<VERSION>` with the version number of the downloaded package.

## Upgrade on RPM-based systems

To upgrade Chef Workstation on an RPM-based system, follow these steps:

1. Download the latest RPM-based installer using one of the following methods:

   - Download using `wget`:

     ```shell
     wget -O "chef-workstation-enterprise-<VERSION>-linux.rpm" "https://chefdownload-commercial.chef.io/stable/chef-workstation-enterprise/download?eol=false&license_id=<LICENSE_ID>&m=x86_64&p=linux&pm=rpm&v=<VERSION>"
     ```

   - Download using `curl`:

     ```shell
     curl -o "chef-workstation-enterprise-<VERSION>-linux.rpm" "https://chefdownload-commercial.chef.io/stable/chef-workstation-enterprise/download?eol=false&license_id=<LICENSE_ID>&m=x86_64&p=linux&pm=rpm&v=<VERSION>"
     ```

   Replace:
   - `<VERSION>` with the version number to upgrade to.
   - `<LICENSE_ID>` with your Chef license ID.

1. Install the new version:

   ```shell
   sudo dnf install chef-workstation-enterprise-<VERSION>.x86_64.rpm
   ```

   Alternatively:

   ```shell
   sudo rpm -Uvh chef-workstation-enterprise-<VERSION>.x86_64.rpm
   ```

   Replace `<VERSION>` with the version number of the downloaded package.

## Upgrade on Windows

To upgrade Chef Workstation on Windows, follow these steps:

1. Download the latest Windows installer:

   ```powershell
   Invoke-WebRequest -Uri "https://chefdownload-commercial.chef.io/stable/chef-workstation-enterprise/download?eol=false&license_id=<LICENSE_ID>&m=x86_64&p=windows&pm=msi&v=<VERSION>" -OutFile "chef-workstation-enterprise-<VERSION>_x86_64.msi"
   ```

   Replace:
   - `<VERSION>` with the version number to upgrade to.
   - `<LICENSE_ID>` with your Chef license ID.

1. Install the new version:

   ```powershell
   msiexec /i chef-workstation-enterprise-<VERSION>_x86_64.msi
   ```

   Replace `<VERSION>` with the version number of the downloaded package.

## Next steps

- [Set up Workstation](/workstation/26.1/set_up/)
- [Add a license](/workstation/26.1/license/)

## See also

- [Install Chef Workstation](install)
- [Uninstall Chef Workstation](uninstall)
