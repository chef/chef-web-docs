.. THIS PAGE DOCUMENTS Enterprise Chef server version 11.2

=====================================================
Scaled Front End
=====================================================

The scaled front end installation allows you to install the Chef server on multiple servers, in order to scale portions of the service horizontally. It does not provide high availability for the back-end data services, but instead relies on the ability to quickly restore the state of the server from a backup or from source code control. Chef generally recommends a High Availability installation rather than a scaled front end installation, whenever possible.

We refer to all the servers in a particular installation of the Chef server as a cluster.

The scaled front end installation consists of multiple front-end servers talking to a single back-end server. This allows for a higher level of concurrency on API requests, while scaling the back-end server vertically to handle the increased I/O load.

System Requirements
=====================================================
A scaled front end installation scenario has the following system requirements:

* 8 total cores 2.0 GHz AMD 41xx/61xx or Intel Xeon 5000/E5 CPUs or faster
* 16GB RAM
* 2 x 300GB SAS RAID1 drives
* Hardware RAID card
* 1 GigE NIC interface
* 20 GB of free disk space in ``/opt``
* 40 GB of free disk space in ``/var``
* A back-end server; all other systems will be front-end servers.

.. note:: While you can certainly run the Chef server on smaller systems, our assumption with the scaled front end installation is that it is intended for production use. The above configuration is rated at 1,500 nodes converging every 5 minutes.

Network Requirements
=====================================================
The Chef server has the following network requirements for a scaled front end installation:

Load Balancing
-----------------------------------------------------
As multiple API front-end servers are being run, provide for a mechanism to load-balancing the requests between them. We recommend using either a hardware or software load-balancer configured for round-robin.

You will want to create a DNS entry for the load balanced virtual IP address, which is used to access the cluster---this is the ``api_fqdn``.

Firewalls
-----------------------------------------------------
For front end servers in an Enterprise Chef installation:

.. list-table::
   :widths: 60 420 60
   :header-rows: 1

   * - Port
     - Service
     - External
   * - 80
     - **nginx**
     - yes
   * - 443
     - **nginx**
     - yes
   * - 8000
     - **opscode-erchef**
     - no
   * - 5140
     - **opscode-certificate**
     - no
   * - 9462
     - **opscode-webui**
     - no
   * - 9090
     - **oc-id**
     - no
   * - 9465
     - **opscode-account**
     - no
   * - 9463
     - **oc_bifrost**
     - no
   * - 9680
     - Chef server API internal LB port
     - no
   * - 9685
     - **opscode-account** internal LB port
     - no
   * - 9683
     - **oc_bifrost** internal LB port
     - no

Loopback Interface
+++++++++++++++++++++++++++++++++++++++++++++++++++++
A single loopback interface should be configured using the ``127.0.0.1`` address. This ensures that all of the services are available to the Chef server, in the event that the Chef server attempts to contact itself from within a machine. For proper functioning, all of the ports listed should be accessible through the loopback interface.

private-chef.rb
-----------------------------------------------------
Each machine in a Chef server cluster has a single configuration file called private-chef.rb. This file describes the topology of the entire cluster. This file lives in ``/etc/opscode/private-chef.rb`` on each server. To change the defaults on a server, use the text editor of your choice to create a file called private-chef.rb.

Configure topology
-----------------------------------------------------
Add the following line to the private-chef.rb configuration file:

.. code-block:: ruby

   topology "tier"

This lets the Chef server know that these servers will be in a horizontally scalable configuration with a single, non-highly-available back-end.

Back-end entries
-----------------------------------------------------
For the server that will be used as a back-end server, add the following to the private-chef.rb file:

.. code-block:: ruby

   server "FQDN",
     :ipaddress => "IPADDRESS",
     :role => "backend",
     :bootstrap => true

Replace ``FQDN`` with the FQDN of the server, and ``IPADDRESS`` with the IP address of the server. The role is ``backend``, and you will be using this server to bootstrap the Chef server installation.

Additionally, this server is used exclusively for the back-end services. Let the Chef server know by adding the following entry to private-chef.rb:

.. code-block:: ruby

   backend_vip "FQDN",
     :ipaddress => "IPADDRESS"

Replace ``FQDN`` with the FQDN of the server, and ``IPADDRESS`` with the IP address of the server.

Front-end entries
-----------------------------------------------------
For each front-end server, add the following to the private-chef.rb file:

.. code-block:: ruby

   server "FQDN",
     :ipaddress => "IPADDRESS",
     :role => "frontend"

Replace ``FQDN`` with the FQDN of the server, and ``IPADDRESS`` with the IP address of the server. The role is ``frontend``.

Set api_fqdn
-----------------------------------------------------
Add the following line to the private-chef.rb config file:

.. code-block:: ruby

   api_fqdn "FQDN"

Replace ``FQDN`` with the FQDN of the load balanced VIP.

Example
-----------------------------------------------------
A completed private-chef.rb configuration file for a four server tiered Chef server cluster, consisting of:

.. list-table::
   :widths: 100 150 150
   :header-rows: 1

   * - FQDN
     - Real IP Address
     - Role
   * - be1.example.com
     - 192.168.4.1
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
     - 192.168.4.5
     - load balanced frontend VIP

Looks like this:

.. code-block:: ruby

   topology "tier"
   
   server "be1.example.com",
     :ipaddress => "192.168.4.1",
     :role => "backend",
     :bootstrap => true
   
   backend_vip "be1.example.com",
     :ipaddress => "192.168.4.1"
   
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
Upload the package provided to the servers you wish to install on, and record its location on the file-system. The rest of this section will assume you uploaded it to the ``/tmp`` directory on each system.

Configure Bootstrap
=====================================================
The following sections describe what is required to configure the bootstrap server.

Add private-chef.rb
-----------------------------------------------------
Copy the private-chef.rb file to ``/etc/opscode/private-chef.rb`` on the bootstrap server.


Configure 
-----------------------------------------------------
To set up the Chef server on your bootstrap server, run:

.. code-block:: bash

   $ private-chef-ctl reconfigure

This command may take several minutes to run, during which you will see the output of the Chef run that is configuring the Chef server installation. When it is complete, you will see:

.. code-block:: bash

   Chef Server Reconfigured!

.. note:: Chef server is composed of many different services, which work together to create a functioning system. One effect is that it can take a few minutes for the system to finish starting up. One way to tell that the system is fully ready is to use the top command. You will notice high CPU utilization for several Ruby processes while the system is starting up. When that utilization drops off, the system is ready.

Configure Front-ends
=====================================================
The following sections describe what is required to configure the front-end servers.

Copy /etc/opscode
-----------------------------------------------------
With the bootstrap complete, you can now populate ``/etc/opscode`` on the front-end servers with the files generated during the bootstrap process. Assuming you are logged in as root on your bootstrap server, something like:

.. code-block:: bash

   $ scp -r /etc/opscode FQDN:/etc

Will copy all the files from the bootstrap server to another system. Replace ``FQDN`` with the FQDN of the system you want to install.

Install package
-----------------------------------------------------
Install the Chef server package on each of the front-end servers. For on Red Hat and CentOS 6:

.. code-block:: bash

   $ rpm -Uvh /tmp/chef-server-core-<version>.rpm

Install the Chef server package on Ubuntu:

.. code-block:: bash

   $ dpkg -i /tmp/chef-server-core-<version>.deb


Reconfigure the Server
-----------------------------------------------------
Run the following command:

.. code-block:: bash

   $ private-chef-ctl reconfigure

Success!
=====================================================
Congratulations, you have installed the Chef server in a scaled front end configuration. Continue with the User Management section of this guide.

