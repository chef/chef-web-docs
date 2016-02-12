.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


This configuration file has the following settings for ``oc-id``:

``oc_id['administrators']``
   |user ocid_admins| For example, ``['user1', 'user2']``. Default value: ``[ ]``.

``oc_id['applications']``
   |application ocid| Default value: ``{ }``. 

   .. include:: ../../step_config/step_config_ocid_application_hash.rst

``oc_id['db_pool_size']``
   |db_pool_size| Default value: ``'20'``.

``oc_id['dir']``
   |directory generic| |default_value_recommended| Default value: none.

``oc_id['enable']``
   |enable service| Default value: ``true``.

``oc_id['ha']``
   |use ha| |ha true| Default value: ``false``.

``oc_id['log_directory']``
   |directory logs| |default_value_recommended| Default value: ``'/var/opt/opscode/oc_id'``.

``oc_id['log_rotation']``
   |log_rotation| Default value:

   .. code-block:: ruby

      { 'file_maxbytes' => 104857600, 'num_to_keep' => 10 }

``oc_id['num_to_keep']``
   |num_to_keep| Default value: ``10``.

``oc_id['port']``
   |port service| Default value: ``9090``.

``oc_id['sql_database']``
   |name db_ocid| Default value: ``oc_id``.

``oc_id['sql_password']``
   |password sql_user| Default value: ``snakepliskin``.

``oc_id['sql_user']``
   |user ocid| Default value: ``oc_id``.

``oc_id['vip']``
   |ip_address virtual| Default value: ``'127.0.0.1'``.
