+++
title = "Install Chef InSpec"
draft = false

[menu.inspec_5_23]
    title = "Install"
    identifier = "install/install"
    parent = "install"
    weight = 20
+++

Use [Chef Downloads](https://www.chef.io/downloads), an installer, script, or package manager to install Chef InSpec.

To see which platforms and platform versions Chef InSpec is supported on, see the [InSpec's platforms documentation](/inspec/5.23/install/platforms/).

## macOS

### CLI

You can install Chef InSpec using a curl script.

```bash
curl -L https://chefdownload-commercial.chef.io/install.sh?license_id=<LICENSE_ID> | sudo bash -s -- -P inspec
```

Replace `<LICENSE_ID>` with your license ID.

For more information about the install script, see the [Chef Install Script documentation](/chef_install_script/).

## Windows

### Installer

Download a Windows Chef InSpec package from [Chef Downloads](https://www.chef.io/downloads),
then double-click on the `.msi` file to launch the installer and follow the prompts.

### Powershell

You can install Chef InSpec using the following Powershell script.

```powershell
. { iwr -useb https://chefdownload-commercial.chef.io/install.ps1?license_id=<LICENSE_ID> } | iex; install -project inspec
```

Replace `<LICENSE_ID>` with your license ID.

For more information about the install script, see the [Chef Install Script documentation](/chef_install_script/).

Once you have installed Chef InSpec, run `inspec version` to verify that the installation
was successful.

## Linux

### CLI

The following curl script will install Chef InSpec for Ubuntu and Red Hat Enterprise Linux:

```bash
curl https://chefdownload-commercial.chef.io/install.sh?license_id=<LICENSE_ID> | sudo bash -s -- -P inspec
```

Replace `<LICENSE_ID>` with your license ID.

For more information about the install script, see the [Chef Install Script documentation](/chef_install_script/).

If you prefer, you can use a package manager to install Chef InSpec.
Once you downloaded the latest [Chef InSpec package](https://www.chef.io/downloads)
relevant to your Linux-based platform, use the command for the respective package
manager listed below. Replace the example file path with the file path leading to
your downloaded package.

For Ubuntu, use the following command to install Chef InSpec:

```bash
sudo dpkg -i /path/to/inspec.deb
```

For Red Hat Enterprise Linux, use the following command to install Chef InSpec:

```bash
sudo rpm -U /path-to/inspec.rpm
```

For SUSE Linux Enterprise Server, use the following command to install Chef InSpec:

```bash
sudo zypper install /path-to/inspec.rpm
```
