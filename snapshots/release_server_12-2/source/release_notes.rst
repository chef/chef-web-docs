
=====================================================
Release Notes: Chef Server 12.2
=====================================================

.. tag chef_index

Chef is a systems and cloud infrastructure automation framework that makes it easy to deploy servers and applications to any physical, virtual, or cloud location, no matter the size of the infrastructure. Each organization is comprised of one (or more) workstations, a single server, and every node that will be configured and maintained by the chef-client. Cookbooks (and recipes) are used to tell the chef-client how each node in your organization should be configured. The chef-client (which is installed on every node) does the actual configuration.

.. end_tag

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

Some ``opscode_solr`` settings are imported automatically, such as heap, new size, and Java options, but many settings are ignored. If your Enterprise Chef configuration is highly tuned for Apache Solr, review :ref:`these configuration settings <config_rb_server_optional_settings-opscode-solr4>` before re-tuning Apache Solr for Chef server version 12.

External PostgreSQL
=====================================================
.. tag server_ha_external_postgresql

The following diagram highlights the specific changes that occur when PostgreSQL is configured and managed independently of the Chef server configuration.

.. image:: ../../images/server_components_postgresql.svg
   :width: 500px

The following table describes the components in an external PostgreSQL configuration that are different from the default configuration of the Chef server:

.. list-table::
   :widths: 60 420
   :header-rows: 1

   * - Component
     - Description
   * - Chef Server
     - The Chef server configuration file is updated to point to an independently configured set of servers for PostgreSQL.
   * - PostgreSQL
     - .. tag chef_server_component_postgresql

       PostgreSQL is the data storage repository for the Chef server.

       .. end_tag

       This represents the independently configured set of servers that are running PostgreSQL and are configured to act as the data store for the Chef server.

.. end_tag

.. note:: The following ``chef-server-ctl`` subcommands for managing services are disabled when an external PostgreSQL database is configured for the Chef server: ``hup``, ``int``, ``kill``, ``once``, ``restart``, ``start``, ``stop``, ``tail``, and ``term``.

Settings
-----------------------------------------------------
.. tag server_ha_external_postgresql_settings

Use the following configuration settings in the chef-server.rb file to configure PostgreSQL for use with the Chef server:

.. list-table::
   :widths: 200 300
   :header-rows: 1

   * - Setting
     - Description
   * - ``postgresql['db_superuser']``
     - Required when ``postgresql['external']`` is set to ``true``. The PostgreSQL user name. This user must be granted either the ``CREATE ROLE`` and ``CREATE DATABASE`` permissions in PostgreSQL or be granted ``SUPERUSER`` permission. This user must also have an entry in the host-based authentication configuration file used by PostgreSQL (traditionally named ``pg_hba.conf``). Default value: ``'superuser_userid'``.
   * - ``postgresql['db_superuser_password']``
     - Required when ``postgresql['external']`` is set to ``true``. The password for the user specified by ``postgresql['db_superuser']``. Default value: ``'the password'``.
   * - ``postgresql['external']``
     - Required. Set to ``true`` to run PostgreSQL external to the Chef server. Must be set once only on a new installation of the Chef server before the first ``chef-server-ctl reconfigure`` command is run. If this is set after a reconfigure or set to ``false``, any reconfigure of the Chef server will return an error. Default value: ``false``.
   * - ``postgresql['port']``
     - Optional when ``postgresql['external']`` is set to ``true``. The port on which the service is to listen. The port used by PostgreSQL if that port is **not** 5432. Default value: ``5432``.
   * - ``postgresql['vip']``
     - Required when ``postgresql['external']`` is set to ``true``. The virtual IP address. The host for this IP address must be online and reachable from the Chef server via the port specified by ``postgresql['port']``. Set this value to the IP address or hostname for the machine on which external PostgreSQL is located when ``postgresql['external']`` is set to ``true``.

.. end_tag

Backup / Restore
=====================================================
Use the following commands to manage backups of Chef server data, and then to restore those backups.

backup
-----------------------------------------------------
.. tag ctl_chef_server_backup

The ``backup`` subcommand is used to back up all Chef server data. This subcommand:

* Requires rsync to be installed on the Chef server prior to running the command
* Requires a ``chef-server-ctl reconfigure`` prior to running the command
* Should not be run in a Chef server configuration with an external PostgreSQL database; `use knife ec backup <https://github.com/chef/knife-ec-backup>`__ instead
* Puts the initial backup in the ``/var/opt/chef-backup`` directory as a tar.gz file; move this backup to a new location for safe keeping

.. end_tag

**Options**

.. tag ctl_chef_server_backup_options

This subcommand has the following options:

``-y``, ``--yes``
   Use to specify if the Chef server can go offline during tar.gz-based backups.

.. end_tag

**Syntax**

.. tag ctl_chef_server_backup_syntax

This subcommand has the following syntax:

.. code-block:: bash

   $ chef-server-ctl backup

.. end_tag

restore
-----------------------------------------------------
.. tag ctl_chef_server_restore

The ``restore`` subcommand is used to restore Chef server data from a backup that was created by the ``backup`` subcommand. This subcommand may also be used to add Chef server data to a newly-installed server. This subcommand:

* Requires rsync to be installed on the Chef server prior to running the command
* Requires a ``chef-server-ctl reconfigure`` prior to running the command
* Should not be run in a Chef server configuration with an external PostgreSQL database; `use knife ec backup <https://github.com/chef/knife-ec-backup>`__ instead
* May restore backed up data to any version of the Chef server that supports this command, starting with Chef server 12.2 (which is the first version of the Chef server in which the ``chef-server-ctl restore`` command is available)

.. end_tag

**Options**

.. tag ctl_chef_server_restore_options

This subcommand has the following options:

``-c``, ``--cleanse``
   Use to remove all existing data on the Chef server; it will be replaced by the data in the backup archive.

``-d DIRECTORY``, ``--staging-dir DIRECTORY``
   Use to specify that the path to an empty directory to be used during the restore process. This directory must have enough disk space to expand all data in the backup archive.

.. end_tag

**Syntax**

.. tag ctl_chef_server_restore_syntax

This subcommand has the following syntax:

.. code-block:: bash

   $ chef-server-ctl restore PATH_TO_BACKUP (options)

.. end_tag

**Examples**

.. code-block:: bash

   $ chef-server-ctl restore /path/to/tar/archive.tar.gz

psql
=====================================================
.. tag ctl_chef_server_psql

The ``psql`` subcommand is used to log into the PostgreSQL database associated with the named service. This subcommand:

* Uses ``psql`` (the interactive terminal for PostgreSQL)
* Has read-only access by default
* Is the recommended way to interact with any PostgreSQL database that is part of the Chef server
* Automatically handles authentication

.. end_tag

**Syntax**

.. tag ctl_chef_server_psql_syntax

This subcommand has the following syntax:

.. code-block:: bash

   $ chef-server-ctl psql SERVICE_NAME (options)

.. end_tag

**Options**

.. tag ctl_chef_server_psql_options

This subcommand has the following options:

``--write``
   Use to enable write access to the PostgreSQL database.

.. end_tag

reindex Options
=====================================================
.. tag ctl_chef_server_reindex_options

This subcommand has the following options:

``-a``, ``--all-orgs``
   Use to reindex all organizations on the Chef server. This option will override any organization specified as part of the command, i.e. ``chef-server-ctl reindex ORG_NAME -a`` will reindex all organizations and not just the specified organization.

``-d``, ``--disable-api``
   Use to disable the Chef server API to prevent writes during reindexing.

``-t``, ``--with-timing``
   Use to print timing information for the reindex processes.

``-w``, ``--wait``
   Use to wait for the reindexing queue to clear before exiting.

.. end_tag

Chef server API Endpoints
=====================================================
The following endpoints have been added to the Chef server API:

/policy_groups/NAME
-----------------------------------------------------
.. tag api_chef_server_endpoint_policy_groups

The ``/policy_groups`` endpoint has the following methods: ``GET``.

.. end_tag

DELETE
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. tag api_chef_server_endpoint_policy_groups_delete

The ``DELETE`` method is used to delete a policy group that is stored on the Chef server.

This method has no parameters.

**Request**

.. code-block:: none

   DELETE /organizations/NAME/policy_groups/NAME

**Response**

The response returns the policy details and is similar to:

.. code-block:: javascript

   {
     "uri": "https://chef.example/organizations/org1/policy_groups/dev",
     "policies": {
       "aar": {
         "revision_id": "95040c199302c85c9ccf1bcc6746968b820b1fa25d92477ea2ec5386cd58b9c5"
       },
       "jenkins": {
         "revision_id": "613f803bdd035d574df7fa6da525b38df45a74ca82b38b79655efed8a189e073"
       }
     }
   }

**Response Codes**

.. list-table::
   :widths: 200 300
   :header-rows: 1

   * - Response Code
     - Description
   * - ``200``
     - OK. The request was successful.
   * - ``401``
     - Unauthorized. The user or client who made the request could not be authenticated. Verify the user/client name, and that the correct key was used to sign the request.
   * - ``403``
     - Forbidden. The user who made the request is not authorized to perform the action.
   * - ``404``
     - Not found. The requested object does not exist.

.. end_tag

/policies/NAME
-----------------------------------------------------
.. tag api_chef_server_endpoint_policy_name

The ``/policies/NAME`` endpoint has the following methods: ``DELETE`` and ``GET``. These endpoints enables the management of policies as they relate to a specific policy group.

.. end_tag

GET
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. tag api_chef_server_endpoint_policy_name_get

The ``GET`` method is used to return a policy document.

This method has no parameters.

**Request**

.. code-block:: none

   GET /organizations/NAME/policies/NAME

**Response**

The response is similar to:

.. code-block:: none

   xxxxx

**Response Codes**

.. list-table::
   :widths: 200 300
   :header-rows: 1

   * - Response Code
     - Description
   * - ``200``
     - OK. The request was successful.
   * - ``401``
     - Unauthorized. The user or client who made the request could not be authenticated. Verify the user/client name, and that the correct key was used to sign the request.
   * - ``403``
     - Forbidden. The user who made the request is not authorized to perform the action.
   * - ``404``
     - Not found. The requested object does not exist.

.. end_tag

DELETE
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. tag api_chef_server_endpoint_policy_name_delete

The ``DELETE`` method is used to delete a policy.

This method has no parameters.

**Request**

.. code-block:: none

   DELETE /organizations/NAME/policies/NAME

**Response**

The response returns the policy details and is similar to:

.. code-block:: javascript

   {
     "revisions":
       {
         "37f9b658cdd1d9319bac8920581723efcc2014304b5f3827ee0779e10ffbdcc9": {},
         "95040c199302c85c9ccf1bcc6746968b820b1fa25d92477ea2ec5386cd58b9c5": {},
         "d81e80ae9bb9778e8c4b7652d29b11d2111e763a840d0cadb34b46a8b2ca4347": {}
       }
   }

**Response Codes**

.. list-table::
   :widths: 200 300
   :header-rows: 1

   * - Response Code
     - Description
   * - ``200``
     - OK. The request was successful.
   * - ``401``
     - Unauthorized. The user or client who made the request could not be authenticated. Verify the user/client name, and that the correct key was used to sign the request.
   * - ``403``
     - Forbidden. The user who made the request is not authorized to perform the action.
   * - ``404``
     - Not found. The requested object does not exist.

.. end_tag

/policies/NAME/revisions
-----------------------------------------------------
.. tag api_chef_server_endpoint_policy_revision

The ``/roles`` endpoint has the following methods: ``POST``.

.. end_tag

POST
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. tag api_chef_server_endpoint_policy_revision_post

The ``POST`` method is used to create a new policy revision.

This method has no parameters.

**Request**

.. code-block:: none

   POST /organizations/NAME/policies/NAME/revisions

with a request body similar to:

.. code-block:: none

   xxxxx

**Response**

The response is similar to:

.. code-block:: none

   xxxxx

**Response Codes**

.. list-table::
   :widths: 200 300
   :header-rows: 1

   * - Response Code
     - Description
   * - ``201``
     - OK. The request was successful.
   * - ``400``
     - Bad request. The contents of the request are not formatted correctly.
   * - ``401``
     - Unauthorized. The user or client who made the request could not be authenticated. Verify the user/client name, and that the correct key was used to sign the request.
   * - ``403``
     - Forbidden. The user who made the request is not authorized to perform the action.
   * - ``409``
     - Conflict. The object already exists.
   * - ``413``
     - Request entity too large. A request may not be larger than 1000000 bytes.

.. end_tag

/policies/NAME/revisions/ID
-----------------------------------------------------
.. tag api_chef_server_endpoint_policy_id_revision

The ``/policies/NAME/revisions/ID`` endpoint has the following methods: ``DELETE`` and ``GET``.

.. end_tag

GET
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. tag api_chef_server_endpoint_policy_id_revision_get

The ``GET`` method is used to return a policy document for a specific policy revision.

This method has no parameters.

**Request**

.. code-block:: none

   GET /organizations/NAME/GROUP/policies/NAME/revisions/ID

**Response**

The response is similar to:

.. code-block:: javascript

   {
     "revision_id": "37f9b658cdd1d9319bac8920581723efcc2014304b5f3827ee0779e10ffbdcc9",
     "name": "aar",
     "run_list": [
       "recipe[aar::default]"
     ],
     "cookbook_locks": {
       "aar": {
         "version": "0.1.0",
         "identifier": "29648fe36333f573d5fe038a53256e23733618aa",
         "dotted_decimal_identifier": "11651043203167221.32604909279531813.121098535835818",
         "source": "cookbooks/aar",
         "cache_key": null,
         "scm_info": {
           "scm": "git",
           "remote": null,
           "revision": "a2c8cbb24a08625921d753cde36e8320465116c3",
           "working_tree_clean": false,
           "published": false,
           "synchronized_remote_branches": []
         },
         "source_options": {
           "path": "cookbooks/aar"
         }
       },
       "apt": {
         "version": "2.7.0",
         "identifier": "16c57abbd056543f7d5a15dabbb03261024a9c5e",
         "dotted_decimal_identifier": "6409580415309396.17870749399956400.55392231660638",
         "cache_key": "apt-2.7.0-supermarket.chef.io",
         "origin": "https://supermarket.chef.io/api/v1/cookbooks/apt/versions/2.7.0/download",
         "source_options": {
           "artifactserver": "https://supermarket.chef.io/api/v1/cookbooks/apt/versions/2.7.0/download",
           "version": "2.7.0"
         }
       }
     },
     "default_attributes": {},
     "override_attributes": {},
     "solution_dependencies": {
       "Policyfile": [
         [
           "aar",
           ">= 0.0.0"
         ],
         [
           "apt",
           "= 2.7.0"
         ],
       ],
       "dependencies": {
         "apt (2.7.0)": [],
         "aar (0.1.0)": [
           [
             "apt",
             ">= 0.0.0"
           ]
         ]
       }
     }
   }

**Response Codes**

.. list-table::
   :widths: 200 300
   :header-rows: 1

   * - Response Code
     - Description
   * - ``200``
     - OK. The request was successful.
   * - ``401``
     - Unauthorized. The user or client who made the request could not be authenticated. Verify the user/client name, and that the correct key was used to sign the request.
   * - ``403``
     - Forbidden. The user who made the request is not authorized to perform the action.
   * - ``404``
     - Not found. The requested object does not exist.

.. end_tag

DELETE
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. tag api_chef_server_endpoint_policy_id_revision_delete

The ``DELETE`` method is used to delete a policy document for a specific policy revision.

This method has no parameters.

**Request**

.. code-block:: none

   DELETE /organizations/NAME/GROUP/policies/NAME/revisions/ID

**Response**

The response returns the policy details and is similar to:

.. code-block:: javascript

   {
     "revision_id": "37f9b658cdd1d9319bac8920581723efcc2014304b5f3827ee0779e10ffbdcc9",
     "name": "aar",
     "run_list": [
       "recipe[aar::default]"
     ],
     "cookbook_locks": {
       "aar": {
         "version": "0.1.0",
         "identifier": "29648fe36333f573d5fe038a53256e23733618aa",
         "dotted_decimal_identifier": "11651043203167221.32604909279531813.121098535835818",
         "source": "cookbooks/aar",
         "cache_key": null,
         "scm_info": {
           "scm": "git",
           "remote": null,
           "revision": "a2c8cbb24a08625921d753cde36e8320465116c3",
           "working_tree_clean": false,
           "published": false,
           "synchronized_remote_branches": []
         },
         "source_options": {
           "path": "cookbooks/aar"
         }
       },
       "apt": {
         "version": "2.7.0",
         "identifier": "16c57abbd056543f7d5a15dabbb03261024a9c5e",
         "dotted_decimal_identifier": "6409580415309396.17870749399956400.55392231660638",
         "cache_key": "apt-2.7.0-supermarket.chef.io",
         "origin": "https://supermarket.chef.io/api/v1/cookbooks/apt/versions/2.7.0/download",
         "source_options": {
           "artifactserver": "https://supermarket.chef.io/api/v1/cookbooks/apt/versions/2.7.0/download",
           "version": "2.7.0"
         }
       }
     },
     "default_attributes": {},
     "override_attributes": {},
     "solution_dependencies": {
       "Policyfile": [
         [
           "aar",
           ">= 0.0.0"
         ],
         [
           "apt",
           "= 2.7.0"
         ],
       ],
       "dependencies": {
         "apt (2.7.0)": [],
         "aar (0.1.0)": [
           [
             "apt",
             ">= 0.0.0"
           ]
         ]
       }
     }
   }

**Response Codes**

.. list-table::
   :widths: 200 300
   :header-rows: 1

   * - Response Code
     - Description
   * - ``200``
     - OK. The request was successful.
   * - ``401``
     - Unauthorized. The user or client who made the request could not be authenticated. Verify the user/client name, and that the correct key was used to sign the request.
   * - ``403``
     - Forbidden. The user who made the request is not authorized to perform the action.
   * - ``404``
     - Not found. The requested object does not exist.

.. end_tag

What's Fixed
=====================================================
For the list of issues that were addressed for this release, please see the changelog on GitHub: https://github.com/chef/chef-server/blob/master/CHANGELOG.md
