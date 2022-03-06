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

{{% ctl_chef_server_uninstall %}}

## Chef Manage

To uninstall the Chef management console, do the following:

1. Run the following command:

    ```bash
    chef-manage-ctl cleanse
    rm -fr /var/opt/opscode/nginx/etc/addon.d/*manage*
    chef-server-ctl restart nginx
    ```

2. Use the package manager for the platform on which the Chef
    management console is installed, and then uninstall the package
    named `chef-manage`.

{{< note >}}

This package used to be named `opscode-manage` and the command line tool
used to be named `opscode-manage-ctl`.

{{< /note >}}

## Chef Analytics

The `uninstall` subcommand is used to remove the Chef Analytics
application, but without removing any of the data. This subcommand will
shut down all services (including the `runit` process supervisor).

This subcommand has the following syntax:

```bash
opscode-analytics-ctl uninstall
```

{{< note >}}

To revert the `uninstall` subcommand, run the `reconfigure` subcommand
(because the `start` subcommand is disabled by the `uninstall` command).

{{< /note >}}

## Reporting

The `uninstall` subcommand is used to remove the Reporting add-on to the
Chef Infra Server, but without removing any of the data. This subcommand
will shut down all services (including the `runit` process supervisor).

This subcommand has the following syntax:

```bash
opscode-reporting-ctl uninstall
```

{{< note >}}

To revert the `uninstall` subcommand, run the `reconfigure` subcommand
(because the `start` subcommand is disabled by the `uninstall` command).

{{< /note >}}

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
