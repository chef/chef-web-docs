=====================================================
Monitor
=====================================================

.. include:: ../../includes_server_monitor/includes_server_monitor.rst

Monitoring Priorities
=====================================================
The following sections describe the priorities for monitoring of the Chef server. In particular, running out of disk space is the primary cause of failure.

Disks
-----------------------------------------------------
.. include:: ../../includes_server_monitor/includes_server_monitor_system_disk.rst

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
.. include:: ../../includes_server_monitor/includes_server_monitor_application.rst

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
.. include:: ../../includes_server_monitor/includes_server_monitor_application_nginx.rst

PostgreSQL
-----------------------------------------------------
.. include:: ../../includes_server_monitor/includes_server_monitor_application_postgresql.rst

RabbitMQ
-----------------------------------------------------
.. include:: ../../includes_server_monitor/includes_server_monitor_application_rabbitmq.rst

Redis
-----------------------------------------------------
.. include:: ../../includes_server_monitor/includes_server_monitor_application_redis.rst

Apache Solr
-----------------------------------------------------
The **opscode-solr4** service located on the primary back end machine handles requests that are made from the Erchef service that is located on all front end machines in a Chef server cluster.

Under normal circumstances, opscode-solr4 will need access to a total of 2x the space used for the index.

The thread at http://comments.gmane.org/gmane.comp.jakarta.lucene.solr.user/99149 explains more fully, including describing an extreme case where it's possible that 3x the storage might be necessary. Chef server usage of Apache Solr via the **opscode-solr4** service will generally only require the used storage for the index + 1x that amount of storage in free space.

For example, a 2GB search index will require about 2GB of free space available in the **opscode-solr4** service's storage area. The standard storage area for the **opscode-solr4** service in a standalone topology Chef server install is ``/var/opt/opscode/opscode-solr4/data``.

System Checks
=====================================================
.. include:: ../../includes_server_monitor/includes_server_monitor_system.rst

ha-status
-----------------------------------------------------
.. include:: ../../includes_ctl_private_chef/includes_ctl_private_chef_ha_status.rst

opscode-authz
-----------------------------------------------------
.. include:: ../../includes_server_monitor/includes_server_monitor_system_authz.rst

opscode-erchef
-----------------------------------------------------
.. include:: ../../includes_server_monitor/includes_server_monitor_system_erchef.rst

opscode-expander
-----------------------------------------------------
.. include:: ../../includes_server_monitor/includes_server_monitor_system_expander.rst

Search Indexes
++++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_search/includes_search.rst

.. include:: ../../includes_server_monitor/includes_server_monitor_system_expander_search.rst

opscode-expander-ctl
++++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_ctl_opscode_expander/includes_ctl_opscode_expander.rst

.. include:: ../../includes_ctl_opscode_expander/includes_ctl_opscode_expander_options.rst

.. include:: ../../includes_ctl_opscode_expander/includes_ctl_opscode_expander_example.rst

Nodes, Workstations
=====================================================
.. include:: ../../includes_server_monitor/includes_server_monitor_system_client.rst

