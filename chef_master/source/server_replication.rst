=====================================================
Chef Replication (DEPRECATED)
=====================================================
`[edit on GitHub] <https://github.com/chef/chef-web-docs/blob/master/chef_master/source/server_replication.rst>`__

.. warning:: This topic is deprecated as of the 12.9 release of the Chef Server.

.. note:: This topic is meant to support existing customers using Chef replication. The capabilities of Chef replication can be reproduced using the features of Chef Automate workflow and we encourage customers to adopt Chef Automate going forward.

Chef replication provides a way to asynchronously distribute cookbook, environment, role, and data bag data from a single, primary Chef Server to one (or more) replicas of that Chef Server.



.. note:: Chef replication requires Chef Server version 12.

.. note:: .. tag chef_subscriptions

          This feature is included as part of the Chef Automate license agreement and is `available via subscription <https://www.chef.io/pricing/>`_.

          .. end_tag

Scenarios
=====================================================
Replication is configured on a per-organization and also a per-replica basis. Each organization must be configured to synchronize with each replica instance. Each organization may be configured to synchronize with all, some, or none of the available replica instances.

For example, a single primary Chef Server and a single replica:

.. image:: ../../images/chef_server_replication.png

and for example, a single primary Chef Server and multiple replicas:

.. image:: ../../images/chef_server_replication_many.png

Chef replication should not be used for:

* Disaster recovery or backup/restore processes. The replication process is read-only and cannot be changed to read-write
* Synchronizing a replica instance with another replica instance
* Node re-registration. A node may be associated only with a single Chef Server



How Replication Works
=====================================================
A daemon named **ec-syncd** runs on each of the replica instances of the Chef Server and periodically polls the primary Chef Server via the ``updated_since`` endpoint in the Chef Server API. The **ec-syncd** daemon requests a list of objects that have been updated since the last successful synchronization time. If there are updates, the **ec-syncd** daemon then pulls down the updated data from the primary Chef Server to the replica.

.. image:: ../../images/chef_server_replication_sequence.png



Configure Chef Replication
=====================================================
To configure replication of Chef Server data, first install Chef replication, then configure the primary Chef Server, then configure the replica Chef Server, and then start the synchronization process.

#. To install Chef replication, run the following on all servers in the Chef Server configuration. For dpkg:

   .. code-block:: bash

      $ dpkg -i chef-sync-<version>.deb

   For RPM Package Manager:

   .. code-block:: bash

      $ rpm -Uvh chef-sync-<version>.rpm

#. On the primary Chef Server, create the chef-sync.rb file in the ``/etc/chef-sync/`` directory, and then add the following setting:

   .. code-block:: ruby

      role :master

#. On the primary Chef Server, run the following command:

   .. code-block:: bash

      $ chef-sync-ctl reconfigure

#. On the primary Chef Server, run the following command:

   .. code-block:: bash

      $ chef-server-ctl reconfigure

#. On the primary Chef Server, run the following command:

   .. code-block:: bash

      $ chef-sync-ctl prepare-org SOURCE_ORG_NAME

#. For each replica Chef Server, move the ``/etc/chef-sync/ec_sync_user.pem`` file from the primary Chef Server to the ``/etc/chef-sync`` directory on the replica. (This file is created automatically on the primary Chef Server.)

#. For each replica Chef Server, create the chef-sync.rb file in the ``/etc/chef-sync/`` directory, and then add the following setting:

   .. code-block:: ruby

      role :replica
      master "https://FQDN_OF_MASTER"

   and then define the source and destination organizations:

   .. code-block:: ruby

      organizations [
                      {
                        :destination => "DEST_ORG_NAME",
                        :source => "SOURCE_ORG_NAME"
                      }
                    ]

   where ``DEST_ORG_NAME`` is an organization on the replica Chef Server and ``SOURCE_ORG_NAME`` is an organization on the primary Chef Server. Both of these organizations must already exist.

#. For each replica Chef Server, run the following command:

   .. code-block:: bash

      $ chef-sync-ctl reconfigure

#. For each replica Chef Server, run the following command:

   .. code-block:: bash

      $ chef-sync-ctl prepare-org DEST_ORG_NAME

#. For each replica Chef Server, run the following command:

   .. code-block:: bash

      $ chef-server-ctl reconfigure

chef-sync-ctl (executable)
=====================================================
chef-sync-ctl is the command line tool for Chef replication, which allows asynchronous replication of cookbook content across Chef Server organizations. This is done from a single, primary Chef Server organization to one (or more) replicas of that Chef Server.

manager-log
-----------------------------------------------------
Use to show the log file for the synchronization manager. This subcommand should only be run for replica organizations.

This option has the following syntax:

.. code-block:: bash

   $ chef-sync-ctl manager-log

prepare-org
-----------------------------------------------------
Use to prepare the specified organization for synchronization by associating the synchronizing user, and then making that user an administrator. This subcommand must be run on both the single, primary Chef Server organization and all replica organizations.

This option has the following syntax:

.. code-block:: bash

   $ chef-sync-ctl prepare-org ORG_NAME

This option will compile a list of group names, organization names, and actors (users, clients, and groups).

sync-log
-----------------------------------------------------
Use to show the log file for the specified organization. This subcommand should only be run for replica organizations.

This option has the following syntax:

.. code-block:: bash

   $ chef-sync-ctl sync-log ORG_NAME

sync-start
-----------------------------------------------------
Use to start synchronizing an organization. This subcommand should only be run for replica organizations.

This option has the following syntax:

.. code-block:: bash

   $ chef-sync-ctl sync-start ORG_NAME

sync-status
-----------------------------------------------------
Use to show the current status of all organizations that are synchronizing. This subcommand should only be run for replica organizations.

This option has the following syntax:

.. code-block:: bash

   $ chef-sync-ctl sync-status

and will return a list that shows the organization name, its status, the last synchronization time, and the time at which the synchronization process will begin again.

sync-stop
-----------------------------------------------------
Use to stop synchronizing an organization. This subcommand should only be run for replica organizations.

This option has the following syntax:

.. code-block:: bash

   $ chef-sync-ctl sync-stop ORG_NAME

unsynced-objects
-----------------------------------------------------
Use to show unsynchronized objects for the specified organization. This subcommand should only be run for replica organizations.

This option has the following syntax:

.. code-block:: bash

   $ chef-sync-ctl unsynced-objects ORG_NAME

chef-sync.rb
=====================================================
The chef-sync.rb file is the default configuration file used by Chef replication.

Settings
-----------------------------------------------------
This configuration file has the following settings:

``bootstrap``
   Indicates whether an attempt to bootstrap the Chef Server is made. Generally only enabled on systems that have bootstrap enabled via a ``server`` entry. Default value: ``true``.

``chef_base_path``
   Default value: ``'/opt/opscode'``.

``ec_sync_client['dir']``
   The working directory. The default value is the recommended value. Default value: ``'/var/opt/chef-sync/ec_sync_client'``.

``ec_sync_client['enable']``
   Enable a service. Default value: ``true``.

``ec_sync_client['ha']``
   Run the Chef Server in a high availability topology. Default value: ``false``.

``ec_sync_client['log_directory']``
   The directory in which log data is stored. The default value is the recommended value. Default value: ``'/var/log/opscode/chef-sync/client'``.

``ec_sync_client['log_rotation']``
   The log rotation policy for this service. Log files are rotated when they exceed ``file_maxbytes``. The maximum number of log files in the rotation is defined by ``num_to_keep``. Default value: ``{ 'file_maxbytes' => 104857600, 'num_to_keep' => 10 }``

``ec_sync_client['master']``
   Default value: ``'https://127.0.0.1'``.

``ec_sync_client['organizations']``
   Default value: ``[]``.

``ec_sync_client['replica']``
   Default value: ``'https://127.0.0.1'``.

``ec_sync_client['socket_path']``
   Default value: ``'/var/opt/chef-sync/ec_sync_client/ec_sync.sock'``.

``ec_sync_client['sync_key']``
   Default value: ``'/etc/chef-sync/ec_sync_user.pem'``.

``ec_sync_client['sync_user']``
   Default value: ``'ec_sync_user'``.

``ec_sync_server['auth_skew']``
   Default value: ``'900'``.

``ec_sync_server['db_pool_size']``
   The number of open connections to PostgreSQL that are maintained by the service. Default value: ``10``.

``ec_sync_server['dir']``
   The working directory. The default value is the recommended value. Default value: ``'/var/opt/chef-sync/ec_sync_server'``.

``ec_sync_server['enable']``
   Enable a service. Default value: ``true``.

``ec_sync_server['ha']``
   Run the Chef Server in a high availability topology. Default value: ``false``.

``ec_sync_server['listen']``
   The IP address on which the service is to listen. Default value: ``'127.0.0.1'``.

``ec_sync_server['log_directory']``
   The directory in which log data is stored. The default value is the recommended value. Default value: ``'/var/log/opscode/chef-sync/server'``.

``ec_sync_server['log_rotation']``
   The log rotation policy for this service. Log files are rotated when they exceed ``file_maxbytes``. The maximum number of log files in the rotation is defined by ``num_to_keep``. Default value: ``{ 'file_maxbytes' => 104857600, 'num_to_keep' => 10 }``

``ec_sync_server['port']``
   The port on which the service is to listen. Default value: ``9996``.

``ec_sync_server['vip']``
   The virtual IP address. Default value: ``'127.0.0.1'``.

``install_path'``
   Default value: ``'/opt/chef-sync'``.

``master``
   Use to specify the root URL for the master Chef Server.

``name``
   Default value: ``'sync'``.

``organization``
   An array that specifies the source and destination organization pairs for synchronization.

``replica``
   Use to specify the root URL for the replica Chef Server.

``role``
   Use to specify if ``chef-sync`` is installed as a master Chef Server, a replica Chef Server, or both. Possible values: ``:master``, ``:master_and_replica``, ``:replica``. Default value: ``:replica``.

``user['home']``
   The home directory for the user under which Chef Server services run. Default value: ``'/opt/opscode/embedded'``.

``user['shell']``
   The shell for the user under which Chef Server services run. Default value: ``'/bin/sh'``.

``user['username']``
   The user name under which Chef Server services run. Default value: ``opscode``.

Chef Server API Endpoint
=====================================================
The following Chef Server API endpoint supports Chef replication.

/updated_since
-----------------------------------------------------
.. tag api_chef_server_endpoint_org_name_updated_since

The ``/updated_since`` endpoint ensures that replica instances of the Chef Infra Server are able to synchronize with the primary Chef Infra Server. The ``/organizations/NAME/updated_since`` endpoint has the following methods: ``GET``.

.. end_tag

GET
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. tag api_chef_server_endpoint_org_name_updated_since_get

The ``GET`` method is used to return the details of an organization as JSON.

**Request**

.. code-block:: none

   GET /organizations/NAME/objects_since?seq=NUM

where ``NUM`` is the largest integer previously returned as an identifier.

**Response**

The response will return an array of paths for objects that have been created, updated, or deleted since ``NUM``, similar to:

.. code-block:: javascript

   [
     {
       "action": "create",
       "id": 1,
       "path": "/roles/foo"
     },
     {
       "action": "create",
       "id": 2,
       "path": "/roles/foo2"
     },
     {
       "action": "create",
       "id": 3,
       "path": "/roles/foo3"
     },
     {
       "action": "update",
       "id": 4,
       "path": "/roles/foo3"
     }
   ]

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
