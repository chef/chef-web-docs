=====================================================
Release Notes: |chef server_title| 12.4
=====================================================

.. include:: ../../includes_chef/includes_chef_index.rst

What's New
=====================================================
The following items are new for |chef server| 12.4:

* **/universe endpoint** Use the ``/universe`` endpoint to retrieve the known collection of cookbooks, and then use it with |berkshelf| and |supermarket|.
* **opscode-expander-reindexer service** The ``opscode-expander-reindexer`` service is deprecated.
* **Global server administrator list** Use the ``grant-server-admin-permissions``, ``remove-server-admin-permissions``, and ``list-server-admins`` to manage the list of users who belong to the Server Admins group.

/universe
=====================================================
.. include:: ../../includes_api_chef_server/includes_api_chef_server_endpoint_universe.rst

GET
-----------------------------------------------------
.. include:: ../../includes_api_chef_server/includes_api_chef_server_endpoint_universe_get.rst

Server Admins
=====================================================
.. include:: ../../includes_server_rbac/includes_server_rbac_server_admins.rst

Scenario
-----------------------------------------------------
.. include:: ../../includes_server_rbac/includes_server_rbac_server_admins_scenario.rst

Superuser Accounts
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_server_rbac/includes_server_rbac_server_admins_superusers.rst

Manage server-admins Group
-----------------------------------------------------
.. include:: ../../includes_ctl_chef_server/includes_ctl_chef_server_server_admin.rst

Add Members
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_ctl_chef_server/includes_ctl_chef_server_server_admin_grant_user.rst

Remove Members
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_ctl_chef_server/includes_ctl_chef_server_server_admin_remove_user.rst

List Membership
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_ctl_chef_server/includes_ctl_chef_server_server_admin_list.rst


What's Fixed
=====================================================
For the list of issues that were addressed for this release, please see the changelog on |github|: https://github.com/chef/opscode-omnibus/blob/master/CHANGELOG.md
