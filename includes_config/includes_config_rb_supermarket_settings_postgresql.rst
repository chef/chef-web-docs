.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


This configuration file has the following settings for |postgresql|:

``supermarket['postgresql']['checkpoint_completion_target']``
   |checkpoint_completion_target| Default value: ``0.5``.

``supermarket['postgresql']['checkpoint_segments']``
   |checkpoint_segments| Default value: ``3``.

``supermarket['postgresql']['checkpoint_timeout']``
   |checkpoint_timeout| Default value: ``'5min'``.

``supermarket['postgresql']['checkpoint_warning']``
   |checkpoint_warning| Default value: ``'30s'``.

``supermarket['postgresql']['data_directory']``
   |directory generic_data| |default_value_recommended| Default value: ``"#{node['supermarket']['var_directory']}/postgresql/9.3/data"``.

``supermarket['postgresql']['effective_cache_size']``
   |effective_cache_size postgresql| Default value: ``'128MB'``.

``supermarket['postgresql']['enable']``
   |enable service| Default value: ``true``.

``supermarket['postgresql']['listen_address']``
   |port listen_postgresql| Default value: ``'127.0.0.1'``.

``supermarket['postgresql']['log_directory']``
   |directory logs| |default_value_recommended| Default value: ``"#{node['supermarket']['log_directory']}/postgresql"``.

``supermarket['postgresql']['log_rotation']``
   |log_rotation| Default value: ``{ 'file_maxbytes' => 104857600, 'num_to_keep' => 10 }``

``supermarket['postgresql']['max_connections']``
   |max_connections| Default value: ``350``.

``supermarket['postgresql']['md5_auth_cidr_addresses']``
   Use to encrypt passwords using MD5 hashes. Default value: ``['127.0.0.1/32', '::1/128']``.

``supermarket['postgresql']['port']``
   |port service| Default value: ``15432``.

``supermarket['postgresql']['shared_buffers']``
   |shared_buffers postgresql| Default value: ``"#{(node['memory']['total'].to_i / 4) / (1024)}MB"``.

``supermarket['postgresql']['shmall']``
   The total amount of available shared memory. Default value: ``4194304``.

``supermarket['postgresql']['shmmax']``
   The maximum amount of shared memory. Default value: ``17179869184``.

``supermarket['postgresql']['work_mem']``
   |work_mem| Default value: ``'8MB'``.
