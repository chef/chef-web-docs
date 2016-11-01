

=====================================================
chef-server.rb Settings
=====================================================

.. tag config_rb_server_8

The chef-server.rb file contains all of the non-default configuration settings used by the Chef server. (The default settings are built-in to the Chef server configuration and should only be added to the chef-server.rb file to apply non-default values.) These configuration settings are processed when the ``chef-server-ctl reconfigure`` command is run, such as immediately after setting up the Chef server or after making a change to the underlying configuration settings after the server has been deployed. The chef-server.rb file is a Ruby file, which means that conditional statements can be used in the configuration file.

.. end_tag

.. note:: .. tag notes_config_rb_server_does_not_exist_by_default

          The chef-server.rb file does not exist by default. To modify the settings for the Chef server, create a file named ``chef-server.rb`` in the ``/etc/opscode/`` directory.

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

.. _config_rb_server-ssl-protocols:

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

.. warning:: Review the full list of :doc:`optional settings </config_rb_server_optional_settings>` that can be added to the chef-server.rb file. Many of these optional settings should not be added without first consulting with Chef support.

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

opscode-solr4
-----------------------------------------------------
.. tag server_tuning_solr

The following sections describe ways of tuning the **opscode-solr4** service to improve performance around large node sizes, available memory, and update frequencies.

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

