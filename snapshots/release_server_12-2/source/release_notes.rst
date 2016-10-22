
=====================================================
Release Notes: Chef Server 12.2
=====================================================

.. include:: ../../includes_chef/includes_chef_index.rst

What's New
=====================================================
The following items are new for Chef server 12.2:

* **Solr to Solr4 settings** Built-in transition for Apache Solr memory and JVM settings from Enterprise Chef to Chef server version 12.
* **Configurable Postgresql** Postgresql can be configured for an external database.
* **New endpoints for the Chef server API** Endpoints have been added to the Chef server API: ``DELETE /policy_groups``.
* **New subcommmands for chef-server-ctl** Use the ``backup`` and ``restore`` subcommmands to back up and restore Chef server data. Use the ``psql`` subcommmand to log into a PostgreSQL database that is associated with a service running in the Chef server configuration.
* **New options for chef-server-ctl reindex** The ``reindex`` subcommand has new options: ``--all-orgs`` (reindex all organizations), ``--disable-api`` (disable the Chef server API during reindexing), ``--with-timing`` (print timing information), and ``--wait`` (wait for reindex queue to clear before exiting).

Solr => Solr 4 Changes
=====================================================
Chef server version 12 is upgraded to Apache Solr 4. If Apache Solr options were added to the private-chef.rb file under ``opscode_solr`` for Enterprise Chef, those configuration options are now stored under ``opscode_solr4`` in the chef-server.rb file for Chef server version 12.

Some ``opscode_solr`` settings are imported automatically, such as heap, new size, and Java options, but many settings are ignored. If your Enterprise Chef configuration is highly tuned for Apache Solr, review `these configuration settings <https://docs.chef.io/config_rb_server_optional_settings.html#opscode-solr4>`__ before re-tuning Apache Solr for Chef server version 12.

External PostgreSQL
=====================================================
.. include:: ../../includes_server_ha/includes_server_ha_external_postgresql.rst

.. note:: The following ``chef-server-ctl`` subcommands for managing services are disabled when an external PostgreSQL database is configured for the Chef server: ``hup``, ``int``, ``kill``, ``once``, ``restart``, ``start``, ``stop``, ``tail``, and ``term``.

Settings
-----------------------------------------------------
.. include:: ../../includes_server_ha/includes_server_ha_external_postgresql_settings.rst


Backup / Restore
=====================================================
Use the following commands to manage backups of Chef server data, and then to restore those backups.

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

Chef server API Endpoints
=====================================================
The following endpoints have been added to the Chef server API:

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

What's Fixed
=====================================================
For the list of issues that were addressed for this release, please see the changelog on GitHub: https://github.com/chef/chef-server/blob/master/CHANGELOG.md
