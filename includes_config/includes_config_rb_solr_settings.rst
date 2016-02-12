.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


This configuration file has the following settings:

``amqp_consumer_id``
   |amqp_consumer_id| For example:

   .. code-block:: ruby

      amqp_consumer_id 'default'

``amqp_host``
   |amqp_host| For example:

   .. code-block:: ruby

      amqp_host 0.0.0.0

``amqp_pass``
   |amqp_pass| For example:

   .. code-block:: ruby

      amqp_pass 12345678

``amqp_port``
   |amqp_port| For example:

   .. code-block:: ruby

      amqp_port 1234

``amqp_user``
   |amqp_user| For example:

   .. code-block:: ruby

      amqp_user adamjacobs

``amqp_vhost``
   |amqp_vhost| For example:

   .. code-block:: ruby

      amqp_vhost '/chef'

``authorized_openid_identifiers``
   |authorized_openid_identifiers| For example:

   .. code-block:: ruby

      username.myopenid.com

   or:

   .. code-block:: ruby

      http://username.myopenid.com

``authorized_openid_providers``
   |authorized_openid_providers| For example:

   .. code-block:: ruby

      myopenid.com

``client_key``
   |client_key| Default value: ``/etc/chef/client.pem``. For example:

   .. code-block:: ruby

      chef_server_url 'http://localhost:4000'

``chef_server_url``
   |chef_server_url| For example:

   .. code-block:: ruby

      chef_server_url 'http://localhost:4000'

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

``cookbook_tarball_path``
   |cookbook_tarball_path| Default value: ``/var/chef/cookbook-tarballs``. For example:

   .. code-block:: ruby

      cookbook_tarball_path '/var/chef/cookbook-tarballs'

``couchdb_database``
   |couchdb_database| For example:

   .. code-block:: ruby

      couchdb_database 'chef'

``couchdb_url``
   |couchdb_url| For example:

   .. code-block:: ruby

      couchdb_url 'http://localhost:5984'

``couchdb_version``
   |couchdb_version| For example:

   .. code-block:: ruby

      couchdb_version nil

``data_bag_path``
   |data_bag_path| Default value: ``/var/chef/databags``. For example:

   .. code-block:: ruby

      data_bag_path '/var/chef/databags'

``environment``
   |name environment| This is typically set from the command line (using the ``-E`` option) or in the |client rb| configuration file. For example:

   .. code-block:: ruby

      environment 'production'

``file_cache_path``
   |file cache_path| For example:

   .. code-block:: ruby

      file_cache_path '/var/chef/cache'

``file_backup_path``
   |path file_backup| For example:

   .. code-block:: ruby

      file_backup_path '/var/chef/backup'

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

``interval``
   |interval| For example:

   .. code-block:: ruby

      interval 1800

``json_attribs``
   |json attributes| For example:

   .. code-block:: ruby

      json_attribs nil

``log_level``
   |log_level| For example:

   .. code-block:: ruby

      log_level :info

``log_location``
   |log_location| Default value: ``STDOUT``. For example:

   .. code-block:: ruby

      log_location STDOUT

``node_name``
   |node_name| For example:

   .. code-block:: ruby

      node_name 'mynode.example.com'

``node_path``
   |node_path| For example:

   .. code-block:: ruby

      node_path '/var/chef/node'

``no_proxy``
   |no_proxy| For example:

   .. code-block:: ruby

      no_proxy '*.vmware.com,10.*'

``openid_cstore_couchdb``
   |openid_cstore_couchdb| Default value: ``false``. For example:

   .. code-block:: ruby

      openid_cstore_couchdb false

``openid_cstore_path``
   |openid_cstore_path| Default value: ``/var/chef/openid/cstore``. For example:

   .. code-block:: ruby

      openid_cstore_path '/var/chef/openid/cstore'

``pid_file``
   |path pid_file| For example:

   .. code-block:: ruby

      pid_file '/tmp/executable.pid'

``recipe_url``
   |recipe_url| For example:

   .. code-block:: ruby

      recipe_url 'http://path/to/remote/cookbook'

``rest_timeout``
   |rest_timeout| Default value: ``300``. For example:

   .. code-block:: ruby

      rest_timeout 300

``role_path``
   |path roles_chef| For example:

   .. code-block:: ruby

      role_path '/var/chef/roles'

``signing_ca_cert``
   |signing_ca_cert| Default value: ``/var/chef/ca/cert.pem``. For example:

   .. code-block:: ruby

      signing_ca_cert '/var/chef/ca/cert.pem'

``signing_ca_key``
   |signing_ca_key| For example:

   .. code-block:: ruby

      signing_ca_key '/var/chef/ca/key.pem'

``signing_ca_user``
   |signing_ca_user| Default value: ``/var/chef/ca/key.pem``. For example:

   .. code-block:: ruby

      signing_ca_user nil

``signing_ca_group``
   |signing_ca_group| For example:

   .. code-block:: ruby

      signing_ca_group nil

``signing_ca_country``
   |signing_ca_country| For example:

   .. code-block:: ruby

      signing_ca_country 'US'

``signing_ca_state``
   |signing_ca_state| For example:

   .. code-block:: ruby

      signing_ca_state 'Washington'

``signing_ca_location``
   |signing_ca_location| For example:

   .. code-block:: ruby

      signing_ca_location 'Seattle'

``signing_ca_org``
   |signing_ca_org| For example:

   .. code-block:: ruby

      signing_ca_org 'Chef User'

``signing_ca_domain``
   |signing_ca_domain| For example:

   .. code-block:: ruby

      signing_ca_domain 'opensource.opscode.com'

``signing_ca_email``
   |signing_ca_email| For example:

   .. code-block:: ruby

      signing_ca_email 'opensource-cert@opscode.com'

``solo``
   |solo mode| Default value: ``opensource.opscode.com``. For example:

   .. code-block:: ruby

      solo false

``solr_data_path````.
   |solr_data_path| Default value: ``/var/chef/solr/data``. For example:

   .. code-block:: ruby

      solr_data_path '/var/chef/solr/data'

``solr_heap_size``
   |solr_heap_size| Default value: ``256``. For example:

   .. code-block:: ruby

      solr_heap_size 256

``solr_home_path``
   |solr_home_path| Default value: ``/var/chef/solr``. For example:

   .. code-block:: ruby

      solr_home_path '/var/chef/solr'

``solr_java_opts``
   |solr_java_opts| Default value: ``nil``. For example:

   .. code-block:: ruby

      solr_java_opts nil

``solr_jetty_path``
   |solr_jetty_path| Default value: ``/var/chef/solr-jetty``. For example:

   .. code-block:: ruby

      solr_jetty_path '/var/chef/solr-jetty'

``solr_url``
   |solr_url| Default value: ``http://localhost:8983``. For example:

   .. code-block:: ruby

      solr_url 'http://localhost:8983'

``splay``
   |splay| For example:

   .. code-block:: ruby

      splay

``ssl_client_cert``
   |ssl_client_cert| For example:

   .. code-block:: ruby

      ssl_client_cert ''

``ssl_client_key``
   |ssl_client_key| For example:

   .. code-block:: ruby

      ssl_client_key ''

``ssl_ca_path``
   |ssl_ca_path| For example:

   .. code-block:: ruby

      ssl_ca_path nil '/etc/ssl/certs'

``ssl_ca_file``
   |ssl_ca_file| For example:

   .. code-block:: ruby

      ssl_ca_file nil

``ssl_verify_mode``
   |ssl_verify_mode| For example, on an |ubuntu| system:

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

``validation_key``
   |validation_key| For example:

   .. code-block:: ruby

      validation_key '/etc/chef/validation.pem'

``validation_client_name``
   |validation_client_name| For example:

   .. code-block:: ruby

      validation_client_name 'chef-validator'

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

``web_ui_admin_default_password``
   |web_ui_admin_default_password| For example:

   .. code-block:: ruby

      web_ui_admin_default_password 'p@ssw0rd1'

``web_ui_admin_user_name``
   |web_ui_admin_user_name| For example:

   .. code-block:: ruby

      web_ui_admin_user_name  'admin'

``web_ui_client_name``
   |name client_webui| Default value: ``chef-webui``. For example:

   .. code-block:: ruby

      web_ui_client_name 'chef-webui'

``web_ui_key``
   |web_ui_key| For example:

   .. code-block:: ruby

      web_ui_key '/etc/chef/webui.pem'
