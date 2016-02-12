.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


The following settings are typically added to the ``opscode-reporting.rb`` file:

``enable``
   |enable service| Default value: ``true``.

``ha``
   |use ha| |ha true| Default value: ``false``.

``dir``
   |directory generic| |default_value_recommended| Default value: ``'/var/opt/opscode-reporting/opscode-reporting'``.

``log_directory``
   |directory logs| |default_value_recommended| Default value: ``'/var/log/opscode/opscode-reporting'``.

``protocol_version``
   Default value: ``'0.1.0'``.

``vip``
   |ip_address virtual| Default value: ``'127.0.0.1'``.

``listen``
   Default value: ``'127.0.0.1'``.

``port``
   Default value: ``10010``.

``auth_skew``
   Default value: ``'900'``.

``db_pool_size``
   |db_pool_size| Default value: ``25``.

``node_search_limit``
   Default value: ``50``.

``org_cache_size``
   Default value: ``'10000'``.

``org_cache_ttl``
   Default value: ``'14400'`` (four hours).

``principals_cache_size``
   Default value: ``'10000'``.

``principals_cache_ttl``
   Default value: ``'14400'`` (four hours).

``node_identifiers_cache_size``
   Default value: ``'20000'``.

``enable_graphite``
   Default value: ``false``.

``node_identifiers_cache_ttl``
   Default value: ``'14440'`` (four hours).

``pool['timeout']``
   Default value: ``10000``.

``pool['http_pool_size']``
   Default value: ``25``.

``pool['cull_interval']``
   May be ``min``, ``sec``, or ``ms``. Default value: ``'{1, min}'``.

``pool['max_age']``
   May be ``min``, ``sec``, or ``ms``. Default value: ``'{70, sec}'``.

``pool['max_connection_duration']``
   May be ``min``, ``sec``, or ``ms``. Default value: ``'{70, sec}'``.

``pool['ibrowse_options']``
   |timeout authz| Default value: ``'[{connect_timeout, 8000}]'``.

``log_rotation['file_maxbytes']``
   |log_rotation| Default value: ``104857600``.

``log_rotation['num_to_keep']``
   Default value: ``10``.

``chef_api_version``
   The version of the |api chef server|. Default value: ``'11.1.0'``.

``refresh_runcounts_interval``
   Default value: ``5``.

``rabbitmq_user``
   Default value: ``'runs'``.

``rabbitmq_password``
   |password rabbitmq| Default value: ``'changeme'``.

``postgresql['enable']``
   |enable service| Default value: ``true``.

``postgresql['username']``
   |name user postgresql| Default value: ``'opscode-pgsql'``.

``postgresql['sql_user']``
   Default value: ``'opscode_reporting'``.

``postgresql['sql_password']``
   The password for the |postgresql| user account. Default value: ``'snakepliskin'``.

``postgresql['sql_ro_user']``
   Default value: ``'opscode_reporting_ro'``.

``postgresql['sql_ro_password']``
   Default value: ``'shmunzeltazzen'``.

``postgresql['vip']``
   |ip_address virtual| Default value: ``'127.0.0.1'``.

``postgresql['port']``
   |port service| Default value: ``5432``.

``nginx['enable']``
   |enable service| Default value: ``true``.

``graphite['host']``
   Default value: ``'localhost'``.

``graphite['port']``
   |port service| Default value: ``2003``.

``graphite['prefix']``
   Default value: ``'folsom'``.

``graphite['send_interval']``
   Default value: ``10000``.

``sqerl['db_pooler_timeout']``
   Default value: ``'0'``.

``pooler['db_pool_queue_max']``
   Default value: ``'50'``.
