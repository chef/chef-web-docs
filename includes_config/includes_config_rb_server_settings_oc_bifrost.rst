.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


This configuration file has the following settings for ``oc_bifrost``:

``oc_bifrost['db_pool_size']``
   |db_pool_size| This value should be increased if failures indicate that the |service bifrost| service ran out of connections. This value should be tuned in conjunction with the ``postgresql['max_connections']`` setting for |postgresql|. Default value: ``20``.

``oc_bifrost['dir']``
   |directory generic| |default_value_recommended| Default value: ``/var/opt/opscode/oc_bifrost``.

``oc_bifrost['enable']``
   |enable service| Default value: ``true``.

``oc_bifrost['extended_perf_log']``
   Default value: ``true``.

``oc_bifrost['ha']``
   |use ha| |ha true|

``oc_bifrost['listen']``
   |ip_address service| Default value: ``'127.0.0.1'``.

``oc_bifrost['log_directory']``
   |directory logs| |default_value_recommended| Default value: ``/var/log/opscode/oc_bifrost``.

``oc_bifrost['log_rotation']``
   |log_rotation| Default value:

   .. code-block:: ruby

      { 'file_maxbytes' => 104857600, 'num_to_keep' => 10 }

``oc_bifrost['port']``
   |port service| Default value: ``9463``.

``oc_bifrost['sql_password']``
   |password sql_user| Default value: ``'challengeaccepted'``.

``oc_bifrost['sql_ro_password']``
   |password sql_ro_user| Default value: ``'foreveralone'``.

``oc_bifrost['sql_ro_user']``
   Default value: ``'bifrost_ro'``.

``oc_bifrost['sql_user']``
   |user bifrost| Default value: ``'bifrost'``.

``oc_bifrost['superuser_id']``
   Default value: ``'5ca1ab1ef005ba111abe11eddecafbad'``.

``oc_bifrost['vip']``
   |ip_address virtual| Default value: ``'127.0.0.1'``.
