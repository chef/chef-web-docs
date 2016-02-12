.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


This configuration file has the following settings:

``add_formatter``
   |add_formatter| (See `nyan-cat <https://github.com/andreacampi/nyan-cat-chef-formatter>`_ for an example of a 3rd-party formatter.) Each formatter requires its own entry. For example:

   .. code-block:: ruby

      add_formatter :nyan
      add_formatter :foo
      add_formatter :bar

``cache_path``
   Optional. |cache_path| For example:

   .. code-block:: ruby

      cache_path '~/.chef/cache'
 
   or:

   .. code-block:: ruby

      cache_path File.join(File.expand_path('~'), '.chef', 'cache')

``checksum_path``
   |checksum_path| For example:

   .. code-block:: ruby

      checksum_path '/var/chef/checksums'

``chef_server_url``
   |chef_server_url| For example:

   .. code-block:: ruby

      chef_server_url 'http://localhost:4000'

``client_key``
   |client_key| Default value: ``/etc/chef/client.pem``. For example:

   .. code-block:: ruby

      client_key '/etc/chef/client.pem'

``client_registration_retries``
   |client_registration_retries| Default value: ``5``. For example:

   .. code-block:: ruby

      client_registration_retries 5

``cookbook_path``
   |cookbook_path subdirectory| For example:

   .. code-block:: ruby

      cookbook_path [ 
        '/var/chef/cookbooks', 
        '/var/chef/site-cookbooks' 
      ]

``data_bag_decrypt_minimum_version``
   |data_bag_decrypt_minimum_version| For example:

   .. code-block:: ruby

      data_bag_decrypt_minimum_version '2'

``data_bag_path``
   |data_bag_path| Default value: ``/var/chef/data_bags``. For example:

   .. code-block:: ruby

      data_bag_path '/var/chef/data_bags'

``diff_disabled``
   |diff_disabled| Default value: ``false``. For example:

   .. code-block:: ruby

      diff_disabled false

``diff_filesize_threshold``
   |diff_filesize_threshold| Default value: ``10000000``. For example:

   .. code-block:: ruby

      diff_filesize_threshold 10000000

``diff_output_threshold``
   |diff_output_threshold| Default value: ``1000000``. For example:

   .. code-block:: ruby

      diff_output_threshold 1000000

``encrypted_data_bag_secret``
   |encrypted_data_bag_secret| For example:

   .. code-block:: ruby

      encrypted_data_bag_secret '/etc/chef/encrypted_data_bag_secret'

``environment``
   |name environment| This is typically set from the command line (using the ``-E`` option) or in the |client rb| configuration file. For example:

   .. code-block:: ruby

      environment 'production'

``environment_path``
   |path environment|  Default value: ``/var/chef/environments``. For example:

   .. code-block:: ruby

      environment_path '/var/chef/environments'

``file_backup_path``
   |path file_backup| Default value: ``/var/chef/backup``. For example:

   .. code-block:: ruby

      file_backup_path '/var/chef/backup'

``file_cache_path``
   |file cache_path| For example:

   .. code-block:: ruby

      file_cache_path '/var/chef/cache'

``file_staging_uses_destdir``
   |file_staging_uses_destdir| Default value: ``false``. For example:

   .. code-block:: ruby

      file_staging_uses_destdir false

``group``
   |group config| For example:

   .. code-block:: ruby

      group nil

``http_proxy``
   |http_proxy| For example:

   .. code-block:: ruby

      http_proxy 'http://proxy.vmware.com:3128'

``http_proxy_pass``
   |http_proxy_pass| For example:

   .. code-block:: ruby

      http_proxy_pass '1234567890'

``http_proxy_user``
   |http_proxy_user| For example:

   .. code-block:: ruby

      http_proxy_user 'my_username'

``http_retry_count``
   |http_retry_count| For example:

   .. code-block:: ruby

      http_retry_count 5

``http_retry_delay``
   |http_retry_delay| For example:

   .. code-block:: ruby

      http_retry_delay 5

``https_proxy``
   |https_proxy| For example:

   .. code-block:: ruby

      https_proxy 'http://proxy.vmware.com:3128'

``https_proxy_pass``
   |https_proxy_pass| Default value: ``nil``. For example:

   .. code-block:: ruby

      https_proxy_pass '1234567890'

``https_proxy_user``
   |https_proxy_user| Default value: ``nil``. For example:

   .. code-block:: ruby

      https_proxy_user 'my_username'

``interval``
   |interval| Default value: ``1800``. For example:

   .. code-block:: ruby

      interval 1800

``json_attribs``
   |json attributes| For example:

   .. code-block:: ruby

      json_attribs nil

``lockfile``
   |lockfile| For example:

   .. code-block:: ruby

      lockfile nil

``log_level``
   |log_level| Possible levels: ``:auto`` (default), ``debug``, ``info``, ``warn``, ``error``, or ``fatal``. Default value: ``warn`` (when a terminal is available) or ``info`` (when a terminal is not available). For example:

   .. code-block:: ruby

      log_level :info

``log_location``
   |log_location| Possible values: ``/path/to/log_location``, ``STDOUT`` or ``STDERR``. The application log will specify the source as ``Chef``. Default value: ``STDOUT``. For example:

   .. code-block:: ruby

      log_location STDOUT

``no_proxy``
   |no_proxy| Default value: ``nil``. For example:

   .. code-block:: ruby

      no_proxy '*.vmware.com,10.*'

``node_name``
   |name node| |name node_client_rb| For example:

   .. code-block:: ruby

      node_name 'mynode.example.com'

``node_path``
   |node_path| Default value: ``/var/chef/node``. For example:

   .. code-block:: ruby

      node_path '/var/chef/node'

``pid_file``
   |path pid_file| Default value: ``/tmp/name-of-executable.pid``. For example:

   .. code-block:: ruby

      pid_file '/tmp/chef-client.pid'

``rest_timeout``
   |timeout rest| Default value: ``300``. For example:

   .. code-block:: ruby

      rest_timeout 300

``role_path``
   |path roles_chef| Default value: ``/var/chef/roles``. For example:

   .. code-block:: ruby

      role_path '/var/chef/roles'

``splay``
   |splay| Default value: ``nil``. For example:

   .. code-block:: ruby

      splay nil

``ssl_ca_file``
   |ssl_ca_file| For example:

   .. code-block:: ruby

      ssl_ca_file nil

``ssl_ca_path``
   |ssl_ca_path| For example:

   .. code-block:: ruby

      ssl_ca_path nil '/etc/ssl/certs'

``ssl_client_cert``
   |ssl_client_cert| For example:

   .. code-block:: ruby

      ssl_client_cert ''

``ssl_client_key``
   |ssl_client_key| For example:

   .. code-block:: ruby

      ssl_client_key ''

``ssl_verify_mode``
   |ssl_verify_mode|
       
   * |ssl_verify_mode_verify_none|
   * |ssl_verify_mode_verify_peer| This is the recommended setting.
       
   Depending on how |open ssl| is configured, the ``ssl_ca_path`` may need to be specified. For example:

   .. code-block:: ruby

      ssl_verify_mode :verify_peer

``syntax_check_cache_path``
   |syntax_check_cache_path|

``umask``
   |umask| Default value: ``0022``. For example:

   .. code-block:: ruby

      umask 0022

``user``
   |user chef_client| Default value: ``nil``. For example:

   .. code-block:: ruby

      user nil

``validation_client_name``
   |validation_client_name| For example:

   .. code-block:: ruby

      validation_client_name 'chef-validator'

``validation_key``
   |validation_key| Default value: ``/etc/chef/validation.pem``. For example:

   .. code-block:: ruby

      validation_key '/etc/chef/validation.pem'

``verbose_logging``
   |verbose_logging| Default value: ``nil``. For example, when ``verbose_logging`` is set to ``true`` or ``nil``:

   .. code-block:: bash

      [date] INFO: *** Chef 0.10.6.rc.1 ***
      [date] INFO: Setting the run_list 
                   to ["recipe[a-verbose-logging]"] from JSON
      [date] INFO: Run List is [recipe[a-verbose-logging]]
      [date] INFO: Run List expands to [a-verbose-logging]
      [date] INFO: Starting Chef Run for some_node
      [date] INFO: Running start handlers
      [date] INFO: Start handlers complete.
      [date] INFO: Loading cookbooks [test-verbose-logging]
      [date] INFO: Processing file[/tmp/a1] action create 
                   (a-verbose-logging::default line 20)
      [date] INFO: Processing file[/tmp/a2] action create 
                   (a-verbose-logging::default line 21)
      [date] INFO: Processing file[/tmp/a3] action create  
                   (a-verbose-logging::default line 22)
      [date] INFO: Processing file[/tmp/a4] action create  
                   (a-verbose-logging::default line 23)
      [date] INFO: Chef Run complete in 1.802127 seconds
      [date] INFO: Running report handlers
      [date] INFO: Report handlers complete

   When ``verbose_logging`` is set to ``false`` (for the same output):

   .. code-block:: bash

      [date] INFO: *** Chef 0.10.6.rc.1 ***
      [date] INFO: Setting the run_list 
                   to ["recipe[a-verbose-logging]"] from JSON
      [date] INFO: Run List is [recipe[a-verbose-logging]]
      [date] INFO: Run List expands to [a-verbose-logging]
      [date] INFO: Starting Chef Run for some_node
      [date] INFO: Running start handlers
      [date] INFO: Start handlers complete.
      [date] INFO: Loading cookbooks [a-verbose-logging]
      [date] INFO: Chef Run complete in 1.565369 seconds
      [date] INFO: Running report handlers
      [date] INFO: Report handlers complete

   Where in the examples above, ``[date]`` represents the date and time the long entry was created. For example: ``[Mon, 21 Nov 2011 09:37:39 -0800]``.
