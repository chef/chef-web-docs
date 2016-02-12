.. THIS PAGE DOCUMENTS Enterprise Chef server version 11.2

=====================================================
Scaled Back End
=====================================================

The scaled back end installation allows the |chef server| to be installed on multiple servers in order to scale portions of the service horizontally, with a highly available back-end infrastructure. This is the recommended configuration for production utilization of the |chef server|.

We refer to all the servers in a particular installation of the |chef server| as a cluster.

The scaled back end installation consists of multiple front-end servers talking to a pair of clustered back-end servers. This allows for a higher level of concurrency on API requests, while scaling the back-end servers vertically to handle the increased I/O load.

System Requirements
=====================================================
A scaled back end installation scenario has the following system requirements:

* 8 total cores 2.0 GHz AMD 41xx/61xx or Intel Xeon 5000/E5 CPUs or faster
* 16GB RAM
* 2 x 300GB SAS RAID1 drives
* Hardware |raid| card
* 1 x GigE NIC interface
* 20 GB of free disk space in ``/opt``
* 40 GB of free disk space in ``/var``
* Two back-end servers; as many front-end servers as required.

.. note:: While the |chef server| can be run on smaller systems, our assumption with the scaled back end installation is that it is intended for production use. The above configuration is rated at 1,500 nodes converging every 5 minutes.

Network Requirements
=====================================================
The |chef server| has the following network requirements for a scaled back end installation:

Networking
-----------------------------------------------------
The back-end servers utilize |drbd|, a distributed block device, to ensure that data written to disk on one back-end server is efficiently replicated to another. For optimal performance and reliability, we recommend that:

* Back-end servers should have `an ethernet interface cross-connected <http://www.drbd.org/users-guide/s-prepare-network.html>`_ to the other, 10G+ recommended, for both the cluster ``keepalive`` signal and |drbd| data replication.

This is in addition to the standard network interfaces that are available and would be used for access by the frontends and management functions. While |drbd| replication can function on systems without this additional network interface, this configuration gives maximum performance and reliability.

Virtual IP Addresses
-----------------------------------------------------
The back-end servers will share a virtual IP address, which needs to be accessible from the front-end servers. This virtual IP address will be created and managed by the |chef server| but will need to be added to DNS to access the cluster.

Disk Configuration
-----------------------------------------------------
The data that is stored in the |chef server| database is primarily cookbook data. It is recommended that disks are dedicated entirely to storing this data for the |chef server| installation. These disks should:

* Utilize hardware |raid|
* Be configured in either |raid1| or |raid5|
* Be identical across both of your back-end servers

Our recommended configuration utilizes the |linux| |lvm| as the backing store for |drbd|. This assumes that:

* ~300GB of raw, unpartitioned disk space is available
* The disk space presents as a single device, ``/dev/sdb``
* The storage is added to a volume group named ``opscode``
* The storage is added in a logical volume group named ``drbd``
* The volume group should have adequate space to enable |lvm| snapshots to be used for backups; this amount depends on many factors, including how much changes in-between snapshots, how long the snapshots will be kept, and the (eventual) size of the |chef server| database; a decent starting point when sizing |lvm| snapshots is ~10% of the raw, unpartitioned disk space

The following commands would properly set up the back-end disk configuration for |drbd|:

.. code-block:: bash

   $ pvcreate /dev/sdb

and:

.. code-block:: bash

   $ vgcreate opscode /dev/sdb

and:

.. code-block:: bash

   $ lvcreate -l 80%VG -n drbd opscode

.. warning:: Talk with your systems administrators about disk configuration if you are at all uncertain of how to configure a new logical volume with |lvm|, as the operations can be destructive.

Load Balancing
-----------------------------------------------------
As multiple front-end servers are run, there will be a need to provide a mechanism for load-balancing the requests between them. We recommend using either a hardware or software load-balancer configured for round-robin.

Create a DNS entry for the load balanced virtual IP address, which will be used to access the cluster. This is also referred to as the ``api_fqdn``.

Firewalls
-----------------------------------------------------
For back end servers in an |chef server oec| installation:

.. list-table::
   :widths: 60 420 60
   :header-rows: 1

   * - Port
     - Service
     - External
   * - 5984
     - |service couchdb|
     - yes
   * - 8983
     - |service solr|
     - yes
   * - 5432
     - |service postgresql|
     - yes
   * - 5672
     - |service rabbitmq|
     - yes
   * - 16379
     - |service redis_lb|
     - yes
   * - 4321
     - |service bookshelf|
     - yes
   * - 4369
     - |service orgcreator|
     - no
   * - 7788-7799
     - |drbd| This port range must be open between all back end servers.
     - no

Loopback Interface
+++++++++++++++++++++++++++++++++++++++++++++++++++++
A single loopback interface should be configured using the ``127.0.0.1`` address. This ensures that all of the services are available to the |chef server|, in the event that the |chef server| attempts to contact itself from within a machine. For proper functioning, all of the ports listed should be accessible through the loopback interface.

Hostnames, FQDNs
-----------------------------------------------------
The hostname for the |chef server| must be a |fqdn|, including the domain suffix, and must be resolvable. See `Hostnames, FQDNs <https://docs.chef.io/install_server_pre.html#hostnames-fqdns>`_ for more information.

|private chef rb|
=====================================================
Each |chef server| cluster has a single configuration file: |private chef rb|. This file describes the topology of the entire cluster and lives in |path chef server enterprise chef server rb| on each server. In any text editor, create a file called |private chef rb|.

Set the topology
-----------------------------------------------------
Add the following line to the |private chef rb| configuration file:

.. code-block:: ruby

   topology "ha"

This lets the |chef server| know that these servers will be in a horizontally scalable configuration with a highly-available back-end.

Back-end entries
-----------------------------------------------------
Nominate a back-end server as the bootstrap server. For that server, add the following to the |private chef rb| file:

.. code-block:: ruby

   server "FQDN",
     :ipaddress => "IPADDRESS",
     :role => "backend",
     :bootstrap => true,
     :cluster_ipaddress => "CLUSTER_IPADDRESS"

Replace ``FQDN`` with the |fqdn| of the server, and ``IPADDRESS`` with the IP address of the server. The role is a back-end server. If the server will be used to bootstrap the |chef server| installation, replace ``CLUSTER_IPADDRESS`` with the IP address of the interface to be used for cluster communications (such as |keepalived| and |drbd| replication). If no such interface is configured, exclude the ``cluster_ipaddress`` entry.

For the other back-end server, add the following:

.. code-block:: ruby

   server "FQDN",
    :ipaddress => "IPADDRESS",
    :role => "backend",
    :cluster_ipaddress => "CLUSTER_IPADDRESS"

Replace ``FQDN`` with the |fqdn| of the server, and ``IPADDRESS`` with the IP address of the server. Replace ``CLUSTER_IPADDRESS`` with the IP address of the server's interface assigned for cluster communications. If no such interface is configured, exclude the ``cluster_ipaddress`` entry.

Add an entry for the back-end virtual IP address that was assigned earlier:

.. code-block:: ruby

   backend_vip "FQDN",
     :ipaddress => "IPADDRESS",
     :device => "eth0",

Replace ``FQDN`` with the |fqdn| of the server, and ``IPADDRESS`` with the IP address of the virtual IP address. The ``:device`` parameter should be the ethernet interface to which the floater virtual IP address will bind (i.e. the public interface of the server).

Front-end entries
-----------------------------------------------------
For each front-end server in the |private chef rb| file, add the following:

.. code-block:: ruby

   server "FQDN",
     :ipaddress => "IPADDRESS",
     :role => "frontend"

Replace ``FQDN`` with the |fqdn| of the server, and ``IPADDRESS`` with the IP address of the server. The role is front end.

Set api_fqdn
-----------------------------------------------------
Add the following line to the |private chef rb| config file:

.. code-block:: ruby

   api_fqdn "FQDN"

Replace ``FQDN`` with the |fqdn| of the load balanced VIP.

Example
-----------------------------------------------------
A completed |private chef rb| configuration file for a four server HA |chef server| cluster, consisting of:

.. list-table::
   :widths: 100 150 150 100
   :header-rows: 1

   * - FQDN
     - Real IP Address
     - Cluster IP Address
     - Role
   * - be1.example.com
     - 192.168.4.1
     - 10.1.2.10
     - backend
   * - be2.example.com
     - 192.168.4.6
     - 10.1.2.12
     - backend
   * - fe1.example.com
     - 192.168.4.2
     - 
     - frontend
   * - fe2.example.com
     - 192.168.4.3
     - 
     - frontend
   * - fe3.example.com
     - 192.168.4.4
     - 
     - frontend
   * - chef.example.com
     - 192.168.4.5
     - 
     - load balanced frontend VIP
   * - be.example.com
     - 192.168.4.7
     - 
     - load balanced backend VIP

Looks like this:

.. code-block:: ruby

   topology "ha"
   
   server "be1.example.com",
     :ipaddress => "192.168.4.1",
     :role => "backend",
     :bootstrap => true,
     :cluster_ipaddress => "10.1.2.10"
   
   server "be2.example.com",
     :ipaddress => "192.168.4.6",
     :role => "backend",
     :cluster_ipaddress => "10.1.2.12"
   
   backend_vip "be.example.com",
     :ipaddress => "192.168.4.7",
     :device => "eth0"
   
   server "fe1.example.com",
     :ipaddress => "192.168.4.2",
     :role => "frontend"
   
   server "fe2.example.com",
     :ipaddress => "192.168.4.3",
     :role => "frontend"
   
   server "fe3.example.com",
     :ipaddress => "192.168.4.4",
     :role => "frontend"
   
   api_fqdn "chef.example.com"



Add Package to Servers
=====================================================
Upload the package provided to the servers you wish to install on, and record its location on the file-system. The rest of this section will assume that it was uploaded to the ``/tmp`` directory on each system.


Add |private chef rb| to /etc/opscode
=====================================================
Copy the |private chef rb| file to |path chef server enterprise chef server rb| on the bootstrap server.

Install the |chef server| on backend
=====================================================
Install the |chef server| package on both of the back-end servers. For |redhat| and |centos| 6:

.. code-block:: bash

   $ rpm -Uvh /tmp/chef-server-core-<version>.rpm

For |ubuntu|:

.. code-block:: bash

   $ dpkg -i /tmp/chef-server-core-<version>.deb

Install |drbd| on back-end servers
=====================================================
Both of the back-end servers must have |drbd| installed:

.. code-block:: bash

   $ rpm --import http://elrepo.org/RPM-GPG-KEY-elrepo.org
   $ rpm -Uvh http://elrepo.org/elrepo-release-6-5.el6.elrepo.noarch.rpm
   $ yum install -y drbd84-utils kmod-drbd84

.. note:: The |elrepo| provides updated drivers for the |linux| family of enterprise distributions (based on |redhat enterprise linux|.) With the introduction of |redhat enterprise linux| 6, |redhat| no longer distributes |drbd| within the kernel. These modules provide properly built, community tested releases of the required kernel and |drbd| userland.

For |ubuntu|:

.. code-block:: bash

   $ apt-get install drbd8-utils

Configure |drbd| on the back-end bootstrap server
=====================================================
In the scaled back end configuration, setup of the |chef server| happens in two phases - the first phase configures |drbd|, and then pauses to allow you to finish establishing |drbd| replication before moving on:

.. code-block:: bash

   $ private-chef-ctl reconfigure

The installer will pause, asking you to confirm that you have set up |drbd|. Press ``CTRL-C`` to exit, and continue the last few steps required to set up |drbd|:

.. code-block:: bash

   $ drbdadm create-md pc0
   $ drbdadm up pc0


Copy config to non-bootstrap back-end server
=====================================================
To configure |drbd| on the non-bootstrap back-end server, first copy all the contents of ``/etc/opscode`` on the bootstrap node to the non-bootstrap back-end. On the non-bootstrap server, run the following command:

.. code-block:: bash

   $ scp -r FQDN:/etc/opscode /etc

Replace ``FQDN`` above with the |fqdn| of the bootstrap server.

Configure |drbd| for non-bootstrap back-end server
=====================================================
Set up the configuration of |drbd| on the non-bootstrap back-end server:

.. code-block:: bash

   $ private-chef-ctl reconfigure

The installer will pause, asking you to confirm that you have set up |drbd|. Press ``CTRL-C`` to exit, and continue the last few steps require to set up |drbd|:

.. code-block:: bash

   $ drbdadm create-md pc0
   $ drbdadm up pc0


Set bootstrap server to be the primary server
=====================================================
With both servers now configured for |drbd|, let the cluster know that the bootstrap server should be primary for the shared device. 

For |drbd| on |redhat| and |centos| 6:

.. code-block:: bash

   $ drbdadm primary --force pc0

For |ubuntu|:

.. code-block:: bash

   $ drbdadm -- --overwrite-data-of-peer primary pc0


Mount the file system on the |drbd| server
=====================================================
On the bootstrap server, if the file system is named ``ext4``, run the following command to create the file system for |drbd|:

.. code-block:: bash

   $ mkfs.ext4 /dev/drbd0
   $ mkdir -p /var/opt/opscode/drbd/data
   $ mount /dev/drbd0 /var/opt/opscode/drbd/data


Monitor the |drbd| server for initial synchronization
=====================================================
Before proceeding with the installation, |drbd| MUST be allowed to fully synchronize all devices. To observe the synchronization process, you can run:

.. code-block:: bash

   $ watch -n1 cat /proc/drbd

Output similar to the following will be shown:

.. code-block:: bash

   cat /proc/drbd output
   
   version: 8.4.1 (api:1/proto:86[STRIKEOUT:100)
   GIT-hash: 91b4c048c1a0e06777b5f65d312b38d47abaea80 build by
   dag@Build64R6, 2011]12[STRIKEOUT:21 06:08:50
     0: cs:SyncSource ro:Primary/Secondary ds:UpToDate/Inconsistent C r]—-
     ns:3071368 nr:0 dw:0 dr:3075736 al:0 bm:187 lo:0 pe:13 ua:4 ap:0 ep:1
     wo:b oos:12685660
     [==>……………..] sync'ed: 19.5% (12388/15372)M
     finish: 0:11:00 speed: 19,188 (24,468) K/sec

When the ``ds`` section of the output reads ``UpToDate/UpToDate``, the synchronization is complete.

Under normal operation, |drbd| dedicates only a portion of the available disk bandwidth to initial/complete re-synchronization. This is to ensure that new data that may be written to the shared device is also being synchronized. To enable |drbd| to utilize more of the bandwidth available during the initial synchronization, you can run:

Speeding up initial synchronization on |redhat| and |centos| 6:

.. code-block:: bash

   $ drbdadm disk-options --resync-rate=1100M pc0

Speeding up initial synchronization on |ubuntu|:

.. code-block:: bash

   $ drbdsetup /dev/drbd0 syncer -r 1100M

With synchronization complete, |drbd| is ready to be used on the bootstrap node. Let the |chef server| know that |drbd| is ready by running the following command:

.. code-block:: bash

   $ touch /var/opt/opscode/drbd/drbd_ready



Configure the |chef server| on the bootstrap server
=========================================================
To continue setting up the |chef server| on a bootstrap server, run:

.. code-block:: bash

   $ private-chef-ctl reconfigure

This command may take several minutes to run, during which you will see the output of the |chef client| run that is configuring the |chef server| installation. When it is complete, the following message is displayed:

.. code-block:: bash

   Chef Server Reconfigured!

.. note:: |chef server| is composed of many different services, which work together to create a functioning system. One impact of this is that it can take a few minutes for the system to finish starting up. One way to tell that the system is fully ready is to use the top command. You will notice high CPU utilization for several |ruby| processes while the system is starting up. When that utilization drops off, the system is ready.


Configure the |chef server| on non-bootstrap back-end
===========================================================
.. warning:: Make sure |drbd| synchronization has completed, and that the |chef server| has fully started on the bootstrap node before continuing!

Each node that is part of the |chef server| back-end cluster participates in an election for which server should be the primary server for the |drbd| device. This means that, if the bootstrap node is not allowed to finish initializing the system before setting up the non-bootstrap server, the system may be left in an unstable state:

.. code-block:: bash

   $ touch /var/opt/opscode/drbd/drbd_ready

Followed by:

.. code-block:: bash

   $ private-chef-ctl reconfigure


Configure the front-ends
=====================================================
The following sections describe what is required to configure the front-end servers.

Copy /etc/opscode
-----------------------------------------------------
With the bootstrap complete, the ``/etc/opscode`` directory on the front-end servers can be populated with the files generated during the bootstrap process. The following command assumes the user is logged in as the root user:

.. code-block:: bash

   $ scp -r /etc/opscode FQDN:/etc

This command will copy all the files from the bootstrap server to another system. Replace ``FQDN`` with the |fqdn| of the system you want to install.

Install package
-----------------------------------------------------
Install the |chef server| package on each of the front-end servers. For |redhat| and |centos| 6:

.. code-block:: bash

   $ rpm -Uvh /tmp/chef-server-core-<version>.rpm

For |ubuntu|:

.. code-block:: bash

   $ dpkg -i /tmp/chef-server-core-<version>.deb


Configure
-----------------------------------------------------
To set up the |chef server| on your front-end servers, run:

.. code-block:: bash

   $ private-chef-ctl reconfigure

This command may take several minutes to run, during which you will see the output of the |chef client| run that is configuring the |chef server| installation. When it is complete, the following message is shown:

.. code-block:: bash

   Chef Server Reconfigured!

.. note:: |chef server| is composed of many different services, which work together to create a functioning system. One impact of this is that it can take a few minutes for the system to finish starting up. One way to tell that the system is fully ready is to use the top command. You will notice high CPU utilization for several |ruby| processes while the system is starting up. When that utilization drops off, the system is ready.

Success!
=====================================================
Congratulations, the |chef server| is installed in a scaled back end configuration.

Using GRE tunnels
=====================================================
Occasionally, a GRE tunnel will be required to handle the |vrrp| traffic. To accomplish this, set the following in ``/var/opt/opscode/keepalived/bin/tunnel.sh`` on the back-end server that will be used for bootstrapping:

.. code-block:: bash

   #!/bin/sh
   ip tunnel add pc mode gre remote VRRP_IP_OF_PEER local MY_IP ttl 25
   ip link set pc up
   ip addr add 172.18.16.1 dev pc
   ip route add 172.18.16.0/24 dev pc

Replace ``VRRP_IP_OF_PEER`` with the IP address of the server on the other end of the tunnel, and ``MY_IP`` with the IP address of the server on which the script will be located.

The ``172.17.16.**`` network addresses used in the previous examples could be any unused reserved IP address space.

Set the following in ``/etc/opscode/private-chef.rb``:

.. code-block:: ruby

   backend_vip "192.168.141.108",
     :ipaddress => "192.168.141.108",
     :device => "eth0"

And set the |keepalived| unicast addresses to the GRE tunnel addresses.


