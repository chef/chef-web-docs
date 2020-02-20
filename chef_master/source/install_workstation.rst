=====================================================
Install Chef Workstation
=====================================================
`[edit on GitHub] <https://github.com/chef/chef-web-docs/blob/master/chef_master/source/install_workstation.rst>`__

Start your infrastructure automation quickly and easily with `Chef Workstation <https://www.chef.sh/>`__ . Chef Workstation gives you everything you need to get started with Chef - ad hoc remote execution, remote scanning, configuration tasks, cookbook creation tools as well as robust dependency and testing software - all in one easy-to-install package.

Chef Workstation includes:

* Chef Infra Client
* Chef InSpec
* chef and knife command line tools
* Testing tools such as Test Kitchen, ChefSpec, and Cookstyle
* Everything else needed to author cookbooks and upload them to the Chef Infra Server

Supported Platforms
====================================================

Supported Host Operating Systems:

.. list-table::
   :widths: 15 15
   :header-rows: 1

   * - Platform
     - Version
   * - Apple macOS
     - 10.13, 10.14, 10.15
   * - Microsoft Windows
     - 10, Server 2012, Server 2012 R2, Server 2016, Server 2019
   * - Red Hat Enterprise Linux / CentOS
     - 6.x, 7.x, 8.x
   * - Ubuntu
     - 16.04, 18.04
   * - Debian
     - 8.x, 9.x, 10.x

System Requirements
====================================================

Minimum system requirements:

* RAM: 2GB
* Disk: 4GB
* Running minimum settings may limit your ability to take advantage of Chef
  Workstation tools such as Test Kitchen which creates and manages virtualized
  test environments.

Recommended system requirements:

* RAM: 4GB
* Disk 8GB

Chef Workstation App Requirements
-----------------------------------------------------

* Windows: No additional requirements
* Mac: No additional requirements
* Linux: You must have a graphical window manager running with support for system tray icons.

  * On some distributions you may need to install additional libraries. After you install the Chef Workstation package from the terminal, the post-install message will tell you which, if any, additional libraries are required to run the Chef Workstation App.

Installation
=====================================================
The Chef Workstation installer must run as a privileged user.

Chef Workstation installs to ``/opt/chef-workstation/`` on macOS / Linux and ``C:\opscode\chef-workstation\`` on Windows. These file locations should help avoid interference between these components and other applications that may be running on the target machine.

macOS
-----------------------------------------------------

#. Dependency: Xcode is recommended for running Chef Workstation on macOS. While Chef Workstation works without Xcode, it is required for native Ruby Gem installation. Run ``xcode-select --install`` from the terminal to install Xcode.
#. Visit the `Chef Workstation downloads page <https://downloads.chef.io/chef-workstation#mac_os_x>`__ and select the appropriate package for your macOS version. Click on the **Download** button.
#. Follow the steps to accept the license and install Chef Workstation.

Windows
-----------------------------------------------------
#. Visit the `Chef Workstation downloads page <https://downloads.chef.io/chef-workstation#windows>`__ and select the appropriate package for your Windows version. Click on the **Download** button.
#. Follow the steps to accept the license and install Chef Workstation. You will have the option to change your install location; by default the installer uses the ``C:\opscode\chef-workstation\`` directory.
#. **Optional:** Set the default shell. On Microsoft Windows it is strongly recommended to use Windows PowerShell instead of ``cmd.exe``.

Spaces and Directories
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. tag windows_spaces_and_directories

Directories that are used by Chef products on Windows cannot have spaces. For example, ``C:\Users\User Name`` will not work, but ``C:\Users\UserName`` will. Chef commands may fail if used against a directory with a space in its name.

.. end_tag

Top-level Directory Names
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. tag windows_top_level_directory_names

Windows will throw errors when path name lengths are too long. For this reason, it's often helpful to use a very short top-level directory, much like what is done in UNIX and Linux. For example, Chef uses ``/opt/`` to install Chef Workstation on macOS. A similar approach can be done on Microsoft Windows, by creating a top-level directory with a short name. For example: ``C:\chef``.

.. end_tag

Linux
-----------------------------------------------------
#. Visit the `Chef Workstation downloads page <https://downloads.chef.io/chef-workstation>`__ and download the appropriate package for your distribution:

   .. code-block:: bash

      wget https://packages.chef.io/files/stable/chefworkstation/0.14/ubuntu/18.04/chefworkstation_0.14.16-1_amd64.deb

#. Use your distribution's package manager to install Chef Workstation:

   * Red Hat Enterprise Linux:

     .. code-block:: bash

        rpm -Uvh chef-workstation-0.14.16-1.el7.x86_64.rpm

   * Debian/Ubuntu:

     .. code-block:: bash

        dpkg -i chefworkstation_0.14.16-1_amd64.deb

Verify the Installation
====================================================

To verify the installation, run:

.. code-block:: shell

   chef -v

Which returns the versions of all installed Chef tools:

.. code-block:: shell

  Chef Workstation version: 0.14.16
  Chef Infra Client version: 15.6.10
  Chef InSpec version: 4.18.39
  Chef CLI version: 2.0.0
  Test Kitchen version: 2.3.4
  Cookstyle version: 5.19.9

Next Steps
=====================================================

Now that you've installed Chef Workstation, proceed to the `Configuring Chef Workstation </workstation_setup.html>`__ guide to configure your Chef Workstation installation.
