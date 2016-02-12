.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


This configuration file has the following settings for ``oc-chef-pedant``:

``oc_chef_pedant['debug_org_creation']``
   |pedant debug_org_creation| Default value: ``false``.

``oc_chef_pedant['dir']``
   |directory generic| |default_value_recommended| Default value:

   .. code-block:: ruby

      '/var/opt/opscode/oc-chef-pedant'

``oc_chef_pedant['log_directory']``
   |directory logs| |default_value_recommended| Default value:

   .. code-block:: ruby

      '/var/log/opscode/oc-chef-pedant'

``oc_chef_pedant['log_http_requests']``
   |pedant log_http_requests| Default value: ``true``.

``oc_chef_pedant['log_rotation']``
   |log_rotation| Default value:

   .. code-block:: ruby

      { 'file_maxbytes' => 104857600, 'num_to_keep' => 10 }
