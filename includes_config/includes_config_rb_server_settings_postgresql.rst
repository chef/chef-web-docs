.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


This configuration file has the following settings for ``postgresql``:

``postgresql['checkpoint_completion_target']``
   |checkpoint_completion_target| Default value: ``0.5``.

``postgresql['checkpoint_segments']``
   |checkpoint_segments| Default value: ``3``.

``postgresql['checkpoint_timeout']``
   |checkpoint_timeout| Default value: ``5min``.

``postgresql['checkpoint_warning']``
   |checkpoint_warning| Default value: ``30s``.

``postgresql['data_dir']``
   |directory generic_data| |default_value_recommended| Default value:

   .. code-block:: ruby

      /var/opt/opscode/postgresql/#{node['private_chef']['postgresql']['version']}/data

``postgresql['db_superuser']``
   Required when ``postgresql['external']`` is set to ``true``. |postgresql external_db_superuser| Default value: ``'superuser_userid'``.

``postgresql['db_superuser_password']``
   Required when ``postgresql['external']`` is set to ``true``. |postgresql external_db_password| Default value: ``'the password'``.

``postgresql['dir']``
   |directory generic| |default_value_recommended| Default value:

   .. code-block:: ruby

      /var/opt/opscode/postgresql/#{node['private_chef']['postgresql']['version']}

``postgresql['effective_cache_size']``
   |effective_cache_size postgresql| Default value: 50% of available RAM.

``postgresql['enable']``
   |enable service| Default value: ``true``.

``postgresql['external']``
   Required. |postgresql external| Default value: ``false``.

``postgresql['ha']``
   |use ha| |ha true| Default value: ``false``.

``postgresql['home']``
   |directory postgresql_home| Default value: ``/var/opt/opscode/postgresql``.

``postgresql['keepalives_count']``
   |keepalive postgresql_count| Default value: ``2``.

``postgresql['keepalives_idle']``
   |keepalive postgresql_idle| Default value: ``60``.

``postgresql['keepalives_interval']``
   |keepalive postgresql_interval| Default value: ``15``.

``postgresql['listen_address']``
   |port listen_postgresql| Default value: ``localhost``.

``postgresql['log_directory']``
   |directory logs| |default_value_recommended| Default value:

   .. code-block:: ruby

      /var/log/opscode/postgresql/#{node['private_chef']['postgresql']['version']}

``postgresql['log_min_duration_statement']``
   |log_rotation min_duration| Possible values: ``-1`` (disabled, do not log any statements), ``0`` (log every statement), or an integer greater than zero. When the integer is greater than zero, this value is the amount of time (in milliseconds) that a query statement must have run before it is logged. Default value: ``-1``.

``postgresql['log_rotation']``
   |log_rotation| Default value:

   .. code-block:: ruby

      { 'file_maxbytes' => 104857600, 'num_to_keep' => 10 }

``postgresql['max_connections']``
   |max_connections| Default value: ``350``.

``postgresql['md5_auth_cidr_addresses']``
   |md5_auth_cidr_addresses| Default value: ``[ '127.0.0.1/32', '::1/128' ]``.

``postgresql['port']``
   Optional when ``postgresql['external']`` is set to ``true``. |port service| |postgresql external_port| Default value: ``5432``.

``postgresql['shared_buffers']``
   |shared_buffers postgresql| Default value:

   .. code-block:: ruby

      #{(node['memory']['total'].to_i / 4) / (1024)}MB

``postgresql['shell']``
   Default value: ``/bin/sh``.

``postgresql['shmall']``
   |postgresql shmall| Default value: ``4194304``.

``postgresql['shmmax']``
   |postgresql shmax| Default value: ``17179869184``.

``postgresql['sql_password']``
   |password postgresql_user| Default value: ``snakepliskin``.

``postgresql['sql_ro_password']``
   Default value: ``shmunzeltazzen``.

``postgresql['sql_ro_user']``
   Default value: ``opscode_chef_ro``.

``postgresql['sql_user']``
   Default value: ``opscode_chef``.

``postgresql['trust_auth_cidr_addresses']``
   |trust_auth_cidr_addresses| See ``md5_auth_cidr_addresses``. Default value: ``'127.0.0.1/32', '::1/128'``.

``postgresql['user_path']``
   Default value:

   .. code-block:: ruby

      /opt/opscode/embedded/bin:/opt/opscode/bin:$PATH

``postgresql['username']``
   |name user postgresql| Default value: ``opscode-pgsql``.

``postgresql['version']``
   |version postgresql| Default value: ``'9.2'``.

``postgresql['vip']``
   Required when ``postgresql['external']`` is set to ``true``. |ip_address virtual| |postgresql external_vip| Default value: ``127.0.0.1``. Set this value to the IP address or hostname for the machine on which external |postgresql| is located when ``postgresql['external']`` is set to ``true``.

``postgresql['work_mem']``
   |work_mem| Default value: ``8MB``.
