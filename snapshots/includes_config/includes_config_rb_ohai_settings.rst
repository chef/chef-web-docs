.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


``Ohai.directory``
   The directory in which Ohai plugins are located.

``Ohai.disabled_plugins``
   An array of Ohai plugins to be disabled on a node. The list of plugins included in Ohai can be found in the ``ohai/lib/ohai/plugins`` directory. For example, disabling a single plugin:

   .. code-block:: ruby

      Ohai.disabled_plugins = [
        :MyPlugin
      ]

    or disabling multiple plugins:

   .. code-block:: ruby

      Ohai.disabled_plugins = [
        :MyPlugin, 
        :MyPlugin, 
        :MyPlugin
      ]

   and to disable multiple plugins, including Ohai 6 plugins:

   .. code-block:: ruby

      Ohai.disabled_plugins = [
		:MyPlugin, 
        :MyPlugin, 
        'my_ohai_6_plugin'
      ]

   When a plugin is disabled, the chef-client log file will contain entries similar to:

   .. code-block:: ruby

      [2014-06-13T23:49:12+00:00] DEBUG: Skipping disabled plugin MyPlugin 


``Ohai.hints_path``
   The path to the file that contains hints for Ohai.

``Ohai.log_level``
   The level of logging to be stored in a log file.

``Ohai.log_location``
   The location of the log file.

``Ohai.plugin_path``
   An array of paths at which Ohai plugins are located. Default value: ``[<CHEF_GEM_PATH>/ohai-9.9.9/lib/ohai/plugins]``. When custom Ohai plugins are added, the paths must be added to the array. For example, a single plugin:

   .. code-block:: ruby

      Ohai.plugin_path << '/etc/chef/ohai_plugins'

   and for multiple plugins:

   .. code-block:: ruby

      Ohai.plugin_path += [
        '/etc/chef/ohai_plugins',
        '/path/to/other/plugins'
        ]

``Ohai.version``
   The version of Ohai.

.. note:: The Ohai executable ignores settings in the client.rb file when Ohai is run independently of the chef-client.
