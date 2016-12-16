=====================================================
Upgrade Chef Compliance
=====================================================
`[edit on GitHub] <https://github.com/chef/chef-web-docs/blob/master/chef_master/source/upgrade_compliance.rst>`__

The following sections describe the upgrade process for Chef Compliance.

Prerequisites
=====================================================
This section describes the prereqs for the upgrade

#. Previously installed Chef Compliance software.
#. ``sudo`` or ``root`` access to the machine.

Upgrade
=====================================================
To upgrade to the latest version of Chef Compliance, do the following:

#. Stop the services:

   .. code-block:: bash

      chef-compliance-ctl stop

#. Run dpkg or RPM Package Manager. For dpkg:

   .. code-block:: bash

      dpkg -i /path/to/chef-compliance-<version>.deb

   For RPM Package Manager:

   .. code-block:: bash

      rpm -Uvh /path/to/chef-compliance-<version>.rpm

#. Start the database to allow connections during the  ``reconfigure`` step:

   .. code-block:: bash

      chef-compliance-ctl start postgresql

#. Reconfigure the services:

   .. code-block:: bash

      chef-compliance-ctl reconfigure

   .. note:: .. tag chef_license_reconfigure_compliance

             Starting with Chef Compliance 1.1.9, the :doc:`Chef MLSA </chef_license>` must be accepted when reconfiguring the product. If the Chef MLSA has not already been accepted, the reconfigure process will prompt for a ``yes`` to accept it. Or run ``chef-compliance-ctl reconfigure --accept-license`` to automatically accept the license.

             .. end_tag

#. Start the services:

   .. code-block:: bash

      chef-compliance-ctl start

#. Check the status of the services:

   .. code-block:: bash

      chef-compliance-ctl status

Logging
=====================================================
.. tag compliance_logging

The default directory where Chef Compliance is saving logs is: ``/var/log/chef-compliance/``. It contains a directory for each service, but you can follow all the logs with this command:

.. code-block:: ruby

   sudo chef-compliance-ctl tail

This command can also be run for an individual service by specifying the name of the service in the command. For example:

.. code-block:: bash

   sudo chef-compliance-ctl tail core

.. end_tag

