+++
title = "Install ChefDK"
draft = false

aliases = "/install_dk.html"

[menu]
  [menu.docs]
    title = "ChefDK"
    identifier = "chef_infra/setup/install_dk.md ChefDK"
    parent = "chef_infra/setup"
    weight = 10
+++    

[\[edit on
GitHub\]](https://github.com/chef/chef-web-docs/blob/master/chef_master/source/install_dk.rst)

{{< note >}}

[Chef Workstation](https://downloads.chef.io/chef-workstation/) gives
you everything you need to get started with Chef — ad hoc remote
execution, remote scanning, configuration tasks, cookbook creation tools
as well as robust dependency and testing software — all in one
easy-to-install package. Chef Workstation replaces ChefDK, combining all
the existing features with new features, such as ad-hoc task support and
the new Chef Workstation desktop application. Chef will continue to
maintain ChefDK, but new development will take place in Chef Workstation
without backporting features.

{{< /note >}}

The ChefDK package is produced by the [Chef
Omnibus](https://github.com/chef/omnibus) tool for installation on a
workstation. ChefDK includes:

-   Chef Infra Client
-   Embedded versions of Ruby, RubyGems, and the Ruby interpreter, all
    of which are build from the source. (The Ruby interpreter is not
    available for Windows)
-   An embedded version of OpenSSL
-   Test Kitchen
-   Cookstyle
-   ChefSpec

ChefDK installs to `/opt/chefdk/` on macOS / Linux and
`C:\opscode\chefdk\` on Windows. These file locations should help avoid
interference between these components and other applications that may be
running on the target machine.

Install
=======

The ChefDK installer must run as a privileged user.

macOS
-----

1.  Dependency: Xcode is recommended for running ChefDK on OSX. While
    ChefDK works without Xcode, it is required for native Ruby Gem
    installation. Run `xcode-select --install` from the terminal to
    install Xcode.
2.  Visit the [ChefDK downloads
    page](https://downloads.chef.io/chefdk#mac_os_x) and select the
    appropriate package for your macOS version. Click on the
    **Download** button.
3.  Follow the steps to accept the license and install ChefDK. You will
    have the option to change your install location; by default the
    installer uses the `/opt/chefdk/` directory.

Windows
-------

1.  Visit the [ChefDK downloads
    page](https://downloads.chef.io/chefdk#windows) and select the
    appropriate package for your Windows version. Click on the
    **Download** button.
2.  Follow the steps to accept the license and install ChefDK. You will
    have the option to change your install location; by default the
    installer uses the `C:\opscode\chefdk\` directory.
3.  **Optional:** Set the default shell. On Microsoft Windows it is
    strongly recommended to use Windows PowerShell and `cmd.exe`.

See the [ChefDK on Windows](/dk_windows/) guide for additional
caveats and configuration options specific to Windows.

Linux
-----

1.  Visit the [ChefDK downloads page](https://downloads.chef.io/chefdk)
    and download the appropriate package for your distribution:

    ``` bash
    wget https://packages.chef.io/files/stable/chefdk/3.2.30/ubuntu/18.04/chefdk_3.2.30-1_amd64.deb
    ```

2.  Use your distribution's package manager to install ChefDK:

    -   Red Hat Enterprise Linux:

        ``` bash
        rpm -Uvh chefdk-3.2.30-1.el7.x86_64.rpm
        ```

    -   Debian/Ubuntu:

        ``` bash
        dpkg -i chefdk_3.2.30-1_amd64.deb
        ```

Next Steps
==========

Now that you've installed ChefDK, proceed to the [ChefDK
Setup](/chefdk_setup/) guide to configure your ChefDK installation.
