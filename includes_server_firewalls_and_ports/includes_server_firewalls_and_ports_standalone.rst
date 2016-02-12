.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

For a standalone installation, ensure that ports marked as external (marked as ``yes`` in the **External** column) are open and accessible via any firewalls that are in use:

.. list-table::
   :widths: 60 420 60
   :header-rows: 1

   * - Port
     - Service Name, Description
     - External
   * - 4321
     - |service bookshelf|

       .. include:: ../../includes_server_services/includes_server_services_bookshelf.rst
     - no
   * - 80, 443, 9683
     - |service nginx|

       .. include:: ../../includes_server_services/includes_server_services_nginx.rst

       .. note:: Port 9683 is used to internally load balance the |service bifrost| service.
     - yes
   * - 9463
     - |service bifrost|

       .. include:: ../../includes_server_services/includes_server_services_bifrost.rst
     - 
   * - 9090
     - |service ocid|

       .. include:: ../../includes_server_services/includes_server_services_oc_id.rst
     - 
   * - 8000
     - |service erchef|

       .. include:: ../../includes_server_services/includes_server_services_erchef.rst
     - 
   * - 8983
     - |service solr4|

       .. include:: ../../includes_server_services/includes_server_services_solr4.rst
     - 
   * - 5432
     - |service postgresql|

       .. include:: ../../includes_server_services/includes_server_services_postgresql.rst
     - 
   * - 5672
     - |service rabbitmq|

       .. include:: ../../includes_server_services/includes_server_services_rabbitmq.rst
     - 
   * - 16379
     - |service redis_lb|

       .. include:: ../../includes_server_services/includes_server_services_redis.rst
     - 
