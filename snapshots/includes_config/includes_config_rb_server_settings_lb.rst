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
   The maximum version of the chef-client that is allowed to access the Chef server via the Chef server API. Default value: ``11``.

``lb['chef_min_version']``
   The minimum version of the chef-client that is allowed to access the Chef server via the Chef server API. Default value: ``10``.

``lb['chef_server_webui']``
   Default value: ``127.0.0.1``.

``lb['debug']``
   Default value: ``false``.

``lb['enable']``
   Enable a service. Default value: ``true``.

``lb['erchef']``
   Default value: ``127.0.0.1``.

``lb['maint_refresh_interval']``
   Default value: ``600``.

``lb['redis_connection_pool_size']``
   Default value: ``250``.

``lb['redis_connection_timeout']``
   The amount of time (in milliseconds) to wait before timing out. Default value: ``1000``.

``lb['redis_keepalive_timeout']``
   The amount of time (in milliseconds) to wait before timing out. Default value: ``2000``.

``lb['upstream']['bookshelf']``
   The default value is the recommended value. Default value: ``[ '127.0.0.1' ]``.

``lb['upstream']['oc_bifrost']``
   The default value is the recommended value. Default value: ``[ '127.0.0.1' ]``.

``lb['upstream']['opscode_erchef']``
   The default value is the recommended value. Default value: ``[ '127.0.0.1' ]``.

``lb['upstream']['opscode_solr4']``
   The default value is the recommended value. Default value: ``[ '127.0.0.1' ]``.

``lb['vip']``
   The virtual IP address. Default value: ``127.0.0.1``.

``lb['web_ui_fqdn']``
   Default value: ``node['fqdn']``.

``lb['xdl_defaults']['503_mode']``
   The default value is the recommended value. Default value: ``false``.

``lb['xdl_defaults']['couchdb_acls']``
   The default value is the recommended value. Default value: ``true``.

``lb['xdl_defaults']['couchdb_association_requests']``
   The default value is the recommended value. Default value: ``true``.

``lb['xdl_defaults']['couchdb_associations']``
   The default value is the recommended value. Default value: ``true``.

``lb['xdl_defaults']['couchdb_containers']``
   The default value is the recommended value. Default value: ``true``.

``lb['xdl_defaults']['couchdb_groups']``
   The default value is the recommended value. Default value: ``true``.

``lb['xdl_defaults']['couchdb_organizations']``
   The default value is the recommended value. Default value: ``true``.

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
   The virtual IP address. Default value: ``'127.0.0.1'``.
