=====================================================
Upgrade |chef compliance|
=====================================================

The following sections describe the upgrade process for |chef compliance|.

Prerequisites
=====================================================
This section describes the prereqs for the upgrade

#. Previously installed |chef compliance| software.
#. ``sudo`` or ``root`` access to the machine.

Upgrade
=====================================================
This section describes the upgrade process:

#. Stop the services:

   .. code-block:: bash

      chef-compliance-ctl stop

#. Run |debian dpkg| or |rpm|. For |debian dpkg|:

   .. code-block:: bash

      dpkg -i /path/to/chef-compliance-<version>.deb

   For |rpm|:

   .. code-block:: bash

      rpm -Uvh /path/to/chef-compliance-<version>.rpm

#. Start the database to allow connections during the  ``reconfigure`` step:

   .. code-block:: bash

      chef-compliance-ctl start postgresql

#. Reconfigure the services:

   .. code-block:: bash

      chef-compliance-ctl reconfigure

#. Start the services:

   .. code-block:: bash

      chef-compliance-ctl start

#. Check the status of the services:

   .. code-block:: bash

      chef-compliance-ctl status


Logging
=====================================================
.. include:: ../../includes_compliance/includes_compliance_logging.rst