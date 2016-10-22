.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


This configuration file has the following settings for ``postgresql``:

``postgresql['checkpoint_completion_target']``
   A completion percentage that is used to determine how quickly a checkpoint should finish in relation to the completion status of the next checkpoint. For example, if the value is ``0.5``, then a checkpoint attempts to finish before 50% of the next checkpoint is done. Default value: ``0.5``.

``postgresql['checkpoint_segments']``
   The maximum amount (in megabytes) between checkpoints in log file segments. Default value: ``3``.

``postgresql['checkpoint_timeout']``
   The amount of time (in minutes) between checkpoints. Default value: ``5min``.

``postgresql['checkpoint_warning']``
   The frequency (in seconds) at which messages are sent to the server log files if checkpoint segments are being filled faster than their currently configured values. Default value: ``30s``.

``postgresql['data_dir']``
   The directory in which on-disk data is stored. The default value is the recommended value. Default value: ``/var/opt/opscode/postgresql/#{node['private_chef']['postgresql']['version']}/data``.

``postgresql['db_superuser']``
   Default value: ``opscode-pgsql``. If ``username`` is set, set ``db_superuser`` to the same value.

``postgresql['dir']``
   The working directory. The default value is the recommended value. Default value: ``/var/opt/opscode/postgresql/#{node['private_chef']['postgresql']['version']}``.

``postgresql['effective_cache_size']``
   The size of the disk cache that is used for data files. Default value: 50% of available RAM.

``postgresql['enable']``
   Enable a service. Default value: ``true``.

``postgresql['ha']``
   Run the Chef server in a high availability topology. When ``topology`` is set to ``ha``, this setting defaults to ``true``. Default value: ``false``.

``postgresql['home']``
   The home directory for PostgreSQL. Default value: ``/var/opt/opscode/postgresql``.

``postgresql['keepalives_count']``
   The maximum number of keepalive proves that should be sent before dropping a connection. Default value: ``2``.

``postgresql['keepalives_idle']``
   The amount of time (in seconds) a connection must remain idle before keepalive probes will resume. Default value: ``60``.

``postgresql['keepalives_interval']``
   The amount of time (in seconds) between probes. Default value: ``15``.

``postgresql['listen_address']``
   The connection source to which PostgreSQL is to respond. Default value: ``localhost``.

``postgresql['log_directory']``
   The directory in which log data is stored. The default value is the recommended value. Default value: ``/var/log/opscode/postgresql/#{node['private_chef']['postgresql']['version']}``.

``postgresql['log_min_duration_statement']``
   When to log a slow PostgreSQL query statement. Possible values: ``-1`` (disabled, do not log any statements), ``0`` (log every statement), or an integer greater than zero. When the integer is greater than zero, this value is the amount of time (in milliseconds) that a query statement must have run before it is logged. Default value: ``-1``.

``postgresql['log_rotation']``
   The log rotation policy for this service. Log files are rotated when they exceed ``file_maxbytes``. The maximum number of log files in the rotation is defined by ``num_to_keep``. Default value: ``{ 'file_maxbytes' => 104857600, 'num_to_keep' => 10 }``

``postgresql['max_connections']``
   The maximum number of allowed concurrent connections. Default value: ``350``.

``postgresql['md5_auth_cidr_addresses']``
   Use instead of ``trust_auth_cidr_addresses`` to encrypt passwords using MD5 hashes. Default value: ``[ '127.0.0.1/32', '::1/128' ]``.

``postgresql['port']``
   The port on which the service is to listen. Default value: ``5432``.

``postgresql['shared_buffers']``
   The amount of memory that is dedicated to PostgreSQL for data caching. Default value: ``#{(node['memory']['total'].to_i / 4) / (1024)}MB``.

``postgresql['shell']``
   Default value: ``/bin/sh``.

``postgresql['shmall']``
   The total amount of available shared memory. Default value: ``4194304``.

``postgresql['shmmax']``
   The maximum amount of shared memory. Default value: ``17179869184``.

``postgresql['sql_password']``
   The password for the PostgreSQL user account. Default value: ``snakepliskin``.

``postgresql['sql_ro_password']``
   Default value: ``shmunzeltazzen``.

``postgresql['sql_ro_user']``
   Default value: ``opscode_chef_ro``.

``postgresql['sql_user']``
   Default value: ``opscode_chef``.

``postgresql['trust_auth_cidr_addresses']``
   Use for clear-text passwords. See ``md5_auth_cidr_addresses``. Default value: ``'127.0.0.1/32', '::1/128'``.

``postgresql['user_path']``
   Default value: ``/opt/opscode/embedded/bin:/opt/opscode/bin:$PATH``.

``postgresql['username']``
   The PostgreSQL account user name. Default value: ``opscode-pgsql``. If setting this value, must set ``db_superuser`` to the same value.

``postgresql['version']``
   The (currently) hardcoded version of PostgreSQL. Default value: ``'9.2'``.

``postgresql['vip']``
   The virtual IP address. Default value: ``127.0.0.1``.

``postgresql['work_mem']``
   The size (in megabytes) of allowed in-memory sorting. Default value: ``8MB``.
