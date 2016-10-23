.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


This configuration file has the following settings for ``oc-id``:

``oc_id['administrators']``
   An array of Chef server user names who may add applications to the identity service. For example, ``['user1', 'user2']``. Default value: ``[ ]``.

``oc_id['applications']``
   A Hash that contains OAuth 2 application information. Default value: ``{ }``. 

   .. include:: ../../step_config/step_config_ocid_application_hash_supermarket.rst

   To define OAuth 2 information for Chef Analytics, create a Hash similar to:
   
      .. code-block:: ruby
   
         oc_id['applications'] ||= {}
         oc_id['applications']['analytics'] = {
           'redirect_uri' => 'https://analytics.rhel.aws'
         }

``oc_id['db_pool_size']``
   The number of open connections to PostgreSQL that are maintained by the service. Default value: ``'20'``.

``oc_id['dir']``
   The working directory. The default value is the recommended value. Default value: none.

``oc_id['enable']``
   Enable a service. Default value: ``true``.

``oc_id['ha']``
   Run the Chef server in a high availability topology. When ``topology`` is set to ``ha``, this setting defaults to ``true``. Default value: ``false``.

``oc_id['log_directory']``
   The directory in which log data is stored. The default value is the recommended value. Default value: ``'/var/opt/opscode/oc_id'``.

``oc_id['log_rotation']``
   The log rotation policy for this service. Log files are rotated when they exceed ``file_maxbytes``. The maximum number of log files in the rotation is defined by ``num_to_keep``. Default value:

   .. code-block:: ruby

      { 'file_maxbytes' => 104857600, 'num_to_keep' => 10 }

``oc_id['num_to_keep']``
   The number of log files to keep. Default value: ``10``.

``oc_id['port']``
   The port on which the service is to listen. Default value: ``9090``.

``oc_id['sql_database']``
   The name of the database. Default value: ``oc_id``.

``oc_id['sql_password']``
   The password for the ``sql_user``. Default value: ``snakepliskin``.

``oc_id['sql_user']``
   The user with permission to write to ``sql_database``. Default value: ``oc_id``.

``oc_id['vip']``
   The virtual IP address. Default value: ``'127.0.0.1'``.
