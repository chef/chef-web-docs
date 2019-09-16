=====================================================
Install ChefDK
=====================================================
`[edit on GitHub] <https://github.com/chef/chef-web-docs/blob/master/chef_master/source/install_dk.rst>`__

.. note:: `Chef Workstation <https://downloads.chef.io/chef-workstation/>`__ gives you everything you need to get started with Chef — ad hoc remote execution, remote scanning, configuration tasks, cookbook creation tools as well as robust dependency and testing software — all in one easy-to-install package. Chef Workstation replaces ChefDK, combining all the existing features with new features, such as ad-hoc task support and the new Chef Workstation desktop application. Chef will continue to maintain ChefDK, but new development will take place in Chef Workstation without backporting features.

The ChefDK package is produced by the `Chef Omnibus <https://github.com/chef/omnibus>`__ tool for installation on a workstation. ChefDK includes:

* Chef Infra Client
* Embedded versions of Ruby, RubyGems, and the Ruby interpreter, all of which are build from the source. (The Ruby interpreter is not available for Windows)
* An embedded version of OpenSSL
* Test Kitchen
* Cookstyle
* Foodcritic
* ChefSpec


ChefDK installs to ``/opt/chefdk/`` on macOS / Linux and ``C:\opscode\chefdk\`` on Windows. These file locations should help avoid interference between these components and other applications that may be running on the target machine.

Install
=====================================================
The ChefDK installer must run as a privileged user.

macOS
-----------------------------------------------------

#. Dependency: Xcode is recommended for running ChefDK on OSX. While ChefDK works without Xcode, it is required for native Ruby Gem installation. Run ``xcode-select --install`` from the terminal to install Xcode.
#. Visit the `ChefDK downloads page <https://downloads.chef.io/chefdk#mac_os_x>`__ and select the appropriate package for your macOS version. Click on the **Download** button.
#. Follow the steps to accept the license and install ChefDK. You will have the option to change your install location; by default the installer uses the ``/opt/chefdk/`` directory.

Windows
-----------------------------------------------------
#. Visit the `ChefDK downloads page <https://downloads.chef.io/chefdk#windows>`__ and select the appropriate package for your Windows version. Click on the **Download** button.
#. Follow the steps to accept the license and install ChefDK. You will have the option to change your install location; by default the installer uses the ``C:\opscode\chefdk\`` directory.
#. **Optional:** Set the default shell. On Microsoft Windows it is strongly recommended to use Windows PowerShell and ``cmd.exe``.

See the `ChefDK on Windows </dk_windows.html>`__ guide for additional caveats and configuration options specific to Windows.

Linux
-----------------------------------------------------
#. Visit the `ChefDK downloads page <https://downloads.chef.io/chefdk>`__ and download the appropriate package for your distribution:

   .. code-block:: bash

      wget https://packages.chef.io/files/stable/chefdk/3.2.30/ubuntu/18.04/chefdk_3.2.30-1_amd64.deb

#. Use your distribution's package manager to install ChefDK:

   * Red Hat Enterprise Linux:

     .. code-block:: bash

        rpm -Uvh chefdk-3.2.30-1.el7.x86_64.rpm

   * Debian/Ubuntu:

     .. code-block:: bash

        dpkg -i chefdk_3.2.30-1_amd64.deb

Next Steps
=====================================================
Now that you've installed ChefDK, proceed to the `ChefDK Setup </chefdk_setup.html>`__ guide to configure your ChefDK installation.
