.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


This configuration file has the following settings:

``postgresql['checkpoint_completion_target']``
   A completion percentage that is used to determine how quickly a checkpoint should finish in relation to the completion status of the next checkpoint. For example, if the value is ``0.5``, then a checkpoint attempts to finish before 50% of the next checkpoint is done. Default value: ``0.9``.

``postgresql['checkpoint_segments']``
   The maximum amount (in megabytes) between checkpoints in log file segments. Default value: ``10``.

``postgresql['checkpoint_timeout']``
   The amount of time (in minutes) between checkpoints. Default value: ``5min``.

``postgresql['checkpoint_warning']``
   The frequency (in seconds) at which messages are sent to the server log files if checkpoint segments are being filled faster than their currently configured values. Default value: ``30s``.

``postgresql['data_dir']``
   The directory in which on-disk data is stored. The default value is the recommended value. Default value: ``/var/opt/chef-server/postgresql/data``.

``postgresql['dir']``
   The working directory. The default value is the recommended value. Default value: ``/var/opt/chef-server/postgresql``.

``postgresql['effective_cache_size']``
   The size of the disk cache that is used for data files. Default value: ``#{(node['memory']['total'].to_i / 2) / (1024)}MB``.

``postgresql['enable']``
   Enable a service. Default value: ``true``.

``postgresql['ha']``
   Run the Chef server in a high availability topology. Default value: ``false``.

``postgresql['home']``
   The home directory for PostgreSQL. Default value: ``/var/opt/chef-server/postgresql``.

``postgresql['listen_address']``
   The connection source to which PostgreSQL is to respond. Default value: ``0.0.0.0``.

``postgresql['log_directory']``
   The directory in which log data is stored. Default value: ``/var/log/chef-server/postgresql``.

``postgresql['max_connections']``
   The maximum number of allowed concurrent connections. Default value: ``200``.

``postgresql['md5_auth_cidr_addresses']``
   Default value: ``[ ]``.

``postgresql['port']``
   The port on which the service is to listen. Default value: ``5432``.

``postgresql['shared_buffers']``
   The amount of memory that is dedicated to PostgreSQL for data caching. Default value: ``#{(node['memory']['total'].to_i / 4) / (1024)}MB``.

``postgresql['shmall']``
   The total amount of available shared memory. Default value: ``kernel['machine'] =~ /x86_64/ ? 4194304 : 1048575``.

``postgresql['shmmax']``
   The maximum amount of shared memory. Default value: ``kernel['machine'] =~ /x86_64/ ? 17179869184 : 4294967295``.

``postgresql['shell']``
   Default value: ``/bin/sh``.

``postgresql['sql_password']``
   The password for the PostgreSQL user account. Default value: ``snakepliskin``.

``postgresql['sql_ro_password']``
   Default value: ``shmunzeltazzen``.

``postgresql['sql_ro_user']``
   Default value: ``opscode_chef_ro``.

``postgresql['sql_user']``
   Default value: ``opscode_chef``.

``postgresql['svlogd_num']``
   The number of svlogd log files to retain. Default value: ``10``.

``postgresql['svlogd_size']``
   The size (in bytes) of the svlogd log file. Default value: ``1000000``.

``postgresql['trust_auth_cidr_addresses']``
   Default value: ``'127.0.0.1/32', '::1/128'``.

``postgresql['user_path']``
   Default value: ``/opt/chef-server/embedded/bin:/opt/chef-server/bin:$PATH``.

``postgresql['username']``
   The PostgreSQL account user name. Default value: ``opscode-pgsql``.

``postgresql['vip']``
   The virtual IP address. Default value: ``127.0.0.1``.

``postgresql['work_mem']``
   The size (in megabytes) of allowed in-memory sorting. Default value: ``8MB``.
