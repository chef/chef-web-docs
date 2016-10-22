.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


This configuration file has the following settings for ``oc-chef-pedant``:

``oc_chef_pedant['debug_org_creation']``
   Run tests with full output. Default value: ``false``.

``oc_chef_pedant['dir']``
   The working directory. The default value is the recommended value. Default value:

   .. code-block:: ruby

      '/var/opt/opscode/oc-chef-pedant'

``oc_chef_pedant['log_directory']``
   The directory in which log data is stored. The default value is the recommended value. Default value:

   .. code-block:: ruby

      '/var/log/opscode/oc-chef-pedant'

``oc_chef_pedant['log_http_requests']``
   Log HTTP requests in a file named ``http-traffic.log`` that is located in the path specified by ``log_directory``. Default value: ``true``.

``oc_chef_pedant['log_rotation']``
   The log rotation policy for this service. Log files are rotated when they exceed ``file_maxbytes``. The maximum number of log files in the rotation is defined by ``num_to_keep``. Default value:

   .. code-block:: ruby

      { 'file_maxbytes' => 104857600, 'num_to_keep' => 10 }
