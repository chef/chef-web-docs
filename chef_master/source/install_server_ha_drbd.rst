.. This page is the Chef 12 server install page, for high availability in AWS.

=====================================================
High Availability: DRBD (DEPRECATED)
=====================================================
`[edit on GitHub] <https://github.com/chef/chef-web-docs/blob/master/chef_master/source/install_server_ha_drbd.rst>`__

.. warning:: This topic is deprecated as of the 12.9 release of the Chef servver. For the latest information on high availability and how to set up a highly-available server cluster, see :doc:`High Availability: Backend Cluster </install_server_ha>`.

This topic describes how to set up the Chef server for high availability using physical machines and DRBD.

.. image:: ../../images/chef_server_ha_drbd.svg
   :width: 600px
   :align: center

Prerequisites
=====================================================
Before installing the Chef server software, perform the following steps:

* Backend servers `should have a dedicated connection <http://www.drbd.org/users-guide/s-prepare-network.html>`_. This is required for replication between the two servers.
* Backend servers will share a virtual IP address that must also be accessible from each frontend server. This virtual IP address is created and managed by the Chef server, but will also need to be added to the DNS so that all servers in the high availability configuration may access it.
* Persistent data on backend servers of the Chef server is primarily composed of cookbook files and directories. Separate disks should be dedicated entirely to storing this data prior to installing the Chef server.
* Load-balancing should be used with frontend machines, along with a DNS entry for the virtual IP address used for load balancing. This virtual IP address is added to the chef-server.rb file as the ``api_fqdn``.
* All required ports must be open. See the Firewalls section (below) for the list of ports. All connections to and from the Chef server are accomplished via TCP. Refer to the operating system's manual or your systems administrators for instructions on how to configure to ports, if necessary.
* The hostname for the Chef server must be an FQDN, including the domain suffix, and must be resolvable by the other backend and frontend servers. See `Hostnames, FQDNs </install_server_pre.html#hostnames>`_ for more information.

Disk Configuration
=====================================================
Persistent data on a backend Chef server is primarily composed of cookbook files and directories. Separate disks should be dedicated entirely to storing this data prior to installing the Chef server. These disks should:

* Utilize hardware RAID
* Be configured in either RAID1 or RAID5
* Be identical across both of your backend servers

The recommended configuration utilizes the Linux logical volume manager (LVM) as the backing store for DRBD. This assumes that:

* ~300GB of raw, unpartitioned disk space is available
* The disk space presents as a single device, ``/dev/sdb``
* The storage is added to a volume group named ``opscode``
* The storage is added in a logical volume group named ``drbd``
* The volume group should have adequate space to enable logical volume manager (LVM) snapshots to be used for backups; this amount depends on many factors, including how much changes in-between snapshots, how long the snapshots will be kept, and the (eventual) size of the Chef server database; a decent starting point when sizing logical volume manager (LVM) snapshots is ~10% of the raw, unpartitioned disk space

The following commands would properly set up the backend disk configuration for DRBD:

.. code-block:: bash

   $ pvcreate /dev/sdb

and:

.. code-block:: bash

   $ vgcreate opscode /dev/sdb

and:

.. code-block:: bash

   $ lvcreate -l 80%VG -n drbd opscode

.. warning:: Talk with your systems administrators about disk configuration if you are at all uncertain of how to configure a new logical volume with logical volume manager (LVM), as the operations can be destructive.

chef-server.rb
=====================================================
Each Chef server in a high availability configuration must have an identical chef-server.rb file that is located in the ``/etc/opscode/`` directory on each server. This file describes the topology of the high availability configuration. On the primary backend server, create a file named chef-server.rb and save it in the ``/etc/opscode/`` directory.

Add the following settings to the chef-server.rb file:

#. Define the topology type:

   .. code-block:: ruby

      topology "ha"

#. Define the primary backend server:

   .. code-block:: ruby

      server "FQDN",
        :ipaddress => "IP_ADDRESS",
        :role => "backend",
        :bootstrap => true,
        :cluster_ipaddress => "CLUSTER_IPADDRESS"

   Replace ``FQDN`` with the FQDN of the server and ``IP_ADDRESS`` with the IP address of the server. The role is a backend server is ``"backend"``. If the backend server is used to bootstrap the Chef server installation, replace ``CLUSTER_IPADDRESS`` with the IP address of the interface that is used for cluster communications. For example, the same IP address that is used by Keepalived and DRBD. If the Chef server is not used to bootstrap the Chef server installation, exclude the ``:cluster_ipaddress`` entry.

#. Define the secondary backend server:

   .. code-block:: ruby

      server "FQDN",
        :ipaddress => "IPADDRESS",
        :role => "backend",
        :cluster_ipaddress => "CLUSTER_IPADDRESS"

   Replace ``FQDN`` with the FQDN of the server, and ``IPADDRESS`` with the IP address of the server. Replace ``CLUSTER_IPADDRESS`` with the IP address of the server's interface assigned for cluster communications. If no such interface is configured, exclude the ``cluster_ipaddress`` entry.

#. Define the backend virtual IP address:

   .. code-block:: ruby

      backend_vip "FQDN",
        :ipaddress => "IP_ADDRESS",
        :device => "eth0"

   Replace ``FQDN`` with the FQDN of the server. Replace ``IP_ADDRESS`` with the virtual IP address of the server. The ``:device`` parameter should be the ethernet interface to which the floater virtual IP address will bind. This is typically the public interface of the server.

#. Define each frontend server:

   .. code-block:: ruby

      server "FQDN",
        :ipaddress => "IP_ADDRESS",
        :role => "frontend"

   Replace ``FQDN`` with the FQDN of the frontend server. Replace ``IP_ADDRESS`` with the IP address of the frontend server. Set ``:role`` to ``"frontend"``.

   Add separate entry in the chef-server.rb file for each frontend server.

#. Define the API FQDN:

   .. code-block:: ruby

      api_fqdn "FQDN"

   Replace ``FQDN`` with the FQDN of the load balanced virtual IP address, which should be equal to the FQDN for the service URI that is used by the Chef server.

#. .. tag install_chef_server_reconfigure

   .. This topic is hooked in globally to install topics for Chef server applications.

   Reconfigure the Chef server and the Chef management console (standalone and frontend group members
     of a High Availabilty installation):

   .. code-block:: bash

      $ chef-server-ctl reconfigure

   .. end_tag

Primary Backend
=====================================================
Use the following steps to set up the primary backend Chef server:

#. Download the packages from https://downloads.chef.io/chef-server/. For Red Hat and CentOS 6:

   .. code-block:: bash

      $ rpm -Uvh /tmp/chef-server-core-<version>.rpm

   For Ubuntu:

   .. code-block:: bash

      $ dpkg -i /tmp/chef-server-core-<version>.deb

   After a few minutes, the Chef server will be installed.

#. Create a file named chef-server.rb that is located in the ``/etc/opscode/`` directory. See the chef-server.rb section below for an example of the settings and values that are required.

#. Install DRBD. These steps vary, depending on the platform.

   **For Ubuntu**:

   .. code-block:: bash

      $ apt-get install drbd8-utils

   **For RedHat and CentOS (all versions)**, first check for the ``xen`` kernel:

   .. code-block:: bash

      $ rpm -qa kernel\* | grep -ci xen

   If anything other than ``0`` is returned, the machine is running the ``xen`` kernel.

   **For RedHat and CentOS 6.6**, install ELRepo:

   .. code-block:: bash

      $ rpm --import http://elrepo.org/RPM-GPG-KEY-elrepo.org

   and then:

   .. code-block:: bash

      $ rpm -Uvh http://elrepo.org/elrepo-release-6-5.el6.elrepo.noarch.rpm

   .. note:: The ELRepo provides updated drivers for the Linux family of enterprise distributions (based on Red Hat Enterprise Linux.) With the introduction of Red Hat Enterprise Linux 6, Red Hat no longer distributes DRBD within the kernel. These modules provide properly built, community tested releases of the required kernel and DRBD userland.

   If the server returned ``0`` for the ``xen`` kernel, run:

   .. code-block:: bash

      $ yum install -y drbd84-utils kmod-drbd84

   If the server returned something other than ``0``, run:

   .. code-block:: bash

      $ yum install -y drbd84-utils kmod-drbd84-xen

   **For RedHat and CentOS 6.5**, install ELRepo:

   .. code-block:: bash

      $ rpm --import http://elrepo.org/RPM-GPG-KEY-elrepo.org

   and then:

   .. code-block:: bash

      $ rpm -Uvh http://elrepo.org/elrepo-release-6-5.el6.elrepo.noarch.rpm

   .. note:: The ELRepo provides updated drivers for the Linux family of enterprise distributions (based on Red Hat Enterprise Linux.) With the introduction of Red Hat Enterprise Linux 6, Red Hat no longer distributes DRBD within the kernel. These modules provide properly built, community tested releases of the required kernel and DRBD userland.

   If the server returned ``0`` for the ``xen`` kernel, run:

   .. code-block:: bash

      $ yum install -y drbd84-utils kmod-drbd84-8.4.5-1.el6.elrepo

   If the server returned something other than ``0``, run:

   .. code-block:: bash

      $ yum install -y drbd84-utils kmod-drbd84-xen-8.4.5-1.el6.elrepo

   **For RedHat and CentOS 5.11**, install ELRepo:

   .. code-block:: bash

      $ rpm --import http://elrepo.org/RPM-GPG-KEY-elrepo.org

   and then:

   .. code-block:: bash

      $ rpm -Uvh http://www.elrepo.org/elrepo-release-5-5.el5.elrepo.noarch.rpm

   .. note:: The ELRepo provides updated drivers for the Linux family of enterprise distributions (based on Red Hat Enterprise Linux.) With the introduction of Red Hat Enterprise Linux 6, Red Hat no longer distributes DRBD within the kernel. These modules provide properly built, community tested releases of the required kernel and DRBD userland.

   If the server returned ``0`` for the ``xen`` kernel, run:

   .. code-block:: bash

      $ yum install -y drbd84-utils kmod-drbd84

   If the server returned something other than ``0``, run:

   .. code-block:: bash

      $ yum install -y drbd84-utils kmod-drbd84-xen

#. .. tag install_chef_server_reconfigure

   .. This topic is hooked in globally to install topics for Chef server applications.

   Reconfigure the Chef server and the Chef management console (standalone and frontend group members
     of a High Availabilty installation):

   .. code-block:: bash

      $ chef-server-ctl reconfigure

   .. end_tag

   This will configure DRBD. The installer will pause and ask for confirmation that DRBD has been set up. Confirm (``CTRL-C``), and then run the following commands:

   .. code-block:: bash

      $ drbdadm create-md pc0

   then:

   .. code-block:: bash

      $ drbdadm up pc0

Secondary Backend
=====================================================
Use the following steps to set up the secondary backend Chef server:

#. Repeat the same steps as described for the primary backend server.

#. Create the ``/etc/opscode/`` directory, and then copy the entire contents of the ``/etc/opscode`` directory from the primary backend server, including all certificates and the chef-server.rb file.

#. .. tag install_chef_server_reconfigure

   .. This topic is hooked in globally to install topics for Chef server applications.

   Reconfigure the Chef server and the Chef management console (standalone and frontend group members
     of a High Availabilty installation):

   .. code-block:: bash

      $ chef-server-ctl reconfigure

   .. end_tag

   This will configure DRBD. The installer will pause and ask for confirmation that DRBD has been set up. Confirm (``CTRL-C``), and then run the following commands:

   .. code-block:: bash

      $ drbdadm create-md pc0

   then:

   .. code-block:: bash

      $ drbdadm up pc0

Establish Failover
=====================================================
To establish failover between the two backend servers, do the following:

#. On the primary backend server, define it as the primary shared device. For Red Hat and CentOS 6:

   .. code-block:: bash

      $ drbdadm primary --force pc0

   For Ubuntu:

   .. code-block:: bash

      $ drbdadm -- --overwrite-data-of-peer primary pc0

#. On the primary backend server, mount the file system. For example, a file system named ``ext4``:

   .. code-block:: bash

      $ mkfs.ext4 /dev/drbd0

   then:

   .. code-block:: bash

      $ mkdir -p /var/opt/opscode/drbd/data

   and then:

   .. code-block:: bash

      $ mount /dev/drbd0 /var/opt/opscode/drbd/data

#. Synchronize DRBD. This process **MUST** be allowed to complete to ensure that DRBD is synchronized with all devices.

   .. note:: Under normal operation, DRBD dedicates only a portion of the available disk bandwidth to initial/complete re-synchronization. This ensures that new data written to the shared device is also synchronized.

   DRBD can be configured to utilize more bandwidth during the initial synchronization. For Red Hat and CentOS 6:

   .. code-block:: bash

      $ drbdadm disk-options --resync-rate=1100M pc0

   For Ubuntu:

   .. code-block:: bash

      $ drbdsetup /dev/drbd0 syncer -r 1100M

   To observe the synchronization process, run the following:

   .. code-block:: bash

      $ watch -n1 cat /proc/drbd

   Output similar to the following will be shown:

   .. code-block:: none

      cat /proc/drbd output

      version: 8.4.1 (api:1/proto:86[STRIKEOUT:100)
      GIT-hash: 91b4c048c1a0e06777b5f65d312b38d47abaea80 build by
      dag@Build64R6, 2011]12[STRIKEOUT:21 06:08:50
        0: cs:SyncSource ro:Primary/Secondary ds:UpToDate/Inconsistent C r]—-
        ns:3071368 nr:0 dw:0 dr:3075736 al:0 bm:187 lo:0 pe:13 ua:4 ap:0 ep:1
        wo:b oos:12685660
        [==>……………..] sync'ed: 19.5% (12388/15372)M
        finish: 0:11:00 speed: 19,188 (24,468) K/sec

   Synchronization is complete hen the ``ds:`` section reads ``UpToDate/UpToDate``.

#. When synchronization is complete, run the following command on the primary backend server:

   .. code-block:: bash

      $ touch /var/opt/opscode/drbd/drbd_ready

#. Reconfigure the primary Chef server:

   .. code-block:: bash

      $ sudo chef-server-ctl reconfigure

#. Run the following command on the secondary backend server:

   .. code-block:: bash

      $ touch /var/opt/opscode/drbd/drbd_ready

#. Reconfigure the secondary Chef server:

   .. code-block:: bash

      $ sudo chef-server-ctl reconfigure

Frontend
=====================================================
For each frontend server, use the following steps to set up the Chef server:

#. Install the Chef server package. For Red Hat and CentOS 6:

   .. code-block:: bash

      $ rpm -Uvh /tmp/chef-server-core-<version>.rpm

   For Ubuntu:

   .. code-block:: bash

      $ dpkg -i /tmp/chef-server-core-<version>.deb

   After a few minutes, the Chef server will be installed.

#. Create the ``/etc/opscode/`` directory, and then copy the entire contents of the ``/etc/opscode`` directory from the primary backend server, including all certificates and the chef-server.rb file.

#. .. tag install_chef_server_reconfigure

   .. This topic is hooked in globally to install topics for Chef server applications.

   Reconfigure the Chef server and the Chef management console (standalone and frontend group members
     of a High Availabilty installation):

   .. code-block:: bash

      $ chef-server-ctl reconfigure

   .. end_tag

#. .. tag install_chef_server_start

   .. This topic is hooked in globally to install topics for Chef server applications.

   Start the Chef server:

   .. code-block:: bash

      $ chef-server-ctl start

   .. end_tag

#. .. tag ctl_chef_server_user_create_admin

   Run the following command to create an administrator:

   .. code-block:: bash

      $ chef-server-ctl user-create USER_NAME FIRST_NAME LAST_NAME EMAIL 'PASSWORD' --filename FILE_NAME

   An RSA private key is generated automatically. This is the user's private key and should be saved to a safe location. The ``--filename`` option will save the RSA private key to the specified absolute path.

   For example:

   .. code-block:: bash

      $ chef-server-ctl user-create stevedanno Steve Danno steved@chef.io 'abc123' --filename /path/to/stevedanno.pem

   .. end_tag

#. .. tag ctl_chef_server_org_create_summary

   Run the following command to create an organization:

   .. code-block:: bash

      $ chef-server-ctl org-create short_name 'full_organization_name' --association_user user_name --filename ORGANIZATION-validator.pem

   The name must begin with a lower-case letter or digit, may only contain lower-case letters, digits, hyphens, and underscores, and must be between 1 and 255 characters. For example: ``4thcoffee``.

   The full name must begin with a non-white space character and must be between 1 and 1023 characters. For example: ``'Fourth Coffee, Inc.'``.

   The ``--association_user`` option will associate the ``user_name`` with the ``admins`` security group on the Chef server.

   An RSA private key is generated automatically. This is the chef-validator key and should be saved to a safe location. The ``--filename`` option will save the RSA private key to the specified absolute path.

   For example:

   .. code-block:: bash

      $ chef-server-ctl org-create 4thcoffee 'Fourth Coffee, Inc.' --association_user stevedanno --filename /path/to/4thcoffee-validator.pem

   .. end_tag

#. .. tag install_chef_server_reconfigure

   .. This topic is hooked in globally to install topics for Chef server applications.

   Reconfigure the Chef server and the Chef management console (standalone and frontend group members
     of a High Availabilty installation):

   .. code-block:: bash

      $ chef-server-ctl reconfigure

   .. end_tag

Enable Features
=====================================================
.. tag ctl_chef_server_install_features

Enable additional features of the Chef server! The packages may be downloaded directly as part of the installation process or they may be first downloaded to a local directory, and then installed.

.. end_tag

**Use Downloads**

.. tag ctl_chef_server_install_features_download_ha

The ``install`` subcommand downloads packages from https://packages.chef.io/ by default. For systems that are not behind a firewall (and have connectivity to https://packages.chef.io/), the Chef management console package can be installed as described below:

Chef Manage
   Use Chef management console to manage data bags, attributes, run-lists, roles, environments, and cookbooks from a web user interface.

   On each front end server in the Chef server configuration, run:

   .. code-block:: bash

      $ chef-server-ctl install chef-manage

   then:

   .. code-block:: bash

      $ chef-server-ctl reconfigure

   and then:

   .. code-block:: bash

      $ chef-manage-ctl reconfigure

   This updates the Chef server and creates the ``/etc/opscode-manage/secrets.rb`` file. When running the Chef management console 1.11 (or higher), copy the ``secrets.rb`` file in the ``/etc/opscode-manage`` directory on one of the frontend servers to the same directory on each of the other frontend servers, and then rerun ``chef-manage-ctl reconfigure`` so the copied ``/etc/opscode-manage/secrets.rb`` file gets used correctly.

   .. note:: .. tag chef_license_reconfigure_manage

             Starting with the Chef management console 2.3.0, the :doc:`Chef MLSA </chef_license>` must be accepted when reconfiguring the product. If the Chef MLSA has not already been accepted, the reconfigure process will prompt for a ``yes`` to accept it. Or run ``chef-manage-ctl reconfigure --accept-license`` to automatically accept the license.

             .. end_tag

.. end_tag

**Use Local Packages**

.. tag ctl_chef_server_install_features_manual

The ``install`` subcommand downloads packages from https://packages.chef.io/ by default. For systems that are behind a firewall (and may not have connectivity to packages.chef.io), these packages can be downloaded from https://downloads.chef.io/chef-manage/, and then installed manually. First download the package that is appropriate for the platform, save it to a local path, and then run the ``install`` command using the ``--path`` option to specify the directory in which the package is located:

.. code-block:: bash

   $ chef-server-ctl install PACKAGE_NAME --path /path/to/package/directory

For example:

.. code-block:: bash

   $ chef-server-ctl install chef-manage --path /root/packages

The ``chef-server-ctl`` command will install the first ``chef-manage`` package found in the ``/root/packages`` directory.

.. end_tag

**Install Reporting**

.. tag install_reporting_ha

To set up the Reporting server:

#. Install the package on each frontend and backend Chef server:

   .. code-block:: bash

      $ chef-server-ctl install opscode-reporting

#. Reconfigure the Chef server on the backend primary server (bootstrap):

   .. code-block:: bash

      $ chef-server-ctl reconfigure

#. Reconfigure the Reporting server on the backend primary server (bootstrap):

   .. code-block:: bash

      $ opscode-reporting-ctl reconfigure

   .. note:: .. tag chef_license_reconfigure_reporting

             Starting with Reporting 1.6.0, the :doc:`Chef MLSA </chef_license>` must be accepted when reconfiguring the product. If the Chef MLSA has not already been accepted, the reconfigure process will prompt for a ``yes`` to accept it. Or run ``opscode-reporting-ctl reconfigure --accept-license`` to automatically accept the license.

             .. end_tag

#. Copy the entire ``/etc/opscode-reporting`` directory from the backend primary server to all frontend and backend servers. For example, from each server run:

   .. code-block:: bash

      $ scp -r <Bootstrap server IP>:/etc/opscode-reporting /etc

   or from the backend primary server:

   .. code-block:: bash

      $ scp -r /etc/opscode-reporting <each servers IP>:/etc

#. Reconfigure any Chef server on which Reporting services have been installed:

   .. code-block:: bash

      $ chef-server-ctl reconfigure

#. Reconfigure Reporting services on each server:

   .. code-block:: bash

      $ opscode-reporting-ctl reconfigure

#. Verify the installation:

   .. code-block:: bash

      $ opscode-reporting-ctl test

.. end_tag

**Install Push Jobs**

.. tag install_push_jobs_server_ha

To set up the Chef push jobs server for a high availability configuration:

#. Install the package on all servers that are running the Chef server. For example on Ubuntu:

   .. code-block:: bash

      $ sudo dpkg -i opscode-push-jobs-server_2.1.0-1_amd64.deb

#. Reconfigure the primary backend Chef push jobs server:

   .. code-block:: bash

      $ opscode-push-jobs-server-ctl reconfigure

#. Copy the entire ``/etc/opscode-push-jobs-server`` directory from the backend primary to all frontend and backend servers. For example, from each server run:

   .. code-block:: bash

      $ scp -r <Bootstrap server IP>:/etc/opscode-push-jobs-server /etc

   or from the backend primary server:

   .. code-block:: bash

      $ scp -r /etc/opscode-push-jobs-server <each servers IP>:/etc

#. TCP protocol ports 10000 and 10003 must be open. These are the heartbeat and command ports respectively. They allow the Chef push jobs server to communicate with the Chef push jobs clients. In a configuration with both frontend and backend servers, these ports only need to be open on the backend servers. The Chef push jobs server waits for connections from the Chef push jobs client (and never makes a connection to a Chef push jobs client).

#. Reconfigure the remaining Chef push jobs servers:

   .. code-block:: bash

      $ opscode-push-jobs-server-ctl reconfigure

#. Run the following command on each of the backend servers:

   .. code-block:: bash

      $ chef-server-ctl reconfigure

   This ensures that the Keepalived scripts are regenerated so they are aware of Chef push jobs.

#. Restart all servers on which Chef push jobs will run:

   .. code-block:: bash

      $ chef-server-ctl restart opscode-pushy-server

#. Verify the installation:

   .. code-block:: bash

      $ opscode-push-jobs-server-ctl test

.. end_tag

Reference
=====================================================
The following sections show an example chef-server.rb file and a list of the ports that are required by the Chef server.

chef-server.rb
-----------------------------------------------------
A completed chef-server.rb configuration file for a four server tiered Chef server cluster, consisting of:

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

Firewalls and Ports
-----------------------------------------------------
.. tag server_firewalls_and_ports_summary

All of the ports used by the Chef server are TCP ports. Refer to the operating system's manual or site systems administrators for instructions on how to enable changes to ports, if necessary.

.. end_tag

.. tag server_firewalls_and_ports_listening

All services must be listening on the appropriate ports. Most monitoring systems provide a means of testing whether a given port is accepting connections and service-specific tools may also be available. In addition, the generic system tool Telnet can also be used to initiate the connection:

.. code-block:: bash

   $ telnet HOST_NAME PORT

.. end_tag

.. tag server_firewalls_and_ports_loopback

A single loopback interface should be configured using the ``127.0.0.1`` address. This ensures that all of the services are available to the Chef server, in the event that the Chef server attempts to contact itself from within a front or back end machine. All ports should be accessible through the loopback interface of their respective hosts.

.. end_tag

Backend
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. tag server_firewalls_and_ports_be

For back-end servers, ensure that ports marked as external (marked as ``yes`` in the **External** column) are open and accessible via any firewalls that are in use:

.. list-table::
   :widths: 60 420 60
   :header-rows: 1

   * - Port
     - Service Name, Description
     - External
   * - 4321
     - **bookshelf**

       .. tag server_services_bookshelf

       The **bookshelf** service is an Amazon Simple Storage Service (S3)-compatible service that is used to store cookbooks, including all of the files---recipes, templates, and so on---that are associated with each cookbook.

       .. end_tag

     - yes
   * - 112
     - **keepalived**

       .. tag server_services_keepalived

       The **keepalived** service manages the virtual IP address (VIP) between the backend machines in a high availability topology that uses DRBD.

       .. end_tag

     - yes
   * - 80, 443, 9683
     - **nginx**

       .. tag server_services_nginx

       The **nginx** service is used to manage traffic to the Chef server, including virtual hosts for internal and external API request/response routing, external add-on request routing, and routing between front- and back-end components.

       .. end_tag

       .. note:: Port 9683 is used to internally load balance the **oc_bifrost** service.
     - yes
   * - 9683
     - **oc_bifrost**

       .. tag server_services_bifrost

       The **oc_bifrost** service ensures that every request to view or manage objects stored on the Chef server is authorized.

       .. end_tag

     - yes
   * - 9090
     - **oc-id**

       .. tag server_services_oc_id

       The **oc-id** service enables OAuth 2.0 authentication to the Chef server by external applications, including Chef Supermarket and Chef Analytics. OAuth 2.0 uses token-based authentication, where external applications use tokens that are issued by the **oc-id** provider. No special credentials---``webui_priv.pem`` or privileged keys---are stored on the external application.

       .. end_tag

     - yes
   * - 8000
     - **opscode-erchef**

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

     - yes
   * -
     - **opscode-expander**

       .. tag server_services_expander

       The **opscode-expander** service is used to process data (pulled from the **rabbitmq** service's message queue) so that it can be properly indexed by the **opscode-solr4** service.

       .. end_tag

     - yes
   * - 8983
     - **opscode-solr4**

       .. tag server_services_solr4

       The **opscode-solr4** service is used to create the search indexes used for searching objects like nodes, data bags, and cookbooks. (This service ensures timely search results via the Chef server API; data that is used by the Chef platform is stored in PostgreSQL.)

       .. end_tag

     -
   * - 5432
     - **postgresql**

       .. tag server_services_postgresql

       The **postgresql** service is used to store node, object, and user data.

       .. end_tag

     - yes
   * - 5672, 15672
     - **rabbitmq**

       .. tag server_services_rabbitmq

       The **rabbitmq** service is used to provide the message queue that is used by the Chef server to get search data to Apache Solr so that it can be indexed for search. When Chef Analytics is configured, the **rabbitmq** service is also used to send data from the Chef server to the Chef Analytics server.

       .. end_tag

     - yes
   * - 16379
     - **redis_lb**

       .. tag server_services_redis

       Key-value store used in conjunction with Nginx to route requests and populate request data used by the Chef server.

       .. end_tag

     - yes
   * - 7788-7799
     - DRBD This port range must be open between all back end servers in a high availability configuration that uses DRBD.
     -

.. end_tag

Frontend
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. tag server_firewalls_and_ports_fe

For front-end servers, ensure that ports marked as external (marked as ``yes`` in the **External** column) are open and accessible via any firewalls that are in use:

.. list-table::
   :widths: 60 420 60
   :header-rows: 1

   * - Port
     - Service Name, Description
     - External
   * - 80, 443, 9683
     - **nginx**

       .. tag server_services_nginx

       The **nginx** service is used to manage traffic to the Chef server, including virtual hosts for internal and external API request/response routing, external add-on request routing, and routing between front- and back-end components.

       .. end_tag

       .. note:: Port 9683 is used to internally load balance the **oc_bifrost** service.
     - yes
   * - 9463
     - **oc_bifrost**

       .. tag server_services_bifrost

       The **oc_bifrost** service ensures that every request to view or manage objects stored on the Chef server is authorized.

       .. end_tag

     -
   * - 9090
     - **oc-id**

       .. tag server_services_oc_id

       The **oc-id** service enables OAuth 2.0 authentication to the Chef server by external applications, including Chef Supermarket and Chef Analytics. OAuth 2.0 uses token-based authentication, where external applications use tokens that are issued by the **oc-id** provider. No special credentials---``webui_priv.pem`` or privileged keys---are stored on the external application.

       .. end_tag

     -
   * - 8000
     - **opscode-erchef**

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

     -

.. end_tag

GRE Tunnels
-----------------------------------------------------
.. tag install_server_ha_drbd_gre_tunnels

.. warning:: This option is sometimes necessary when the Chef server is configured for high availability using DRBD.

Occasionally, a GRE tunnel will be required to handle the VRRP traffic. To accomplish this, set the following in ``/var/opt/opscode/keepalived/bin/tunnel.sh`` on the back-end server that will be used for bootstrapping:

.. code-block:: bash

   #!/bin/sh
   ip tunnel add pc mode gre remote VRRP_IP_OF_PEER local MY_IP ttl 25
   ip link set pc up
   ip addr add 172.18.16.1 dev pc
   ip route add 172.18.16.0/24 dev pc

Replace ``VRRP_IP_OF_PEER`` with the IP address of the server on the other end of the tunnel, and ``MY_IP`` with the IP address of the server on which the script will be located.

The ``172.17.16.**`` network addresses used in the previous examples could be any unused reserved IP address space.

Set the following in ``/etc/opscode/chef-server.rb``:

.. code-block:: ruby

   backend_vip "192.168.141.108",
     :ipaddress => "192.168.141.108",
     :device => "eth0"

And set the Keepalived unicast addresses to the GRE tunnel addresses.

.. end_tag

