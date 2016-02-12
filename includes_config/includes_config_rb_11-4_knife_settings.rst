.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


This configuration file has the following settings:

``chef_server_url``
   |chef_server_url| For example:

   .. code-block:: ruby

      chef_server_url 'http://localhost:4000'

``client_key``
   |client_key| Default value: ``/etc/chef/client.pem``. For example:

   .. code-block:: ruby

      client_key '/etc/chef/client.pem'

``cookbook_copyright``
   |copyright|

``cookbook_email``
   |email|

``data_bag_encrypt_version``
   The minimum required version of data bag encryption. Possible values: ``1`` or ``2``. When all of the machines in an organization are running |chef client| version 11.6 (or higher), it is recommended that this value be set to ``2``. For example:

   .. code-block:: ruby

      data_bag_encrypt_version 2

``cookbook_license``
   |license|


``cookbook_path``
   |cookbook_path subdirectory| For example:

   .. code-block:: ruby

      cookbook_path [ 
        '/var/chef/cookbooks', 
        '/var/chef/site-cookbooks' 
      ]

``http_proxy``
   |http_proxy| For example:

   .. code-block:: ruby

      http_proxy 'http://proxy.vmware.com:3128'

``https_proxy``
   |https_proxy| For example:

   .. code-block:: ruby

      https_proxy 'http://proxy.vmware.com:3128'

``http_proxy_user``
   |http_proxy_user|

``http_proxy_pass``
   |http_proxy_pass|

``node_name``
   |name node_knife_rb| For example:

   .. code-block:: ruby

      node_name 'user_name'

   or:

   .. code-block:: ruby

      node_name 'machine_name'

``no_proxy``
   |no_proxy| Default value: ``nil``. For example:

   .. code-block:: ruby

      no_proxy 'localhost, 10.*, *.example.com, *.dev.example.com'

``syntax_check_cache_path``
   |syntax_check_cache_path|

``validation_client_name``
   |validation_client_name| For example:

   .. code-block:: ruby

      validation_client_name 'chef-validator'

``validation_key``
   |validation_key| Default value: ``/etc/chef/validation.pem``. For example:

   .. code-block:: ruby

      validation_key '/etc/chef/validation.pem'
