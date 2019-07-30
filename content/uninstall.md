+++
title = "Uninstall"
description = "DESCRIPTION"
draft = false

aliases = "/uninstall.html"

[menu]
  [menu.docs]
    title = "Uninstall"
    identifier = "uninstall/uninstall.html"
    parent = "chef infra/getting started"
    weight = 100
+++    

[\[edit on
GitHub\]](https://github.com/chef/chef-web-docs/blob/master/chef_master/source/uninstall.rst)

The following sections describe how to uninstall Chef, add-ons, and
other components.

Chef Server
===========

{{% ctl_chef_server_uninstall %}}

Chef Manage
===========

To uninstall the Chef management console, do the following:

1.  Run the following command:

    ``` bash
    $ chef-manage-ctl cleanse
    ```

2.  Use the package manager for the platform on which the Chef
    management console is installed, and then uninstall the package
    named `chef-manage`.

<div class="note" markdown="1">

<div class="admonition-title" markdown="1">

Note

</div>

This package used to be named `opscode-manage` and the command line tool
used to be named `opscode-manage-ctl`.

</div>

Chef Analytics
==============

The `uninstall` subcommand is used to remove the Chef Analytics
application, but without removing any of the data. This subcommand will
shut down all services (including the `runit` process supervisor).

This subcommand has the following syntax:

``` bash
$ opscode-analytics-ctl uninstall
```

<div class="note" markdown="1">

<div class="admonition-title" markdown="1">

Note

</div>

To revert the `uninstall` subcommand, run the `reconfigure` subcommand
(because the `start` subcommand is disabled by the `uninstall` command).

</div>

Reporting
=========

The `uninstall` subcommand is used to remove the Reporting add-on to the
Chef Infra Server, but without removing any of the data. This subcommand
will shut down all services (including the `runit` process supervisor).

This subcommand has the following syntax:

``` bash
$ opscode-reporting-ctl uninstall
```

<div class="note" markdown="1">

<div class="admonition-title" markdown="1">

Note

</div>

To revert the `uninstall` subcommand, run the `reconfigure` subcommand
(because the `start` subcommand is disabled by the `uninstall` command).

</div>

Chef Push Jobs
==============

To uninstall Chef Push Jobs, do the following:

1.  Shut down the Chef Push Jobs service.

2.  Uninstall the Chef Push Jobs package.

3.  Run the following command:

    ``` bash
    $ chef-server-ctl reconfigure
    ```

<div class="note" markdown="1">

<div class="admonition-title" markdown="1">

Note

</div>

This will leave some data in PostgreSQL that is not used by any other
Chef application or service.

</div>

push-jobs-client
----------------

Use the package manager for the platform on which Chef Push Jobs is
installed to uninstall Chef Push Jobs.

ChefDK
======

ChefDK can be uninstalled using the steps below that are appropriate for
the platform on which ChefDK is installed.

Debian
------

Use the following command to remove ChefDK on Debian-based platforms:

``` bash
$ dpkg -P chefdk
```

macOS
-----

Use the following commands to remove ChefDK on macOS.

To remove installed files:

``` bash
$ sudo rm -rf /opt/chefdk
```

To remove the system installation entry:

``` bash
$ sudo pkgutil --forget com.getchef.pkg.chefdk
```

To remove symlinks:

-   For Chef Client 12.x, under `/usr/local/bin`:

    ``` bash
    $ sudo find /usr/local/bin -lname '/opt/chefdk/*' -delete
    ```

-   For Chef Client 11.x, under `/usr/bin`:

    ``` bash
    $ sudo find /usr/bin -lname '/opt/chefdk/*' -delete
    ```

Red Hat Enterprise Linux
------------------------

Use the following commands to remove ChefDK on Red Hat Enterprise
Linux-based platforms:

``` bash
$ rpm -qa *chefdk*
$ sudo yum remove -y <package>
```

Microsoft Windows
-----------------

Use **Add / Remove Programs** to remove ChefDK on the Microsoft Windows
platform.
