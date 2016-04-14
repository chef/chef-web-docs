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
The |chef server| includes the following default groups:

.. list-table::
   :widths: 60 420
   :header-rows: 1

   * - Group
     - Description
   * - ``admins``
     - |group default_admins| 
   * - ``billing_admins``
     - |group default_billing_admins| 
   * - ``clients``
     - |group default_clients| 
   * - ``users``
     - |group default_users| 


|push jobs| Groups
=====================================================

.. include:: ../../includes_push_jobs/includes_push_jobs.rst

.. include:: ../../includes_server_rbac/includes_server_rbac_groups_push_jobs.rst

|reporting| Groups
=====================================================

.. include:: ../../includes_reporting/includes_reporting.rst

.. include:: ../../includes_server_rbac/includes_server_rbac_groups_reporting.rst
