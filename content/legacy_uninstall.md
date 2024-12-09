+++
title = "Uninstall Legacy Products"
draft = false
gh_repo = "chef-web-docs"

[menu]
  [menu.legacy]
    title = "Uninstall"
    identifier = "legacy/uninstall"
    parent = "legacy"
    weight = 999
+++

## Chef Analytics

Use the `uninstall` subcommand to remove the Chef Analytics application, but without removing any of the data. This subcommand will shut down all services (including the `runit` process supervisor).

This subcommand has the following syntax:

```bash
opscode-analytics-ctl uninstall
```

{{< note >}}

To revert the `uninstall` subcommand, run the `reconfigure` subcommand (because the `start` subcommand is disabled by the `uninstall` command).

{{< /note >}}

## Reporting

Use the `uninstall` subcommand to remove the Reporting add-on to the Chef Infra Server, but without removing any of the data. This subcommand will shut down all services (including the `runit` process supervisor).

This subcommand has the following syntax:

```bash
opscode-reporting-ctl uninstall
```

{{< note >}}

To revert the `uninstall` subcommand, run the `reconfigure` subcommand (because the `start` subcommand is disabled by the `uninstall` command).

{{< /note >}}

## Uninstall Chef management console

To uninstall the Chef management console, do the following:

1. Run the following command:

    ```bash
    chef-manage-ctl cleanse
    rm -fr /var/opt/opscode/nginx/etc/addon.d/*manage*
    chef-server-ctl restart nginx
    ```

1. Use the package manager for the platform on which the Chef management console is installed, and then uninstall the package named `chef-manage`.

{{< note >}}

This package used to be named `opscode-manage` and the command line tool used to be named `opscode-manage-ctl`.

{{< /note >}}
