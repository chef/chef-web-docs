.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


This configuration file has the following settings for ``redis_lb``:

``redis_lb['activerehashing']``
   Enable active rehashing. Default value: ``'no'``.

``redis_lb['aof_rewrite_min_size']``
   The minimum size of the append-only file. Only files larger than this value are rewritten. Default value: ``'16mb'``.

``redis_lb['aof_rewrite_percent']``
   The size of the current append-only file, as compared to the base size. The append-only file is rewritten when the current file exceeds the base size by this value. Default value: ``'50'``.

``redis_lb['appendfsync']``
   The frequency at which the operating system writes data on-disk, instead of waiting for more data. Possible values: ``no`` (don't fsync, let operating system flush data), ``always`` (fsync after every write to the append-only log file), and ``everysec`` (fsync only once time per second). Default value: ``'always'``.

``redis_lb['appendonly']``
   Dump data asynchronously on-disk or to an append-only log file. Set to ``yes`` to dump data to an append-only log file. Default value: ``'no'``.

``redis_lb['bind']``
   Bind Redis to the specified IP address. Default value: ``'127.0.0.1'``.

``redis_lb['data_dir']``
   The directory in which on-disk data is stored. The default value is the recommended value. Default value: ``'/var/opt/opscode/redis_lb/data'``.

``redis_lb['databases']``
   The number of databases. Default value: ``'16'``.

``redis_lb['dir']``
   The working directory. The default value is the recommended value. Default value: ``'/var/opt/opscode/redis_lb'``.

``redis_lb['enable']``
   Enable a service. Default value: ``true``.

``redis_lb['ha']``
   Run the Chef server in a high availability topology. When ``topology`` is set to ``ha``, this setting defaults to ``true``. Default value: ``false``.

``redis_lb['keepalive']``
   The amount of time (in seconds) to wait for requests on a connection. Default value: ``'60'``.

``redis_lb['log_directory']``
   The directory in which log data is stored. The default value is the recommended value. Default value: ``'/var/log/opscode/redis_lb'``.

``redis_lb['log_rotation']``
   The log rotation policy for this service. Log files are rotated when they exceed ``file_maxbytes``. The maximum number of log files in the rotation is defined by ``num_to_keep``. Default value:

   .. code-block:: ruby

      { 'file_maxbytes' => 104857600, 'num_to_keep' => 10 }

``redis_lb['loglevel']``
   The level of logging to be stored in a log file.. Possible values: ``debug``, ``notice``, ``verbose``, and ``warning``. Default value: ``'notice'``.

``redis_lb['maxmemory']``
   The maximum amount of memory (in bytes). Default value: ``'8m'``.

``redis_lb['maxmemory_policy']``
   The policy applied when the maximum amount of memory is reached. Possible values: ``allkeys-lru`` (remove keys, starting with those used least frequently), ``allkeys-random`` (remove keys randomly), ``noeviction`` (don't expire, return an error on write operation), ``volatile-lru`` (remove expired keys, starting with those used least frequently), ``volatile-random`` (remove expired keys randomly), and ``volatile-ttl`` (remove keys, starting with nearest expired time). Default value: ``'noeviction'``.

``redis_lb['port']``
   The port on which the service is to listen. Default value: ``'16379'``.

``redis_lb['save_frequency']``
   Set the save frequency. Pattern: ``{ "seconds" => "keys", "seconds" => "keys", "seconds" => "keys" }``. Default value:

   .. code-block:: ruby

      { '900' => '1', '300' => '10', '60' => '1000' }

   Which saves the database every 15 minutes if at least one key changes, every 5 minutes if at least 10 keys change, and every 60 seconds if 10000 keys change.

``redis_lb['timeout']``
   The amount of time (in seconds) a client may be idle before timeout. Default value: ``'300'``.

``redis_lb['vip']``
   The virtual IP address. Default value: ``'127.0.0.1'``.
