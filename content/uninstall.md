+++
title = "Uninstall"
draft = false

gh_repo = "chef-web-docs"

aliases = ["/uninstall.html"]
product = ["workstation", "server"]

[menu]
  [menu.infra]
    title = "Uninstall"
    identifier = "chef_infra/install/uninstall.md Uninstall"
    parent = "chef_infra/install"
    weight = 80
+++

The following sections describe how to uninstall Chef, add-ons, and
other components.

## Chef Infra Server

{{% chef-server/ctl_chef_server_uninstall %}}

## Chef Workstation

Chef Workstation can be uninstalled using the steps below that are
appropriate for the platform on which Chef Workstation is installed.

### Debian

Use the following command to remove Chef Workstation on Debian-based
platforms:

```bash
dpkg -P chef-workstation
```

### macOS

Use the following commands to remove Chef Workstation on macOS.

To remove installed files:

```bash
sudo rm -rf /opt/chef-workstation
```

To remove the system installation entry:

```bash
sudo pkgutil --forget com.getchef.pkg.chef-workstation
```

To remove symlinks:

> ```bash
> sudo find /usr/local/bin -lname '`/opt/chef-workstation/*' -delete
> ```

### Red Hat Enterprise Linux

Use the following commands to remove Chef Workstation on Red Hat
Enterprise Linux-based platforms:

```bash
rpm -qa *chef-workstation*
sudo yum remove -y <package>
```

### Windows

Use **Add / Remove Programs** to remove Chef Workstation on the
Windows platform.
