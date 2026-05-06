+++
title = "Uninstall Chef Manage"
draft = false
gh_repo = "chef-web-docs"

[menu]
  [menu.legacy]
    title = "Uninstall"
    identifier = "legacy/manage/uninstall"
    parent = "legacy/manage"
    weight = 15
+++

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
