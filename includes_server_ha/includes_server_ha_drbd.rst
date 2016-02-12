.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

|drbd| is a supported high availability configuration option for the |chef server|. 

.. image:: ../../images/chef_server_ha_drbd.svg
   :width: 600px
   :align: center

Front-end machines are scaled horizontally, and then load balanced using a hardware load balancer, |ssl| off-loading, and round-robin as the load balancing algorithm.

Back-end machines are scaled vertically by adding memory, processing power, and faster disks to increase throughput, by adding faster disks and dedicated network interface cards to increase the reliability of |drbd| and the responsiveness of the |chef server|. Failover is achieved using:

* Asynchronous block level replication of logical volume managers, positioned between the two back-end machines
* A primary and backup cluster election using |vrrp| over unicast TCP/IP and |keepalived|
* A virtual IP address to the primary |chef server| that is maintained based on the results of the election done by |keepalived|

When the primary |chef server| in the cluster fails, the |vrrp| heartbeat will stop. At this point, the backup server will begin transitioning to the primary state by:

#. Assigning the virtual IP address and sending a ``proxy-arp``; this step transitions the virtual IP address, which means traffic will flow to the back-end |chef server| while it makes the transition to becoming the primary |chef server|.
#. Attempting to take over as the primary |chef server| for the |drbd| device.
#. Starting all of the back-end services.

For more information about |drbd|, see http://www.drbd.org.