.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


The following example shows the results of running the ``chef-backend-ctl gen-server-config`` subcommand. The settings and output will vary, depending on the configuration. These settings should be modified carefully:

.. code-block:: ruby

   fqdn "frontend1.chef-demo.com"
   postgresql['external'] = true
   postgresql['vip'] = '192.168.33.220'
   postgresql['db_superuser'] = 'chef_pgsql'
   postgresql['db_superuser_password'] = '...6810e52a01e562'
   opscode_solr4['external'] = true
   opscode_solr4['external_url'] = 'http://192.168.33.220:9200'
   opscode_erchef['search_provider'] = 'elasticsearch'
   opscode_erchef['search_queue_mode'] = 'batch'
   bookshelf['storage_type'] = :sql
   rabbitmq['enable'] = false
   rabbitmq['management_enabled'] = false
   rabbitmq['queue_length_monitor_enabled'] = false
   opscode_expander['enable'] = false
   dark_launch['actions'] = false
   opscode_erchef['nginx_bookshelf_caching'] = :on
   opscode_erchef['s3_url_expiry_window_size'] = '50%'

.. note:: The ``opscode_solr4``, ``postgresql``, and ``rabbitmq`` services are disabled in this configuration file for the frontend machines when running the |chef server| with a backend HA cluster.
