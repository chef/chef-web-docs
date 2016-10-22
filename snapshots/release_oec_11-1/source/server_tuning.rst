.. THIS PAGE DOCUMENTS Enterprise Chef server version 11.1

=====================================================
Server Tuning
=====================================================

.. include:: ../../includes_server_tuning/includes_server_tuning.rst

.. note:: .. include:: ../../includes_notes/includes_notes_enterprise_chef_tuning.rst

Customize the Config File
=====================================================
.. include:: ../../includes_config/includes_config_rb_chef_server_enterprise.rst

Use Conditions
-----------------------------------------------------
.. include:: ../../step_config/step_config_add_condition.rst

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
.. include:: ../../includes_server_tuning/includes_server_tuning_nginx.rst

Optional Settings
=====================================================
The following settings are often used to for performance tuning of Enterprise Chef in larger installations.

.. note:: When changes are made to the private-chef.rb file the Enterprise Chef must be reconfigured by running the ``private-chef-ctl reconfigure`` command.

bookshelf
-----------------------------------------------------
.. include:: ../../includes_server_tuning/includes_server_tuning_bookshelf.rst

opscode-account
-----------------------------------------------------
.. include:: ../../includes_server_tuning/includes_server_tuning_account.rst

opscode-erchef
-----------------------------------------------------
.. include:: ../../includes_server_tuning/includes_server_tuning_erchef.rst

opscode-expander
-----------------------------------------------------
.. include:: ../../includes_server_tuning/includes_server_tuning_expander.rst

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
.. include:: ../../includes_server_tuning/includes_server_tuning_solr_update_frequency.rst

opscode-webui
-----------------------------------------------------
.. include:: ../../includes_server_tuning/includes_server_tuning_webui.rst

postgresql
-----------------------------------------------------
.. include:: ../../includes_server_tuning/includes_server_tuning_postgresql.rst
