.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

A recipe should be clean and well-commented. For example:

.. code-block:: ruby

   ###########
   # variables
   ###########
   
   connection_info = {
     host: '127.0.0.1',
     port: '3306',
     username: 'root',
     password: 'm3y3sqlr00t'
   }
   
   #################
   # Mysql resources
   #################
   
   mysql_service 'default' do
     port '3306'
     initial_root_password 'm3y3sqlr00t'
     action [:create, :start]
   end
   
   mysql_database 'wordpress_demo' do
     connection connection_info
     action :create
   end
   
   mysql_database_user 'wordpress_user' do
     connection connection_info
     database_name 'wordpress_demo'
     password 'w0rdpr3ssdem0'
     privileges [:create, :delete, :select, :update, :insert]
     action :grant
   end
   
   ##################
   # Apache resources
   ##################
   
   httpd_service 'default' do
     listen_ports %w(80)
     mpm 'prefork'
     action [:create, :start]
   end
   
   httpd_module 'php' do
     notifies :restart, 'httpd_service[default]'
     action :create
   end
   
   ###############
   # Php resources
   ###############
   
   # php_runtime 'default' do
   #   action :install
   # end
   
   package 'php-gd' do
     action :install
   end
   
   package 'php-mysql' do
     action :install
   end
   
   directory '/etc/php.d' do
     action :create
   end
   
   template '/etc/php.d/mysql.ini' do
     source 'mysql.ini.erb'
     action :create
   end
   
   httpd_config 'php' do
     source 'php.conf.erb'
     notifies :restart, 'httpd_service[default]'
     action :create
   end
   
   #####################
   # wordpress resources
   #####################
   
   directory '/srv/wordpress_demo' do
     user 'apache'
     recursive true
     action :create
   end
   
   tar_extract 'https://wordpress.org/wordpress-4.1.tar.gz' do
     target_dir '/srv/wordpress_demo'
     tar_flags ['--strip-components 1']
     user 'apache'
     creates '/srv/wordpress_demo/index.php'
     action :extract
   end
   
   directory '/srv/wordpress_demo/wp-content' do
     user 'apache'  
     action :create
   end
   
   httpd_config 'wordpress' do
     source 'wordpress.conf.erb'
     variables(
       servername: 'wordpress',
       server_aliases: %w(computers.biz www.computers.biz),
       document_root: '/srv/wordpress_demo'
       )
     notifies :restart, 'httpd_service[default]'
     action :create
   end
   
   template '/srv/wordpress_demo/wp-config.php' do
     source 'wp-config.php.erb'
     owner 'apache'
     variables(
       db_name: 'wordpress_demo',
       db_user: 'wordpress_user',
       db_password: 'w0rdpr3ssdem0',
       db_host: '127.0.0.1',
       db_prefix: 'wp_',
       db_charset: 'utf8',
       auth_key: 'You should probably use randomly',
       secure_auth_key: 'generated strings. These can be hard',
       logged_in_key: 'coded, pulled from encrypted databags,',
       nonce_key: 'or a ruby function that accessed an',
       auth_salt: 'arbitrary data source, such as a password',
       secure_auth_salt: 'vault. Node attributes could work',
       logged_in_salt: 'as well, but you take special care',
       nonce_salt: 'so they are not saved to your chef-server.',
       allow_multisite: 'false'
       )
     action :create
   end
