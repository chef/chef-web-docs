.. THIS PAGE DOCUMENTS Enterprise Chef server version 11.1

=====================================================
Organizations, Groups, and Users
=====================================================

.. include:: ../../includes_server_rbac/includes_server_rbac.rst

.. include:: ../../includes_server_rbac/includes_server_rbac_components.rst

.. include:: ../../includes_server_rbac/includes_server_rbac_workflow.rst


Multiple Organizations
=====================================================
.. include:: ../../includes_server_rbac/includes_server_rbac_orgs_multi.rst

.. include:: ../../includes_server_rbac/includes_server_rbac_orgs_multi_use.rst

Permissions
=====================================================
.. include:: ../../includes_server_rbac/includes_server_rbac_permissions.rst

Object Permissions
-----------------------------------------------------
.. include:: ../../includes_server_rbac/includes_server_rbac_permissions_object.rst

Global Permissions
-----------------------------------------------------
.. include:: ../../includes_server_rbac/includes_server_rbac_permissions_global.rst

Default Groups
=====================================================
The Chef server includes the following default groups:

.. list-table::
   :widths: 60 420
   :header-rows: 1

   * - Group
     - Description
   * - ``admins``
     - The ``admins`` group defines the list of users who have administrative rights to all objects and object types for a single organization. 
   * - ``billing_admins``
     - The ``billing_admins`` group defines the list of users who have permission to manage billing information. This permission exists only for the hosted Chef server. 
   * - ``clients``
     - The ``clients`` group defines the list of nodes on which a chef-client is installed and under management by Chef. In general, think of this permission as "all of the non-human actors---the chef-client, in nearly every case---that get data from, and/or upload data to, the Chef server". Newly-created chef-client instances are added to this group automatically. 
   * - ``users``
     - The ``users`` group defines the list of users who use knife and the Chef management console to interact with objects and object types. In general, think of this permission as "all of the non-admin human actors who work with data that is uploaded to and/or downloaded from the Chef server". 


Chef push jobs Groups
=====================================================

.. include:: ../../includes_push_jobs/includes_push_jobs.rst

.. include:: ../../includes_server_rbac/includes_server_rbac_groups_push_jobs.rst

Reporting Groups
=====================================================

.. include:: ../../includes_reporting/includes_reporting.rst

.. include:: ../../includes_server_rbac/includes_server_rbac_groups_reporting.rst
