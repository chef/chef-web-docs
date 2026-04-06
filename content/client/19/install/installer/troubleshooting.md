+++
title = "Chef Infra Client native installer troubleshooting"

[menu.install]
title = "Troubleshooting"
identifier = "install/installer/troubleshooting"
parent = "install/installer"
weight = 200
+++

## Conflicts with Chef Workstation

If the Chef Workstation is already on your system, the installation process fails with a conflict.

- On Debian-based systems, the installer returns the following error:

  ```sh
  Selecting previously unselected package chef-infra-client.
  dpkg: regarding chef-ice-19.2.rc3-linux.deb containing chef-infra-client:
  chef-infra-client conflicts with chef-workstation
    chef-workstation (version 0.4.2-1) is present and installed.

  dpkg: error processing archive chef-ice-19.2.rc3-linux.deb (--install):
  conflicting packages - not installing chef-infra-client
  Errors were encountered while processing:
  chef-ice-19.2.rc3-linux.deb
  ```

- On RPM-based systems, the installer returns the following error:

  ```sh
  Error:
  Problem: package chef-ice-19.2.rc3-linux from @System conflicts with chef-workstation provided by chef-workstation-25.1.1074-1.amazon2023.x86_64 from @commandline
    - conflicting requests
    - problem with installed package chef-ice-19.2.rc3-linux
  (try to add '--allowerasing' to command line to replace conflicting packages or '--skip-broken' to skip uninstallable packages)
  ```

- On Windows, the Windows Package Manager displays the following error:

  ```plain
  Chef Workstation is installed. Please uninstall it before installing Chef Infra (air-gapped).
  ```

To resolve the error:

1. [Uninstall Chef Workstation](https://docs.chef.io/workstation/install_workstation/#uninstalling).
1. [Reinstall Chef Infra Client](install).

## Error: Invalid license

The installation process requires a valid Progress Chef License key.

The installer returns the following error if you don't add a valid license:

```sh
Validating chef-client license with https://services.chef.io
Invalid License Key: ssfree-833b40cf-336a-42ee-b71d-f14a0
chef-client installation failed. Error: invalid license
warning: %post(chef-infra-client-19.1.0-1.amzn2.x86_64) scriptlet failed, exit status 1

Error in POSTIN scriptlet in rpm package chef-infra-client
  Verifying        : chef-infra-client-19.1.0-1.amzn2.x86_64
```

To resolve this error:

1. Add a valid Progress Chef License key to your machine's environment:

    {{< accordion-list data-multi-expand="true" data-allow-all-closed="true" >}}
    {{< accordion-item accordion-title="Add license key on Linux" accordion-title-link="add-license-key-linux" >}}

    Add a Progress Chef license key on Linux:

    ```sh
    export CHEF_LICENSE_KEY=<LICENSE_KEY>
    ```

    Replace `<LICENSE_KEY>` with your Progress Chef license key.

    {{< /accordion-item >}}
    {{< accordion-item accordion-title="Add license key on Windows" accordion-title-link="add-license-key-windows" >}}

    Add a Progress Chef license key on Windows:

    ```ps1
    [System.Environment]::SetEnvironmentVariable("CHEF_LICENSE_KEY", "<LICENSE_KEY>", "Machine")
    ```

    Replace `<LICENSE_KEY>` with your Progress Chef license key.

    {{< /accordion-item >}}
    {{< /accordion-list >}}

2. Install Chef Infra Client:

    {{< accordion-list data-multi-expand="false" data-allow-all-closed="true" id="install-infra-client" >}}
    {{< accordion-item accordion-title="Install on Debian distributions" accordion-title-link="install-infra-client-deb" >}}

    Install on Debian-based distributions:

    ```sh
    sudo -E dpkg -i chef-ice-19.2.rc3-linux.deb
    ```

    {{< /accordion-item >}}
    {{< accordion-item accordion-title="Install on RPM distributions" accordion-title-link="install-infra-client-rpm">}}

    Install on RPM-based distributions using the `dnf reinstall` command:

    ```sh
    sudo -E dnf reinstall chef-ice-19.2.rc3-linux.rpm
    ```

    {{< /accordion-item >}}
    {{< accordion-item accordion-title="Install on Windows" accordion-title-link="install-infra-client-windows">}}

    Install on Windows:

    - Double-click on the MSI package and install using the Windows Package Manager.

    or:

    - Install the MSI package with Powershell:

      ```sh
      msiexec /i "chef-ice-19.2.rc3-windows.msi"
      ```

    {{< /accordion-item >}}
    {{< /accordion-list >}}
