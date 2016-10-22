=====================================================
System Requirements
=====================================================

Before installing Chef:

* Ensure that each machine that will be a node is running a :doc:`platform </platforms>`
* Ensure that the machine that will run the Chef server is sufficiently powerful
* Ensure that any network and firewall settings are configured correctly

Install and configure the Chef server, then install and configure a workstation, and then run the bootstrap command from the workstation to install the chef-client on each node.

chef-client
=====================================================
In addition:

* The recommended amount of RAM available to the chef-client during a chef-client run is 512MB
* The chef-client binaries are stored in the ``/opt/chef`` directory, which requires a minimum of 200MB of disk space
* The chef-client caches to ``/var/chef/cache`` during the chef-client run. This is the location in which downloaded cookbooks, packages required by those cookbooks, and other large files are stored. This directory requires enough space to save all of this data and should be generously sized. 5GB is a safe number, as a starting point, but tune the size of ``/var/chef/cache`` as necessary
* Each node and workstation must have access to the Chef server via HTTPS. If you have a proxy, :doc:`read about how to configure </proxies>` the chef-client for that proxy.
* Ruby 2.2.2 (or higher). In general, using the version of Ruby that is installed by the omnibus installer is recommended
* The hosted Chef server is compatible with chef-client version 0.10.0 and greater; older clients must be upgraded before they can connect to Hosted Chef

The Chef Server
=====================================================
The following sections describe the various requirements for the Chef server.

Hosted Chef Server
-----------------------------------------------------
The hosted Chef server has the following requirements:

* **Browser** --- Firefox, Google Chrome, Safari, or Internet Explorer (versions 9 or better)
* Every node that will be configured by the chef-client and every workstation that will upload data to the Chef server must be able to communicate with the hosted Chef server

Chef Server, On-premises
-----------------------------------------------------
All machines in a Chef server deployment (including a standalone Chef Analytics machine) have the following requirements.

For all deployments:

* 64-bit architecture

For a standalone deployment:

* 4 total cores, 2.0 GHz AMD 41xx/61xx or Intel Xeon 5000/E5 CPUs
* 4 GB of RAM; 8 GB of RAM for Chef Analytics
* 5 GB of free disk space in ``/opt``
* 5 GB of free disk space in ``/var``

For a tiered deployment:

* 8 total cores 2.0 GHz AMD 41xx/61xx or Intel Xeon 5000/E5 CPUs or faster
* 16GB RAM
* 2 x 300GB SAS RAID1 drives
* Hardware RAID card
* 1 GigE NIC interface
* 20 GB of free disk space in ``/opt``
* 40 GB of free disk space in ``/var``
* A back-end server; all other systems will be front-end servers.

For a high availability deployment:

* 8 total cores 2.0 GHz AMD 41xx/61xx or Intel Xeon 5000/E5 CPUs or faster
* 16GB RAM
* 2 x 300GB SAS RAID1 drives
* Hardware RAID card
* 1 x GigE NIC interface
* 20 GB of free disk space in ``/opt``
* 40 GB of free disk space in ``/var``
* Two back-end servers; as many front-end servers as required.

.. note:: Front end machines, when load balanced, may have fewer than 4 cores and 4 GB of RAM.

.. warning:: The Chef server MUST NOT use a network file system of any type---virtual or physical---for backend storage. The Chef server database operates quickly. The behavior of operations, such as the writing of log files, will be unpredictable when run over a network file system.

.. tag system_requirements_server_etc

Before installing the Chef server, ensure that each machine has the following installed and configured properly:

* **Hostnames** --- Ensure that all systems have properly configured hostnames. The hostname for the Chef server must be a FQDN, including the domain suffix, and must be resolvable. See `Hostnames, FQDNs <https://docs.chef.io/install_server_pre.html#hostnames>`_ for more information
* **FQDNs** --- Ensure that all systems have a resolvable FQDN
* **NTP** --- Ensure that every server is connected to NTP; the Chef server is sensitive to clock drift
* **Mail Relay** --- The Chef server uses email to send notifications for various events; a local mail transfer agent should be installed and available to the Chef server
* **cron** --- Periodic maintenance tasks are performed using cron
* **git** --- git must be installed so that various internal services can confirm revisions
* **libfreetype and libpng** --- These libraries are required
* **Apache Qpid** --- This daemon must be disabled on CentOS and Red Hat systems
* **Required users** --- If the environment in which the Chef server will run has restrictions on the creation of local user and group accounts, ensure that the correct users and groups exist before reconfiguring
* **Firewalls and ports** --- If host-based firewalls (iptables, ufw, etc.) are being used, ensure that ports 80 and 443 are open. These ports are used by the **nginx** service
* **Hostname** --- The hostname for the Chef server must be a FQDN, including the domain suffix, and must be resolvable. See `Hostnames, FQDNs <https://docs.chef.io/install_server_pre.html#hostnames>`_ for more information

In addition:

* **Browser** --- Firefox, Google Chrome, Safari, or Internet Explorer (versions 9 or better)
* **chef-client communication with the Chef server** Every node that will be configured by the chef-client and every workstation that will upload data to the Chef server must be able to communicate with the Chef server

.. end_tag

Chef DK
=====================================================
The Chef development kit has the same requirements as the chef-client.
