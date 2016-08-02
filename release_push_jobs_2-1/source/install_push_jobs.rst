.. THIS PAGE DOCUMENTS Push Jobs version 2.1

=====================================================
Install |push jobs_title|
=====================================================

.. include:: ../../includes_install/includes_install_push_jobs_overview_2-1.rst

Install the Server
=====================================================
The |push jobs| server can be installed as part of a standalone or high availability configuration. Use the `chef-server-ctl install <https://docs.chef.io/server/ctl_chef_server.html#install>`_ command to add |push jobs|.

Install the Client
=====================================================
.. include:: ../../includes_install/includes_install_push_jobs_client.rst

Install the Workstation
=====================================================
.. include:: ../../includes_install/includes_install_push_jobs_workstation.rst

|cookbook push jobs| Cookbook
-----------------------------------------------------
.. include:: ../../includes_install/includes_install_push_jobs_cookbook.rst

|push jobs_title| Groups
=====================================================
.. include:: ../../includes_push_jobs/includes_push_jobs.rst

.. note:: The |chef server| uses role-based access control to define the :doc:`organizations, groups, and users </server_orgs>`, including those needed by |push jobs|.

.. include:: ../../includes_server_rbac/includes_server_rbac_groups_push_jobs.rst
