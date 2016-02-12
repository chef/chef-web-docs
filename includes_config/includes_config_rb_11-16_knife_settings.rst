.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


This configuration file has the following settings:

``chef_server_url``
   |chef_server_url| For example:

   .. code-block:: ruby

      chef_server_url 'http://localhost:4000'

``chef_zero.enabled``
   |chef_zero_enabled| This setting requires ``local_mode`` to be set to ``true``. Default value: ``false``. For example:

   .. code-block:: ruby

      chef_zero.enabled true

``chef_zero[:port]``
   |chef_zero_port| Default value: ``8889``. For example:

   .. code-block:: ruby

      chef_zero[:port] 8889

``client_key``
   |client_key| Default value: ``/etc/chef/client.pem``. For example:

   .. code-block:: ruby

      client_key '/etc/chef/client.pem'

``cookbook_copyright``
   |copyright|

``cookbook_email``
   |email|

``cookbook_license``
   |license|

``cookbook_path``
   |cookbook_path subdirectory| For example:

   .. code-block:: ruby

      cookbook_path [ 
        '/var/chef/cookbooks', 
        '/var/chef/site-cookbooks' 
      ]

``data_bag_encrypt_version``
   The minimum required version of data bag encryption. Possible values: ``1`` or ``2``. When all of the machines in an organization are running |chef client| version 11.6 (or higher), it is recommended that this value be set to ``2``. For example:

   .. code-block:: ruby

      data_bag_encrypt_version 2

``local_mode``
   |local_mode| For example:

   .. code-block:: ruby

      local_mode true

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

``verify_api_cert``
   |ssl_verify_mode_verify_api_cert| Default value: ``false``.

``versioned_cookbooks``
   |versioned_cookbooks| For example:

   .. code-block:: ruby

      versioned_cookbooks true
