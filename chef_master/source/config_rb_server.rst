=====================================================
chef-server.rb Settings
=====================================================
`[edit on GitHub] <https://github.com/chef/chef-web-docs/blob/master/chef_master/source/config_rb_server.rst>`__

.. tag config_rb_server_summary

The ``/etc/opscode/chef-server.rb`` file contains all of the non-default configuration settings used by the Chef server. The default settings are built into the Chef server configuration and should only be added to the ``chef-server.rb`` file to apply non-default values. These configuration settings are processed when the ``chef-server-ctl reconfigure`` command is run. The ``chef-server.rb`` file is a Ruby file, which means that conditional statements can be used within it.

.. end_tag

.. note:: .. tag notes_config_rb_server_was_private_chef_rb

          This file was named private-chef.rb in previous versions of Enterprise Chef. After an upgrade to Chef server 12 from Enterprise Chef, the private-chef.rb file is symlinked to chef-server.rb. The private-chef.rb file is deprecated, starting with Chef server 12.

          .. end_tag

Use Conditions
=====================================================
.. tag config_add_condition

Use a ``case`` statement to apply different values based on whether the setting exists on the front-end or back-end servers. Add code to the server configuration file similar to the following:

.. code-block:: ruby

   role_name = ChefServer["servers"][node['fqdn']]["role"]
   case role_name
   when "backend"
     # backend-specific configuration here
   when "frontend"
     # frontend-specific configuration here
   end

.. end_tag

Recommended Settings
=====================================================
.. tag server_tuning_general

The following settings are typically added to the server configuration file (no equal sign is necessary to set the value):

``api_fqdn``
   The FQDN for the Chef server. This setting is not in the server configuration file by default. When added, its value should be equal to the FQDN for the service URI used by the Chef server. For example: ``api_fqdn "chef.example.com"``.

``bootstrap``
   Default value: ``true``.

``ip_version``
   Use to set the IP version: ``"ipv4"`` or ``"ipv6"``. When set to ``"ipv6"``, the API listens on IPv6 and front end and back end services communicate via IPv6 when a high availability configuration is used. When configuring for IPv6 in a high availability configuration, be sure to set the netmask on the IPv6 ``backend_vip`` attribute. Default value: ``"ipv4"``.

``notification_email``
   Default value: ``info@example.com``.

.. end_tag

SSL Protocols
-----------------------------------------------------
.. tag server_tuning_nginx

The following settings are often modified from the default as part of the tuning effort for the **nginx** service and to configure the Chef server to use SSL certificates:

``nginx['ssl_certificate']``
   The SSL certificate used to verify communication over HTTPS. Default value: ``nil``.

``nginx['ssl_certificate_key']``
   The certificate key used for SSL communication. Default value: ``nil``.

``nginx['ssl_ciphers']``
   The list of supported cipher suites that are used to establish a secure connection. To favor AES256 with ECDHE forward security, drop the ``RC4-SHA:RC4-MD5:RC4:RSA`` prefix. For example:

   .. code-block:: ruby

      nginx['ssl_ciphers'] =  "HIGH:MEDIUM:!LOW:!kEDH: \
                               !aNULL:!ADH:!eNULL:!EXP: \
                               !SSLv2:!SEED:!CAMELLIA: \
                               !PSK"

``nginx['ssl_protocols']``
   The SSL protocol versions that are enabled. SSL 3.0 is supported by the Chef server; however, SSL 3.0 is an obsolete and insecure protocol. Transport Layer Security (TLS)---TLS 1.0, TLS 1.1, and TLS 1.2---has effectively replaced SSL 3.0, which provides for authenticated version negotiation between the chef-client and Chef server, which ensures the latest version of the TLS protocol is used. For the highest possible security, it is recommended to disable SSL 3.0 and allow all versions of the TLS protocol.  For example:

   .. code-block:: ruby

      nginx['ssl_protocols'] = "TLSv1 TLSv1.1 TLSv1.2"

.. note:: See https://wiki.mozilla.org/Security/Server_Side_TLS for more information about the values used with the ``nginx['ssl_ciphers']`` and ``nginx['ssl_protocols']`` settings.

For example, after copying the SSL certificate files to the Chef server, update the ``nginx['ssl_certificate']`` and ``nginx['ssl_certificate_key']`` settings to specify the paths to those files, and then (optionally) update the ``nginx['ssl_ciphers']`` and ``nginx['ssl_protocols']`` settings to reflect the desired level of hardness for the Chef server:

.. code-block:: ruby

   nginx['ssl_certificate'] = "/etc/pki/tls/private/name.of.pem"
   nginx['ssl_certificate_key'] = "/etc/pki/tls/private/name.of.key"
   nginx['ssl_ciphers'] = "HIGH:MEDIUM:!LOW:!kEDH:!aNULL:!ADH:!eNULL:!EXP:!SSLv2:!SEED:!CAMELLIA:!PSK"
   nginx['ssl_protocols'] = "TLSv1 TLSv1.1 TLSv1.2"

.. end_tag

Optional Settings
=====================================================
The following settings are often used for performance tuning of the Chef server in larger installations.

.. note:: .. tag notes_config_rb_server_must_reconfigure

          When changes are made to the chef-server.rb file the Chef server must be reconfigured by running the following command:

          .. code-block:: bash

             $ chef-server-ctl reconfigure

          .. end_tag

.. note:: Review the full list of `optional settings </config_rb_server_optional_settings.html>`__ that can be added to the chef-server.rb file. Many of these optional settings should not be added without first consulting with Chef support.

bookshelf
-----------------------------------------------------
.. tag server_tuning_bookshelf

The following setting is often modified from the default as part of the tuning effort for the **bookshelf** service:

``bookshelf['vip']``
   The virtual IP address. Default value: ``node['fqdn']``.

.. end_tag

.. warning:: .. tag notes_server_aws_cookbook_storage

             To `configure the server for external cookbook storage </server_components.html#aws-settings>`_, updates are made to settings for both the **bookshelf** and **opscode-erchef** services.

             .. end_tag

opscode-account
-----------------------------------------------------
The following setting is often modified from the default as part of the tuning effort for the **opscode-account** service:

``opscode_account['worker_processes']``
   The number of allowed worker processes. This value should be increased if requests made to the **opscode-account** service are timing out, but only if the front-end machines have available CPU and RAM. Default value: ``4``.

opscode-erchef
-----------------------------------------------------
.. tag server_tuning_erchef

The following settings are often modified from the default as part of the tuning effort for the **opscode-erchef** service:

``opscode_erchef['db_pool_size']``
   The number of open connections to PostgreSQL that are maintained by the service. If failures indicate that the **opscode-erchef** service ran out of connections, try increasing the ``postgresql['max_connections']`` setting. If failures persist, then increase this value (in small increments) and also increase the value for ``postgresql['max_connections']``. Default value: ``20``.

``opscode_erchef['s3_url_ttl']``
   The amount of time (in seconds) before connections to the server expire. If chef-client runs are timing out, increase this setting to ``3600``, and then adjust again if necessary. Default value: ``900``.

``opscode_erchef['strict_search_result_acls']``
   .. tag settings_strict_search_result_acls

   Use to specify that search results only return objects to which an actor (user, client, etc.) has read access, as determined by ACL settings. This affects all searches. When ``true``, the performance of the Chef management console may increase because it enables the Chef management console to skip redundant ACL checks. To ensure the Chef management console is configured properly, after this setting has been applied with a ``chef-server-ctl reconfigure`` run ``chef-manage-ctl reconfigure`` to ensure the Chef management console also picks up the setting. Default value: ``false``.

   .. warning:: When ``true``, ``opscode_erchef['strict_search_result_acls']`` affects all search results and any actor (user, client, etc.) that does not have read access to a search result will not be able to view it. For example, this could affect search results returned during chef-client runs if a chef-client does not have permission to read the information.

   .. end_tag

.. end_tag

Data Collector
+++++++++++++++++++++++++++++++++++++++++++++++++++++
The following settings are often modified from the default as part of the tuning effort for the **data_collector** **opscode-erchef** application:

``data_collector['http_max_count']``
   The maximum worker count for the HTTP connection pool that is used by the data collector. If failures indicate that **opscode-erchef** application has run out of HTTP connections for the **data_collector** then increase this value. Default value: `100`.

opscode-expander
-----------------------------------------------------
.. tag server_tuning_expander

The following setting is often modified from the default as part of the tuning effort for the **opscode-expander** service:

``opscode_expander['nodes']``
   The number of allowed worker processes. The **opscode-expander** service runs on the back-end and feeds data to the **opscode-solr** service, which creates and maintains search data used by the Chef server. Additional memory may be required by these worker processes depending on the frequency and volume of chef-client runs across the organization, but only if the back-end machines have available CPU and RAM. Default value: ``2``.

.. end_tag

opscode-solr4
-----------------------------------------------------
.. tag server_tuning_solr

The following sections describe ways of tuning the **opscode-solr4** service to improve performance around large node sizes, available memory, and update frequencies.

.. end_tag

Available Memory
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. tag server_tuning_solr_available_memory

Use the following configuration setting to help ensure that Apache Solr does not run out of memory:

``opscode_solr4['heap_size']``
   The amount of memory (in MBs) available to Apache Solr. If there is not enough memory available, search queries made by nodes to Apache Solr may fail. The amount of memory that must be available also depends on the number of nodes in the organization, the frequency of search queries, and other characteristics that are unique to each organization. In general, as the number of nodes increases, so does the amount of memory.

If Apache Solr is running out of memory, the ``/var/log/opscode/opscode-solr4/current`` log file will contain a message similar to:

.. code-block:: bash

   SEVERE: java.lang.OutOfMemoryError: Java heap space

The default value for ``opscode_solr4['heap_size']`` should work for many organizations, especially those with fewer than 25 nodes. For organizations with more than 25 nodes, set this value to 25% of system memory or ``1024``, whichever is smaller. For very large configurations, increase this value to 25% of system memory or ``4096``, whichever is smaller. This value should not exceed ``8192``.

.. end_tag

Large Node Sizes
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. tag server_tuning_solr_large_node_sizes

The maximum field length setting for Apache Solr should be greater than any expected node object file sizes in order for them to be successfully added to the search index. If a node object file is greater than the maximum field length, the node object will be indexed up to the maximum, but the part of the file past that limit will not be indexed. If this occurs, it will seem as if nodes disappear from the search index. To ensure that large node file sizes are indexed properly, verify the following configuration settings:

``nginx['client_max_body_size']``
   The maximum accepted body size for a client request, as indicated by the ``Content-Length`` request header. When the maximum accepted body size is greater than this value, a ``413 Request Entity Too Large`` error is returned. Default value: ``250m``.

and

``opscode_erchef['max_request_size']``
   When the request body size is greater than this value, a 413 Request Entity Too Large error is returned. Default value: ``1000000``.

to ensure that those settings are not part of the reasons for incomplete indexing, and then update the following setting so that its value is greater than the expected node file sizes:

``opscode_solr4['max_field_length']``
   The maximum field length (in number of tokens/terms). If a field length exceeds this value, Apache Solr may not be able to complete building the index. Default value: ``100000`` (increased from the Apache Solr default value of ``10000``).

Use the ``wc`` command to get the byte count of a large node object file. For example:

.. code-block:: bash

   $ wc -c NODE_NAME.json

and then ensure there is a buffer beyond that value. For example, verify the size of the largest node object file:

.. code-block:: bash

   $ wc -c nodebsp2016.json

which returns ``154516``. Update the ``opscode_solr4['max_field_length']`` setting to have a value greater than the returned value. For example: ``180000``.

If you don't have a node object file available then you can get an approximate size of the node data by running the following command on a node.

.. code-block:: bash

   $ ohai | wc -c

.. end_tag

Update Frequency
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. tag server_tuning_solr_update_frequency

At the end of every chef-client run, the node object is saved to the Chef server. From the Chef server, each node object is then added to the ``SOLR`` search index. This process is asynchronous. By default, node objects are committed to the search index every 60 seconds or per 1000 node objects, whichever occurs first.

When data is committed to the Apache Solr index, all incoming updates are blocked. If the duration between updates is too short, it is possible for the rate at which updates are asked to occur to be faster than the rate at which objects can be actually committed.

Use the following configuration setting to improve the indexing performance of node objects:

``opscode_solr4['commit_interval']``
   The frequency (in seconds) at which node objects are added to the Apache Solr search index. Default value: ``60000`` (every 60 seconds).

``opscode_solr4['max_commit_docs']``
   The frequency (in documents) at which node objects are added to the Apache Solr search index. Default value: ``1000`` (every 1000 documents).

.. end_tag

postgresql
-----------------------------------------------------
.. tag server_tuning_postgresql

The following setting is often modified from the default as part of the tuning effort for the **postgresql** service:

``postgresql['max_connections']``
   The maximum number of allowed concurrent connections. This value should only be tuned when the ``opscode_erchef['db_pool_size']`` value used by the **opscode-erchef** service is modified. Default value: ``350``.

   If there are more than two front end machines in a cluster, the ``postgresql['max_connections']`` setting should be increased. The increased value depends on the number of machines in the front end, but also the number of services that are running on each of these machines.

   * Each front end machine always runs the **oc_bifrost** and **opscode-erchef** services.
   * The Reporting add-on adds the **reporting** service.
   * The Chef push jobs service adds the **push_jobs** service.

   Each of these services requires 25 connections, above the default value.

   Use the following formula to help determine what the increased value should be:

   .. code-block:: ruby

      new_value = current_value + [
                  (# of front end machines - 2) * (25 * # of services)
   			   ]

   For example, if the current value is 350, there are four front end machines, and all add-ons are installed, then the formula looks like:

   .. code-block:: ruby

      550 = 350 + [(4 - 2) * (25 * 4)]

.. end_tag

rabbitmq
-----------------------------------------------------
.. tag server_tuning_rabbitmq

.. note:: Chef Analytics has been replaced by Chef Automate.

The following settings must be modified when the Chef Analytics server is configured as a standalone server:

``rabbitmq['node_ip_address']``
   The bind IP address for RabbitMQ. Default value: ``"127.0.0.1"``.

   Chef Analytics uses the same RabbitMQ service that is configured on the Chef server. When the Chef Analytics server is configured as a standalone server, the default settings for ``rabbitmq['node_ip_address']`` and ``rabbitmq['vip']`` must be updated. When the Chef Analytics server is configured as a standalone server, change this value to ``0.0.0.0``.

``rabbitmq['vip']``
   The virtual IP address. Default value: ``"127.0.0.1"``.

   Chef Analytics uses the same RabbitMQ service that is configured on the Chef server. When the Chef Analytics server is configured as a standalone server, the default settings for ``rabbitmq['node_ip_address']`` and ``rabbitmq['vip']`` must be updated. When the Chef Analytics server is configured as a standalone server, change this value to the backend VIP address for the Chef server.

.. end_tag
