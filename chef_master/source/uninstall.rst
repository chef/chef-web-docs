=====================================================
Uninstall
=====================================================
`[edit on GitHub] <https://github.com/chef/chef-web-docs/blob/master/chef_master/source/uninstall.rst>`__

The following sections describe how to uninstall Chef, add-ons, and other components.

Chef Server
=====================================================
.. tag ctl_chef_server_uninstall

The ``uninstall`` subcommand is used to remove the Chef Infra Server application, but without removing any of the data. This subcommand will shut down all services (including the ``runit`` process supervisor).

This subcommand has the following syntax:

.. code-block:: bash

   $ chef-server-ctl uninstall

.. note:: To revert the ``uninstall`` subcommand, run the ``reconfigure`` subcommand (because the ``start`` subcommand is disabled by the ``uninstall`` command).

.. end_tag

Chef Manage
=====================================================
To uninstall the Chef management console, do the following:

#. Run the following command:

   .. code-block:: bash

      $ chef-manage-ctl cleanse

#. Use the package manager for the platform on which the Chef management console is installed, and then uninstall the package named ``chef-manage``.

.. note:: This package used to be named ``opscode-manage`` and the command line tool used to be named ``opscode-manage-ctl``.

Chef Analytics
=====================================================
The ``uninstall`` subcommand is used to remove the Chef Analytics application, but without removing any of the data. This subcommand will shut down all services (including the ``runit`` process supervisor).

This subcommand has the following syntax:

.. code-block:: bash

   $ opscode-analytics-ctl uninstall

.. note:: To revert the ``uninstall`` subcommand, run the ``reconfigure`` subcommand (because the ``start`` subcommand is disabled by the ``uninstall`` command).

Reporting
=====================================================
.. tag ctl_reporting_uninstall

The ``uninstall`` subcommand is used to remove the Reporting add-on to the Chef Infra Server, but without removing any of the data. This subcommand will shut down all services (including the ``runit`` process supervisor).

This subcommand has the following syntax:

.. code-block:: bash

   $ opscode-reporting-ctl uninstall

.. note:: To revert the ``uninstall`` subcommand, run the ``reconfigure`` subcommand (because the ``start`` subcommand is disabled by the ``uninstall`` command).

.. end_tag

Chef Push Jobs
=====================================================
To uninstall Chef Push Jobs, do the following:

#. Shut down the Chef Push Jobs service.
#. Uninstall the Chef Push Jobs package.
#. Run the following command:

   .. code-block:: bash

      $ chef-server-ctl reconfigure

.. note:: This will leave some data in PostgreSQL that is not used by any other Chef application or service.

push-jobs-client
-----------------------------------------------------
Use the package manager for the platform on which Chef Push Jobs is installed to uninstall Chef Push Jobs.

ChefDK
=====================================================
.. tag uninstall_chef_dk

ChefDK can be uninstalled using the steps below that are appropriate for the platform on which ChefDK is installed.

.. end_tag

Debian
-----------------------------------------------------
.. tag uninstall_chef_dk_ubuntu

Use the following command to remove ChefDK on Debian-based platforms:

.. code-block:: bash

   $ dpkg -P chefdk

.. end_tag

macOS
-----------------------------------------------------
.. tag uninstall_chef_dk_mac

Use the following commands to remove ChefDK on macOS.

To remove installed files:

.. code-block:: bash

   $ sudo rm -rf /opt/chefdk

To remove the system installation entry:

.. code-block:: bash

   $ sudo pkgutil --forget com.getchef.pkg.chefdk

To remove symlinks:

* For Chef Client 12.x, under ``/usr/local/bin``:

  .. code-block:: bash

     $ sudo find /usr/local/bin -lname '/opt/chefdk/*' -delete

* For Chef Client 11.x, under ``/usr/bin``:

  .. code-block:: bash

     $ sudo find /usr/bin -lname '/opt/chefdk/*' -delete

.. end_tag

Red Hat Enterprise Linux
-----------------------------------------------------
.. tag uninstall_chef_dk_redhat

Use the following commands to remove ChefDK on Red Hat Enterprise Linux-based platforms:

.. code-block:: bash

   $ rpm -qa *chefdk*
   $ sudo yum remove -y <package>

.. end_tag

Microsoft Windows
-----------------------------------------------------
.. tag uninstall_chef_dk_windows

Use **Add / Remove Programs** to remove ChefDK on the Microsoft Windows platform.

.. end_tag
