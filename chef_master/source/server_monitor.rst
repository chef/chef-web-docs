=====================================================
Monitor
=====================================================
`[edit on GitHub] <https://github.com/chef/chef-web-docs/blob/master/chef_master/source/server_monitor.rst>`__

Monitoring the Chef server involves two types of checks: application and system. In addition monitoring the HTTP requests that workstations and nodes are making to the Chef server and per-disk data storage volumes is recommended.

Monitoring Priorities
=====================================================
The following sections describe the priorities for monitoring of the Chef server. In particular, running out of disk space is the primary cause of failure.

Disks
-----------------------------------------------------
Over time, and with enough data, disks will fill up or exceed the per-disk quotas that may have been set for them and they will not be able to write data. A disk that is not able to write data will not be able to support certain components of the Chef server, such as PostgreSQL, RabbitMQ, service log files, and deleted file handles. Monitoring disk usage is the best way to ensure that disks don't fill up or exceed their quota.

Use the following commands to monitor global disk usage on a Chef server with a typical installation:

.. code-block:: bash

   $ du -sh /var/opt/opscode

and:

.. code-block:: bash

   $ du -sh /var/log/opscode

To keep the Chef server healthy, both ``/var/opt/opscode`` and ``/var/log/opscode`` should never exceed 80% use. In situations where disk space grows at a rapid pace, it may be preferable to shut down the Chef server and contact Chef support.

The following components should be monitored for signs that disks may be rapidly filling up:

* **PostgreSQL** PostgreSQL is the data store for the Chef server.
* **RabbitMQ** The RabbitMQ data folder can fill up if the **opscode-expander** service is not able to keep up with the data being moved into the search database by RabbitMQ. When the **opscode-expander** service falls behind, RabbitMQ will start storing the individual messages on-disk while it waits for the **opscode-expander** service to catch up. If the RabbitMQ disk fills up completely, RabbitMQ will need to be restarted to free up the disk space and any data that was stored on-disk will be lost.
* **Log files** If ``/var/log/opscode`` is taking up a lot of disk space, ensure that the Chef server log rotation cron job is running without errors. These errors can be found in ``/var/log/messages``, ``/var/log/syslog`` and/or the root user's local mail.
* **Deleted file handles** Running processes with file handles associated with one (or more) deleted files will prevent the disk space being used by the deleted files from being reclaimed. Use the ``sudo lsof | grep '(deleted)'`` command to find all deleted file handles.

High Availability
-----------------------------------------------------
All components of computer systems fail, and ethernet networks, while being generally very robust, are no exception. A high availability configuration of the Chef server that uses DRBD depends on a functioning network to begin and maintain replication between the back end servers on which the Chef server is running.

To become aware of failure at the earliest opportunity, the ``/proc/drbd`` psuedo file should be monitored for signs
that cluster replication has stopped or is falling behind:

.. code-block:: bash

   $ cat /proc/drbd

A healthy connection state is similar to:

.. code-block:: bash

   version: 8.4.0 (api:1/proto:86-100)
   GIT-hash: 09b6d528b3b3de50462cd7831c0a3791abc665c3 build by linbit@buildsystem.linbit, 2011-10-12 09:07:35
    0: cs:Connected ro:Secondary/Secondary ds:UpToDate/UpToDate C r-----
       ns:0 nr:0 dw:0 dr:656 al:0 bm:0 lo:0 pe:0 ua:0 ap:0 ep:1 wo:b oos:0

An unhealthy connection state from the perspective of the initial primary machine is similar to:

.. code-block:: bash

   version: 8.4.0 (api:1/proto:86-100)
   GIT-hash: 09b6d528b3b3de50462cd7831c0a3791abc665c3 build by linbit@buildsystem.linbit, 2011-10-12 09:07:35
    0: cs:WFConnection ro:Primary/Secondary ds:UpToDate/Unknown C r---
       ns:0 nr:0 dw:0 dr:0 al:0 bm:0 lo:0 pe:0 ua:0 ap:0 ep:1 wo:b oos:54192

where this shows lost communication with the secondary machine and ``oos:`` at non-zero (and increasing). This connection state is not fatal, but does represent a degraded state for the cluster where the machines are no longer in sync and are building up a queue of unwritten writes on the originating side that must eventually be synchronized to the secondary machine after the network stabilizes.

Application Checks
=====================================================
Application-level checks should be done periodically to ensure that there is enough disk space, enough memory, and that the front-end and back-end services are communicating.

DRBD
-----------------------------------------------------
Drbdadm is the management tool for DRBD. It can be used to obtain status information and to alter the state of the DRBD cluster. For more information about Drbdadm, see http://www.drbd.org/users-guide/re-drbdadm.html.

``/proc/drbd`` is a virtual file that displays real-time status information about all currently-configured DRBD resources. Use the following command to view the contents of this virtual file:

.. code-block:: bash

   $ cat /proc/drbd

Use ``chef-server-ctl ha-status`` along with ``/proc/drbd`` to help evaluate the current state of the cluster. Follow the split-brain recovery procedures for DRBD if the cluster becomes two unconnected pieces.

Erlang
-----------------------------------------------------
Many components of the Chef server are written using Erlang and run on the BEAM virtual machine. One feature of Erlang and BEAM is the ability to interact with the running service using a command shell. For example:

.. code-block:: bash

   $ cd /opt/opscode/embedded
     export PATH=$PATH:/opt/opscode/bin:/opt/opscode/embedded/bin
     bin/erl -setcookie service_name -name me@127.0.0.1 -remsh service_name@127.0.0.1

where ``service_name`` is ``bifrost`` or ``erchef``. This command will then open a shell that is connected to the Erchef processes:

.. code-block:: bash

   $ Erlang R15B02 (erts-5.9.2) [source] [64-bit] ...

.. warning:: Connecting to the Erlang processes should only be done when directed by Chef support services.

To connect to the **oc_bifrost** service, use the following command:

.. code-block:: bash

   $ erl -setcookie oc_bifrost -name me@127.0.0.1 -remsh oc_bifrost@127.0.0.1

To connect to the **opscode-erchef** service, use the following command:

.. code-block:: bash

   $ erl -setcookie erchef -name me@127.0.0.1 -remsh erchef@127.0.0.1

To disconnect from the shell, use the following key sequence ``CTRL-g``, ``q``, and then ``ENTER``.

The output from the shell after the ``CTRL-g`` looks similar to:

.. code-block:: bash

   (erchef@127.0.0.1)1>
   User switch command

then enter ``q``, and then hit ``ENTER`` to exit the shell.

Some commands should not be entered when interacting with a running service while using the command shell, including:

* ``q()`` kills the Erlang node
* ``init:stop()``
* ``exit`` or ``exit()`` does nothing

``eper`` tools
+++++++++++++++++++++++++++++++++++++++++++++++++++++
As root on the Chef server, point to the bundled ``eper`` package of debugging tools. Replace the 2nd and 5th path entries and the ``X.XX.X`` value in the following path with the items that occur on the system.

.. code-block:: bash

   $ export ERL_LIB=:/opt/{chef-server,opscode}/embedded/service/{erchef,opscode-erchef}/lib/eper-X.XX.X/ebin/

Open an Erlang command shell to begin diagnosing service issues on the Chef server:

.. code-block:: bash

   Eshell V5.10.4  (abort with ^G)
   (erchef@127.0.0.1)1>

The ``dtop`` tool presents a view on the Erlang virtual machine that is similar to the ``linuxdagnostic`` command. The period at the end of the dtop command is required for the command to take effect.

.. code-block:: bash

   (erchef@127.0.0.1)1> dtop:start().

To stop the ``dtop`` command, run:

.. code-block:: bash

   (erchef@127.0.0.1)1> dtop:stop().

To disconnect from the shell, use the following key sequence ``CTRL-g``, ``q``, and then ``ENTER``.

The output from the shell after the ``CTRL-g`` looks similar to:

.. code-block:: bash

   (erchef@127.0.0.1)1>
   User switch command

then enter ``q``, and then hit ``ENTER`` to exit the shell.

Nginx
-----------------------------------------------------
Use Nginx to monitor for services that may be returning 504 errors. Use the following command on a front-end machine:

.. code-block:: bash

   $ grep 'HTTP/1.1" 504' /var/log/opscode/nginx/access.log

and then extract the URLs and sort them by ``uniq`` count:

.. code-block:: bash

   $ grep 'HTTP/1.1" 504' nginx-access.log | cut -d' ' -f8 | sort | uniq -c | sort

In a large installation, restricting these results to a subset of results may be necessary:

.. code-block:: bash

   $ tail -10000 nginx-access.log | grep 'HTTP/1.1" 504' | cut -d' ' -f8 | sort | uniq -c | sort

PostgreSQL
-----------------------------------------------------
psql is the management tool for PostgreSQL. It can be used to obtain information about data stored in PostgreSQL. For more information about psql, see http://www.postgresql.org/docs/manuals/, and then the doc set appropriate for the version of PostgreSQL being used.

To connect to the PostgreSQL database, run the following command:

.. code-block:: bash

   $ cd /opt/opscode/embedded/service/postgresql/
     export PATH=$PATH:/opt/opscode/bin:/opt/opscode/embedded/bin
     bin/psql -U opscode_chef

.. warning:: Connecting to the PostgreSQL database should only be done when directed by Chef support services.

RabbitMQ
-----------------------------------------------------
rabbitmqctl is the management tool for RabbitMQ. It can be used to obtain status information and to ensure that message queuing is running properly. For more information about rabbitmqctl, see https://www.rabbitmq.com/man/rabbitmqctl.1.man.html.

To obtain status information for message queues, run the following command:

.. code-block:: bash

   $ export PATH=$PATH:/opt/opscode/bin:/opt/opscode/embedded/bin
     rabbitmqctl status

to return something similar to:

.. code-block:: bash

   Status of node rabbit@localhost ...
   [{pid,3044},
    {running_applications, [{rabbit,"RabbitMQ","2.7.1"},
                            {mnesia,"MNESIA CXC 138 12","4.7.1},
                            {os_mon,"CPO CXC 138 46","2.2.10},
                            ...
                            {kernel,"ERTS CXC 138 10","2.15.2"}]},
    {os,{unix,linux}},
    {erlang_version,"Erlang R15B02 (erts-5.9.2) [source] [64-bit] ..."},
    {memory,[{total,96955896},
             {processes,38634560},
             ...
             {ets,5850336}]},
    {vm_memory_high_watermark,0.39999999995176794},
    {vm_memory_limit,1658647347}]
    ... done

Redis
-----------------------------------------------------
The **redis_lb** service located on the back end machine handles requests that are made from the Nginx service that is located on all front end machines in a Chef server cluster.

In the event of a disk full condition for the Redis data store, the ``dump.rdb`` (the primary data store ``.rdb`` used by Redis) can become corrupt and saved as a zero byte file.

When this occurs, after the **redis_lb** service started, it's logs will show a statement similar to the following:

.. code-block:: bash

   2015-03-23_16:11:31.44256 [11529] 23 Mar 16:10:09.624 # Server started, Redis version 2.8.2
   2015-03-23_16:11:31.44256 [11529] 23 Mar 16:10:09.624 # WARNING overcommit_memory is set to 0! Background save may fail under low memory condition. To fix this issue add 'vm.overcommit_memory = 1' to /etc/sysctl.conf and then reboot or run the command 'sysctl vm.overcommit_memory=1' for this to take effect.
   2015-03-23_16:11:31.44257 [11529] 23 Mar 16:11:31.438 # Short read or OOM loading DB. Unrecoverable error, aborting now.

The ``dump.rdb`` file will be empty:

.. code-block:: bash

   ls -al /var/opt/opscode/redis_lb/data/
   total 20
   drwxr-x--- 2 opscode opscode 4096 Mar 23 15:58 .
   drwxr-x--- 4 opscode opscode 4096 Dec 22 18:59 ..
   -rw-r--r-- 1 opscode opscode    0 Mar 23 15:58 dump.rdb

This situation is caused by a bug in Redis where saves are allowed to succeed even when the disk has been full for some time, and not just on edge cases where the disk becomes full as Redis is writing. To fix this issue, do the following:

1. Stop the **redis_lb** service:

   .. code-block:: bash

      chef-server-ctl stop redis_lb

2. Remove the corrupt files:

   .. code-block:: bash

      cd /var/opt/opscode/redis_lb/data
      rm -fr *rdb

3. Start the **redis_lb** service:

   .. code-block:: bash

      chef-server-ctl start redis_lb

      less /var/log/opscode/redis_lb/current
      2015-03-23_17:05:18.82516 [28676] 23 Mar 17:05:18.825 * The server is now ready to accept connections on port 16379

4. Reconfigure the Chef server to re-populate Redis:

   .. code-block:: bash

      chef-server-ctl reconfigure

5. Verify that Redis is re-populated, as indicated by the key ``dl_default``:

   .. code-block:: bash

      /opt/opscode/embedded/bin/redis-cli -p 16379 keys \*
      1) "dl_default"

Apache Solr
-----------------------------------------------------
The **opscode-solr4** service located on the primary back end machine handles requests that are made from the Erchef service that is located on all front end machines in a Chef server cluster.

Under normal circumstances, opscode-solr4 will need access to a total of 2x the space used for the index.

The thread at http://comments.gmane.org/gmane.comp.jakarta.lucene.solr.user/99149 explains more fully, including describing an extreme case where it's possible that 3x the storage might be necessary. Chef server usage of Apache Solr via the **opscode-solr4** service will generally only require the used storage for the index + 1x that amount of storage in free space.

For example, a 2GB search index will require about 2GB of free space available in the **opscode-solr4** service's storage area. The standard storage area for the **opscode-solr4** service in a standalone topology Chef server install is ``/var/opt/opscode/opscode-solr4/data``.

System Checks
=====================================================
System-level checks should be done for the following components: ports, services, and high availability status.

chef-backend-ctl status
-----------------------------------------------------
The ``chef-backend-ctl status`` subcommand is used to check the status of services running in the `Chef Backend server topology </install_server_ha.html>`__. This command will verify the status of the following services on the node it is run on:

* ``leaderl`` 
* ``postgresql`` 
* ``etcd``
*  ``epmd`` 
* ``elasticsearch``

It will also check on the status of other nodes in the cluster, from the current node's perspective. For example:

.. code-block:: bash

   $ chef-backend-ctl status 
   Service Local Status Time in State Distributed Node Status 
   leaderl running (pid 1191) 53d 15h 11m 12s leader: 1; waiting: 0; follower: 2;    total: 3 
   epmd running (pid 1195) 53d 15h 11m 12s status: local-only 
   etcd running (pid 1189) 53d 15h 11m 12s health: green; healthy nodes: 3/3 
   postgresql running (pid 40686) 0d 12h 36m 23s leader: 1; offline: 0; syncing: 0;    synced: 2 
   elasticsearch running (pid 47423) 0d 12h 18m 6s state: green; nodes online: 3/3
   
   System Local Status Distributed Node Status 
   disks /var/log/chef-backend: OK; /var/opt/chef-backend: OK health: green; healthy    nodes: 3/3

More information about each service can be found in the individual service logs in ``/var/opt/chef-backend/``. 

ha-status
-----------------------------------------------------
The ``ha-status`` subcommand is used to check the status of services running in the (deprecated as of Chef Server 12.9.0) DRBD high availability topology. This command will verify the following:

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

opscode-authz
-----------------------------------------------------
The authz API provides a high-level view of the health of the **opscode-authz** service with a simple endpoint: ``_ping``. This endpoint can be accessed using cURL and GNU Wget. For example:

.. code-block:: bash

   $ curl http://localhost:9463/_ping

This command typically prints a lot of information. Use Python to use pretty-print output:

.. code-block:: bash

   $ curl http://localhost:9463/_ping | python -mjson.tool

opscode-erchef
-----------------------------------------------------
The status API provides a high-level view of the health of the system with a simple endpoint: ``_status``. This endpoint can be accessed using cURL and GNU Wget. For example:

.. code-block:: bash

   $ curl http://localhost:8000/_status

which will return something similar to:

.. code-block:: bash

   {
     "status":"pong",
     "upstreams":{"upstream_service":"pong","upstream_service":"fail",...},
   }

For each of the upstream services, ``pong`` or ``fail`` is returned. The possible upstream names are:

* ``chef_solr`` (for the **opscode-solr4** service)
* ``chef_sql`` (for the **postgresql** service)
* ``oc_chef_authz`` (for the **opscode-authz** service)

If any of the status values return ``fail``, this typically means the Chef server is unavailable for that service.

opscode-expander
-----------------------------------------------------
As the queue depth increases it may take longer for updates posted to the Chef server by each chef-client to be added to the search indexes on the Chef server. The depth of this queue should be monitored using the following command:

.. code-block:: bash

   $ cd /opt/opscode/embedded/service/opscode-expander/
     export PATH=$PATH:/opt/opscode/bin:/opt/opscode/embedded/bin

Search Indexes
++++++++++++++++++++++++++++++++++++++++++++++++++++++
.. tag search

Search indexes allow queries to be made for any type of data that is indexed by the Chef server, including data bags (and data bag items), environments, nodes, and roles. A defined query syntax is used to support search patterns like exact, wildcard, range, and fuzzy. A search is a full-text query that can be done from several locations, including from within a recipe, by using the ``search`` subcommand in knife, the ``search`` method in the Recipe DSL, the search box in the Chef management console, and by using the ``/search`` or ``/search/INDEX`` endpoints in the Chef server API. The search engine is based on Apache Solr and is run from the Chef server.

.. end_tag

If the search indexes are not being updated properly, first ensure that the **opscode-expander** service is running on the backend machine:

.. code-block:: bash

   $ chef-server-ctl status opscode-expander

and then (if it is not running), start the service:

.. code-block:: bash

   $ chef-server-ctl start opscode-expander

If the **opscode-expander** does not start correctly, then take a look at the ``/var/log/opscode/opscode-expander/current`` log file for error messages.

If the **opscode-expander** is running, check the queue length:

.. code-block:: bash

   $ watch -n1 sudo -E bin/opscode-expanderctl queue-depth

If the number of total messages continues to increase, increase the number of workers available to the **opscode-expander** service.

opscode-expander-ctl
++++++++++++++++++++++++++++++++++++++++++++++++++++++
.. tag ctl_opscode_expander_summary

The ``opscode-expander-ctl`` executable can be used to generate status information for the **opscode-expander** service. The ``opscode-expander-ctl`` executable is run as a command-line tool from the master backend machine.

.. end_tag

.. tag ctl_opscode_expander_options

This tool has the following syntax::

   opscode-expander-ctl COMMAND

Where ``COMMAND`` can be any of the following:

``log-level``
   Use to show the log level for all nodes in the cluster.

``node-status``
   Use to show the status for all nodes in the cluster.

``queue-depth``
   Use to display the aggregate queue backlog.

``queue-status``
   Use to show the backlog and consumer counts for each vnode queue.

.. end_tag

.. tag ctl_opscode_expander_example

For example, to view the aggregate queue backlog, enter the following:

.. code-block:: bash

   $ cd /opt/opscode/embedded/service/opscode-expander/
   $ export PATH=$PATH:/opt/opscode/bin:/opt/opscode/embedded/bin
   $ bin/opscode-expander-ctl queue-depth

to return something similar to:

.. code-block:: bash

       total messages:       0
       average queue depth:  0.0
       max queue depth:      0
       min queue depth:      0

.. end_tag

Nodes, Workstations
=====================================================
If a client makes an HTTP request to the server that returns a non-specific error message, this is typically an issue with the **opscode-chef** or **opscode-erchef** services. View the full error message for these services in their respective log files. The error is most often a stacktrace from the application error. In some cases, the error message will clearly indicate a problem with another service, which can then be investigated further. For non-obvious errors, please contact Chef support services.

