+++
title = "Install knife"

[menu.workstation_26_1]
title = "Install"
identifier = "workstation_26_1/tools/knife/install"
parent = "workstation_26_1/tools/knife"
weight = 20
+++

knife is included as a component of Chef Workstation, but you can also install it as a standalone package.
The knife standalone installation doesn't include the knife cloud provider plugins (knife-ec2, knife-google, knife-windows).
For that reason, Progress Chef recommends installing Chef Workstation, which includes knife and the knife cloud provider plugins.

If you want to install knife as a standalone component, follow the steps below.

## Requirements

knife has the following requirements:

- Supported on Linux (Ubuntu 18.04+, CentOS 7+, RHEL 7+), macOS 10.15+, or Windows 10/Server 2016+
- Chef Habitat 1.6.0 or later installed
- Internet connectivity for package download and bootstrapping remote nodes
- SSH or WinRM to manage remote nodes

## Install the knife standalone package

To install the knife standalone package, follow these steps:

1. Install knife:

    ```sh
    hab pkg install chef/knife --channel unstable --binlink --force
    ```

1. Optional: After installation, verify knife is installed and working:

    ```sh
    knife --version
    ```

## Next steps

- [Add a license](/workstation/26.1/license)
- [Set up Workstation](/workstation/26.1/set_up)
