.. THIS PAGE DOCUMENTS Push Jobs version 2.1

=====================================================
push-jobs-client.rb
=====================================================

A ``push-jobs-client.rb`` file is used to specify the configuration details for the |push jobs| client.

* This file is loaded every time this executable is run
* This file is not created by default
* When a ``push-jobs-client.rb`` file is present in the default location, the settings contained within that file will override the default configuration settings

Settings
==========================================================================
This configuration file has the following settings:

``allow_unencrypted``
   Allow unencrypted connections to 1.x servers. Default value: ``false``

``chef_server_url``
   |chef_server_url| For example:

   .. code-block:: ruby

      http://localhost:4000/organizations/ORG_NAME

``client_key``
   |client_key| Default value: ``/etc/chef/client.pem``.

``file_dir``
   The directory for temporary files. Default value: ``/tmp/chef-push``.

``node_name``
   |name node|

``ssl_verify_mode``
   |ssl_verify_mode|

   * |ssl_verify_mode_verify_none|
   * |ssl_verify_mode_verify_peer| This is the recommended setting.

   Depending on how |open ssl| is configured, the ``ssl_ca_path`` may need to be specified. Default value: ``:verify_peer``.

``trusted_certs_dir``
   The location of trusted certificates. Default value: ``'/etc/chef/trusted_certs'``.

``whitelist``
   A |ruby hash| that contains the whitelist used by |push jobs|. For example:

   .. code-block:: ruby

      whitelist {
        'job-name' => 'command',
        'job-name' => 'command',
        'chef-client' => 'chef-client'
      }
