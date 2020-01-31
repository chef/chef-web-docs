+++
title = "Installing Chef on Windows"
draft = false

aliases = "/dk_windows.html"

[menu]
  [menu.docs]
    title = "Chef Workstation and ChefDK on Windows"
    identifier = "chef_infra/getting_started/chef_on_windows_guide/dk_windows.md Chef Workstation and ChefDK on Windows"
    parent = "chef_infra/getting_started/chef_on_windows_guide"
    weight = 20
+++    

[\[edit on GitHub\]](https://github.com/chef/chef-web-docs/blob/master/content/dk_windows.md)

Chef Workstation
================

Start your infrastructure automation quickly and easily with [Chef
Workstation](https://www.chef.sh/) Chef Workstation gives you everything
you need to get started with Chef — ad hoc remote execution, remote
scanning, configuration tasks, cookbook creation tools as well as robust
dependency and testing software — all in one easy-to-install package.

Chef Workstation replaces ChefDK, combining all the existing features
with new features, such as ad-hoc task support and the new Chef
Workstation desktop application. Chef will continue to maintain ChefDK,
but new development will take place in Chef Workstation without
back-porting features.

[Download Chef Workstation](https://downloads.chef.io/chef-workstation/)

Chef Workstation Supported Platforms
------------------------------------

Supported Host Operating Systems:

<table>
<caption>Supported Host Operating System</caption>
<colgroup>
<col style="width: 50%" />
<col style="width: 50%" />
</colgroup>
<thead>
<tr class="header">
<th>Platform</th>
<th>Version</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td>Apple macOS</td>
<td>10.13, 10.14, 10.15</td>
</tr>
<tr class="even">
<td>Microsoft Windows</td>
<td>10, Server 2012, Server 2012 R2, Server 2016, Server 2019</td>
</tr>
<tr class="odd">
<td>Red Hat Enterprise Linux / CentOS</td>
<td>6.x, 7.x, 8.x</td>
</tr>
<tr class="even">
<td>Ubuntu</td>
<td>16.04, 18.04</td>
</tr>
<tr class="odd">
<td>Debian</td>
<td>8.x, 9.x</td>
</tr>
</tbody>
</table>

<table>
<caption>Supported Target Operating System</caption>
<colgroup>
<col style="width: 50%" />
<col style="width: 50%" />
</colgroup>
<thead>
<tr class="header">
<th>Platform</th>
<th>Version</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td>Microsoft Windows</td>
<td>10, Server 2012, Server 2012 R2, Server 2016, Server 2019</td>
</tr>
<tr class="even">
<td>Red Hat Enterprise Linux</td>
<td>6.x, 7.x, 8.x</td>
</tr>
<tr class="odd">
<td>SUSE Enterprise Linux Server</td>
<td>12 SP1+, 15.x</td>
</tr>
<tr class="even">
<td>Ubuntu</td>
<td>16.04, 18.04</td>
</tr>
<tr class="odd">
<td>Debian</td>
<td>8.x, 9.x</td>
</tr>
</tbody>
</table>

Chef Workstation System Requirements
------------------------------------

Minimum system requirements:

-   RAM: 2GB
-   Disk: 4GB
-   Running minimum settings may limit your ability to take advantage of
    Chef Workstation tools such as Test Kitchen which creates and
    manages virtualized test environments.

Recommended system requirements:

-   RAM: 4GB
-   Disk 8GB

Chef Workstation App
--------------------

-   Windows: No additional requirements
-   Mac: No additional requirements
-   

    Linux:

    :   -   You must have a graphical window manager running
        -   Additional libraries may be required. See [Running the Chef
            Workstation App](https://chef-workstation-app.html) for more
            details.

Installing ChefDK
=================

In some cases, such as if you're working with older or unsupported
systems, you may need to use ChefDK instead of Chef Workstation.
Download ChefDK by following the installation instructions on
[Installing ChefDK](/install_dk/).

1.  Visit the [ChefDK downloads page](https://downloads.chef.io/chefdk)
    and select the appropriate package for your Windows version. Select
    the **Download** button.
2.  Follow the steps to accept the license and install ChefDK. You will
    have the option to change your install location; by default the
    installer uses the `C:\opscode\chefdk\` directory.

Verify the Chef Workstation or ChefDK Installation
--------------------------------------------------

To verify the installation, run:

``` shell
chef -v
```

Which returns the versions of all installed Chef tools:

``` shell
Chef Workstation version: 0.14.16
Chef Infra Client version: 15.6.10
Chef InSpec version: 4.18.39
Chef CLI version: 2.0.0
Test Kitchen version: 2.3.4
Cookstyle version: 5.19.9
```

### Spaces and Directories

{{% windows_spaces_and_directories %}}

### Top-level Directory Names

{{% windows_top_level_directory_names %}}

Install a Code Editor
---------------------

A good visual code editor is not a requirement for working with Chef,
but a good code editor can save you time. A code editor should support
the following: themes, plugins, snippets, syntax Ruby code
coloring/highlighting, multiple cursors, a tree view of the entire
folder/repository you are working with, and a Git integration.

These are a few common editors:

-   [Visual Studio Code (free/open
    source)](https://code.visualstudio.com/)
-   [GitHub Atom - (free/open source)](https://atom.io/)

Chef support in editors:

-   [VSCode Chef
    Extension](https://marketplace.visualstudio.com/items?itemName=chef-software.Chef)
-   [Chef on Atom](https://atom.io/packages/language-chef)

Install the Windows Tools
-------------------------

> -   [Azure-cli](https://azure.microsoft.com/en-gb/downloads/)
> -   [Azure Resource Manager
>     Tools](https://marketplace.visualstudio.com/items?itemName=msazurermtools.azurerm-vscode-tools)
> -   If you are using Visual Studio Code, add the [Microsoft Azure SDK
>     for .NET](https://azure.microsoft.com/en-us/tools/) for help with
>     writing Azure Resource Manager JSON deployment templates.
> -   [PowerShellGet](https://docs.microsoft.com/en-us/powershell/azure/install-azurerm-ps?view=azurermps-6.12.0)
