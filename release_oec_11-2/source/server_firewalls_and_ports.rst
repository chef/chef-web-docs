.. THIS PAGE DOCUMENTS Enterprise Chef server version 11.2

=====================================================
Firewalls and Ports
=====================================================

The ports that should be open depend on how the |chef server oec| is deployed---standalone, high availability, front and back end servers. Refer to the operating system's manual or site systems administrators for instructions on how to enable changes to ports, if necessary.

Standalone
=====================================================
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

Front End
=====================================================
For front end servers in an |chef server oec| installation:

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

Back End
=====================================================
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
=====================================================
A single loopback interface should be configured using the ``127.0.0.1`` address. This ensures that all of the services are available to the |chef server|, in the event that the |chef server| attempts to contact itself from within a front or back end machine. All ports should be accessible through the loopback interface of their respective hosts.
