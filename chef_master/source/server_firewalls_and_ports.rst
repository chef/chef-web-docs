=====================================================
Firewalls and Ports
=====================================================
`[edit on GitHub] <https://github.com/chef/chef-web-docs/blob/master/chef_master/source/server_firewalls_and_ports.rst>`__

.. tag server_firewalls_and_ports_summary

All of the ports used by the Chef server are TCP ports. Refer to the operating system's manual or site systems administrators for instructions on how to enable changes to ports, if necessary.

.. end_tag

.. tag server_firewalls_and_ports_listening

All services must be listening on the appropriate ports. Most monitoring systems provide a means of testing whether a given port is accepting connections and service-specific tools may also be available. In addition, the generic system tool Telnet can also be used to initiate the connection:

.. code-block:: bash

   $ telnet HOST_NAME PORT

.. end_tag

.. note:: An "external" port is external from the perspective of a workstation (such as knife), a machine (the chef-client), or any other user that accesses the Chef server via the Chef server API.

Standalone
=====================================================
The following sections describe the ports that are required by the Chef server in a standalone configuration:

.. image:: ../../images/chef_server_ports_standalone.png

.. tag server_firewalls_and_ports_loopback

A single loopback interface should be configured using the ``127.0.0.1`` address. This ensures that all of the services are available to the Chef server, in the event that the Chef server attempts to contact itself from within a front or back end machine. All ports should be accessible through the loopback interface of their respective hosts.

.. end_tag

For a standalone installation, ensure that ports marked as external (marked as ``yes`` in the **External** column) are open and accessible via any firewalls that are in use:

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

     - no
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

     -
   * - 5672
     - **rabbitmq**

       .. tag server_services_rabbitmq

       The **rabbitmq** service is used to provide the message queue that is used by the Chef server to get search data to Apache Solr so that it can be indexed for search. When Chef Analytics is configured, the **rabbitmq** service is also used to send data from the Chef server to the Chef Analytics server.

       .. end_tag

     -
   * - 16379
     - **redis_lb**

       .. tag server_services_redis

       Key-value store used in conjunction with Nginx to route requests and populate request data used by the Chef server.

       .. end_tag

     -

High Availability
=====================================================
The following sections describe the ports that are required by the Chef server in a high availability configuration that is running DRBD and Keepalived to manage the active/passive backend servers:

.. image:: ../../images/chef_server_ports_ha_drbd.png

.. tag server_firewalls_and_ports_loopback

A single loopback interface should be configured using the ``127.0.0.1`` address. This ensures that all of the services are available to the Chef server, in the event that the Chef server attempts to contact itself from within a front or back end machine. All ports should be accessible through the loopback interface of their respective hosts.

.. end_tag

Front End
-----------------------------------------------------
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

Back End
-----------------------------------------------------
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

Tiered
=====================================================
The following sections describe the ports that are required by the Chef server in a tiered configuration:

.. image:: ../../images/chef_server_ports_tiered.png

.. tag server_firewalls_and_ports_loopback

A single loopback interface should be configured using the ``127.0.0.1`` address. This ensures that all of the services are available to the Chef server, in the event that the Chef server attempts to contact itself from within a front or back end machine. All ports should be accessible through the loopback interface of their respective hosts.

.. end_tag

Front End
-----------------------------------------------------
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

Back End
-----------------------------------------------------
.. tag server_firewalls_and_ports_tiered

For back-end servers in a tiered Chef server installation, ensure that ports marked as external (marked as ``yes`` in the **External** column) are open and accessible via any firewalls that are in use:

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

     -
   * - 5672, 15672
     - **rabbitmq**

       .. tag server_services_rabbitmq

       The **rabbitmq** service is used to provide the message queue that is used by the Chef server to get search data to Apache Solr so that it can be indexed for search. When Chef Analytics is configured, the **rabbitmq** service is also used to send data from the Chef server to the Chef Analytics server.

       .. end_tag

     -
   * - 16379
     - **redis_lb**

       .. tag server_services_redis

       Key-value store used in conjunction with Nginx to route requests and populate request data used by the Chef server.

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

Chef Analytics
=====================================================
The following sections describe the ports that are required by Chef Analytics:

For communication between Chef Analytics and the Chef server, ensure that ports marked as external (``yes``) are open and accessible via any firewalls that are in use:

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
   * - 5672
     - **rabbitmq**

       .. note:: The RabbitMQ port on the Chef server must allow inbound traffic from Chef Analytics.
     - no
   * - 10011
     - actions
     - no
   * - 10012
     - actions_messages
     - no
   * - 10013
     - notifier_config
     - no

Chef Push Jobs
=====================================================
.. tag server_firewalls_and_ports_push_jobs

TCP protocol ports 10000 and 10002. TCP/10000 is the default heartbeat port. TCP/10002 is the command port. It may be configured in the Chef push jobs configuration file . This port allows Chef push jobs clients to communicate with the Chef push jobs server. In a configuration with both front and back ends, this port only needs to be open on the back end servers. The Chef push jobs server waits for connections from the Chef push jobs client, and never initiates a connection to a Chef push jobs client.

.. end_tag

