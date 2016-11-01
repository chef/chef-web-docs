

=====================================================
Services
=====================================================

.. tag server_services_12

The Chef server has a built in process supervisor, which ensures that all of the required services are in the appropriate state at any given time. The supervisor starts two processes per service.

.. end_tag

Service Subcommands
=====================================================
.. tag ctl_common_service_subcommands

This command has a built in process supervisor that ensures all of the required services are in the appropriate state at any given time. The supervisor starts two processes per service and provides the following subcommands for managing services: ``hup``, ``int``, ``kill``, ``once``, ``restart``, ``service-list``, ``start``, ``status``, ``stop``, ``tail``, and ``term``.

.. end_tag

hup
-----------------------------------------------------
.. tag ctl_private_chef_hup

The ``hup`` subcommand is used to send a ``SIGHUP`` to all services. This command can also be run for an individual service by specifying the name of the service in the command.

This subcommand has the following syntax:

.. code-block:: bash

   $ private-chef-ctl hup name_of_service

where ``name_of_service`` represents the name of any service that is listed after running the ``service-list`` subcommand.

.. end_tag

int
-----------------------------------------------------
.. tag ctl_private_chef_int

The ``int`` subcommand is used to send a ``SIGINT`` to all services. This command can also be run for an individual service by specifying the name of the service in the command.

This subcommand has the following syntax:

.. code-block:: bash

   $ private-chef-ctl int name_of_service

where ``name_of_service`` represents the name of any service that is listed after running the ``service-list`` subcommand.

.. end_tag

kill
-----------------------------------------------------
.. tag ctl_private_chef_kill

The ``kill`` subcommand is used to send a ``SIGKILL`` to all services. This command can also be run for an individual service by specifying the name of the service in the command.

This subcommand has the following syntax:

.. code-block:: bash

   $ private-chef-ctl kill name_of_service

where ``name_of_service`` represents the name of any service that is listed after running the ``service-list`` subcommand.

.. end_tag

once
-----------------------------------------------------
.. tag ctl_private_chef_once

The supervisor for Enterprise Chef is configured to restart any service that fails, unless that service has been asked to change its state. The ``once`` subcommand is used to tell the supervisor to not attempt to restart any service that fails.

This command is useful when troubleshooting configuration errors that prevent a service from starting. Run the ``once`` subcommand followed by the ``status`` subcommand to look for services in a down state and/or to identify which services are in trouble. This command can also be run for an individual service by specifying the name of the service in the command.

This subcommand has the following syntax:

.. code-block:: bash

   $ private-chef-ctl once name_of_service

where ``name_of_service`` represents the name of any service that is listed after running the ``service-list`` subcommand.

.. end_tag

restart
-----------------------------------------------------
.. tag ctl_private_chef_restart

The ``restart`` subcommand is used to restart all services enabled on Enterprise Chef or to restart an individual service by specifying the name of that service in the command.

.. warning:: When running Enterprise Chef in a high availability configuration, restarting all services may trigger failover.

This subcommand has the following syntax:

.. code-block:: bash

   $ private-chef-ctl restart name_of_service

where ``name_of_service`` represents the name of any service that is listed after running the ``service-list`` subcommand. When a service is successfully restarted the output should be similar to:

.. code-block:: bash

   $ ok: run: service_name: (pid 12345) 1s

.. end_tag

service-list
-----------------------------------------------------
.. tag ctl_private_chef_service_list

The ``service-list`` subcommand is used to display a list of all available services. A service that is enabled is labeled with an asterisk (*).

This subcommand has the following syntax:

.. code-block:: bash

   $ private-chef-ctl service-list

.. end_tag

start
-----------------------------------------------------
.. tag ctl_private_chef_start

The ``start`` subcommand is used to start all services that are enabled in Enterprise Chef. This command can also be run for an individual service by specifying the name of the service in the command.

This subcommand has the following syntax:

.. code-block:: bash

   $ private-chef-ctl start name_of_service

where ``name_of_service`` represents the name of any service that is listed after running the ``service-list`` subcommand. When a service is successfully started the output should be similar to:

.. code-block:: bash

   $ ok: run: service_name: (pid 12345) 1s

The Enterprise Chef supervisor is configured to wait seven seconds for a service to respond to a command from the supervisor. If you see output that references a timeout, it means that a signal has been sent to the process, but that the process has yet to actually comply. In general, processes that have timed out are not a big concern, unless they are failing to respond to the signals at all. If a process is not responding, use a command like the ``kill`` subcommand to stop the process, investigate the cause (if required), and then use the ``start`` subcommand to re-enable it.

.. end_tag

status
-----------------------------------------------------
.. tag ctl_private_chef_status

The ``status`` subcommand is used to show the status of all services available to Enterprise Chef. The results will vary based on the configuration of a given server. This subcommand has the following syntax:

.. code-block:: bash

   $ private-chef-ctl status

and will return the status for all services. Status can be returned for individual services by specifying the name of the service as part of the command:

.. code-block:: bash

   $ private-chef-ctl status name_of_service

where ``name_of_service`` represents the name of any service that is listed after running the ``service-list`` subcommand.

When service status is requested, the output should be similar to:

.. code-block:: bash

   $ run: service_name: (pid 12345) 12345s; run: log: (pid 1234) 67890s

where

* ``run:`` is the state of the service (``run:`` or ``down:``)
* ``service_name:`` is the name of the service for which status is returned
* ``(pid 12345)`` is the process identifier
* ``12345s`` is the uptime of the service, in seconds

For example:

.. code-block:: bash

   $ down: opscode-erchef: (pid 35546) 10s

By default, runit will restart services automatically when the services fail. Therefore, runit may report the status of a service as ``run:`` even when there is an issue with that service. When investigating why a particular service is not running as it should be, look for the services with the shortest uptimes. For example, the list below indicates that the **opscode-erchef** should be investigated further:

.. code-block:: bash

   run: opscode-account: (pid 3912) 13706s; run: log: (pid 3911) 13706s
   run: opscode-authz: (pid 3804) 13718s; run: log: (pid 3803) 13718s
   run: opscode-certificate: (pid 3866) 13712s; run: log: (pid 3865) 13712s
   run: opscode-chef: (pid 4327) 13671s; run: log: (pid 4326) 13671s
   run: opscode-erchef: (pid 5383) 5s; run: log: (pid 4382) 13669s
   run: opscode-expander: (pid 4078) 13694s; run: log: (pid 4077) 13694s
   run: opscode-expander-reindexer: (pid 4130) 13692s; run: log: (pid 4114) 13692s

.. end_tag

High Availability
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. tag ctl_private_chef_status_ha

On back-end servers in a high availability topology, Keepalived is used by the clustering service to determine whether a service should be running. If the ``status`` subcommand is run against any of these nodes, a few things change:

* On the back-end node that is currently the backup server, it is normal to see only two running processes: Keepalived and NRPE
* On the back-end node that is currently the master server, it is normal to see all services running. It is also normal to see some services in a down state if the server, on reboot, did not attempt to start the services because Keepalived determines which services are restarted based on the state of the cluster

A sample status line for a service that is running on the master server in a high availability topology:

.. code-block:: bash

   run: opscode-solr: (pid 25341) 239s, normally down; run: log: (pid 5700) 145308s

.. end_tag

Log Files
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. tag ctl_private_chef_status_logs

A typical status line for a service that is running in Enterprise Chef in a tiered or standalone topology is similar to the following:

.. code-block:: bash

   run: name_of_service: (pid 1486) 7819s; run: log: (pid 1485) 7819s

where:

* ``run`` describes the state in which the supervisor attempts to keep processes. This state is either ``run`` or ``down``. If a service is in a ``down`` state, it should be stopped
* ``name_of_service`` is the service name, for example: ``opscode-solr``
* ``(pid 1486) 7819s;`` is the process identifier followed by the amount of time (in seconds) the service has been running
* ``run: log: (pid 1485) 7819s`` is the log process. It is typical for a log process to have a longer run time than a service; this is because the supervisor does not need to restart the log process in order to connect the supervised process

If the service is down, the status line will appear similar to the following:

.. code-block:: bash

   down: opscode-solr: 3s, normally up; run: log: (pid 1485) 8526s

where

* ``down`` indicates that the service is in a down state
* ``3s, normally up;`` indicates that the service is normally in a run state and that the supervisor would attempt to restart this service after a reboot

.. end_tag

stop
-----------------------------------------------------
.. tag ctl_private_chef_stop

The ``stop`` subcommand is used to stop services enabled on Enterprise Chef. This command can also be run for an individual service by specifying the name of the service in the command.

This subcommand has the following syntax:

.. code-block:: bash

   $ private-chef-ctl stop name_of_service

where ``name_of_service`` represents the name of any service that is listed after running the ``service-list`` subcommand. When a service is successfully stopped the output should be similar to:

.. code-block:: bash

   $ ok: diwb: service_name: 0s, normally up

For example:

.. code-block:: bash

   $ private-chef-ctl stop

will return something similar to:

.. code-block:: bash

   ok: down: couchdb: 394s, normally up
   ok: down: nginx: 393s, normally up
   ok: down: opscode-account: 393s, normally up
   ok: down: opscode-authz: 392s, normally up
   ok: down: opscode-certificate: 392s, normally up
   ok: down: opscode-chef: 391s, normally up
   ok: down: opscode-erchef: 391s, normally up
   ok: down: opscode-expander: 390s, normally up
   ok: down: opscode-expander-reindexer: 389s, normally up
   ok: down: opscode-org-creator: 389s, normally up
   ok: down: opscode-solr: 389s, normally up
   ok: down: opscode-webui: 388s, normally up
   ok: down: postgresql: 388s, normally up
   ok: down: rabbitmq: 388s, normally up
   ok: down: redis: 387s, normally up

.. end_tag

tail
-----------------------------------------------------
.. tag ctl_private_chef_tail

The ``tail`` subcommand is used to follow all Enterprise Chef logs for all services. This command can also be run for an individual service by specifying the name of the service in the command.

This subcommand has the following syntax:

.. code-block:: bash

   $ private-chef-ctl tail name_of_service

where ``name_of_service`` represents the name of any service that is listed after running the ``service-list`` subcommand.

.. end_tag

term
-----------------------------------------------------
.. tag ctl_private_chef_term

The ``term`` subcommand is used to send a ``SIGTERM`` to all services. This command can also be run for an individual service by specifying the name of the service in the command.

This subcommand has the following syntax:

.. code-block:: bash

   $ private-chef-ctl term name_of_service

where ``name_of_service`` represents the name of any service that is listed after running the ``service-list`` subcommand.

.. end_tag

List of Services
=====================================================
The following services are part of Enterprise Chef:

* bifrost
* bookshelf
* couchdb
* keepalived
* nginx
* opscode-account
* opscode-certificate
* opscode-erchef
* opscode-expander
* opscode-expander-reindexer
* opscode-org-creator
* opscode-solr
* opscode-webui
* postgresql
* rabbitmq
* redis

All services have the following options: ``status``, ``start``, ``stop``, ``restart``, ``kill``, ``run once``, and ``tail``.

bifrost
-----------------------------------------------------
.. tag server_services_bifrost

The **oc_bifrost** service ensures that every request to view or manage objects stored on the Chef server is authorized.

.. end_tag

bookshelf
-----------------------------------------------------
.. tag server_services_bookshelf

The **bookshelf** service is an Amazon Simple Storage Service (S3)-compatible service that is used to store cookbooks, including all of the files---recipes, templates, and so on---that are associated with each cookbook.

.. end_tag

couchdb
-----------------------------------------------------
The **couchdb** service is used to store key/value data.

keepalived
-----------------------------------------------------
.. tag server_services_keepalived

The **keepalived** service manages the virtual IP address (VIP) between the backend machines in a high availability topology that uses DRBD.

.. end_tag

nginx
-----------------------------------------------------
.. tag server_services_nginx

The **nginx** service is used to manage traffic to the Chef server, including virtual hosts for internal and external API request/response routing, external add-on request routing, and routing between front- and back-end components.

.. end_tag

opscode-account
-----------------------------------------------------
The **opscode-account** service is a Ruby-based service that handles the following types of Chef server API requests:

* ACLs
* Association requests
* Containers
* Groups
* Organizations
* Clients
* Users

.. note:: This service is deprecated in Chef server 12.

opscode-certificate
-----------------------------------------------------
The **opscode-certificate** service is used to provide the certificates that are returned when the chef-client is set up and configured on nodes and workstations.

.. note:: This service is deprecated in Chef server 12.

opscode-erchef
-----------------------------------------------------
.. tag server_services_erchef

The **opscode-erchef** service is an Erlang-based service that is used to handle Chef server API requests to the following areas within the Chef server:

* Cookbooks
* Data bags
* Environments
* Nodes
* Roles
* Sandboxes
* Search

.. end_tag

opscode-expander
-----------------------------------------------------
.. tag server_services_expander

The **opscode-expander** service is used to process data (pulled from the **rabbitmq** service's message queue) so that it can be properly indexed by the **opscode-solr4** service.

.. end_tag

opscode-expander-reindexer
-----------------------------------------------------
.. tag server_services_reindexer

.. This service was removed from the Chef Server in version 12.4

The **opscode-expander-reindexer** service is used to help ensure that search data is added to the Apache Solr database.

.. end_tag

opscode-solr
-----------------------------------------------------
The **opscode-solr** service is used to create the search indexes.

opscode-webui
-----------------------------------------------------
The **opscode-webui** service is used to mange the web user interface for the Chef server.

postgresql
-----------------------------------------------------
.. tag server_services_postgresql

The **postgresql** service is used to store node, object, and user data.

.. end_tag

rabbitmq
-----------------------------------------------------
.. tag server_services_rabbitmq

The **rabbitmq** service is used to provide the message queue that is used by the Chef server to get search data to Apache Solr so that it can be indexed for search. When Chef Analytics is confiugred, the **rabbitmq** service is also used to send data from the Chef server to the Chef Analytics server.

.. end_tag

redis
-----------------------------------------------------
.. tag server_services_redis

Key-value store used in conjunction with Nginx to route requests and populate request data used by the Chef server.

.. end_tag

