=====================================================
About Ohai 8
=====================================================

.. include:: ../../includes_ohai/includes_ohai.rst

.. include:: ../../includes_ohai/includes_ohai_platforms.rst

View the :doc:`release notes </release_notes>` for Ohai 8.

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

Whitelist Attributes
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_node/includes_node_attribute_whitelist.rst

How Ohai Saves Data
=====================================================
.. include:: ../../includes_ohai/includes_ohai_custom_plugin_json.rst

Default Plugins
=====================================================
.. include:: ../../includes_ohai/includes_ohai_plugins_default.rst

Custom Plugins
=====================================================
.. include:: ../../includes_ohai/includes_ohai_custom_plugin.rst

.. note:: See https://github.com/rackerlabs/ohai-plugins/tree/master/plugins for some great examples of custom Ohai plugins.

Syntax
-----------------------------------------------------
.. include:: ../../includes_ohai/includes_ohai_custom_plugin_syntax.rst

Ohai DSL Methods
-----------------------------------------------------
.. include:: ../../includes_dsl_ohai/includes_dsl_ohai.rst

collect_data
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_dsl_ohai/includes_dsl_ohai_method_collect_data.rst

Use a Mash
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
.. include:: ../../includes_dsl_ohai/includes_dsl_ohai_method_collect_data_mash.rst

Examples
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
.. include:: ../../includes_dsl_ohai/includes_dsl_ohai_method_collect_data_example.rst

require
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_dsl_ohai/includes_dsl_ohai_method_require.rst

/common Directory
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
.. include:: ../../includes_dsl_ohai/includes_dsl_ohai_method_require_common.rst

Shared Methods
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_dsl_ohai/includes_dsl_ohai_method_shared_methods.rst

Hints
-----------------------------------------------------
.. include:: ../../includes_ohai/includes_ohai_hints.rst

.. include:: ../../includes_ohai/includes_ohai_hints_json.rst

Log Entries
-----------------------------------------------------
.. include:: ../../includes_ohai/includes_ohai_custom_plugin_logs.rst

rescue
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_ohai/includes_ohai_custom_plugin_logs_rescue.rst

Examples 
-----------------------------------------------------
The following examples show different ways of building Ohai plugins.

collect_data Blocks
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_ohai/includes_ohai_custom_plugin_example_multiple_collect_data_blocks.rst

Use a mixin Library
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_ohai/includes_ohai_custom_plugin_example_use_mixin_library.rst

Get Kernel Values
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_ohai/includes_ohai_custom_plugin_example_kernels.rst

Ohai 6 vs. Ohai 8 Plugins
-----------------------------------------------------
Ohai 8 is backwards compatible with existing Ohai 6 plugins; however, none of the new (or future) functionality will be made available to Ohai 6 plugins. It is recommended that all Ohai 6 plugins be updated for new DSL behavior in Ohai 8 as soon as possible. When migrating Ohai 6 plugins to Ohai 8, consider the following:

* Pick a name for the existing plugin, and then define it as an Ohai 8 plugin
* Convert the ``required_plugin()`` calls to ``depends`` statements
* Move the Ohai 6 plugin logic into a ``collect_data()`` block

For example, Ohai 6:

.. code-block:: ruby

   provides 'my_app'
   
   require_plugin('kernel')
   
   my_app Mash.new
   my_app[:version] = shell_out('my_app -v').stdout
   my_app[:message] = 'Using #{kernel[:version]}'

and then Ohai 8:

.. code-block:: ruby

   Ohai.plugin(:MyAPP) do
     provides 'my_app'
     depends 'kernel'
   
     collect_data do
       my_app Mash.new
       my_app[:version] = shell_out('my_app -v').stdout
       my_app[:message] = 'Using #{kernel[:version]}'
     end
   end

Another example, for Ohai 6:

.. code-block:: ruby

   provide 'ipaddress'
   require_plugin '#{os}::network'
   require_plugin '#{os}::virtualization'
   require_plugin 'passwd'
   
   if virtualization['system'] == 'vbox'
     if etc['passwd'].any? { |k,v| k == 'vagrant'}
       if network['interfaces']['eth1']
         network['interfaces']['eth1']['addresses'].each do |ip, params|
           if params['family'] == ('inet')
             ipaddress ip
           end
         end
       end
     end
   end

and then Ohai 8:

.. code-block:: ruby

   Ohai.plugin(:Vboxipaddress) do
     provides 'ipaddress'
     depends 'ipaddress', 'network/interfaces', 'virtualization/system', 'etc/passwd'
     collect_data(:default) do
       if virtualization['system'] == 'vbox'
         if etc['passwd'].any? { |k,v| k == 'vagrant'}
           if network['interfaces']['eth1']
             network['interfaces']['eth1']['addresses'].each do |ip, params|
               if params['family'] == ('inet')
                 ipaddress ip
               end
             end
           end
         end
       end  
     end
   end

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
.. include:: ../../includes_resources/includes_resource_ohai_attributes.rst

Providers
-----------------------------------------------------
.. include:: ../../includes_resources/includes_resource_ohai_providers.rst

Examples
-----------------------------------------------------
The following examples demonstrate various approaches for using resources in recipes. If you want to see examples of how Chef uses resources in recipes, take a closer look at the cookbooks that Chef authors and maintains: https://github.com/chef-cookbooks.

**Reload Ohai**

.. include:: ../../step_resource/step_resource_ohai_reload.rst

**Reload Ohai after a new user is created**

.. include:: ../../step_resource/step_resource_ohai_reload_after_create_user.rst



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
.. include:: ../../includes_ctl_ohai/includes_ctl_ohai_options.rst

Examples
-----------------------------------------------------
None.


Ohai Settings in client.rb
=====================================================

.. include:: ../../includes_config/includes_config_rb_ohai.rst

chef-client 12.5 (and higher)
-----------------------------------------------------
.. include:: ../../includes_config/includes_config_rb_ohai_settings.rst

chef-client 12.4 (and earlier)
-----------------------------------------------------
.. include:: ../../includes_config/includes_config_rb_12-4_ohai_settings.rst


.. Hide the TOC from this file.  

.. toctree::
   :hidden:

   release_notes
