+++
title = "Install Chef Workstation"
draft = false


[menu]
  [menu.workstation_25]
    title = "Install"
    identifier = "workstation_25/install.md Install Chef Workstation"
    weight = 20
+++
<!-- markdownlint-disable-file MD033 -->

{{< readfile file="content/workstation/25/reusable/md/chef_workstation.md" >}}

For general information about downloading Chef products, see the [Chef download documentation](/download/).

For supported Chef Workstation versions, see the [Chef Workstation release notes](/release_notes/workstation/) or use the [Chef download APIs](/download).

## Supported Platforms

The following table lists the commercially supported platforms and versions for Chef Workstation:

| Platform                          | Architecture                | Version                                                                    |
|-----------------------------------| ----------------------------| ---------------------------------------------------------------------------|
| Amazon Linux                      | x86_64, arch64 (2023 only)  | 2.x, 2023                                                                  |
| macOS                             | aarch64                     | 13.x, 14.x                                                                 |
| Debian                            | x86_64                      | 10.x, 11.x                                                                 |
| Red Hat Enterprise Linux / CentOS | x86_64                      | 7.x, 8.x, 9.x                                                              |
| Ubuntu                            | x86_64                      | 18.04, 20.04, 22.04                                                        |
| Windows                           | x64                         | 10, 11, Server 2016, Server 2019, Server 2022                              |

### Derived Platforms

The following table lists supported derived platforms and versions for Chef Workstation.

See our policy on [support for derived platforms](/platforms/#support-for-derived-platforms) for more information.

| Platform | Architecture | Version | Parent platform |
| --- | --- | --- | --- |
| AlmaLinux | `x86_64` | `8.x` | CentOS |
| Rocky Linux | `x86_64` | `8.x` | CentOS |

## System Requirements

Minimum system requirements:

- RAM: 4GB
- Disk: 8GB
- Additional memory and storage space may be necessary to take advantage of Chef Workstation tools such as Test Kitchen which creates and manages virtualized test environments.

Additional Chef Workstation App Requirements:

- On Linux, you must have a graphical window manager running with support for system tray icons. For some distributions you may also need to install additional libraries. After you install the Chef Workstation package from the terminal, the post-install message will tell you which, if any, additional libraries are required to run the Chef Workstation App.

## Installation

The Chef Workstation installer must run as a privileged user.

Chef Workstation installs to `/opt/chef-workstation/` on macOS and Linux, and `C:\opscode\chef-workstation\` on Windows.
These file locations help avoid interference between these components and other applications that may be running on the target machine.

### macOS Install

1. Visit [Chef Downloads](https://www.chef.io/downloads) to download a Chef Workstation package.
1. Follow the steps to accept the license and install Chef Workstation.

Alternatively, install Chef Workstation using the [Homebrew](https://brew.sh/) package manager:

`brew install --cask chef-workstation`

### Windows Install

1. Visit [Chef Downloads](https://www.chef.io/downloads) to download a Chef Workstation package.
1. Follow the steps to accept the license and install Chef Workstation. You will have the option to change your install location; by default the installer uses the `C:\opscode\chef-workstation\` directory.
1. **Optional:** Set the default shell. On Windows, Progress Chef strongly recommends using Windows PowerShell instead of `cmd.exe`.

Alternatively, install Chef Workstation using the [Chocolatey](https://chocolatey.org/) package manager:

`choco install chef-workstation`

#### Headless Unattended Install

"Headless" systems are configured to operate without a monitor (the "head") keyboard, and mouse. They're usually administered remotely using protocols such as SSH or WinRM.

Chef Workstation can be installed on a headless system using the `msiexec` command and flags to skip the installation of the Chef Workstation Application, which requires a GUI. Run the following command in Windows PowerShell or `cmd.exe`, replacing `MsiPath` with the path of the downloaded Chef Workstation installer.

```powershell
msiexec /q /i MsiPath ADDLOCAL=ALL REMOVE=ChefWSApp
```

#### Spaces and Directories

Directories that are used by Chef products on Windows can't have
spaces. For example, `C:\Users\User Name` won't work, but
`C:\Users\UserName` will. Chef commands may fail if used against a
directory with a space in its name.

#### Top-level Directory Names

Windows will throw errors when path name lengths are too long. For this
reason, it's often helpful to use a short top-level directory, much
like what's done in UNIX and Linux. For example, Chef uses `/opt/` to
install Chef Workstation on macOS. A similar approach can be done on
Windows, by creating a top-level directory with a short name.
For example: `C:\chef`.

### Linux

You can use [Chef's download APIs](/download) or a package manager to install Chef Workstation on Linux.

#### Download API

- To use the [Chef download APIs](/download) to download Chef Workstation:

  ```bash
  wget https://chefdownload-commercial.chef.io/stable/chef-workstation/download?p=<PLATFORM>&pv=<PLATFORM_VERSION>&m=<ARCHITECTURE>&v=<WORKSTATION_VERSION>&license_id=<LICENSE_ID>
  ```

  Replace:

  - `<PLATFORM>` with the platform you want to run Chef Workstation on. For example, `ubuntu` or `el`.
  - `<PLATFORM_VERSION>` with the version of the platform you want to run Chef Workstation on.
  - `<ARCHITECTURE>` with the architecture that Chef Workstation on. For example, `x86_64`.
  - `<WORKSTATION_VERSION>` with the version of Chef Workstation you want to download.
  - `<LICENSE_ID>` with your [Chef license ID](/licensing).

  For example, run the following to download Chef Workstation 24.8.1068 on Red Hat Enterprise Linux 9 running on x86-64 architecture:

  ```sh
  wget https://chefdownload-commercial.chef.io/stable/chef-workstation/download?p=el&pv=9&m=x86_64&v=24.4.1068&license_id=<LICENSE_ID>
  ```

See the [Chef download API documentation](/download) and [Chef licensing documentation](/licensing) for more information.

#### Package manager

You can use Yum or Dpkg package managers to install Chef Workstation.

- To download Chef Workstation using Yum on Red Hat Enterprise Linux:

  ```bash
  yum localinstall chef-workstation-<WORKSTATION_VERSION>-1.el<RHEL_VERSION>.x86_64.rpm
  ```

  For example:

  ```bash
  yum localinstall chef-workstation-24.4.1064-1.el8.x86_64.rpm
  ```

- To download Chef Workstation using Dpkg on Ubuntu or Debian:

  ```bash
  dpkg -i chef-workstation_<WORKSTATION_VERSION>-1_amd64.deb
  ```

  For example:

  ```sh
  dpkg -i chef-workstation_24.4.1064-1_amd64.deb
  ```

## Verify the Installation

To verify the installation, run:

```shell
chef -v
```

Which returns the versions of all installed Chef tools:

```shell
Chef Workstation version: 24.6.1066
Chef Infra Client version: 18.5.0
Chef InSpec version: 5.22.55
Chef CLI version: 5.6.14
Chef Habitat version: 1.6.1041
Test Kitchen version: 3.6.0
Cookstyle version: 7.32.8
```

## Upgrading

To upgrade from ChefDK or an earlier release of Chef Workstation, follow the instructions provided under [Installing]({{< ref "install.md" >}}).

## Uninstalling

### Mac Uninstall

Run `uninstall_chef_workstation` in your terminal.

### Windows Uninstall

Use **Add / Remove Programs** to remove Chef Workstation.

### Linux Uninstall

Ubuntu, Debian, and related:

```bash
sudo dpkg -P chef-workstation
```

Red Hat, CentOS, and related:

```bash
sudo yum remove chef-workstation
```

## Next steps

Now that you've installed Chef Workstation, proceed to the [Setup]({{< relref "set_up.md" >}}) guide to configure your Chef Workstation installation.
