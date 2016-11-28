

=====================================================
private-chef-ctl (executable)
=====================================================

.. tag ctl_private_chef_2

The Chef server installations that are done using the omnibus installer include a command-line utility named chef-server-ctl. This command-line tool is used to start and stop individual services, reconfigure the Chef server, run chef-pedant, and tail Chef server log files.

.. end_tag

backup-recover
=====================================================
.. tag ctl_private_chef_backup_recover

The ``backup-recover`` subcommand is used to force a Enterprise Chef server to attempt to become the backup server. This is the opposite of the ``master-recover`` subcommand.

.. warning:: If this command is run on both back-end servers, it will put the back-end cluster into a state where no server holds the DRBD resource.

This subcommand has the following syntax:

.. code-block:: bash

   $ private-chef-ctl backup-recover

.. end_tag

cleanse
=====================================================
.. tag ctl_private_chef_cleanse

The ``cleanse`` subcommand is used to re-set the server to the state it was in before the first time the ``reconfigure`` subcommand is run to destroy all data, configuration files, and logs.

This subcommand has the following syntax:

.. code-block:: bash

   $ private-chef-ctl cleanse

.. end_tag

gather-logs
=====================================================
.. tag ctl_private_chef_gather_logs

The ``gather-logs`` subcommand is used to gather the Chef server log files into a tarball that contains all of the important log files and system information.

This subcommand has the following syntax:

.. code-block:: bash

   $ private-chef-ctl gather-logs

.. end_tag

ha-status
=====================================================
.. tag ctl_private_chef_ha_status

The ``ha-status`` subcommand is used to check the status for services running in a high availability topology. This command will verify the following:

       * The Keepalived daemon is enabled in the config
       * The DRBD process is enabled in the config
       * The underlying block device or logical volume for DRBD has been created and configured
       * The DRBD device exists
       * The current state of the server is ``master`` or ``backup``; any migration processes have completed
       * The failover virtual IP address is correctly attached to only the ``master`` node
       * The DRBD state is correct based on the state of the server being ``master`` or ``backup``
       * The DRBD mount point is correctly mounted to only the ``master`` node
       * The DRBD replication IP addresses are pingable
       * The ``runit`` status of the services are correct (up or down) based on the ``master`` or ``backup`` state of the server

This subcommand has the following syntax:

.. code-block:: bash

   $ private-chef-ctl ha-status

If this command runs successfully, it will return the following:

.. code-block:: bash

   $ [OK] all checks passed.

Otherwise it will print out a list of errors, similar to the following:

.. code-block:: bash

   ...
   [OK] nginx is running correctly, and I am master.
   [ERROR] nrpe is not running.
   [OK] opscode-account is running correctly, and I am master.
   ...
   [ERROR] ERRORS WERE DETECTED.

For example:

.. code-block:: bash

   [OK] keepalived HA services enabled
   [OK] DRBD disk replication enabled
   [OK] DRBD partition /dev/opscode/drbd found
   [OK] DRBD device /dev/drbd0 found
   [OK] cluster status = master
   [OK] found VIP IP address and I am master
   [OK] found VRRP communications interface eth1
   [OK] my DRBD status is Connected/Primary/UpToDate and I am master
   [OK] my DRBD partition is mounted and I am master
   [OK] DRBD primary IP address pings
   [OK] DRBD secondary IP address pings
   ...
   [OK] all checks passed.

.. end_tag

help
=====================================================
.. tag ctl_private_chef_help

The ``help`` subcommand is used to print a list of all available private-chef-ctl commands.

This subcommand has the following syntax:

.. code-block:: bash

   $ private-chef-ctl help

.. end_tag

master-recover
=====================================================
.. tag ctl_private_chef_master_recover

The ``master-recover`` subcommand is used to force a Enterprise Chef server to attempt to become the master server. This command is typically run in tandem with the ``backup-recover`` subcommand on the back-end peer, unless the back-end peer is no longer available.

This subcommand has the following syntax:

.. code-block:: bash

   $ private-chef-ctl master-recover

.. end_tag

password
=====================================================
.. tag ctl_private_chef_password

.. warning:: This subcommand is currently disabled.

.. The ``password`` subcommand is used to change a user's password. When |microsoft ad| or LDAP is enabled, this command enables (or disables) the system recovery password for that user. For example:
.. 
.. This subcommand has the following syntax:
.. 
.. .. code-block:: bash
.. 
..    $ private-chef-ctl password
.. 
.. This subcommand has the following options:
.. 
.. ``--disable``
..    Use this option to disable a user's system recovery password.
.. 
.. **Examples**
.. 
.. For example, to change a user's password, enter:
.. 
.. .. code-block:: bash
.. 
..    $ private-chef-ctl password adamjacobs
.. 
.. and then enter the password and confirm it:
.. 
.. .. code-block:: bash
.. 
..    Enter the new password:  ******
..    Enter the new password again:  ******
.. 
.. to return:
.. 
.. .. code-block:: bash
.. 
..    Password for adamjacobs successfully set.
.. 
.. To disable a system recovery password:
.. 
.. .. code-block:: bash
.. 
..    $ private-chef-ctl password adamjacobs --disable
.. 
.. to return:
.. 
.. .. code-block:: bash
.. 
..    Password for adamjacobs successfully disabled for System Recovery.

.. end_tag

reconfigure
=====================================================
.. tag ctl_private_chef_reconfigure

The ``reconfigure`` subcommand is used when changes are made to the private-chef.rb file to reconfigure the server. When changes are made to the private-chef.rb file, they will not be applied to the Enterprise Chef configuration until after this command is run. This subcommand will also restart any services for which the ``service_name['enabled']`` setting is set to ``true``.

This subcommand has the following syntax:

.. code-block:: bash

   $ private-chef-ctl reconfigure

.. end_tag

show-config
=====================================================
.. tag ctl_private_chef_show_config

The ``show-config`` subcommand is used to view the configuration that will be generated by the ``reconfigure`` subcommand. This command is most useful in the early stages of a deployment to ensure that everything is built properly prior to installation.

This subcommand has the following syntax:

.. code-block:: bash

   $ private-chef-ctl show-config

.. end_tag

uninstall
=====================================================
.. tag ctl_private_chef_uninstall

The ``uninstall`` subcommand is used to remove the Enterprise Chef application, but without removing any of the data. This subcommand will shut down all services (including the ``runit`` process supervisor).

This subcommand has the following syntax:

.. code-block:: bash

   $ private-chef-ctl uninstall

.. note:: To revert the ``uninstall`` subcommand, run the ``reconfigure`` subcommand (because the ``start`` subcommand is disabled by the ``uninstall`` command).

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

