.. THIS PAGE DOCUMENTS Chef server version 12.0

=====================================================
Authentication, Authorization
=====================================================

.. include:: ../../includes_chef_auth/includes_chef_auth.rst

Authentication
=====================================================
.. include:: ../../includes_chef_auth/includes_chef_auth_authentication.rst

chef-validator
-----------------------------------------------------
.. include:: ../../includes_security/includes_security_chef_validator.rst

During a chef-client Run
-----------------------------------------------------
.. include:: ../../includes_security/includes_security_key_pairs_chef_client.rst

Knife
-----------------------------------------------------
.. include:: ../../includes_security/includes_security_key_pairs_knife.rst

knife can also use the ``knife exec`` subcommand to make specific, authenticated requests to the Chef server. knife plugins can also make authenticated requests to the Chef server by leveraging the ``knife exec`` subcommand.

API Requests
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_plugin_knife/includes_plugin_knife.rst

.. include:: ../../includes_plugin_knife/includes_plugin_knife_using_authenticated_requests.rst

From the Web Interface
-----------------------------------------------------
.. include:: ../../includes_chef_auth/includes_chef_auth_authentication_webui.rst

Other Options
-----------------------------------------------------
The most common ways to interact with the Chef server using the Chef server API abstract the API from the user. That said, the Chef server API can be interacted with directly. The following sections describe a few of the ways that are available for doing that.

cURL
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_chef_auth/includes_chef_auth_authentication_other_curl.rst

PyChef
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_chef_auth/includes_chef_auth_authentication_other_pychef.rst

Ruby
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_chef_auth/includes_chef_auth_authentication_other_ruby.rst

Debug Authentication Issues
-----------------------------------------------------
.. include:: ../../includes_chef_auth/includes_chef_auth_authentication_debug.rst

Authorization
=====================================================
.. include:: ../../includes_chef_auth/includes_chef_auth_authorization.rst

Chef Server
-----------------------------------------------------
.. include:: ../../includes_server_rbac/includes_server_rbac.rst

.. include:: ../../includes_server_rbac/includes_server_rbac_components.rst

.. include:: ../../includes_server_rbac/includes_server_rbac_workflow.rst

Object Permissions
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_server_rbac/includes_server_rbac_permissions_object.rst

Global Permissions
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_server_rbac/includes_server_rbac_permissions_global.rst

Client Key Permissions
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. note:: This is only necessary after migrating a client from one Chef server to another. Permissions must be reset for client keys after the migration.

.. include:: ../../includes_server_rbac/includes_server_rbac_clients.rst

.. include:: ../../includes_server_rbac/includes_server_rbac_permissions_key.rst

Default Groups
+++++++++++++++++++++++++++++++++++++++++++++++++++++
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


Multiple Organizations
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_server_rbac/includes_server_rbac_orgs_multi.rst

.. include:: ../../includes_server_rbac/includes_server_rbac_orgs_multi_use.rst

Many Users, Same Repo
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
.. include:: ../../includes_chef_repo/includes_chef_repo_many_users_same_repo.rst

Chef server API
=====================================================
.. include:: ../../includes_api_chef_server/includes_api_chef_server.rst

Authentication Headers
-----------------------------------------------------
.. include:: ../../includes_api_chef_server/includes_api_chef_server_headers.rst

Header Format
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_api_chef_server/includes_api_chef_server_headers_format.rst

Required Headers
+++++++++++++++++++++++++++++++++++++++++++++++++++++
The following authentication headers are required:

.. list-table::
   :widths: 130 400
   :header-rows: 1

   * - Feature
     - Description
   * - ``Accept``
     - .. include:: ../../includes_api_chef_server/includes_api_chef_server_headers_accept.rst
   * - ``Host``
     - .. include:: ../../includes_api_chef_server/includes_api_chef_server_headers_host.rst
   * - ``X-Chef-Version``
     - .. include:: ../../includes_api_chef_server/includes_api_chef_server_headers_x_chef_version.rst
   * - ``X-Ops-Authorization-N``
     - .. include:: ../../includes_api_chef_server/includes_api_chef_server_headers_x_ops_authorization.rst
   * - ``X-Ops-Content-Hash``
     - .. include:: ../../includes_api_chef_server/includes_api_chef_server_headers_x_ops_content_hash.rst
   * - ``X-Ops-Sign``
     - .. include:: ../../includes_api_chef_server/includes_api_chef_server_headers_x_ops_sign.rst
   * - ``X-Ops-Timestamp``
     - .. include:: ../../includes_api_chef_server/includes_api_chef_server_headers_x_ops_timestamp.rst
   * - ``X-Ops-UserId``
     - .. include:: ../../includes_api_chef_server/includes_api_chef_server_headers_x_ops_userid.rst

Example
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_api_chef_server/includes_api_chef_server_headers_example.rst

Endpoints
-----------------------------------------------------
.. include:: ../../includes_api_chef_server/includes_api_chef_server_endpoints.rst

For more information about the Chef server API endpoints see :doc:`api_chef_server`.

