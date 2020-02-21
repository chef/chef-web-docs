=====================================================
Tiered Installation
=====================================================
`[edit on GitHub] <https://github.com/chef/chef-web-docs/blob/master/chef_master/source/install_server_tiered.rst>`__

This topic describes how to set up the Chef Infra Server with a single back end and multiple load-balanced frontend servers.

.. image:: ../../images/chef_server_tiered.png

Prerequisites
=====================================================
Before installing the Chef Infra Server software, perform the following steps:

* The backend server must be accessible from each frontend server. A virtual IP address is created and managed by the Chef Infra Server, but will also need to be added to the DNS so that all machines in the tiered configuration may access it.
* Persistent data on the backend Chef Infra Server is primarily composed of cookbook files and directories. Separate disks should be dedicated entirely to storing this data prior to installing the Chef Infra Server.
* Load-balancing should be used with frontend servers, along with a DNS entry for the virtual IP address used for load balancing. This virtual IP address is added to the chef-server.rb file as the ``api_fqdn``.
* All required ports must be open. See the Firewalls section (below) for the list of ports. All connections to and from the Chef Infra Server are accomplished via TCP. Refer to the operating system's manual or your systems administrators for instructions on how to configure to ports, if necessary.
* The hostname for the Chef Infra Server must be an FQDN, including the domain suffix, and must be resolvable by the backend and frontend servers. See `Hostnames, FQDNs </install_server_pre.html#hostnames>`_ for more information.
* ``chef-server-ctl reconfigure`` will not bind the ``backend_vip`` to the backend server. The easiest thing to do is just define ``backend_vip`` as the already configured main IP address of the backend system. If you need to use an additional address, it will need to be configured and bound on the system before ``chef-server-ctl reconfigure`` is run.

Basic Hardware Requirements
=====================================================
For a tiered deployment, your backend server should support the following hardware requirements:

* 64-bit architecture
* 8 total cores (physical or virtual)
* 16GB RAM
* Fast, redundant storage (SSD/RAID-based solution)

  * 50 GB/backend server (SSD if on premises, Premium Storage in Microsoft Azure, EBS-Optimized GP2 in AWS)

* 1 GigE NIC interface
* A back-end server; all other systems will be front-end servers.

Disk Configuration
=====================================================
Persistent data on the backend server of the Chef Infra Server is primarily composed of cookbook files and directories. Separate disks should be dedicated entirely to storing this data prior to installing the Chef Infra Server. These disks should be part of a SSD or hardware RAID-based solution that ensure redundancy and high IOPS. This configuration guide assumes that:

* ~50GB of raw, unpartitioned disk space is available. Disk space should scale up with the number of nodes that the backend server is managing. A good rule to follow is to allocate 2 MB per node.
* The disk space presents as a single device. For example: ``/dev/sdb``.
* The storage is added to a volume group named ``opscode`` and is presented to the Chef Infra Server by mounting on ``/var/opt/opscode`` before a reconfiguration

The following commands properly set up disk configuration on the backend server:

.. code-block:: bash

   pvcreate /dev/sdb

and:

.. code-block:: bash

   vgcreate opscode /dev/sdb

and:

.. code-block:: bash

   lvcreate -l 80%VG -n tiered opscode

Mount Storage Device
-----------------------------------------------------
To build and mount the storage device on the backend server, do the following:

#. Create the file system. For example, an ``ext4`` type named ``tiered``:

   .. code-block:: bash

      mkfs.ext4 /dev/opscode/tiered

   then:

   .. code-block:: bash

      mkdir -p /var/opt/opscode

   and then:

   .. code-block:: bash

      mount /dev/opscode/tiered /var/opt/opscode

Backend
=====================================================
Use the following steps to set up the backend Chef Infra Server:

#. Download the packages from https://downloads.chef.io/chef-server/. For Red Hat and CentOS 6:

   .. code-block:: bash

      rpm -Uvh /tmp/chef-server-core-<version>.rpm

   For Ubuntu:

   .. code-block:: bash

      dpkg -i /tmp/chef-server-core-<version>.deb

   After a few minutes, the Chef Infra Server will be installed.

#. Create a file named chef-server.rb that is located in the ``/etc/opscode/`` directory. See the chef-server.rb section below for an example of the settings and values that are required.

chef-server.rb
=====================================================
The chef-server.rb file that is located in the ``/etc/opscode/`` directory describes the topology of the tiered configuration. On the backend server, create a file named chef-server.rb and save it in the ``/etc/opscode/`` directory.

Add the following settings to the chef-server.rb file:

#. Define the topology type:

   .. code-block:: ruby

      topology "tier"

#. Define the backend server:

   .. code-block:: ruby

      server "FQDN",
        :ipaddress => "IP_ADDRESS",
        :role => "backend",
        :bootstrap => true

   Replace ``FQDN`` with the FQDN of the server and ``IP_ADDRESS`` with the IP address of the server. The role is a backend server is ``"backend"``.

#. Define the backend virtual IP address:

   .. code-block:: ruby

      backend_vip "FQDN",
        :ipaddress => "IP_ADDRESS",
        :device => "eth0"

   Replace ``FQDN`` with the FQDN of the server. Replace ``IP_ADDRESS`` with the virtual IP address of the server. The ``:device`` parameter should be the ethernet interface to which the virtual IP address will bind. This is typically the public interface of the server. In a typical tiered install, the config here could also be just the main FQDN and IP address that are already configured for the backend. Running ``chef-server-ctl reconfigure`` will not bind the ``backend_vip`` address to an interface, this must be done on startup of the machine.

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

   Replace ``FQDN`` with the FQDN of the load balanced virtual IP address, which should be equal to the FQDN for the service URI that is used by the Chef Infra Server.

#. .. tag install_chef_server_reconfigure

   .. This topic is hooked in globally to install topics for Chef Infra Server applications.

   Reconfigure the Chef Infra Server and the Chef management console (standalone and frontend group members
     of a High Availabilty installation):

   .. code-block:: bash

      chef-server-ctl reconfigure

   .. end_tag

Frontend
=====================================================
For each frontend server, use the following steps to set up the Chef Infra Server:

#. Install the Chef Infra Server package. For Red Hat and CentOS 6:

   .. code-block:: bash

      rpm -Uvh /tmp/chef-server-core-<version>.rpm

   For Ubuntu:

   .. code-block:: bash

      dpkg -i /tmp/chef-server-core-<version>.deb

   After a few minutes, the Chef Infra Server will be installed.

#. Create the ``/etc/opscode/`` directory, and then copy the entire contents of the ``/etc/opscode`` directory from the primary backend server, including all certificates and the chef-server.rb file.

#. .. tag install_chef_server_reconfigure

   .. This topic is hooked in globally to install topics for Chef Infra Server applications.

   Reconfigure the Chef Infra Server and the Chef management console (standalone and frontend group members
     of a High Availabilty installation):

   .. code-block:: bash

      chef-server-ctl reconfigure

   .. end_tag

#. .. This topic is hooked in globally to install topics for Chef Infra Server applications.

   Start the Chef Infra Server:

   .. code-block:: bash

      chef-server-ctl start



On a single frontend server, create an administrator and an organization:

#. .. tag ctl_chef_server_user_create_admin

   Run the following command to create an administrator:

   .. code-block:: bash

      sudo chef-server-ctl user-create USER_NAME FIRST_NAME LAST_NAME EMAIL 'PASSWORD' --filename FILE_NAME

   An RSA private key is generated automatically. This is the user's private key and should be saved to a safe location. The ``--filename`` option will save the RSA private key to the specified absolute path.

   For example:

   .. code-block:: bash

      sudo chef-server-ctl user-create janedoe Jane Doe janed@example.com 'abc123' --filename /path/to/janedoe.pem

   .. end_tag

#. .. tag ctl_chef_server_org_create_summary

   Run the following command to create an organization:

   .. code-block:: bash

      sudo chef-server-ctl org-create short_name 'full_organization_name' --association_user user_name --filename ORGANIZATION-validator.pem

   For example:

   .. code-block:: bash

      sudo chef-server-ctl org-create 4thcoffee 'Fourth Coffee, Inc.' --association_user janedoe --filename /path/to/4thcoffee-validator.pem

   The name must begin with a lower-case letter or digit, may only contain lower-case letters, digits, hyphens, and underscores, and must be between 1 and 255 characters. For example: ``4thcoffee``.

   The full name must begin with a non-white space character and must be between 1 and 1023 characters. For example: ``'Fourth Coffee, Inc.'``.

   The ``--association_user`` option will associate the ``user_name`` with the ``admins`` security group on the Chef Infra Server.

   An RSA private key is generated automatically. This is the chef-validator key and should be saved to a safe location. The ``--filename`` option will save the RSA private key to the specified absolute path.

   .. end_tag

Enable Features
=====================================================
Enable additional features of the Chef Infra Server! The packages may be downloaded directly as part of the installation process or they may be first downloaded to a local directory, and then installed.

**Use Downloads**

The ``install`` subcommand downloads packages from https://packages.chef.io/ by default. For systems that are not behind a firewall (and have connectivity to https://packages.chef.io/), the Chef management console package can be installed as described below:

Chef Manage
   Use Chef management console to manage data bags, attributes, run-lists, roles, environments, and cookbooks from a web user interface.

   On each front end server in the Chef Infra Server configuration, run:

   .. code-block:: bash

      chef-server-ctl install chef-manage

   then:

   .. code-block:: bash

      chef-server-ctl reconfigure

   and then:

   .. code-block:: bash

      chef-manage-ctl reconfigure

   To accept the `Chef MLSA </chef_license.html>`__:

   .. code-block:: bash

      sudo chef-manage-ctl reconfigure --accept-license

   This updates the Chef Infra Server and creates the ``/etc/opscode-manage/secrets.rb`` file. When running the Chef management console 1.11 (or higher), copy the ``secrets.rb`` file in the ``/etc/opscode-manage`` directory on one of the frontend servers to the same directory on each of the other frontend servers, and then rerun ``chef-manage-ctl reconfigure`` so the copied ``/etc/opscode-manage/secrets.rb`` file gets used correctly.

**Use Local Packages**

.. tag ctl_chef_server_install_features_manual

The ``install`` subcommand is used to install premium features of the Chef server: Chef management console(``chef-manage``) and push jobs(``opscode-push-jobs-server``).

.. code-block:: bash

   sudo chef-server-ctl install PACKAGE_NAME --path /path/to/package/directory

For example:

.. code-block:: bash

   sudo chef-server-ctl install chef-manage --path /root/packages

The ``chef-server-ctl`` command will install the first ``chef-manage`` package found in the ``/root/packages`` directory.

.. end_tag

Reference
=====================================================
The following sections show an example chef-server.rb file and a list of the ports that are required by the Chef Infra Server.

chef-server.rb
-----------------------------------------------------
A completed chef-server.rb configuration file for a four server tiered Chef Infra Server configuration, consisting of:

.. list-table::
   :widths: 100 150 150
   :header-rows: 1

   * - FQDN
     - Real IP Address
     - Role
   * - be1.example.com
     - 192.0.2.0
     - backend
   * - fe1.example.com
     - 192.168.4.2
     - frontend
   * - fe2.example.com
     - 192.168.4.3
     - frontend
   * - fe3.example.com
     - 192.168.4.4
     - frontend
   * - chef.example.com
     -
     - load balanced frontend VIP
   * - be.example.com
     - 192.168.4.7
     - load balanced backend VIP

Looks like this:

.. code-block:: ruby

   topology "tier"

   server "be1.example.com",
     :ipaddress => "192.0.2.0",
     :role => "backend",
     :bootstrap => true

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

Firewalls
-----------------------------------------------------
.. tag server_firewalls_and_ports_summary

All of the ports used by the Chef Infra Server are TCP ports. Refer to the operating system's manual or site systems administrators for instructions on how to enable changes to ports, if necessary.

.. end_tag

.. tag server_firewalls_and_ports_listening

All services must be listening on the appropriate ports. Most monitoring systems provide a means of testing whether a given port is accepting connections and service-specific tools may also be available. In addition, the generic system tool Telnet can also be used to initiate the connection:

.. code-block:: bash

   telnet HOST_NAME PORT

.. end_tag

.. tag server_firewalls_and_ports_loopback

A single loopback interface should be configured using the ``127.0.0.1`` address. This ensures that all of the services are available to the Chef Infra Server, in the event that the Chef Infra Server attempts to contact itself from within a front or back end machine. All ports should be accessible through the loopback interface of their respective hosts.

.. end_tag

Backend
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. tag server_firewalls_and_ports_tiered

For back-end servers in a tiered Chef Infra Server installation, ensure that ports marked as external (marked as ``yes`` in the **External** column) are open and accessible via any firewalls that are in use:

.. list-table::
   :widths: 60 420 60
   :header-rows: 1

   * - Port
     - Service Name, Description
     - External
   * - 80, 443, 9683
     - **nginx**

       .. tag server_services_nginx

       The **nginx** service is used to manage traffic to the Chef Infra Server, including virtual hosts for internal and external API request/response routing, external add-on request routing, and routing between front- and back-end components.

       .. end_tag

       .. note:: Port 9683 is used to internally load balance the **oc_bifrost** service.
     - yes
   * - 9463
     - **oc_bifrost**

       .. tag server_services_bifrost

       The **oc_bifrost** service ensures that every request to view or manage objects stored on the Chef Infra Server is authorized.

       .. end_tag

     -
   * - 8983
     - **opscode-solr4**

       .. tag server_services_solr4

       The **opscode-solr4** service is used to create the search indexes used for searching objects like nodes, data bags, and cookbooks. (This service ensures timely search results via the Chef Infra Server API; data that is used by the Chef platform is stored in PostgreSQL.)

       .. end_tag

     -
   * - 5432
     - **postgresql**

       .. tag server_services_postgresql

       The **postgresql** service is used to store node, object, and user data.

       .. end_tag

     -
   * - 5672, 15672
     - **rabbitmq**

       .. tag server_services_rabbitmq

       The **rabbitmq** service is used to provide the message queue that is used by the Chef Infra Server to get search data to Apache Solr so that it can be indexed for search.

       .. end_tag

     -
   * - 16379
     - **redis_lb**

       .. tag server_services_redis

       Key-value store used in conjunction with Nginx to route requests and populate request data used by the Chef Infra Server.

       .. end_tag

     -
   * - 4321
     - **bookshelf**

       .. tag server_services_bookshelf

       The **bookshelf** service is an Amazon Simple Storage Service (S3)-compatible service that is used to store cookbooks, including all of the files---recipes, templates, and so on---that are associated with each cookbook.

       .. end_tag

     -
   * - 8000
     - **opscode-erchef**

       .. tag server_services_erchef

       The **opscode-erchef** service is an Erlang-based service that is used to handle Chef Infra Server API requests to the following areas within the Chef Infra Server:

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

       The **nginx** service is used to manage traffic to the Chef Infra Server, including virtual hosts for internal and external API request/response routing, external add-on request routing, and routing between front- and back-end components.

       .. end_tag

       .. note:: Port 9683 is used to internally load balance the **oc_bifrost** service.
     - yes
   * - 9463
     - **oc_bifrost**

       .. tag server_services_bifrost

       The **oc_bifrost** service ensures that every request to view or manage objects stored on the Chef Infra Server is authorized.

       .. end_tag

     -
   * - 9090
     - **oc-id**

       .. tag server_services_oc_id

       The **oc-id** service enables OAuth 2.0 authentication to the Chef Infra Server by external applications, including Chef Supermarket. OAuth 2.0 uses token-based authentication, where external applications use tokens that are issued by the **oc-id** provider. No special credentials---``webui_priv.pem`` or privileged keys---are stored on the external application.

       .. end_tag

     -
   * - 8000
     - **opscode-erchef**

       .. tag server_services_erchef

       The **opscode-erchef** service is an Erlang-based service that is used to handle Chef Infra Server API requests to the following areas within the Chef Infra Server:

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
