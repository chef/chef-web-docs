
=====================================================
Release Notes: |chef server_title| 12.2
=====================================================

.. include:: ../../includes_chef/includes_chef_index.rst

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

What's Fixed
=====================================================
For the list of issues that were addressed for this release, please see the changelog on |github|: https://github.com/chef/chef-server/blob/master/CHANGELOG.md
