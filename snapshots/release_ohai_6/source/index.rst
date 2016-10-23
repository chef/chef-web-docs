=====================================================
About Ohai 6  
=====================================================

.. include:: ../../includes_ohai/includes_ohai.rst

.. include:: ../../includes_ohai/includes_ohai_platforms.rst

View the :doc:`release notes </release_notes>` for Ohai 6.


Automatic Attributes
=====================================================
.. include:: ../../includes_ohai/includes_ohai_automatic_attribute.rst

**Get a list of automatic attributes for a node**

.. include:: ../../includes_ohai/includes_ohai_attribute_list.rst

.. note:: .. include:: ../../includes_notes/includes_notes_see_attributes_overview.rst

Attribute Persistence
-----------------------------------------------------
.. include:: ../../includes_node/includes_node_attribute_persistence.rst

Attribute Precedence
-----------------------------------------------------
.. include:: ../../includes_node/includes_node_attribute_precedence.rst

Custom Ohai 6 Plugins
=====================================================

.. warning:: Custom plugins change significantly in Ohai 7 (see the `release notes <https://docs.chef.io/release/ohai-7/release_notes.html>`_). While Chef has worked to ensure backwards compatibility for all Ohai plugins, all plugins that were built for Ohai 6 should be updated, tested, and then verified for Ohai 7.

.. include:: ../../includes_ohai/includes_ohai_custom_plugin.rst

Syntax
-----------------------------------------------------
The syntax for an Ohai 6 plugin is as follows:

.. code-block:: ruby

   require_plugin 'plugin_name'
   provides 'attribute', 'attribute/subattribute'

   # start of Ruby code that defines the Ohai 6 plugin
   
     attribute my_data
   
   # end of Ruby code that defines the Ohai 6 plugin

where 

* ``require_plugin`` is used to extend one (or more) existing Ohai 6 plugins; an often-used value for ``require_plugin`` is ``'#{os}::hostname'``
* Required. ``provides`` is a comma-separated list of one (or more) attributes that are defined by this plugin. This attribute will become an automatic attribute (i.e. ``node[:attribute]``) after it is collected by Ohai at the start of the chef-client run. An attribute can also be defined using an ``attribute/subattribute`` pattern
* ``my_data`` is  string (``a string value``) or an empty mash (``{ :setting_a => 'value_a', :setting_b => 'value_b' }``). This is used to define the data that should be collected by the plugin

For example, an Ohai 6 plugin could be built to add additional ``ipaddrtype_iface`` network attributes to help make it semantically easier to retrieve addresses:

.. code-block:: ruby

   provides 'network'
   
   require_plugin 'hostname'
   require_plugin '#{os}::network'
   
   network['interfaces'].each do |iface, addrs|
   
   addrs['addresses'].each do |ip, params|
     network['ipaddress_#{iface}'] ||= ip if params['family'].eql?('inet')
     network['ipaddress6_#{iface}'] ||= ip if params['family'].eql?('inet6')
     network['macaddress_#{iface}'] ||= ip if params['family'].eql?('lladdr')
   end
   
   end
   
   network

and then knife can be used to show these values. For example:

.. code-block:: bash

   $ knife node show guineapig -a network

to return something similar to:

.. code-block:: bash

   network:
   ...
     ipaddress6_eth0:    fe80::20c:29ff:fe12:7adc
     ipaddress6_lo:      ::1
     ipaddress_eth0:     10.13.37.200
     ipaddress_lo:       127.0.0.1
     macaddress_eth0:    00:0c:29:12:7a:dc


Use a Mash
-----------------------------------------------------
.. include:: ../../includes_dsl_ohai/includes_dsl_ohai_method_collect_data_mash.rst

Hints
-----------------------------------------------------
.. include:: ../../includes_ohai/includes_ohai_hints.rst

.. include:: ../../includes_ohai/includes_ohai_hints_json.rst

Ohai 6 vs. Ohai 7 Plugins
-----------------------------------------------------
.. include:: ../../includes_ohai/includes_ohai_migrate_plugins_6_to_7.rst

ohai Resource
=====================================================
.. include:: ../../includes_resources_common/includes_resources_common_generic.rst

.. include:: ../../includes_resources/includes_resource_ohai.rst

Syntax
-----------------------------------------------------
.. include:: ../../includes_resources/includes_resource_ohai_syntax.rst

Actions
-----------------------------------------------------
.. include:: ../../includes_resources/includes_resource_ohai_actions.rst

Attributes
-----------------------------------------------------
.. include:: ../../includes_resources/includes_resource_ohai_attributes_11-10.rst

Providers
-----------------------------------------------------
.. include:: ../../includes_resources/includes_resource_ohai_providers.rst

Examples
-----------------------------------------------------
The following examples demonstrate various approaches for using resources in recipes. If you want to see examples of how Chef uses resources in recipes, take a closer look at the cookbooks that Chef authors and maintains: https://github.com/chef-cookbooks.

**Reload Ohai**

.. include:: ../../step_resource/step_resource_ohai_reload.rst

**Reload Ohai after a new user is created**

.. include:: ../../step_resource/step_resource_11-10_ohai_reload_after_create_user.rst

ohai Cookbook
=====================================================
.. include:: ../../step_ohai/step_ohai_download_cookbook.rst

Default Location
-----------------------------------------------------
.. include:: ../../step_ohai/step_ohai_plugin_change_path.rst

Upload Custom Plugins
-----------------------------------------------------
.. include:: ../../step_ohai/step_ohai_plugin_upload.rst

Add Ohai to a Run-list
-----------------------------------------------------
.. include:: ../../step_ohai/step_ohai_add_to_run_list.rst



ohai Command Line Tool
=====================================================
.. include:: ../../includes_ctl_ohai/includes_ctl_ohai.rst

Options
-----------------------------------------------------
This command has the following syntax:

.. code-block:: bash

   $ ohai OPTION

This tool has the following options:

``-d PATH``, ``--directory PATH``
   The directory in which Ohai plugins are located. For example: ``/etc/ohai/plugins``. (Only one directory may be specified when using this option.)

``-f FILE_NAME``, ``--file FILE_NAME``
   The name of an Ohai plugin against which Ohai will run. (Only one Ohai plugin may be specified when using this option.)

``-h``, ``--help``
   Show help for the command.

``-l LEVEL``, ``--log_level LEVEL``
   The level of logging to be stored in a log file.

``-L LOGLOCATION``, ``--logfile c``
   The location of the log file.

``-v``, ``--version``
   The version of Ohai.


Examples
-----------------------------------------------------
The following examples show how to use the Ohai command-line tool:

**Run a plugin independently of a chef-client run**

An Ohai plugin can be run independently of a chef-client run. First, ensure that the plugin is located in the ``/plugins`` directory and then use the ``-f`` option when running Ohai from the command line. For example, a plugin named ``sl_installed`` may look like the following:

.. code-block:: ruby

   provides "sl"
   
   if ::File.exists?("/usr/games/sl")
     sl Mash.new
     sl[:installed] = true
   end

To run that plugin from the command line, use the following command:

.. code-block:: bash

   $ ohai -f sl_installed.rb

The command will return something similar to:

.. code-block:: javascript

   {
     "sl": {
       "installed": true
     }
   }






Ohai Settings in client.rb
=====================================================
.. include:: ../../includes_config/includes_config_rb_ohai.rst

``Ohai::Config[:directory]``
   The directory in which Ohai plugins are located.

``Ohai::Config[:disabled_plugins]``
   An array of Ohai plugins to be disabled on a node.  The list of plugins included in Ohai can be found in the ``ohai/lib/ohai/plugins`` directory. For example:

   .. code-block:: ruby

      Ohai::Config[:disabled_plugins] = 'my_plugin'

   or:

   .. code-block:: ruby

      Ohai::Config[:disabled_plugins] = 'windows::my_plugin'

   or:

   .. code-block:: ruby

      Ohai::Config[:disabled_plugins] = ['my_plugin', 'my_plugin', 'my_plugin']

   When a plugin is disabled, the chef-client log file will contain entries similar to:

   .. code-block:: ruby

      [2014-06-13T23:49:12+00:00] DEBUG: Skipping disabled plugin my_plugin

``Ohai::Config[:hints_path]``
   The path to the file that contains hints for Ohai.

``Ohai::Config[:log_level]``
   The level of logging to be stored in a log file.

``Ohai::Config[:log_location]``
   The location of the log file.

``Ohai::Config[:version]``
   The version of Ohai.

.. note:: The Ohai executable ignores settings in the client.rb file when Ohai is run independently of the chef-client.



.. Hide the TOC from this file.  

.. toctree::
   :hidden:

   release_notes
