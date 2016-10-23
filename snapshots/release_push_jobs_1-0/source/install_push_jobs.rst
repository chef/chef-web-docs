.. THIS PAGE DOCUMENTS Push Jobs version 1.0

=====================================================
Install Chef Push Jobs
=====================================================

Chef push jobs is installed to the following locations:

* The same machine as the Chef server (version 11.0.1 or higher)
* One (or more) nodes on which the chef-client (version 11.0 or higher) is installed
* At least one management workstation

Install the Server
=====================================================
The Chef push jobs server can be installed as part of a standalone or high availability configuration. Use the `chef-server-ctl install <https://docs.chef.io/server/ctl_chef_server.html#install>`_ command to add Chef push jobs.

Install the Client
=====================================================
.. include:: ../../includes_install/includes_install_push_jobs_client.rst

Install the Workstation
=====================================================
.. include:: ../../includes_install/includes_install_push_jobs_workstation.rst

**push-jobs** Cookbook
-----------------------------------------------------
.. include:: ../../includes_install/includes_install_push_jobs_cookbook.rst

Chef Push Jobs Groups
=====================================================
.. include:: ../../includes_push_jobs/includes_push_jobs.rst

.. note:: The Chef server uses role-based access control to define the :doc:`organizations, groups, and users </server_orgs>`, including those needed by Chef push jobs.

.. include:: ../../includes_server_rbac/includes_server_rbac_groups_push_jobs.rst





