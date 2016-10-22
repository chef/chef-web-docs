.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


This configuration file has the following settings for ``oc_bifrost``:

``oc_bifrost['db_pool_size']``
   The number of open connections to PostgreSQL that are maintained by the service. This value should be increased if failures indicate that the **oc_bifrost** service ran out of connections. This value should be tuned in conjunction with the ``postgresql['max_connections']`` setting for PostgreSQL. Default value: ``20``.

``oc_bifrost['dir']``
   The working directory. The default value is the recommended value. Default value: ``/var/opt/opscode/oc_bifrost``.

``oc_bifrost['enable']``
   Enable a service. Default value: ``true``.

``oc_bifrost['extended_perf_log']``
   Default value: ``true``.

``oc_bifrost['ha']``
   Run the Chef server in a high availability topology. When ``topology`` is set to ``ha``, this setting defaults to ``true``.

``oc_bifrost['listen']``
   The IP address on which the service is to listen. Default value: ``'127.0.0.1'``.

``oc_bifrost['log_directory']``
   The directory in which log data is stored. The default value is the recommended value. Default value: ``/var/log/opscode/oc_bifrost``.

``oc_bifrost['log_rotation']``
   The log rotation policy for this service. Log files are rotated when they exceed ``file_maxbytes``. The maximum number of log files in the rotation is defined by ``num_to_keep``. Default value:

   .. code-block:: ruby

      { 'file_maxbytes' => 104857600, 'num_to_keep' => 10 }

``oc_bifrost['port']``
   The port on which the service is to listen. Default value: ``9463``.

``oc_bifrost['sql_password']``
   The password for the ``sql_user``. Default value: ``'challengeaccepted'``.

``oc_bifrost['sql_ro_password']``
   The password for the ``sql_ro_user``. Default value: ``'foreveralone'``.

``oc_bifrost['sql_ro_user']``
   Default value: ``'bifrost_ro'``.

``oc_bifrost['sql_user']``
   The user with permission to publish data. Default value: ``'bifrost'``.

``oc_bifrost['superuser_id']``
   Default value: ``'5ca1ab1ef005ba111abe11eddecafbad'``.

``oc_bifrost['vip']``
   The virtual IP address. Default value: ``'127.0.0.1'``.
