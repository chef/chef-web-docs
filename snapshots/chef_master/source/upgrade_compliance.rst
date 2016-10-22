=====================================================
Upgrade Chef Compliance
=====================================================

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

   .. note:: .. include:: ../../includes_chef_license/includes_chef_license_reconfigure_compliance.rst

#. Start the services:

   .. code-block:: bash

      chef-compliance-ctl start

#. Check the status of the services:

   .. code-block:: bash

      chef-compliance-ctl status

Logging
=====================================================
.. include:: ../../includes_compliance/includes_compliance_logging.rst
