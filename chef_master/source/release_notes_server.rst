=====================================================
Release Notes: |chef server_title| 12.0 - 12.8
=====================================================

.. include:: ../../includes_chef/includes_chef_index.rst

What's New in 12.8
=====================================================
The following items are new for |chef server| 12.8:

* **Initial support for sending updates to a data collector service** See `Configuring Chef Server to send Chef Client data <https://docs.chef.io/ingest_data_chef_automate.html#configuring-chef-server-to-send-chef-client-data>`_ for more information on how to set up and send data from Chef server to an |automate| server.
* **Minor bug fixes in postgresql setup**.

What's New in 12.7
=====================================================
The following items are new for |chef server| 12.7:

* **Support for service credential rotation through Veil** Veil is a library for securely creating, storing, and rotating Chef server secrets. It is also required when using the new ``chef-server-ctl require-credential-rotation`` command.
* **Filtering by external authentication ID in Chef server API** Users can now be filtered by ``external_authentication_uid``, which is needed to support SAML authentication in Chef Manage.
* **Updated to OpenSSL 1.0.1t** Version 1.0.1t contains several security fixes.

Service credential rotation support
=====================================================
`Veil <https://github.com/chef/chef-server/blob/3ff412b5a2e6ad54cfa79bca6865e1bbca28fe5e/omnibus/files/veil/README.md>`_ is a new library to manage Chef server secrets. It allows any Chef server with a given set of secrets to create new service credentials and rotate them without requiring the secrets files to be copied between each Chef server in a cluster.

Five new commands have been created to support credential rotation:

* `require-credential-rotation <https://docs.chef.io/ctl_chef_server.html#require-credential-rotation>`_
* `rotate-all-credentials <https://docs.chef.io/ctl_chef_server.html#rotate-all-credentials>`_
* `rotate-credentials <https://docs.chef.io/ctl_chef_server.html#rotate-credentials>`_
* `rotate-shared-secrets <https://docs.chef.io/ctl_chef_server.html#rotate-shared-secrets>`_
* `show-service-credentials <https://docs.chef.io/ctl_chef_server.html#show-service-credentials>`_

Your secrets file is located at ``/etc/opscode/private-chef-secrets.json``, so whenever you rotate your service credentials, or update your shared secrets, this file will contain the changes. 

Supporting SAML-authentication in Chef Manage
=====================================================
To support SAML-authentication in Chef Manage, you can now filter users using ``external_authentication_uid`` in a GET request against the Chef server API. For example, to retrieve users where the ``external_authentication_uid`` is ``jane@doe.com``, do the following:

.. code-block:: none

   GET /users?external_authentication_uid=jane%40doe.com

What's New in 12.6
=====================================================
The following items are new for |chef server| 12.6:

* **Chef licenses** All |chef| products have a license that governs the entire product and includes links to license files for any third-party software included in |chef| packages. This release updates the |chef server| for the |company_name| license.

About Chef Licenses
=====================================================
.. include:: ../../includes_chef_license/includes_chef_license.rst

.. warning:: .. include:: ../../includes_chef_license/includes_chef_license_note_current.rst

Apache 2.0
-----------------------------------------------------
.. include:: ../../includes_chef_license/includes_chef_license_apache.rst

What's New in 12.5
=====================================================
The following items are new for |chef server| 12.5:

* **New group for key-related Chef server API endpoints** The ``public_key_read_access`` group defines which users and clients have read permissions to key-related endpoints in the |api chef server|.

public_key_read_access
=====================================================
.. include:: ../../includes_server_rbac/includes_server_rbac_permissions_default_public_key_read_access.rst

What's New in 12.4
=====================================================
The following items are new for |chef server| 12.4:

* **/universe endpoint** Use the ``/universe`` endpoint to retrieve the known collection of cookbooks, and then use it with |berkshelf| and |supermarket|.
* **opscode-expander-reindexer service** The ``opscode-expander-reindexer`` service is deprecated.
* **Global server administrator list** Use the ``grant-server-admin-permissions``, ``remove-server-admin-permissions``, and ``list-server-admins`` to manage the list of users who belong to the ``server-admins`` group.

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

What's New in 12.3
=====================================================
The following items are new for |chef server| 12.3:

* **Nginx stub_status module is enabled** The |nginx| ``stub_status`` module is enabled by default and may be viewed at the ``/nginx_status`` endpoint. The settings for this module are configurable.
* **RabbitMQ queue tuning** New settings for managing |rabbitmq| queues allow the size of the queue used by |chef analytics| to be configured, including settings for the queue length monitor and for tuning the |rabbitmq mgmt|.

|nginx| stub_status Module
-----------------------------------------------------
The following configuration settings are new and enable the |nginx| ``stub_status`` module:

``nginx['enable_stub_status']``
   |nginx stub_status| See ``nginx['stub_status']['allow_list']``, ``nginx['stub_status']['listen_host']``, ``nginx['stub_status']['listen_port']``, and ``nginx['stub_status']['location']``. Default value: ``true``.

``nginx['stub_status']['allow_list']``
   |nginx stub_status allow_list| Default value: ``["127.0.0.1"]``.

``nginx['stub_status']['listen_host']``
   |nginx stub_status listen_host| Default value: ``"127.0.0.1"``.

``nginx['stub_status']['listen_port']``
   |nginx stub_status listen_port| Default value: ``"9999"``.

``nginx['stub_status']['location']``
   |nginx stub_status location| Default value: ``"/nginx_status"``.

|rabbitmq| Queues
-----------------------------------------------------
.. include:: ../../includes_server_tuning/includes_server_tuning_rabbitmq_analytics_queue.rst

.. include:: ../../includes_server_tuning/includes_server_tuning_rabbitmq_analytics_queue_settings.rst

What's New
=====================================================
The following items are new for |chef server| 12.2:

* **Solr to Solr4 settings** Built-in transition for |apache solr| memory and |jvm| settings from |chef server oec| to |chef server| version 12.
* **Configurable Postgresql** Postgresql can be configured for an external database.
* **New endpoints for the Chef server API** Endpoints have been added to the |api chef server|: ``DELETE /policy_groups``.
* **New subcommmands for chef-server-ctl** Use the ``backup`` and ``restore`` subcommmands to back up and restore |chef server| data. Use the ``psql`` subcommmand to log into a |postgresql| database that is associated with a service running in the |chef server| configuration.
* **New options for chef-server-ctl reindex** The ``reindex`` subcommand has new options: ``--all-orgs`` (reindex all organizations), ``--disable-api`` (disable the |api chef server| during reindexing), ``--with-timing`` (print timing information), and ``--wait`` (wait for reindex queue to clear before exiting).

Solr => Solr 4 Changes
=====================================================
.. include:: ../../includes_upgrade/includes_upgrade_12-2_solr_to_solr4.rst

External |postgresql|
=====================================================
.. include:: ../../includes_server_ha/includes_server_ha_external_postgresql.rst

.. note:: The following ``chef-server-ctl`` subcommands for managing services are disabled when an external |postgresql| database is configured for the |chef server|: ``hup``, ``int``, ``kill``, ``once``, ``restart``, ``start``, ``stop``, ``tail``, and ``term``.

Settings
-----------------------------------------------------
.. include:: ../../includes_server_ha/includes_server_ha_external_postgresql_settings.rst


Backup / Restore
=====================================================
Use the following commands to manage backups of |chef server| data, and then to restore those backups.

backup
-----------------------------------------------------
.. include:: ../../includes_ctl_chef_server/includes_ctl_chef_server_backup.rst

**Options**

.. include:: ../../includes_ctl_chef_server/includes_ctl_chef_server_backup_options.rst

**Syntax**

.. include:: ../../includes_ctl_chef_server/includes_ctl_chef_server_backup_syntax.rst

restore
-----------------------------------------------------
.. include:: ../../includes_ctl_chef_server/includes_ctl_chef_server_restore.rst

**Options**

.. include:: ../../includes_ctl_chef_server/includes_ctl_chef_server_restore_options.rst

**Syntax**

.. include:: ../../includes_ctl_chef_server/includes_ctl_chef_server_restore_syntax.rst

**Examples**

.. code-block:: bash

   $ chef-server-ctl restore /path/to/tar/archive.tar.gz


psql
=====================================================
.. include:: ../../includes_ctl_chef_server/includes_ctl_chef_server_psql.rst

**Syntax**

.. include:: ../../includes_ctl_chef_server/includes_ctl_chef_server_psql_syntax.rst

**Options**

.. include:: ../../includes_ctl_chef_server/includes_ctl_chef_server_psql_options.rst

reindex Options
=====================================================
.. include:: ../../includes_ctl_chef_server/includes_ctl_chef_server_reindex_options.rst

|api chef server| Endpoints
=====================================================
The following endpoints have been added to the |api chef server|:

/policy_groups/NAME
-----------------------------------------------------
.. include:: ../../includes_api_chef_server/includes_api_chef_server_endpoint_policy_groups.rst

DELETE
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_api_chef_server/includes_api_chef_server_endpoint_policy_groups_delete.rst

/policies/NAME
-----------------------------------------------------
.. include:: ../../includes_api_chef_server/includes_api_chef_server_endpoint_policy_name.rst

GET
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_api_chef_server/includes_api_chef_server_endpoint_policy_name_get.rst

DELETE
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_api_chef_server/includes_api_chef_server_endpoint_policy_name_delete.rst

/policies/NAME/revisions
-----------------------------------------------------
.. include:: ../../includes_api_chef_server/includes_api_chef_server_endpoint_policy_revision.rst

POST
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_api_chef_server/includes_api_chef_server_endpoint_policy_revision_post.rst

/policies/NAME/revisions/ID
-----------------------------------------------------
.. include:: ../../includes_api_chef_server/includes_api_chef_server_endpoint_policy_id_revision.rst

GET
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_api_chef_server/includes_api_chef_server_endpoint_policy_id_revision_get.rst

DELETE
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_api_chef_server/includes_api_chef_server_endpoint_policy_id_revision_delete.rst

What's New in 12.1
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

What's New in 12.0
=====================================================
The following items are new for |chef server| 12:

* **Upgrades from Open Source Chef and Enterprise Chef servers to Chef 12 server** Upgrades to |chef server| 12 are supported from |chef server oec| 11 high availability and standalone configurations and |chef server osc| 11 standalone configurations. View the topic :doc:`Upgrade to Chef Server 12 </upgrade_server>` for more information about these processes.
* **chef-server.rb configuration file is created by default** Previous versions of the |chef server| did not create the |chef server rb| file and users had to create the file first, before updates to tuneable settings could be made.
* **Pluggable high availability architecture** Support for high availability now provides alternatives to |drbd|, including using |amazon aws|.
* **High availability using Amazon Web Services** |amazon aws| is a supported high availability configuration option for the |chef server|. Machines are stored as |amazon ebs| volumes. A passive node monitors the availabilty of the active node, and will take over if required.
* **Chef server replication** |chef replication| provides a way to asynchronously distribute cookbook, environment, role, and data bag data from a single, primary |chef server| to one (or more) replicas of that |chef server|.
* **New chef-server-ctl command line tool** The |chef server ctl| command line tool is an update of the |private chef ctl| command line tool. All of the previous functionality remains, with some new commands added that are specific to |chef server| version 12.
* **New command for installing features of the Chef server** The ``install`` subcommand may be used to install |chef manage|, |push jobs|, |chef replication|, and |reporting|.
* **New commands for managing organizations** New subcommands for the |chef server ctl| command line tool: ``org-user-add``, ``org-create``, ``org-delete``, ``org-user-remove``, ``org-list``, and ``org-show``.
* **New commands for managing users** New subcommands for the |chef server ctl| command line tool: ``user-create``, ``user-delete``, ``user-edit``, ``user-list``, and ``user-show``.
* **New command for log files** Use the ``gather-logs`` command to create a tarball of important log files and system information.
* **Solr has been upgraded to Solr 4** The search capabilities of the |chef server| now use |apache solr| 4. The config item for |apache solr| 4 has changed names from opscode-solr to opscode-solr4. Change ``/etc/opscode/chef-server.rb`` accordingly.
* **CouchDB removed** |couch db| is no longer a component of the |chef server|. All data is migrated to |postgresql|.
* **Services removed** The following services have been removed from the |chef server|: ``opscode-account``, ``opscode-certificate``, ``oc_authz_migrator``, ``opscode-org-creator``, ``orgmapper``, and ``opscode-webui``. ``opscode-webui`` is replaced by the |chef manage|.
* **private-chef.rb is now called chef-server.rb** The name of the configuration file used by the |chef server| has been changed. A symlink from |private chef rb| to |chef server rb| is created during upgrades from older versions of the |chef server|.
* **New setting for the default organization name** Use the ``default_orgname`` setting to ensure compatibility with |chef server osc| version 11.
* **New settings for oc_chef_authz** The |service authz| service handles authorization requests to the |chef server|.
* **Organization policy changes** Users must be removed from the ``admins`` security group before they can be removed from an organization. The |chef client| is not granted **Create**, **Delete**, or **Update** permissions to data bags when organizations are created.
* **Administrators cannot be removed from organizations** The |chef server| requires that a member of an organization's ``admins`` group cannot be removed from the organization without first being removed from the ``admins`` group.
* **New settings for managing LDAP encryption** New settings that manage LDAP encryption have been added, existing settings have been deprecated.
* **New commands for managing keys** The following commands are new: ``add-client-key``, ``add-user-key``, ``delete-client-key``, ``delete-user-key``, ``list-client-keys``, and ``list-user-keys``. (These are preview commands, new as-of the |chef server| 12.0.3 release.)

Upgrade to |chef server| 12!
-----------------------------------------------------
Upgrades to |chef server| 12 are supported for both |chef server oec| and |chef server osc| users. See https://docs.chef.io/server/upgrade_server.html for more information about upgrades. If you are upgrading from |chef server osc|, please see https://docs.chef.io/server/upgrade_server_open_source_notes.html as well.

HA using AWS
-----------------------------------------------------
.. include:: ../../includes_server_ha/includes_server_ha_aws.rst

View the topic :doc:`High Availability: AWS </install_server_ha_aws>` for more information about how to set up the |chef server| for high availability in |amazon aws|.

|chef replication_title|
-----------------------------------------------------
.. include:: ../../includes_server_replication/includes_server_replication.rst

**Scenarios**

.. include:: ../../includes_server_replication/includes_server_replication_scenarios.rst

**How Replication Works**

.. include:: ../../includes_server_replication/includes_server_replication_how_it_works.rst

View the topic :doc:`Chef Replication </server_replication>` for more information about how to set up the |chef server| for replication.

|chef server ctl|
-----------------------------------------------------
The command line tool for the |chef server| has been renamed from |private chef ctl| to |chef server ctl|. The same set of subcommands available for |private chef ctl| are also available for |chef server ctl|, but with an updated syntax:

.. code-block:: bash

   $ chef-server-ctl command

In addition, the ``install`` subcommand is added, plus two new subcommand groupings---``org-*`` and ``user-*``---have been added for managing organizations and users. See below for more information about these new subcommands.

install Command
-----------------------------------------------------
.. include:: ../../includes_ctl_chef_server/includes_ctl_chef_server_install.rst

**Syntax**

.. include:: ../../includes_ctl_chef_server/includes_ctl_chef_server_install_syntax.rst

**Options**

.. include:: ../../includes_ctl_chef_server/includes_ctl_chef_server_install_options.rst

**Use Downloads**

.. include:: ../../includes_ctl_chef_server/includes_ctl_chef_server_install_features_download.rst

**Use Local Packages**

.. include:: ../../includes_ctl_chef_server/includes_ctl_chef_server_install_features_manual.rst

gather-logs Command
-----------------------------------------------------
.. include:: ../../includes_ctl_chef_server/includes_ctl_chef_server_gather_logs.rst

user-* Commands
-----------------------------------------------------
The following subcommands can be used to manage users:

user-create
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_ctl_chef_server/includes_ctl_chef_server_user_create.rst

**Syntax**

.. include:: ../../includes_ctl_chef_server/includes_ctl_chef_server_user_create_syntax.rst

**Options**

.. include:: ../../includes_ctl_chef_server/includes_ctl_chef_server_user_create_options.rst

**Examples**

.. code-block:: bash

   $ chef-server-ctl user-create john_smith John Smith john_smith@example.com p@s5w0rD!

.. code-block:: bash

   $ chef-server-ctl user-create jane_doe Jane Doe jane_doe@example.com p@s5w0rD! -f /tmp/jane_doe.key

.. code-block:: bash

   $ chef-server-ctl user-create waldendude Henry David Thoreau waldendude@example.com excursions

user-delete
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_ctl_chef_server/includes_ctl_chef_server_user_delete.rst

**Syntax**

.. include:: ../../includes_ctl_chef_server/includes_ctl_chef_server_user_delete_syntax.rst

**Examples**

.. code-block:: bash

   $ chef-server-ctl user-delete john_smith

.. code-block:: bash

   $ chef-server-ctl user-delete jane_doe

user-edit
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_ctl_chef_server/includes_ctl_chef_server_user_edit.rst

**Syntax**

.. include:: ../../includes_ctl_chef_server/includes_ctl_chef_server_user_edit_syntax.rst

**Examples**

.. code-block:: bash

   $ chef-server-ctl user-edit john_smith

.. code-block:: bash

   $ chef-server-ctl user-edit jane_doe

user-list
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_ctl_chef_server/includes_ctl_chef_server_user_list.rst

**Syntax**

.. include:: ../../includes_ctl_chef_server/includes_ctl_chef_server_user_list_syntax.rst

**Options**

.. include:: ../../includes_ctl_chef_server/includes_ctl_chef_server_user_list_options.rst

user-show
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_ctl_chef_server/includes_ctl_chef_server_user_show.rst

**Syntax**

.. include:: ../../includes_ctl_chef_server/includes_ctl_chef_server_user_show_syntax.rst

**Options**

.. include:: ../../includes_ctl_chef_server/includes_ctl_chef_server_user_show_options.rst

org-* Commands
-----------------------------------------------------
The following subcommands can be used to manage organizations:

org-create
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_ctl_chef_server/includes_ctl_chef_server_org_create.rst

**Syntax**

.. include:: ../../includes_ctl_chef_server/includes_ctl_chef_server_org_create_syntax.rst

**Options**

.. include:: ../../includes_ctl_chef_server/includes_ctl_chef_server_org_create_options.rst

**Examples**

.. code-block:: bash

   $ chef-server-ctl org-create prod Production

.. code-block:: bash

   $ chef-server-ctl org-create staging Staging -a chef-admin

.. code-block:: bash

   $ chef-server-ctl org-create dev Development -f /tmp/id-dev.key

org-delete
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_ctl_chef_server/includes_ctl_chef_server_org_delete.rst

**Syntax**

.. include:: ../../includes_ctl_chef_server/includes_ctl_chef_server_org_delete_syntax.rst

**Examples**

.. code-block:: bash

   $ chef-server-ctl org-delete infra-testing-20140909

.. code-block:: bash
      
   $ chef-server-ctl org-delete pedant-testing-org

org-list
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_ctl_chef_server/includes_ctl_chef_server_org_list.rst

**Syntax**

.. include:: ../../includes_ctl_chef_server/includes_ctl_chef_server_org_list_syntax.rst

**Options**

.. include:: ../../includes_ctl_chef_server/includes_ctl_chef_server_org_list_options.rst

org-show
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_ctl_chef_server/includes_ctl_chef_server_org_show.rst

**Syntax**

.. include:: ../../includes_ctl_chef_server/includes_ctl_chef_server_org_show_syntax.rst

org-user-add
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. warning:: Early RC candidates for the |chef server| 12 release named this command ``org-associate``. This is the same command, with the exception of the ``--admin`` flag, which is added to the command (along with the rename) for the upcoming final release of |chef server| 12.

.. include:: ../../includes_ctl_chef_server/includes_ctl_chef_server_org_user_add.rst

**Syntax**

.. include:: ../../includes_ctl_chef_server/includes_ctl_chef_server_org_user_add_syntax.rst

**Options**

.. include:: ../../includes_ctl_chef_server/includes_ctl_chef_server_org_user_add_options.rst

**Examples**

.. code-block:: bash

   $ chef-server-ctl org-user-add prod john_smith

.. code-block:: bash

   $ chef-server-ctl org-user-add preprod testmaster

.. code-block:: bash

   $ chef-server-ctl org-user-add dev grantmc --admin


org-user-remove
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. warning:: Early RC candidates for the |chef server| 12 release named this command ``org-disociate``. This is the same command, but renamed for the upcoming final release of |chef server| 12.

.. include:: ../../includes_ctl_chef_server/includes_ctl_chef_server_org_user_remove.rst

**Syntax**

.. include:: ../../includes_ctl_chef_server/includes_ctl_chef_server_org_user_remove_syntax.rst

**Examples**

.. code-block:: bash

   $ chef-server-ctl org-user-remove prod john_smith

.. code-block:: bash

   $ chef-server-ctl org-user-remove prod testmaster


Configuration Settings
-----------------------------------------------------
The name of the |chef server| configuration file is now |chef server rb|.

The following configuration settings are new for |chef server| version 12:

.. list-table::
   :widths: 200 300
   :header-rows: 1

   * - Setting
     - Description
   * - ``default_orgname``
     - |default_orgname|
   * - ``postgresql['log_min_duration_statement']``
     - |log_rotation min_duration| Possible values: ``-1`` (disabled, do not log any statements), ``0`` (log every statement), or an integer greater than zero. When the integer is greater than zero, this value is the amount of time (in milliseconds) that a query statement must have run before it is logged. Default value: ``-1``.

The following configuration settings have updated default values starting with |chef server| version 12:

.. list-table::
   :widths: 200 300
   :header-rows: 1

   * - Setting
     - Description
   * - ``api_version``
     - |version chef_server| Default value: ``"12.0.0"``.

The following configuration settings are new in |chef server| version 12.0.5:

.. list-table::
   :widths: 200 300
   :header-rows: 1

   * - Setting
     - Description
   * - ``opscode_erchef['nginx_bookshelf_caching']``
     - |nginx bookshelf_caching| Default value: ``:off``.
   * - ``opscode_erchef['s3_url_expiry_window_size']``
     - |s3_url_expiry_window_size| Default value: ``:off``.

oc_chef_authz
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_server_services/includes_server_services_authz.rst

.. include:: ../../includes_config/includes_config_rb_server_settings_oc_chef_authz.rst


Data Bag Policy Changes
-----------------------------------------------------
In previous versions of the |chef server|, the default permissions allowed data bags to be updated by the |chef client| during a |chef client| run. Starting with |chef server| version 12, the |chef client| is not granted **Create**, **Delete**, or **Update** permissions to data bags when organizations are created. Use the |chef manage| or the ``knife-acl`` plugin (https://github.com/chef/knife-acl) to manage permissions to data bags as required. For example:

.. code-block:: bash

   $ knife acl add containers data update group clients

For cookbooks that create or delete data bags:

.. code-block:: bash

   $ knife acl add containers data create group clients
   
   $ knife acl add containers data delete group clients

For existing organizations that want to remove the **Create**, **Delete**, or **Update** permissions from existing nodes:

.. code-block:: bash

   $ knife acl remove containers data update group clients
   
   $ knife acl remove containers data delete group clients
   
   $ knife acl remove containers data create group clients

See this blog post for more information about the ``knife-acl`` plugin: https://www.chef.io/blog/2014/11/10/security-update-hosted-chef/

New Settings for LDAP
-----------------------------------------------------
The following settings are new:

.. list-table::
   :widths: 200 300
   :header-rows: 1

   * - Setting
     - Description
   * - ``ldap['ssl_enabled']``
     - Use to enable |ssl|. Default value: ``false``. Must be ``false`` when ``ldap['tls_enabled']`` is ``true``.
   * - ``ldap['tls_enabled']``
     - Use to enable TLS. When enabled, communication with the |ldap| server is done via a secure |ssl| connection on a dedicated port. When ``true``, ``ldap['port']`` is also set to ``636``. Default value: ``false``. Must be ``false`` when ``ldap['ssl_enabled']`` is ``true``.

.. note:: Previous versions of the |chef server| used the ``ldap['ssl_enabled']`` setting to first enable |ssl|, and then the ``ldap['encryption']`` setting to specify the encryption type. These settings are deprecated.


Key Rotation
=====================================================
Use the following commands to manage public and private key rotation for users and clients.

add-client-key
-----------------------------------------------------
.. include:: ../../includes_ctl_chef_server/includes_ctl_chef_server_add_client_key.rst

**Syntax**

.. include:: ../../includes_ctl_chef_server/includes_ctl_chef_server_add_client_key_syntax.rst

**Options**

.. include:: ../../includes_ctl_chef_server/includes_ctl_chef_server_add_client_key_options.rst

add-user-key
-----------------------------------------------------
.. include:: ../../includes_ctl_chef_server/includes_ctl_chef_server_add_user_key.rst

**Syntax**

.. include:: ../../includes_ctl_chef_server/includes_ctl_chef_server_add_user_key_syntax.rst

**Options**

.. include:: ../../includes_ctl_chef_server/includes_ctl_chef_server_add_user_key_options.rst

delete-client-key
-----------------------------------------------------
.. include:: ../../includes_ctl_chef_server/includes_ctl_chef_server_delete_client_key.rst

**Syntax**

.. include:: ../../includes_ctl_chef_server/includes_ctl_chef_server_delete_client_key_syntax.rst

**Options**

.. include:: ../../includes_ctl_chef_server/includes_ctl_chef_server_delete_client_key_options.rst

delete-user-key
-----------------------------------------------------
.. include:: ../../includes_ctl_chef_server/includes_ctl_chef_server_delete_user_key.rst

**Syntax**

.. include:: ../../includes_ctl_chef_server/includes_ctl_chef_server_delete_user_key_syntax.rst

**Options**

.. include:: ../../includes_ctl_chef_server/includes_ctl_chef_server_delete_user_key_options.rst

list-client-key
-----------------------------------------------------
.. include:: ../../includes_ctl_chef_server/includes_ctl_chef_server_list_client_keys.rst

**Syntax**

.. include:: ../../includes_ctl_chef_server/includes_ctl_chef_server_list_client_keys_syntax.rst

**Options**

.. include:: ../../includes_ctl_chef_server/includes_ctl_chef_server_list_client_keys_options.rst

list-user-key
-----------------------------------------------------
.. include:: ../../includes_ctl_chef_server/includes_ctl_chef_server_list_user_keys.rst

**Syntax**

.. include:: ../../includes_ctl_chef_server/includes_ctl_chef_server_list_user_keys_syntax.rst

**Options**

.. include:: ../../includes_ctl_chef_server/includes_ctl_chef_server_list_user_keys_options.rst

**Example**

.. code-block:: bash

   $ chef-server-ctl list-user-keys applejack

Returns:

.. code-block:: bash

   2 total key(s) found for user applejack
   
   key_name: test-key
   expires_at: Infinity
   public_key:
   -----BEGIN PUBLIC KEY-----
   MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEA4q9Dh+bwJSjhU/VI4Y8s
   9WsbIPfpmBpoZoZVPL7V6JDfIaPUkdcSdZpynhRLhQwv9ScTFh65JwxC7wNhVspB
   4bKZeW6vugNGwCyBIemMfxMlpKZQDOc5dnBiRMMOgXSIimeiFtL+NmMXnGBBHDaE
   b+XXI8oCZRx5MTnzEs90mkaCRSIUlWxOUFzZvnv4jBrhWsd/yBM/h7YmVfmwVAjL
   VST0QG4MnbCjNtbzToMj55NAGwSdKHCzvvpWYkd62ZOquY9f2UZKxYCX0bFPNVQM
   EvBQGdNG39XYSEeF4LneYQKPHEZDdqe7TZdVE8ooU/syxlZgADtvkqEoc4zp1Im3
   2wIDAQAB
   -----END PUBLIC KEY-----
   
   key_name: default
   expires_at: Infinity
   public_key:
   -----BEGIN PUBLIC KEY-----
   MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEA4q9Dh+bwJSjhU/VI4Y8s
   9WsbIPfpmBpoZoZVPL7V6JDfIaPUkdcSdZpynhRLhQwv9ScTFh65JwxC7wNhVspB
   4bKZeW6vugNGwCyBIemMfxMlpKZQDOc5dnBiRMMOgXSIimeiFtL+NmMXnGBBHDaE
   b+XXI8oCZRx5MTnzEs90mkaCRSIUlWxOUFzZvnv4jBrhWsd/yBM/h7YmVfmwVAjL
   VST0QG4MnbCjNtbzToMj55NAGwSdKHCzvvpWYkd62ZOquY9f2UZKxYCX0bFPNVQM
   EvBQGdNG39XYSEeF4LneYQKPHEZDdqe7TZdVE8ooU/syxlZgADtvkqEoc4zp1Im3
   2wIDAQAB
   -----END PUBLIC KEY-----

Changelog
=====================================================
For the list of issues that were addressed for this release, please see the changelog on |github|: https://github.com/chef/chef-server/blob/master/CHANGELOG.md