.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


This configuration file has the following settings for ``lb``:

``lb['api_fqdn']``
   Default value: ``node['fqdn']``.

``lb['ban_refresh_interval']``
   Default value: ``600``.

``lb['bookshelf']``
   Default value: ``127.0.0.1``.

``lb['cache_cookbook_files']``
   Default value: ``false``.

``lb['chef_max_version']``
   |version chef_max| Default value: ``11``.

``lb['chef_min_version']``
   |version chef_min| Default value: ``10``.

``lb['chef_server_webui']``
   Default value: ``127.0.0.1``.

``lb['debug']``
   Default value: ``false``.

``lb['enable']``
   |enable service| Default value: ``true``.

``lb['erchef']``
   Default value: ``127.0.0.1``.

``lb['maint_refresh_interval']``
   Default value: ``600``.

``lb['redis_connection_pool_size']``
   Default value: ``250``.

``lb['redis_connection_timeout']``
   |timeout ms| Default value: ``1000``.

``lb['redis_keepalive_timeout']``
   |timeout ms| Default value: ``2000``.

``lb['upstream']['bookshelf']``
   |default_value_recommended| Default value: ``[ '127.0.0.1' ]``.

``lb['upstream']['oc_bifrost']``
   |default_value_recommended| Default value: ``[ '127.0.0.1' ]``.

``lb['upstream']['opscode_erchef']``
   |default_value_recommended| Default value: ``[ '127.0.0.1' ]``.

``lb['upstream']['opscode_solr4']``
   |default_value_recommended| Default value: ``[ '127.0.0.1' ]``.

``lb['vip']``
   |ip_address virtual| Default value: ``127.0.0.1``.

``lb['web_ui_fqdn']``
   Default value: ``node['fqdn']``.

``lb['xdl_defaults']['503_mode']``
   |default_value_recommended| Default value: ``false``.

``lb['xdl_defaults']['couchdb_acls']``
   |default_value_recommended| Default value: ``true``.

``lb['xdl_defaults']['couchdb_association_requests']``
   |default_value_recommended| Default value: ``true``.

``lb['xdl_defaults']['couchdb_associations']``
   |default_value_recommended| Default value: ``true``.

``lb['xdl_defaults']['couchdb_containers']``
   |default_value_recommended| Default value: ``true``.

``lb['xdl_defaults']['couchdb_groups']``
   |default_value_recommended| Default value: ``true``.

``lb['xdl_defaults']['couchdb_organizations']``
   |default_value_recommended| Default value: ``true``.

And for the internal load balancers:

``lb_internal['account_port']``
   Default value: ``9685``.

``lb_internal['chef_port']``
   Default value: ``9680``.

``lb_internal['enable']``
   Default value: ``true``.

``lb_internal['oc_bifrost_port']``
   Default value: ``9683``.

``lb_internal['vip']``
   |ip_address virtual| Default value: ``'127.0.0.1'``.
