=====================================================
Install the Chef DK
=====================================================
`[edit on GitHub] <https://github.com/chef/chef-web-docs/blob/master/chef_master/source/install_dk.rst>`__

Use the Chef Development Kit installer to set up the Chef DK on a workstation. Chef DK includes the chef-client, an embedded version of Ruby, RubyGems, and OpenSSL, as well as our tools: Test Kitchen, Cookstyle, Foodcritic and ChefSpec. The Chef installer puts everything into a unique directory (``/opt/chefdk/`` on macOS / Linux and ``C:\opscode\chefdk\`` on Windows) so that these components will not interfere with other applications that may be running on the target machine.

.. note:: The Chef installer must run as a privileged user.

Install
=====================================================

macOS
-----------------------------------------------------

.. note:: ChefDK works without installing Xcode, but Xcode is required for native Ruby Gem installation. Run ``xcode-select --install`` from the terminal to install Xcode.

#. Visit the `Chef DK downloads page <https://downloads.chef.io/chefdk>`_ and select the appropriate package for your macOS version. Click on the **Download** button.
#. Follow the steps to accept the license and install the Chef development kit. You will have the option to change your install location; by default the installer uses the ``/opt/chefdk/`` directory.

Windows
-----------------------------------------------------
#. Visit the `Chef DK downloads page <https://downloads.chef.io/chefdk>`_ and select the appropriate package for your Windows version. Click on the **Download** button.
#. Follow the steps to accept the license and install the Chef development kit. You will have the option to change your install location; by default the installer uses the ``C:\opscode\chefdk\`` directory.
#. **Optional:** Set the default shell. On Microsoft Windows it is strongly recommended to use Windows PowerShell and ``cmd.exe``.

See the `Chef DK on Windows </dk_windows.html>`__ guide for additional caveats and configuration options specific to Windows.

Linux
-----------------------------------------------------
#. Visit the `Chef DK downloads page <https://downloads.chef.io/chefdk>`_ and download the appropriate package for your distribution:

   .. code-block:: bash

      wget https://packages.chef.io/files/stable/chefdk/3.2.30/ubuntu/18.04/chefdk_3.2.30-1_amd64.deb

#. Use your distribution's package manager to install the Chef Development Kit:

   * Red Hat Enterprise Linux:

     .. code-block:: bash

        rpm -Uvh chefdk-3.2.30-1.el7.x86_64.rpm

   * Debian/Ubuntu:

     .. code-block:: bash

        dpkg -i chefdk_3.2.30-1_amd64.deb

Next Steps
=====================================================
Now that you've installed the Chef DK, proceed to the `Chef DK Setup </chefdk_setup.html>`__ guide to configure your ChefDK installation.
