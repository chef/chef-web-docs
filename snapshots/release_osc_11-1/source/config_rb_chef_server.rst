

=====================================================
chef-server.rb
=====================================================

.. tag config_rb_chef_server_2

The chef-server.rb file contains all of the non-default configuration settings used by the Open Source Chef server. (The default settings are built-in to the Chef server configuration and should only be added to the chef-server.rb file to apply non-default values.) These configuration settings are processed when the ``chef-server-ctl reconfigure`` command is run, such as immediately after setting up the Open Source Chef server or after making a change to the underlying configuration settings after the server has been deployed.

.. end_tag

.. note:: The chef-server.rb file does not exist by default. To modify the settings for the Chef server, create a file named ``chef-server.rb`` in the ``/etc/chef-server/`` directory.

Example
=====================================================
The following shows a common starting point for settings in a chef-server.rb:

.. code-block:: ruby

   # /etc/chef-server/chef-server.rb
   # This file is used to configure the chef server. 
   # After making any changes you need to run 'chef-server-ctl reconfigure' for the changes to be implemented
   # For a full list of parameters, see: :doc:`config_rb_chef_server`
   # All examples shown are default values

   # lb['api_fqdn'] = node['fqdn']
   # nginx['enable_non_ssl'] = false
   # chef_server_webui['enable'] = true

Recommended Settings
=====================================================
.. tag server_tuning_osc_general

The following settings are typically added to the chef-server.rb file:

.. list-table::
   :widths: 200 300
   :header-rows: 1

   * - Setting
     - Description
   * - ``api_fqdn``
     - The FQDN for the Chef server. This setting is not in the chef-server.rb file by default. When added, its value should be equal to the FQDN for the service URI used by the Chef server. Then configure the same value for the ``bookshelf['vip']`` setting prior to installing Open Source Chef. For example: ``api_fqdn "chef.example.com"``.
   * - ``bookshelf['vip']``
     - The virtual IP address. Default value: ``node['fqdn']``. (This setting is related to the **bookshelf** service.)
   * - ``bootstrap``
     - Default value: ``true``.
   * - ``notification_email``
     - Default value: ``info@example.com``.
   * - ``topology``
     - Default value: ``standalone``.

.. end_tag

Optional Settings
=====================================================
The following settings are often used for performance tuning of Open Source Chef in larger installations.

.. note:: When changes are made to the chef-server.rb file the Open Source Chef must be reconfigured by running the ``chef-server-ctl reconfigure`` command.

.. warning:: Review the full list of :doc:`optional settings </config_rb_chef_server_optional_settings>` that can be added to the chef-server.rb file. Many of these optional settings should not be added without first consulting with Chef support.

bookshelf
-----------------------------------------------------
.. tag server_tuning_osc_bookshelf

The following setting is often modified from the default as part of the tuning effort for the **bookshelf** service:

.. list-table::
   :widths: 200 300
   :header-rows: 1

   * - Setting
     - Description
   * - ``bookshelf['vip']``
     - The virtual IP address. Default value: ``node['fqdn']``.

.. end_tag

chef-expander
-----------------------------------------------------
.. tag server_tuning_osc_expander

The following setting is often modified from the default as part of the tuning effort for the **opscode-expander** service:

.. list-table::
   :widths: 200 300
   :header-rows: 1

   * - Setting
     - Description
   * - ``chef_expander['nodes']``
     - The number of allowed worker processes. The **opscode-expander** service runs on the back-end and feeds data to the **opscode-solr** service, which creates and maintains search data used by the Chef server. Additional memory may be required by these worker processes depending on the frequency and volume of chef-client runs across the organization, but only if the back-end machines have available CPU and RAM.. Default value: ``2``.

.. end_tag

chef-solr
-----------------------------------------------------
.. tag server_tuning_osc_solr

The following settings are often modified from the default as part of the tuning effort for the **opscode-solr** service:

.. list-table::
   :widths: 200 300
   :header-rows: 1

   * - Setting
     - Description
   * - ``chef_solr['heap_size']``
     - The amount of memory (in MBs) available to Apache Solr. If there is not enough memory available, search queries made by nodes to Apache Solr may fail. The amount of memory that must be available also depends on the number of nodes in the organization, the frequency of search queries, and other characteristics that are unique to each organization. In general, as the number of nodes increases, so does the amount of memory.

       If Apache Solr is running out of memory, the ``/var/log/opscode/chef_solr-solr/current`` log file will contain ``SEVERE: java.lang.OutOfMemoryError: Java heap space``.

       The default value should work for many organizations with fewer than 25 nodes. Suggested value: ``256`` per every 25 nodes. For example, an organization with 300 nodes, this value should be set to ``3072``.
   * - ``chef_solr['max_field_length']``
     - The maximum field length (in number of tokens/terms). If a field length exceeds this value, Apache Solr may not be able to complete building the index. Default value: ``100000`` (increased from the Apache Solr default value of ``10000``).

.. end_tag

Update Frequency
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. tag server_tuning_osc_solr_update_frequency

At the end of every chef-client run, the node object is saved to the Chef server. From the Chef server, each node object is then added to the ``SOLR`` search index. This process is asynchronous. By default, node objects are committed to the search index every 60 seconds or per 1000 node objects, whichever occurs first.

When data is committed to the Apache Solr index, all incoming updates are blocked. If the duration between updates is too short, it is possible for the rate at which updates are asked to occur to be faster than the rate at which objects can be actually committed.

For Open Source Chef, these settings are configurable in the chef-server.rb file:

.. list-table::
   :widths: 200 300
   :header-rows: 1

   * - Setting
     - Description
   * - ``chef_solr['commit_interval']``
     - The frequency (in seconds) at which node objects are added to the Apache Solr search index. Default value: ``60000`` (every 60 seconds).
   * - ``chef_solr['max_commit_docs']``
     - The frequency (in documents) at which node objects are added to the Apache Solr search index. Default value: ``1000`` (every 1000 documents).

.. end_tag

erchef
-----------------------------------------------------
.. tag server_tuning_osc_erchef

The following settings are often modified from the default as part of the tuning effort for the **opscode-erchef** service:

.. list-table::
   :widths: 200 300
   :header-rows: 1

   * - Setting
     - Description
   * - ``erchef['db_pool_size']``
     - The number of open connections to PostgreSQL that are maintained by the service. If failures indicate that the **opscode-erchef** service ran out of connections, try increasing the ``postgresql['max_connections']`` setting. If failures persist, then increase this value and also increase the value for ``postgresql['max_connections']``. Default value: ``20``.
   * - ``erchef['s3_url_ttl']``
     - The amount of time (in seconds) before connections to the server expire. If chef-client runs are timing out, increase this setting to ``3600``, and then adjust again if necessary. Default value: ``900``.

.. end_tag

postgresql
-----------------------------------------------------
.. tag server_tuning_osc_postgresql

The following setting is often modified from the default as part of the tuning effort for the **postgresql** service:

.. list-table::
   :widths: 200 300
   :header-rows: 1

   * - Setting
     - Description
   * - ``postgresql['max_connections']``
     - The maximum number of allowed concurrent connections. This value should only be tuned when the ``erchef['db_pool_size']`` value used by the **opscode-erchef** service is modified. Default value: ``200``.

.. end_tag

webui
-----------------------------------------------------
.. tag server_tuning_osc_webui

The following setting is often modified from the default as part of the tuning effort for the **opscode-webui** service:

.. list-table::
   :widths: 200 300
   :header-rows: 1

   * - Setting
     - Description
   * - ``chef_server_webui['worker_processes']``
     - The number of allowed worker processes. This setting should be increased or decreased based on the number of users in an organization who use the Chef server web user interface. The default value is ``2``.

.. end_tag

