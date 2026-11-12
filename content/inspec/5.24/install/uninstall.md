+++
title = "Uninstall Chef InSpec"
draft = false


[menu.inspec_5_24]
    title = "Uninstall"
    identifier = "install/uninstall"
    parent = "install"
    weight = 40
+++

You can uninstall Chef InSpec using the steps below that are appropriate for the
method of Chef InSpec installation.

## macOS

### Homebrew

Use the following _destructive_ command to remove the Chef InSpec standalone Homebrew package:

```bash
brew cask uninstall inspec
```

### CLI

Use the following _destructive_ command in your terminal to remove the Chef InSpec package:

```bash
sudo rm -rf /opt/inspec
```

## Windows

### Installer

Use _Add / Remove Programs_ to remove Chef InSpec.

## Linux

### CLI

Use the following _destructive_ commands to uninstall Chef InSpec from Linux-based platforms.

For Ubuntu, use the following _destructive_ command to uninstall Chef InSpec:

```bash
sudo dpkg -P inspec
```

For Red Hat Enterprise Linux, use the following _destructive_ command to uninstall Chef InSpec:

```bash
sudo rpm -e inspec
```

For SUSE Linux Enterprise Server, use the following _destructive_ command to uninstall Chef InSpec:

```bash
sudo zypper remove inspec
```
