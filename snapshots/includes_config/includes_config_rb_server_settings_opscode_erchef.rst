.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


This configuration file has the following settings for ``opscode-erchef``:

``opscode_erchef['auth_skew']``
   Default value: ``900``.

``opscode_erchef['authz_fanout']``
   Default value: ``20``.

``opscode_erchef['authz_timeout']``
   The amount of time (in seconds) before a request to the **oc_bifrost** service times out. Default value: ``2000``.

``opscode_erchef['base_resource_url']``
   The base URL to which the service is to return links to API resources. Use ``:host_header`` to ensure the URL is derived from the host header of the incoming HTTP request. Default value: ``:host_header``.

``opscode_erchef['bulk_fetch_batch_size']``
   The number of nodes that may be deserialized. Currently only applies to the ``/search`` endpoint in the Chef server API. The default value is the recommended value. Default value: ``5``.

``opscode_erchef['cache_ttl']``
   Default value: ``3600``.

``opscode_erchef['cleanup_batch_size']``
   Default value: ``0``.

``opscode_erchef['couchdb_max_conn']``
   Default value: ``'100'``.

``opscode_erchef['db_pool_size']``
   The number of open connections to PostgreSQL that are maintained by the service. Default value: ``20``.

``opscode_erchef['depsolver_timeout']``
   The amount of time (in milliseconds) to wait for cookbook dependency problems to be solved. Default value: ``'5000'``.

``opscode_erchef['depsolver_worker_count']``
   The number of Ruby processes for which cookbook dependency problems are unsolved. Use the ``pgrep -fl depselector`` command to verify the number of depsolver workers that are running. If you are seeing 503 service unavailable errors, increase this value. Default value: ``'5'``.

``opscode_erchef['dir']``
   The working directory. The default value is the recommended value. Default value: ``/var/opt/opscode/opscode-erchef``.

``opscode_erchef['enable']``
   Enable a service. Default value: ``true``.

``opscode_erchef['enable_actionlog']``
   Use to enable Chef actions, a premium feature of the Chef server. Default value: ``false``.

``opscode_erchef['ha']``
   Run the Chef server in a high availability topology. When ``topology`` is set to ``ha``, this setting defaults to ``true``. Default value: ``false``.

``opscode_erchef['ibrowse_max_pipeline_size']``
   Default value: ``1``.

``opscode_erchef['ibrowse_max_sessions']``
   Default value: ``256``.

``opscode_erchef['listen']``
   The IP address on which the service is to listen. Default value: ``127.0.0.1``.

``opscode_erchef['log_directory']``
   The directory in which log data is stored. The default value is the recommended value. Default value: ``/var/log/opscode/opscode-erchef``.

``opscode_erchef['log_rotation']``
   The log rotation policy for this service. Log files are rotated when they exceed ``file_maxbytes``. The maximum number of log files in the rotation is defined by ``num_to_keep``. Default value:

   .. code-block:: ruby

      { 'file_maxbytes' => 104857600, 'num_to_keep' => 10 }

``opscode_erchef['max_cache_size']``
   Default value: ``10000``.

``opscode_erchef['max_request_size']``
   Default value: ``1000000``.

``opscode_erchef['nginx_bookshelf_caching']``
   Whether Nginx is used to cache cookbooks. When ``:on``, Nginx serves up the cached content instead of forwarding the request. Default value: ``:off``.

``opscode_erchef['port']``
   The port on which the service is to listen. Default value: ``8000``.

``opscode_erchef['root_metric_key']``
   Default value: ``chefAPI``.

``opscode_erchef['s3_bucket']``
   The name of the Amazon Simple Storage Service (S3) bucket. (This is configurable and may be pointed at external storage locations, such as Amazon EC2. Four settings require configuration when pointing at an external cookbook storage location: ``bookshelf['vip']``, for the endpoint used by the chef-client; ``bookshelf['external_url']``, for the endpoint used by the Chef server; ``bookshelf['access_key_id']``, for user access key; ``bookshelf['secret_access_key']``, for secret key; and ``opscode_erchef['s3_bucket']``, for the bucket name. Reconfigure the Chef server after changing these settings. Default value: ``bookshelf``.

``opscode_erchef['s3_parallel_ops_fanout']``
   Default value: ``20``.

``opscode_erchef['s3_parallel_ops_timeout']``
   Default value: ``5000``.

``opscode_erchef['s3_url_expiry_window_size']``
   The frequency at which unique URLs are generated. This value may be a specific amount of time, i.e. ``15m`` (fifteen minutes) or a percentage of the value of ``s3_url_ttl``, i.e. ``10%``. Default value: ``:off``.

``opscode_erchef['s3_url_ttl']``
   The amount of time (in seconds) before connections to the server expire. If node bootstraps are timing out, increase this setting. Default value: ``28800``.

``opscode_erchef['strict_search_result_acls']``
   .. include:: ../../includes_settings/includes_settings_strict_search_result_acls.rst

``opscode_erchef['udp_socket_pool_size']``
   Default value: ``20``.

``opscode_erchef['umask']``
   Default value: ``0022``.

``opscode_erchef['validation_client_name']``
   Default value: ``chef-validator``.

``opscode_erchef['vip']``
   The virtual IP address. Default value: ``127.0.0.1``.
