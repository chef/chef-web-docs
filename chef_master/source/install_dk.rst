=====================================================
Install the Chef DK
=====================================================
`[edit on GitHub] <https://github.com/chef/chef-web-docs/blob/master/chef_master/source/install_dk.rst>`__

The omnibus installer is used to set up the Chef development kit on a workstation, including the chef-client itself, an embedded version of Ruby, RubyGems, OpenSSL, key-value stores, parsers, libraries, command line utilities, and community tools such as Kitchen, Berkshelf, and ChefSpec. The omnibus installer puts everything into a unique directory (``opt/chefdk/`` on macOS / Linux and ``C:\opscode\chefdk\`` on Windows) so that these components will not interfere with other applications that may be running on the target machine.

.. note:: The omnibus installer must run as a root user.

Install
=====================================================

macOS
-----------------------------------------------------

.. note:: Apple Xcode is required to install the Chef DK on macOS. Install Xcode via the Mac App Store.

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

      wget https://packages.chef.io/files/stable/chefdk/2.4.17/ubuntu/16.04/chefdk_2.4.17-1_amd64.deb

#. Use your distribution's package manager to install the Chef Development Kit:

   * Red Hat Enterprise Linux:

     .. code-block:: bash

        rpm -Uvh https://packages.chef.io/files/stable/chefdk/2.4.17/el/7/chefdk-2.4.17-1.el7.x86_64.rpm

   * Debian/Ubuntu:

     .. code-block:: bash

        dpkg -i https://packages.chef.io/files/stable/chefdk/2.4.17/ubuntu/16.04/chefdk_2.4.17-1_amd64.deb

Next Steps
=====================================================
Now that you've installed the Chef DK, proceed to the `Workstation </workstation.html>`__ guide to set up your Chef DK workstation.
