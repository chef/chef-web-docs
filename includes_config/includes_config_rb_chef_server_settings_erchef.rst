.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


This configuration file has the following settings:

``erchef['auth_skew']``
   Default value: ``900``.

``erchef['base_resource_url']``
   The base URL to which the service will return links to API resources. Use ``:host_header`` to ensure the URL is derived from the host header of the incoming HTTP request. Default value: ``:host_header``.

``erchef['bulk_fetch_batch_size']``
   Default value: ``5``.

``erchef['cache_ttl']``
   Default value: ``3600``.

``erchef['depsolver_timeout']``
   The amount of time (in milliseconds) to wait for cookbook dependency problems to be solved. Default value: ``'5000'``.

``erchef['depsolver_worker_count']``
   The number of |ruby| processes for which cookbook dependency problems are unsolved. Use the ``pgrep -fl depselector`` command to verify the number of depsolver workers that are running. Default value: ``'5'``.

``erchef['db_pool_size']``
   Default value: ``20``.

``erchef['dir']``
   |directory generic| |default_value_recommended| Default value: ``/var/opt/chef-server/erchef``.

``erchef['enable']``
   Default value: ``true``.

``erchef['ha']``
   |use ha| Default value: ``false``.

``erchef['ibrowse_max_pipeline_size']``
   Default value: ``1``.

``erchef['ibrowse_max_sessions']``
   Default value: ``256``.

``erchef['listen']``
   Default value: ``127.0.0.1``.

``erchef['log_directory']``
   The directory in which log files are located. Default value: ``/var/log/chef-server/erchef``.

``erchef['log_rotation']``
   |log_rotation| Default value: ``{ 'file_maxbytes' => 104857600, 'num_to_keep' => 10 }``

``erchef['max_cache_size']``
   Default value: ``10000``.

``opscode_erchef['max_request_size']``
   Default value: ``2500000``.

``erchef['port']``
   |port service| Default value: ``8000``.

``erchef['proxy_user']``
   Default value: ``pivotal``.

``erchef['root_metric_key']``
   Default value: ``chefAPI``.

``erchef['s3_bucket']``
   Default value: ``bookshelf``.

``erchef['s3_parallel_ops_fanout']``
   Default value: ``20``.

``erchef['s3_parallel_ops_timeout']``
   Default value: ``5000``.

``erchef['s3_url_ttl']``
   Default value: ``900``.

``erchef['svlogd_size']``
   |svlogd_size| Default value: ``1000000``.

``erchef['svlogd_num']``
   |svlogd_num| Default value: ``10``.

``erchef['umask']``
   Default value: ``0022``.

``erchef['validation_client_name']``
   Default value: ``chef-validator``.

``erchef['vip']``
   |ip_address virtual| Default value: ``127.0.0.1``.

``erchef['web_ui_client_name']``
   Default value: ``chef-webui``.
