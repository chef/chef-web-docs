.. THIS PAGE DOCUMENTS Enterprise Chef server version 11.2

=====================================================
Firewalls and Ports
=====================================================

The ports that should be open depend on how the Enterprise Chef is deployed---standalone, high availability, front and back end servers. Refer to the operating system's manual or site systems administrators for instructions on how to enable changes to ports, if necessary.

Standalone
=====================================================
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

Front End
=====================================================
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

Back End
=====================================================
For back end servers in an Enterprise Chef installation:

.. list-table::
   :widths: 60 420 60
   :header-rows: 1

   * - Port
     - Service
     - External
   * - 5984
     - **couchdb**
     - yes
   * - 8983
     - **opscode-solr**
     - yes
   * - 5432
     - **postgresql**
     - yes
   * - 5672
     - **rabbitmq**
     - yes
   * - 16379
     - **redis_lb**
     - yes
   * - 4321
     - **bookshelf**
     - yes
   * - 4369
     - **opscode-org-creator**
     - no
   * - 7788-7799
     - DRBD This port range must be open between all back end servers.
     - no

Loopback Interface
=====================================================
A single loopback interface should be configured using the ``127.0.0.1`` address. This ensures that all of the services are available to the Chef server, in the event that the Chef server attempts to contact itself from within a front or back end machine. All ports should be accessible through the loopback interface of their respective hosts.
