
=====================================================
Release Notes: |chef server_title| 12.1
=====================================================

.. include:: ../../includes_chef/includes_chef_index.rst

What's New
=====================================================
The following items are new for |chef server| 12.1:

* **chef-server-ctl key commands use the chef-client Chef::Key object** The key rotation commands (``chef-server-ctl key``) for ``create``, ``delete``, ``edit``, ``list``, and ``show`` keys for users and clients. These were a preview in the |chef server| 12.0.3 release, and are now fully integrated.
* **New version headers for Chef Server API** The |api chef server| uses the ``X-Ops-Server-API-Version`` header to specify the version of the API that is used as part of a request to the |api chef server|.
* **New endpoints for policy and policy files** The |api chef server| adds the following endpoints: ``/policies``, ``/policy_groups``, and ``/POLICY_GROUP/policies/POLICY_NAME``.
* **New endpoints for client key management** The |api chef server| adds the following endpoints: ``/client/CLIENT/keys`` and ``/client/CLIENT/keys/KEY``.
* **New endpoints for user key management** The |api chef server| adds the following endpoints: ``/user/USER/keys`` and ``/user/USER/keys/KEY``.
* **New configuration setting** Use the ``estatsd['protocol']`` setting to send application statistics with |statsd| protocol formatting.


Key Rotation
-----------------------------------------------------
The ``knife user`` and ``knife client`` subcommands support key rotation. Use the ``create``, ``delete``, ``edit``, ``list``, and ``show`` subcommands to manage keys for users and clients, such as creating multiple expiring keys for a single user and also for basic key management. See https://docs.chef.io/knife_user.html and https://docs.chef.io/knife_client.html for more information about these subcommands.

X-Ops-Server-API-Version
-----------------------------------------------------
.. include:: ../../includes_api_chef_server/includes_api_chef_server_headers_x_ops_server_api_version.rst

/client/CLIENT/keys/
-----------------------------------------------------
.. include:: ../../includes_api_chef_server/includes_api_chef_server_endpoint_keys_clients.rst

GET
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_api_chef_server/includes_api_chef_server_endpoint_keys_clients_get.rst

POST
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_api_chef_server/includes_api_chef_server_endpoint_keys_clients_post.rst

/client/CLIENT/keys/KEY
-----------------------------------------------------
.. include:: ../../includes_api_chef_server/includes_api_chef_server_endpoint_key_client.rst

DELETE
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_api_chef_server/includes_api_chef_server_endpoint_key_client_delete.rst

GET
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_api_chef_server/includes_api_chef_server_endpoint_key_client_get.rst

PUT
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_api_chef_server/includes_api_chef_server_endpoint_key_client_put.rst

/user/USER/keys/
-----------------------------------------------------
.. include:: ../../includes_api_chef_server/includes_api_chef_server_endpoint_keys_users.rst

GET
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_api_chef_server/includes_api_chef_server_endpoint_keys_users_get.rst

POST
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_api_chef_server/includes_api_chef_server_endpoint_keys_users_post.rst

/user/USER/keys/KEY
-----------------------------------------------------
.. include:: ../../includes_api_chef_server/includes_api_chef_server_endpoint_key_user.rst

DELETE
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_api_chef_server/includes_api_chef_server_endpoint_key_user_delete.rst

GET
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_api_chef_server/includes_api_chef_server_endpoint_key_user_get.rst

PUT
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_api_chef_server/includes_api_chef_server_endpoint_key_user_put.rst

/policies
-----------------------------------------------------
.. include:: ../../includes_api_chef_server/includes_api_chef_server_endpoint_policies.rst

GET
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_api_chef_server/includes_api_chef_server_endpoint_policies_get.rst

/policy_groups
-----------------------------------------------------
.. include:: ../../includes_api_chef_server/includes_api_chef_server_endpoint_policy_groups.rst

.. include:: ../../includes_policy/includes_policy_group_relates_to_nodes.rst

GET
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_api_chef_server/includes_api_chef_server_endpoint_policy_groups_get.rst

/policies/NAME
-----------------------------------------------------
.. include:: ../../includes_api_chef_server/includes_api_chef_server_endpoint_policy_group.rst

.. include:: ../../includes_policy/includes_policy_group_relates_to_nodes.rst

.. include:: ../../includes_policy/includes_policy_auth.rst

DELETE
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_api_chef_server/includes_api_chef_server_endpoint_policy_group_delete.rst

GET
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_api_chef_server/includes_api_chef_server_endpoint_policy_group_get.rst

PUT
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_api_chef_server/includes_api_chef_server_endpoint_policy_group_put.rst

New Config Settings
-----------------------------------------------------
The following configuration settings are new for the |chef server|:

.. list-table::
   :widths: 200 300
   :header-rows: 1

   * - Setting
     - Description
   * - ``estatsd['protocol']``
     - Use to send application statistics with |statsd| protocol formatting. Set this value to ``statsd`` to apply |statsd| protocol formatting.


What's Fixed
=====================================================
For the list of issues that were addressed for this release, please see the changelog on |github|: https://github.com/chef/opscode-omnibus/blob/master/CHANGELOG.md
