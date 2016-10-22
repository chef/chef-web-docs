.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


This configuration file has the following settings:

``chef_server_url``
   The URL for the Chef server. For example:

   .. code-block:: ruby

      chef_server_url 'https://localhost/'

``chef_zero.enabled``
   Enable chef-zero. This setting requires ``local_mode`` to be set to ``true``. Default value: ``false``. For example:

   .. code-block:: ruby

      chef_zero.enabled true

``chef_zero[:port]``
   The port on which chef-zero is to listen. Default value: ``8889``. For example:

   .. code-block:: ruby

      chef_zero[:port] 8889

``client_key``
   The location of the file that contains the client key. Default value: ``/etc/chef/client.pem``. For example:

   .. code-block:: ruby

      client_key '/etc/chef/client.pem'

``cookbook_copyright``
   The name of the copyright holder. This option places a copyright notice that contains the name of the copyright holder in each of the pre-created files. If this option is not specified, a copyright name of "COMPANY_NAME" is used instead; it can easily be modified later.

``cookbook_email``
   The email address for the individual who maintains the cookbook. This option places an email address in each of the pre-created files. If not specified, an email name of "YOUR_EMAIL" is used instead; this can easily be modified later.

``cookbook_license``
   The type of license under which a cookbook is distributed: ``apachev2``, ``gplv2``, ``gplv3``, ``mit``, or ``none`` (default). This option places the appropriate license notice in the pre-created files: ``Apache v2.0`` (for ``apachev2``), ``GPL v2`` (for ``gplv2``), ``GPL v3`` (for ``gplv3``), ``MIT`` (for ``mit``), or ``license 'Proprietary - All Rights Reserved`` (for ``none``). Be aware of the licenses for files inside of a cookbook and be sure to follow any restrictions they describe.

``cookbook_path``
   The sub-directory for cookbooks on the chef-client. This value can be a string or an array of file system locations, processed in the specified order. The last cookbook is considered to override local modifications. For example:

   .. code-block:: ruby

      cookbook_path [ 
        '/var/chef/cookbooks', 
        '/var/chef/site-cookbooks' 
      ]

``data_bag_encrypt_version``
   The minimum required version of data bag encryption. Possible values: ``1`` or ``2``. When all of the machines in an organization are running chef-client version 11.6 (or higher), it is recommended that this value be set to ``2``. For example:

   .. code-block:: ruby

      data_bag_encrypt_version 2

``local_mode``
   Run the chef-client in local mode. This allows all commands that work against the Chef server to also work against the local chef-repo. For example:

   .. code-block:: ruby

      local_mode true

``node_name``
   The name of the node. This may be a username with permission to authenticate to the Chef server or it may be the name of the machine from which knife is run. For example:

   .. code-block:: ruby

      node_name 'user_name'

   or:

   .. code-block:: ruby

      node_name 'machine_name'

``no_proxy``
   A comma-separated list of URLs that do not need a proxy. Default value: ``nil``. For example:

   .. code-block:: ruby

      no_proxy 'localhost, 10.*, *.example.com, *.dev.example.com'

``syntax_check_cache_path``
   All files in a cookbook must contain valid Ruby syntax. Use this setting to specify the location in which knife caches information about files that have been checked for valid Ruby syntax.

``validation_client_name``
   The name of the chef-validator key that is used by the chef-client to access the Chef server during the initial chef-client run. For example:

   .. code-block:: ruby

      validation_client_name 'chef-validator'

``validation_key``
   The location of the file that contains the key used when a chef-client is registered with a Chef server. A validation key is signed using the ``validation_client_name`` for authentication. Default value: ``/etc/chef/validation.pem``. For example:

   .. code-block:: ruby

      validation_key '/etc/chef/validation.pem'

``verify_api_cert``
   Verify the SSL certificate on the Chef server. When ``true``, the chef-client always verifies the SSL certificate. When ``false``, the chef-client uses the value of ``ssl_verify_mode`` to determine if the SSL certificate requires verification. Default value: ``false``.

``versioned_cookbooks``
   Append cookbook versions to cookbooks. Set to ``false`` to hide cookbook versions: ``cookbooks/apache``. Set to ``true`` to show cookbook versions: ``cookbooks/apache-1.0.0`` and/or ``cookbooks/apache-1.0.1``. When this setting is ``true``, ``knife download`` downloads ALL cookbook versions, which can be useful if a full-fidelity backup of data on the Chef server is required. For example:

   .. code-block:: ruby

      versioned_cookbooks true
