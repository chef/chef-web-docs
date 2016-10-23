.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

For back-end servers, ensure that ports marked as external (marked as ``yes`` in the **External** column) are open and accessible via any firewalls that are in use:

.. list-table::
   :widths: 60 420 60
   :header-rows: 1

   * - Port
     - Service Name, Description
     - External
   * - 4321
     - **bookshelf**

       .. include:: ../../includes_server_services/includes_server_services_bookshelf.rst
     - yes
   * - 112
     - **keepalived**

       .. include:: ../../includes_server_services/includes_server_services_keepalived.rst
     - yes
   * - 80, 443, 9683
     - **nginx**

       .. include:: ../../includes_server_services/includes_server_services_nginx.rst

       .. note:: Port 9683 is used to internally load balance the **oc_bifrost** service.
     - yes
   * - 9683
     - **oc_bifrost**

       .. include:: ../../includes_server_services/includes_server_services_bifrost.rst
     - yes
   * - 9090
     - **oc-id**

       .. include:: ../../includes_server_services/includes_server_services_oc_id.rst
     - yes
   * - 8000
     - **opscode-erchef**

       .. include:: ../../includes_server_services/includes_server_services_erchef.rst
     - yes
   * - 
     - **opscode-expander**

       .. include:: ../../includes_server_services/includes_server_services_expander.rst
     - yes
   * - 8983
     - **opscode-solr4**

       .. include:: ../../includes_server_services/includes_server_services_solr4.rst
     - 
   * - 5432
     - **postgresql**

       .. include:: ../../includes_server_services/includes_server_services_postgresql.rst
     - yes
   * - 5672
     - **rabbitmq**

       .. include:: ../../includes_server_services/includes_server_services_rabbitmq.rst
     - yes
   * - 16379
     - **redis_lb**

       .. include:: ../../includes_server_services/includes_server_services_redis.rst
     - yes
   * - 7788-7799
     - DRBD This port range must be open between all back end servers in a high availability configuration that uses DRBD.
     - 
