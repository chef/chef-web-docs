.. THIS PAGE DOCUMENTS Enterprise Chef server version 11.0

=====================================================
Standalone
=====================================================

The standalone installation of the Chef server creates a working installation on a single server. This installation is also useful when you are installing the Chef server in a virtual machine, for proof-of-concept deployments, or as a part of a development or testing loop.

System Requirements
=====================================================
A standalone installation scenario has the following system requirements:

* 4 total cores, 2.0 GHz AMD 41xx/61xx or Intel Xeon 5000/E5 CPUs or faster
* 4 GB of RAM
* 5 GB of free disk space in ``/opt``
* 5 GB of free disk space in ``/var``

Firewalls
-----------------------------------------------------
For a standalone Enterprise Chef installation, and if host-based firewalls (iptables, ufw, etc.) are being used, ensure that the following ports are open:

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
   * - 4369
     - **opscode-org-creator**
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
   * - 5984
     - **couchdb**
     - no
   * - 8983
     - **opscode-solr**
     - no
   * - 5432
     - **postgresql**
     - no
   * - 5672
     - **rabbitmq**
     - no
   * - 16379
     - **redis_lb**
     - no
   * - 4321
     - **bookshelf**
     - no

Loopback Interface
+++++++++++++++++++++++++++++++++++++++++++++++++++++
A single loopback interface should be configured using the ``127.0.0.1`` address. This ensures that all of the services are available to the Chef server, in the event that the Chef server attempts to contact itself from within a machine. For proper functioning, all of the ports listed should be accessible through the loopback interface.

Hostnames, FQDNs
-----------------------------------------------------
The hostname for the Chef server must be a FQDN, including the domain suffix, and must be resolvable. See `Hostnames, FQDNs <https://docs.chef.io/install_server_pre.html#hostnames>`__ for more information.

Add Package to Server
=====================================================
Upload the package provided to the server on which Enterprise Chef will be installed, and then record its location on the file system. The rest of this section assumes this location is in ``/tmp`` directory.

Install the Package
=====================================================
Install the Enterprise Chef package on the server, using the name of the package provided by Chef. For Red Hat and CentOS 6:

.. code-block:: bash

   $ rpm -Uvh /tmp/private-chef-full-1.0.0–1.x86_64.rpm

For Ubuntu:

.. code-block:: bash

   $ dpkg -i /tmp/private-chef-full_1.0.0–1_amd64.deb

Configure
=====================================================
Enterprise Chef is now installed on your server, but is not configured for use. To configure it for a standalone installation, simply run:

.. code-block:: bash

   $ private-chef-ctl reconfigure

This command may take several minutes to run, during which the output of the Chef run that is configuring your new Enterprise Chef installation is shown. When it is complete, you will see:

.. code-block:: bash

   Chef Server Reconfigured!

.. note:: Enterprise Chef is composed of many different services, which work together to create a functioning system. One outcome is that it can take a few minutes for the system to finish starting up. One way to tell that the system is fully ready is to use the top command. You will notice high CPU utilization for several Ruby processes while the system is starting up. When that utilization drops off, the system is ready.

Success!
=====================================================
Congratulations, a standalone Enterprise Chef server is installed.
