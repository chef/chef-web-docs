.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


This configuration file has the following settings:

``add_formatter``
   |add_formatter| (See `nyan-cat <https://github.com/andreacampi/nyan-cat-chef-formatter>`_ for an example of a 3rd-party formatter.) Each formatter requires its own entry.

``cache_path``
   Optional. |cache_path|

``checksum_path``
   |checksum_path|

``chef_server_url``
   |chef_server_url|

``chef_zero.enabled``
   |chef_zero_enabled| Default value: ``false``.

``chef_zero[:port]``
   |chef_zero_port| Default value: ``8889``.

``client_key``
   |client_key| Default value: ``/etc/chef/client.pem``.

``client_registration_retries``
   |client_registration_retries| Default value: ``5``.

``cookbook_path``
   |cookbook_path subdirectory|

``data_bag_decrypt_minimum_version``
   |data_bag_decrypt_minimum_version|

``data_bag_path``
   |data_bag_path| Default value: ``/var/chef/data_bags``.

``diff_disabled``
   |diff_disabled| Default value: ``false``.

``diff_filesize_threshold``
   |diff_filesize_threshold| Default value: ``10000000``.

``diff_output_threshold``
   |diff_output_threshold| Default value: ``1000000``.

``enable_reporting``
   |enable reporting| 

   .. warning:: This setting is available only when using |reporting|, an add-on for |chef server oec| that collects reporting data about nodes.

``enable_reporting_url_fatals``
   |enable reporting_url_fatals|

   .. warning:: This setting is available only when using |reporting|, an add-on for |chef server oec| that collects reporting data about nodes.

``enable_selinux_file_permission_fixup``
   |enable_selinux_file_permission_fixup|

``encrypted_data_bag_secret``
   |encrypted_data_bag_secret|

``environment``
   |name environment|

``environment_path``
   |path environment|  Default value: ``/var/chef/environments``.

``file_atomic_update``
   |file atomic_update| Default value: ``true``.

``file_backup_path``
   |path file_backup| Default value: ``/var/chef/backup``.

``file_cache_path``
   |file cache_path|

``file_staging_uses_destdir``
   |file_staging_uses_destdir| Default value: ``false``.

``group``
   |group config|

``http_proxy``
   |http_proxy| Default value: ``nil``.

``http_proxy_pass``
   |http_proxy_pass| Default value: ``nil``.

``http_proxy_user``
   |http_proxy_user| Default value: ``nil``.

``http_retry_count``
   |http_retry_count| Default value: ``5``.

``http_retry_delay``
   |http_retry_delay| Default value: ``5``.

``https_proxy``
   |https_proxy| Default value: ``nil``.

``https_proxy_pass``
   |https_proxy_pass| Default value: ``nil``.

``https_proxy_user``
   |https_proxy_user| Default value: ``nil``.

``interval``
   |interval| Default value: ``1800``.

``json_attribs``
   |json attributes|

``local_key_generation``
   |generate local_keys|

``local_mode``
   |local_mode|

``lockfile``
   |lockfile|

``log_level``
   |log_level| Possible levels: ``:auto`` (default), ``:debug``, ``:info``, ``:warn``, ``:error``, or ``:fatal``. Default value: ``:warn`` (when a terminal is available) or ``:info`` (when a terminal is not available).

``log_location``
   |log_location| Possible values: ``/path/to/log_location``, ``STDOUT`` or ``STDERR``. The application log will specify the source as ``Chef``. Default value: ``STDOUT``.

``no_lazy_load``
   |no_lazy_load| Default value: ``false``.

``no_proxy``
   |no_proxy| Default value: ``nil``.

``node_name``
   |name node| |name node_client_rb|

``node_path``
   |node_path| Default value: ``/var/chef/node``.

``pid_file``
   |path pid_file| Default value: ``/tmp/name-of-executable.pid``.

``rest_timeout``
   |timeout rest|

``role_path``
   |path roles_chef| Default value: ``/var/chef/roles``.

``splay``
   |splay| Default value: ``nil``.

``ssl_ca_file``
   |ssl_ca_file|

``ssl_ca_path``
   |ssl_ca_path|

``ssl_client_cert``
   |ssl_client_cert|

``ssl_client_key``
   |ssl_client_key|

``ssl_verify_mode``
   |ssl_verify_mode|
       
   * |ssl_verify_mode_verify_none|
   * |ssl_verify_mode_verify_peer| This is the recommended setting.
       
   Depending on how |open ssl| is configured, the ``ssl_ca_path`` may need to be specified.

``syntax_check_cache_path``
   |syntax_check_cache_path|

``umask``
   |umask| Default value: ``0022``.

``user``
   |user chef_client| Default value: ``nil``.

``validation_client_name``
   |validation_client_name|

``validation_key``
   |validation_key| Default value: ``/etc/chef/validation.pem``.

``verbose_logging``
   |verbose_logging| Default value: ``nil``.

``verify_api_cert``
   |ssl_verify_mode_verify_api_cert| Default value: ``false``.

``whitelist``
   A |ruby hash| that contains the whitelist used by |push jobs|. For example:

   .. code-block:: ruby

      whitelist {
        'job-name' => 'command',
        'job-name' => 'command',
        'chef-client' => 'chef-client'
      }

   A job entry may also be ``'job-name' => {:lock => true}``, which will check the ``lockfile`` setting in the |client rb| file before starting the job.

   .. warning:: The ``whitelist`` setting is available only when using |push jobs|, a tool that runs jobs against nodes in an |chef server| organization.
