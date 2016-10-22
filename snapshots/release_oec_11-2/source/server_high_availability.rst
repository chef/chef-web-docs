.. THIS PAGE DOCUMENTS Enterprise Chef server version 11.2

=====================================================
High Availability
=====================================================

Enterprise Chef can operate in a high availability configuration that provides automated failover for stateful components in the system architecture. This configuration splits servers into two segments: front-end and back-end servers. The front-end servers handle requests to the user interface and requests that use the Chef server API. The back-end servers handle data storage and retrieval, which consists of:

* CouchDB
* PostgreSQL
* opscode-solr
* RabbitMQ
* Redis
* Cookbook data

Failover on the back-end servers is achieved using the following:

* Asynchronous block level replication of logical volume managers using DRBD, positioned between two back-end servers
* A primary and backup cluster election using VRRP over unicast TCP/IP and Keepalived
* A virtual IP address to the primary server, maintained based on the results of the election done by Keepalived

.. image:: ../../images_old/oec_ha.png

The front-end servers require load-balancers. Chef recommends:

* Hardware load-balancers (such as F5 or NetScalar)
* SSL off-loading
* Round-robin as the load-balancing algorithm


Scalability 
=====================================================
Scalability for front-end servers is achieved by horizontally scaling the number of servers.

Scalability for back-end servers is achieved by vertically scaling the servers. For example, adding memory, CPU, and faster disks will all increase throughput from the back-end servers. Faster disks, and dedicated network interface cards will all increase the reliability of DRBD and the responsiveness of Enterprise Chef.

Failover and Recovery
=====================================================
When the primary server in the cluster fails, the VRRP heartbeat will stop. At this point the backup server will begin transitioning to the primary state, which involves:

#. Assigning the virtual IP address and sending a ``proxy-arp``
#. Attempting to take-over as the primary server for the DRBD device
#. Starting all of the back-end services

.. note:: The first step is transitioning the virtual IP address, which means that traffic will flow to the backup server while it makes the transition to being the primary server.

Graceful Transitions
=====================================================
The Keepalived service manages the VRRP and cluster transitions. It should be running on both the primary and secondary servers. To transition from the primary to the secondary, simply run the following on the primary:

.. code-block:: bash

   $ private-chef-ctl stop keepalived

which will initiate a failover from the primary to the secondary. This will cause the current primary to:

#. Remove the virtual IP address.
#. Stop the services.
#. Unmount the DRBD device.
#. Becoming secondary for the DRBD device. 

Meanwhile, the backup will be undergoing the same steps as listed above. Use the ``ha-status`` option to view the progress:

.. code-block:: bash

   $ watch -n1 sudo private-chef-ctl ha-status


Status
=====================================================
.. include:: ../../includes_api_chef_server/includes_api_chef_server_endpoint_status.rst

DRBD
=====================================================
DRBD is a supported high availability configuration option for the Chef server. More information about DRBD is available at http://www.drbd.org.

Split Brains
-----------------------------------------------------
.. include:: ../../includes_server_ha/includes_server_ha_drbd_split_brain.rst

Split-brain Handlers
-----------------------------------------------------
.. include:: ../../includes_server_ha/includes_server_ha_drbd_handlers.rst

Assumptions
-----------------------------------------------------
.. include:: ../../includes_server_ha/includes_server_ha_drbd_assumptions.rst

Failure Scenarios
=====================================================
.. include:: ../../includes_server_ha/includes_server_ha_drbd_scenario.rst

Scenarios 1 and 2
-----------------------------------------------------
When the acting backup server fails, DRBD on the master will continue to function in primary mode, whether the DRBD on the secondary was shut down gracefully or became unavailable unexpectedly. Verify that DRBD is functioning by running ``drbdadm role pc0`` on the primary:

.. code-block:: bash

   [root@be1 opscode]# drbdadm role pc0
   Primary/Unknown
   [root@be1 opscode]#

You can see the full status by running cat ``/proc/drbd``:

.. code-block:: none

   version: 8.4.0 (api:1/proto:86-100)
   GIT-hash: 28753f559ab51b549d16bcf487fe625d5919c49c build by    root@localhost.localdomain, 2012-02-06 12:59:36
 0: cs:WFConnection ro:Primary/Unknown ds:UpToDate/DUnknown C r-----
       ns:672 nr:0 dw:24 dr:1697 al:2 bm:0 lo:0 pe:0 ua:0 ap:0 ep:1 wo:b oos:130760

The disk partition is still mounted into the file system and can be used as normal.

When the secondary becomes available again, two things may happen:

* If the status of the secondary reports ``Inconsistent`` or ``UpToDate`` without manual intervention, all is well.
* If it remains ``DUnknown``, DRBD on the secondary can be manually restarted and it will start to sync. The ``DUnknown`` status is the report which indicates that DRBD sees no network connection to its partner.

The last field in the ``/prod/drbd`` file (``oos``) reports how far the primary is out of sync with its partner. If the secondary is down and there are a lot of writes on the primary, this number will increase. For example:

.. code-block:: none

   version: 8.4.0 (api:1/proto:86-100)
   GIT-hash: 28753f559ab51b549d16bcf487fe625d5919c49c build by root@localhost.localdomain, 2012-02-06 12:59:36
    0: cs:WFConnection ro:Primary/Unknown ds:UpToDate/DUnknown C r-----
        ns:5205048 nr:64 dw:1466728 dr:4180125 al:354 bm:261 lo:1667 pe:0 ua:0 ap:1665 ep:1 wo:b oos:361540

When the disks return to a synced state, that field will return to ``0``. While the secondary is syncing, status about the syncing process will be shown for both hosts. For the secondary, something like the following:

.. code-block:: none

   GIT-hash: 91b4c048c1a0e06777b5f65d312b38d47abaea80 build by dag@Build64R6, 2011-12-21 06:08:50
    0: cs:SyncTarget ro:Secondary/Primary ds:Inconsistent/UpToDate C r-----
       ns:0 nr:1263008 dw:1257888 dr:0 al:0 bm:60 lo:6 pe:8 ua:5 ap:0 ep:1 wo:f oos:1670512
           [======>.............] sync'ed: 36.3% (1670512/2613068)K
           finish: 0:00:47 speed: 35,152 (18,124) want: 44,520 K/sec

and for the primary, something like the following:

.. code-block:: none

   version: 8.4.0 (api:1/proto:86-100)
   GIT-hash: 28753f559ab51b549d16bcf487fe625d5919c49c build by root@localhost.localdomain, 2012-02-06 12:59:36
    0: cs:SyncSource ro:Primary/Secondary ds:UpToDate/Inconsistent C r-----
       ns:7259268 nr:64 dw:4279364 dr:5721317 al:949 bm:360 lo:5 pe:0 ua:5 ap:0 ep:1 wo:b oos:1121600
           [==========>.........] sync'ed: 57.3% (1121600/2613068)K
           finish: 0:00:32 speed: 34,328 (21,304) K/sec

Eventually the hosts will quiesce and report ``ds:UpToDate/UpToDate``. Depending on how long the secondary was down, how much data was written to the primary in the interim, and the speed of the shared network, this process could be nearly instantaneous, or could take several minutes. The processes used to manage the Chef server should not require manipulation in any way during this recovery.

If the secondary host is lost completely, a new host can be installed in its place, the device built, and then DRBD started. The new host will pair with the existing primary, sync data, and be ready to take over if necessary.

Scenario 3
-----------------------------------------------------
Trouble starts when the DRBD primary is the host that becomes unavailable. The DRBD process on the secondary makes no assumptions about whether or not it should automatically take over, based on the split-brain configurations in the ``drbd.conf`` file.

Basically, what this means is that when the primary becomes unavailable to the secondary without an explicit takeover being initiated, the secondary will assume that it itself is the wrong, ``split-brained`` host, and is the one unconnected and incorrect. It will take no automatic action.

The status of the secondary will look something like the following:

.. code-block:: none

   version: 8.4.1 (api:1/proto:86-100)
   GIT-hash: 91b4c048c1a0e06777b5f65d312b38d47abaea80 build by dag@Build64R6, 2011-12-21 06:08:50
    0: cs:WFConnection ro:Secondary/Unknown ds:UpToDate/DUnknown C r-----
       ns:0 nr:3505480 dw:4938128 dr:0 al:0 bm:290 lo:0 pe:0 ua:0 ap:0 ep:1 wo:f oos:0

The ``ds:UpToDate/Unknown`` is important; it indicates that the secondary has all the data that was on the primary and won't lose anything if it is promoted.

If it is verified that the primary host is going to be down for a while, the secondary can be promoted to primary:

.. code-block:: bash

   $ drbdadm primary pc0

at that point the status will change to something like the following:

.. code-block:: none

   version: 8.4.1 (api:1/proto:86-100)
   GIT-hash: 91b4c048c1a0e06777b5f65d312b38d47abaea80 build by dag@Build64R6, 2011-12-21 06:08:50
    0: cs:WFConnection ro:Primary/Unknown ds:UpToDate/DUnknown C r-----
       ns:0 nr:3505480 dw:4938128 dr:672 al:0 bm:290 lo:0 pe:0 ua:0 ap:0 ep:1 wo:f oos:0

Notice that ``ro`` is now ``ro:Primary/Unknown``. The Chef server can now be recovered by entering the following command:

.. code-block:: bash

   $ private-chef-ctl master-recover

This will start up the configured services and the Chef server will be master on this host.

If the original primary can be brought back online, the cluster management script run by Keepalived will try to do a DRBD takeover, based on that host's original primary Chef server master status.

The first thing it will do is attempt to promote itself to DRBD primary, which will fail if the disk has been written to at all while this host was down, and Keepalived will be unable to transition back to the original master. This leaves the pair of servers in a good state, with the second back-end box as the DRBD primary Chef server master.

DRBD on the first back-end server will sync to the second back-end server and will become the clean secondary FQDN.

Scenario 4
-----------------------------------------------------
So far, the scenarios have not described any data loss. When the hosts in the high availability pair are synced, either can be lost and the data will be safe.

If you get to a situation in which the primary host is lost and unrecoverable, but the last status of the DRBD pair was reporting that the secondary node was in an ``Inconsistent`` state, it is very likely that some data will be lost. The DRBD status on the remaining host will look something like the following:

.. code-block:: none

   version: 8.4.0 (api:1/proto:86-100)
   GIT-hash: 28753f559ab51b549d16bcf487fe625d5919c49c build by root@localhost.localdomain, 2012-02-06 12:59:36
   0: cs:WFConnection ro:Secondary/Unknown ds:Inconsistent/DUnknown C r-----
      ns:0 nr:210572 dw:210572 dr:0 al:0 bm:13 lo:0 pe:0 ua:0 ap:0 ep:1 wo:b oos:40552

As long as good source code management is practiced with cookbooks and other files in the chef-repo, any missing bits can be re-uploaded after there is a working cluster. In some cases, newly-created users or organizations will need to be re-created. Other actions, such as chef-client runs and uploads may fail while the cluster is in an ``Inconsistent`` state, but will be fine after there is a working cluster.

When the primary back-end server has been lost while the secondary back-end server is in an ``Inconsistent`` state and it's not going to be back online quickly, the best thing to do is to provision another host to become the new Chef server cluster partner for the secondary back-end server, and then build it out. If the new host has an IP address that is different from the primary back-end server, change the configuration on the secondary back-end server, and then reconfigure.

In this situation, the Chef server may be freaking out a bit, so turn off the daemons using the ``private-chef-ctl stop`` command.

Once the new host is identified and the DRBD devices on that host are ready, bring up DRBD and get it talking to the secondary back-end server. This secondary server should not want to be the primary server; it should be waiting for the old primary server to return. Start up DRBD on the new host and verify that it is listening on the correct port and that the status in ``/proc/drbd`` is reporting that the host is up, but in the ``WFConnect: waiting for connection`` state.

By the time you get the new node is up, the secondary back-end server may have taken itself into ``standalone`` mode, which means that it is no longer listening on the network port. In this situation, run the following commands to get the secondary back-end server to talk to the new node:

.. code-block:: bash

   $ drbdadm primary --force pc0

and:

.. code-block:: bash

   $ drbdadm connect pc0

At this point, the new host should be synchronizing with the secondary back-end server. The secondary back-end server will forget all about the data it was missing from the now-gone primary back-end server, and the process of bringing the Chef server back online can begin.

Running a fast network between the primary and secondary hosts, and keeping it full throttle for DRBD transfers, will go a long way to mitigating the any damage that may be done in the event of a loss of the primary from an un-synced cluster.

Scenario 5
-----------------------------------------------------
Sometimes DRBD hedges its bets, and puts both nodes in a pair into secondary mode. When this happens, you can look at the contents of ``/proc/drbd`` on both hosts and see if either of them is showing out of sync. If they are both ``oos:0``, just pick one and promote it to primary using the ``drbdadm primary pc0`` command. If one or both of the hosts is out of sync, choose the one with the lower amount of ``oos`` and promote it to primary.

If the chosen node won't promote, run the following commands on the other host to reset its disk state:

.. code-block:: bash

   $ drbdadm wipe-md pc0

and:

.. code-block:: bash

   $ drbdadm create-md pc0

That will tell DRBD to abandon what is on the node and start over, and should allow it to sync with the primary.
