

=====================================================
Server Tuning
=====================================================

.. tag server_tuning_12

The server configuration file contains a list of all configuration options that are available for the Chef server. Some of these values should be modified for large-scale installations.

.. end_tag

.. note:: .. tag notes_enterprise_chef_tuning

          This topic contains general information about how settings can be tuned. In many cases, this topic suggests specific values to be used for tuning. That said, every organization and configuration is different, so please don't hesitate to contact Chef support to discuss your tuning effort so as to help ensure the right value is identified for any particular setting.

          .. end_tag

Customize the Config File
=====================================================
.. tag config_rb_chef_server_enterprise_2

The private-chef.rb file contains all of the non-default configuration settings used by the Enterprise Chef server. (The default settings are built-in to the Chef server configuration and should only be added to the private-chef.rb file to apply non-default values.) These configuration settings are processed when the ``private-chef-ctl reconfigure`` command is run, such as immediately after setting up the Enterprise Chef server or after making a change to the underlying configuration settings after the server has been deployed. The private-chef.rb file is a Ruby file, which means that conditional statements can be used in the configuration file.

.. end_tag

Use Conditions
-----------------------------------------------------
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
The following settings are typically added to the private-chef.rb file:

.. list-table::
   :widths: 200 300
   :header-rows: 1

   * - Setting
     - Description
   * - ``api_fqdn``
     - The FQDN for the Chef server. This setting is not in the private-chef.rb file by default. When added, its value should be equal to the FQDN for the service URI used by the Chef server. Then configure the same value for the ``bookshelf['vip']`` setting prior to installing Enterprise Chef. For example: ``api_fqdn "chef.example.com"``.
   * - ``bookshelf['vip']``
     - The virtual IP address. Default value: ``node['fqdn']``. (This setting is related to the **bookshelf** service.)
   * - ``bootstrap``
     - Default value: ``true``.
   * - ``notification_email``
     - Default value: ``info@example.com``.

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
The following settings are often used to for performance tuning of Enterprise Chef in larger installations.

.. note:: When changes are made to the private-chef.rb file the Enterprise Chef must be reconfigured by running the ``private-chef-ctl reconfigure`` command.

bookshelf
-----------------------------------------------------
.. tag server_tuning_bookshelf

The following setting is often modified from the default as part of the tuning effort for the **bookshelf** service:

``bookshelf['vip']``
   The virtual IP address. Default value: ``node['fqdn']``.

.. end_tag

opscode-account
-----------------------------------------------------
.. tag server_tuning_account

The following setting is often modified from the default as part of the tuning effort for the **opscode-account** service:

``opscode_account['worker_processes']``
   The number of allowed worker processes. This value should be increased if requests made to the **opscode-account** service are timing out, but only if the front-end machines have available CPU and RAM. Default value: ``4``.

.. end_tag

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

opscode-expander
-----------------------------------------------------
.. tag server_tuning_expander

The following setting is often modified from the default as part of the tuning effort for the **opscode-expander** service:

``opscode_expander['nodes']``
   The number of allowed worker processes. The **opscode-expander** service runs on the back-end and feeds data to the **opscode-solr** service, which creates and maintains search data used by the Chef server. Additional memory may be required by these worker processes depending on the frequency and volume of chef-client runs across the organization, but only if the back-end machines have available CPU and RAM. Default value: ``2``.

.. end_tag

opscode-solr
-----------------------------------------------------
The following settings are often modified from the default as part of the tuning effort for the **opscode-solr** service:

.. list-table::
   :widths: 200 300
   :header-rows: 1

   * - Setting
     - Description
   * - ``opscode_solr['heap_size']``
     - The amount of memory (in MBs) available to Apache Solr. If there is not enough memory available, search queries made by nodes to Apache Solr may fail. The amount of memory that must be available also depends on the number of nodes in the organization, the frequency of search queries, and other characteristics that are unique to each organization. In general, as the number of nodes increases, so does the amount of memory.

       If Apache Solr is running out of memory, the ``/var/log/opscode/opscode-solr/current`` log file will contain ``SEVERE: java.lang.OutOfMemoryError: Java heap space``.

       The default value should work for many organizations with fewer than 25 nodes. Suggested value: ``256`` per every 25 nodes. For example, an organization with 300 nodes, this value should be set to ``3072``.
   * - ``opscode_solr['max_field_length']``
     - The maximum field length (in number of tokens/terms). If a field length exceeds this value, Apache Solr may not be able to complete building the index. Default value: ``100000`` (increased from the Apache Solr default value of ``10000``).

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

opscode-webui
-----------------------------------------------------
.. tag server_tuning_webui

The following setting is often modified from the default as part of the tuning effort for the **opscode-webui** service:

``opscode_webui['worker_processes']``
   The number of allowed worker processes. This setting should be increased or decreased based on the number of users in an organization who use the Chef server web user interface. The default value is ``2``.

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

