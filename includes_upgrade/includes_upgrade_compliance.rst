.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics. 


To upgrade to the latest version of |chef compliance|, do the following:

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

   .. note:: .. include:: ../../includes_chef_license/includes_chef_license_reconfigure_compliance.rst

#. Start the services:

   .. code-block:: bash

      chef-compliance-ctl start

#. Check the status of the services:

   .. code-block:: bash

      chef-compliance-ctl status
