=====================================================
Chef Replication (DEPRECATED)
=====================================================

.. warning:: This topic is deprecated as of the 12.9 release of the Chef servver.

.. note:: This topic is meant to support existing customers using Chef replication. The capabilities of Chef replication can be reproduced using the features of Chef Automate workflow and we encourage customers to adopt Chef Automate going forward.

.. include:: ../../includes_server_replication/includes_server_replication.rst

.. note:: Chef replication requires Chef server version 12.

.. note:: .. include:: ../../includes_chef/includes_chef_subscriptions.rst

Scenarios
=====================================================
.. include:: ../../includes_server_replication/includes_server_replication_scenarios.rst

How Replication Works
=====================================================
.. include:: ../../includes_server_replication/includes_server_replication_how_it_works.rst

Configure Chef Replication
=====================================================
To configure replication of Chef server data, first install Chef replication, then configure the primary Chef server, then configure the replica Chef server, and then start the synchronization process. 

#. To install Chef replication, run the following on all servers in the Chef server configuration. For dpkg:

   .. code-block:: bash
      
      $ dpkg -i chef-sync-<version>.deb

   For RPM Package Manager:

   .. code-block:: bash
      
      $ rpm -Uvh chef-sync-<version>.rpm

#. On the primary Chef server, create the chef-sync.rb file in the ``/etc/chef-sync/`` directory, and then add the following setting:

   .. code-block:: ruby
      
      role :master

#. On the primary Chef server, run the following command:
  
   .. code-block:: bash
      
      $ chef-sync-ctl reconfigure

#. On the primary Chef server, run the following command:
  
   .. code-block:: bash
      
      $ chef-server-ctl reconfigure

#. On the primary Chef server, run the following command:

   .. code-block:: bash
      
      $ chef-sync-ctl prepare-org SOURCE_ORG_NAME

#. For each replica Chef server, move the ``/etc/chef-sync/ec_sync_user.pem`` file from the primary Chef server to the ``/etc/chef-sync`` directory on the replica. (This file is created automatically on the primary Chef server.)

#. For each replica Chef server, create the chef-sync.rb file in the ``/etc/chef-sync/`` directory, and then add the following setting:

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
   
   where ``DEST_ORG_NAME`` is an organization on the replica Chef server and ``SOURCE_ORG_NAME`` is an organization on the primary Chef server. Both of these organizations must already exist.

#. For each replica Chef server, run the following command:
  
   .. code-block:: bash
      
      $ chef-sync-ctl reconfigure

#. For each replica Chef server, run the following command:

   .. code-block:: bash
      
      $ chef-sync-ctl prepare-org DEST_ORG_NAME

#. For each replica Chef server, run the following command:
  
   .. code-block:: bash
      
      $ chef-server-ctl reconfigure

chef-sync-ctl (executable)
=====================================================
chef-sync-ctl is the command line tool for Chef replication, which allows asynchronous replication of cookbook content across Chef server organizations. This is done from a single, primary Chef server organization to one (or more) replicas of that Chef server.

manager-log
-----------------------------------------------------
Use to show the log file for the synchronization manager. This subcommand should only be run for replica organizations.

This option has the following syntax:

.. code-block:: bash

   $ chef-sync-ctl manager-log

prepare-org
-----------------------------------------------------
Use to prepare the specified organization for synchronization by associating the synchronizing user, and then making that user an administrator. This subcommand must be run on both the single, primary Chef server organization and all replica organizations.

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
   Indicates whether an attempt to bootstrap the Chef server is made. Generally only enabled on systems that have bootstrap enabled via a ``server`` entry. Default value: ``true``.

``chef_base_path``
   Default value: ``'/opt/opscode'``.

``ec_sync_client['dir']``
   The working directory. The default value is the recommended value. Default value: ``'/var/opt/chef-sync/ec_sync_client'``.

``ec_sync_client['enable']``
   Enable a service. Default value: ``true``.

``ec_sync_client['ha']``
   Run the Chef server in a high availability topology. Default value: ``false``.

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
   Run the Chef server in a high availability topology. Default value: ``false``.

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
   Use to specify the root URL for the master Chef server.

``name``
   Default value: ``'sync'``.

``organization``
   An array that specifies the source and destination organization pairs for synchronization.

``replica``
   Use to specify the root URL for the replica Chef server.

``role``
   Use to specify if ``chef-sync`` is installed as a master Chef server, a replica Chef server, or both. Possible values: ``:master``, ``:master_and_replica``, ``:replica``. Default value: ``:replica``.

``user['home']``
   The home directory for the user under which Chef server services run. Default value: ``'/opt/opscode/embedded'``.

``user['shell']``
   The shell for the user under which Chef server services run. Default value: ``'/bin/sh'``.

``user['username']``
   The user name under which Chef server services run. Default value: ``opscode``.



Chef server API Endpoint
=====================================================
The following Chef server API endpoint supports Chef replication. 

/updated_since
-----------------------------------------------------
.. include:: ../../includes_api_chef_server/includes_api_chef_server_endpoint_org_name_updated_since.rst

GET
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_api_chef_server/includes_api_chef_server_endpoint_org_name_updated_since_get.rst
