.. THIS PAGE DOCUMENTS Enterprise Chef server version 11.2

=====================================================
Standalone
=====================================================

The standalone installation of the |chef server| creates a working installation on a single server. This installation is also useful when you are installing the |chef server| in a virtual machine, for proof-of-concept deployments, or as a part of a development or testing loop.

System Requirements
=====================================================
A standalone installation scenario has the following system requirements:

* 4 total cores, 2.0 GHz AMD 41xx/61xx or Intel Xeon 5000/E5 CPUs or faster
* 4 GB of RAM
* 5 GB of free disk space in ``/opt``
* 5 GB of free disk space in ``/var``

Firewalls
-----------------------------------------------------
For a standalone |chef server oec| installation, and if host-based firewalls (iptables, ufw, etc.) are being used, ensure that the following ports are open:

.. list-table::
   :widths: 60 420 60
   :header-rows: 1

   * - Port
     - Service
     - External
   * - 80
     - |service nginx|
     - yes
   * - 443
     - |service nginx|
     - yes
   * - 8000
     - |service erchef|
     - no
   * - 5140
     - |service certificate|
     - no
   * - 4369
     - |service orgcreator|
     - no
   * - 9462
     - |service webui|
     - no
   * - 9090
     - |service ocid|
     - no
   * - 9465
     - |service account|
     - no
   * - 9463
     - |service bifrost|
     - no
   * - 9680
     - |api chef server| internal LB port
     - no
   * - 9685
     - |service account| internal LB port
     - no
   * - 9683
     - |service bifrost| internal LB port
     - no
   * - 5984
     - |service couchdb|
     - no
   * - 8983
     - |service solr|
     - no
   * - 5432
     - |service postgresql|
     - no
   * - 5672
     - |service rabbitmq|
     - no
   * - 16379
     - |service redis_lb|
     - no
   * - 4321
     - |service bookshelf|
     - no

Loopback Interface
+++++++++++++++++++++++++++++++++++++++++++++++++++++
A single loopback interface should be configured using the ``127.0.0.1`` address. This ensures that all of the services are available to the |chef server|, in the event that the |chef server| attempts to contact itself from within a machine. For proper functioning, all of the ports listed should be accessible through the loopback interface.

Hostnames, FQDNs
-----------------------------------------------------
The hostname for the |chef server| must be a |fqdn|, including the domain suffix, and must be resolvable. See `Hostnames, FQDNs <https://docs.chef.io/install_server_pre.html#hostnames-fqdns>`__ for more information.

Add Package to Server
=====================================================
Upload the package provided to the server on which |chef server oec| will be installed, and then record its location on the file system. The rest of this section assumes this location is in ``/tmp`` directory.

Install the Package
=====================================================
Install the |chef server oec| package on the server, using the name of the package provided by |company_name|. For |redhat| and |centos| 6:

.. code-block:: bash

   $ rpm -Uvh /tmp/private-chef-full-1.0.0–1.x86_64.rpm

For |ubuntu|:

.. code-block:: bash

   $ dpkg -i /tmp/private-chef-full_1.0.0–1_amd64.deb

Configure
=====================================================
|chef server oec| is now installed on your server, but is not configured for use. To configure it for a standalone installation, simply run:

.. code-block:: bash

   $ private-chef-ctl reconfigure

This command may take several minutes to run, during which the output of the |chef| run that is configuring your new |chef server oec| installation is shown. When it is complete, you will see:

.. code-block:: bash

   Chef Server Reconfigured!

.. note:: |chef server oec| is composed of many different services, which work together to create a functioning system. One outcome is that it can take a few minutes for the system to finish starting up. One way to tell that the system is fully ready is to use the top command. You will notice high CPU utilization for several |ruby| processes while the system is starting up. When that utilization drops off, the system is ready.

Success!
=====================================================
Congratulations, a standalone |chef server oec| server is installed.
