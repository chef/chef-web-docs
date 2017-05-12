=====================================================
Release Notes: Ohai 7 - 8.23
=====================================================
`[edit on GitHub] <https://github.com/chef/chef-web-docs/blob/master/chef_master/source/release_notes_ohai.rst>`__

.. tag ohai_summary

Ohai is a tool that is used to collect system configuration data, which is provided to the chef-client for use within cookbooks. Ohai is run by the chef-client at the beginning of every Chef run to determine system state. Ohai includes many built-in plugins to detect common configuration details as well as a plugin model for writing custom plugins.

The types of attributes Ohai collects include but are not limited to:

* Operating System
* Network
* Memory
* Disk
* CPU
* Kernel
* Host names
* Fully qualified domain names
* Virtualization
* Cloud provider metadata

Attributes that are collected by Ohai are automatic level attributes, in that these attributes are used by the chef-client to ensure that these attributes remain unchanged after the chef-client is done configuring the node.

.. end_tag

What's New in 8.23
=====================================================
Ohai 8.23 introduces the following changes:

* **Cumulus Linux Platform** Cumulus Linux will now be detected as platform ``cumulus`` instead of ``debian`` and the ``platform_version`` will be properly set to the Cumulus Linux release.
* **Virtualization Detection** Windows / Linux / BSD guests running on the Veertu hypervisors will now be detected. Windows guests running on Xen and Hyper-V hypervisors will now be detected.
* **New Sysconf Plugin** A new plugin parses the output of the sysconf command to provide information on the underlying system.
* **AWS Account ID** The EC2 plugin now fetches the AWS Account ID in addition to previous instance metadata.
* **GCC Detection** GCC detection has been improved to collect additional information, and to not prompt for the installation of Xcode on macOS systems.

New deprecations introduced in this release:
-----------------------------------------------------

Ohai::Config removed
+++++++++++++++++++++++++++++++++++++++++++++++++++++
* **Deprecation ID**: OHAI-1
* **Remediation Docs**: :doc:`OHAI-1 </deprecations_ohai_legacy_config>`
* **Expected Removal**: Ohai 13 (April 2017)

sigar gem based plugins removed
+++++++++++++++++++++++++++++++++++++++++++++++++++++
* **Deprecation ID**: OHAI-2
* **Remediation Docs**: :doc:`OHAI-2 </deprecations_ohai_sigar_plugins>`
* **Expected Removal**: Ohai 13 (April 2017)

run_command and popen4 helper methods removed
+++++++++++++++++++++++++++++++++++++++++++++++++++++
* **Deprecation ID**: OHAI-3
* **Remediation Docs**: :doc:`OHAI-3 </deprecations_ohai_run_command_helpers>`
* **Expected Removal**: Ohai 13 (April 2017)

libvirt plugin attributes moved
+++++++++++++++++++++++++++++++++++++++++++++++++++++
* **Deprecation ID**: OHAI-4
* **Remediation Docs**: :doc:`OHAI-4 </deprecations_ohai_libvirt_plugin>`
* **Expected Removal**: Ohai 13 (April 2017)

Windows CPU plugin attribute changes
+++++++++++++++++++++++++++++++++++++++++++++++++++++
* **Deprecation ID**: OHAI-5
* **Remediation Docs**: :doc:`OHAI-5 </deprecations_ohai_windows_cpu>`
* **Expected Removal**: Ohai 13 (April 2017)

DigitalOcean plugin attribute changes
+++++++++++++++++++++++++++++++++++++++++++++++++++++
* **Deprecation ID**: OHAI-6
* **Remediation Docs**: :doc:`OHAI-6 </deprecations_ohai_digitalocean>`
* **Expected Removal**: Ohai 13 (April 2017)

What's New in 8
=====================================================
Ohai 8 introduces the following change:

* **Minimum supported version of Ruby** The version of Ruby supported by Ohai 8 is Ruby version 2.0.

What's New in 7
=====================================================
Ohai 7 collects all of the same information that Ohai 6 collected and Ohai 7 introduces two major changes. The short version:

* **New DSL** New features like ``collect_data()`` blocks and ``depends`` / ``provides`` statements make it easier to build plugins for platform-specific situations.
* **Attribute name-based user interaction** Only specify the name of the attribute; Ohai 7 will figure out which plugins are required to collect that data.

Ohai 6 vs. Ohai 7 Plugins
-----------------------------------------------------
.. tag ohai_migrate_plugins_6_to_7

Ohai 7 is backwards compatible with existing Ohai 6 plugins; however, none of the new (or future) functionality will be made available to Ohai 6 plugins. It is recommended that all Ohai 6 plugins be updated for new DSL behavior in Ohai 7 as soon as possible. When migrating Ohai 6 plugins to Ohai 7, consider the following:

* Pick a name for the existing plugin, and then define it as an Ohai 7 plugin
* Convert the ``required_plugin()`` calls to ``depends`` statements
* Move the Ohai 6 plugin logic into a ``collect_data()`` block

For example, Ohai 6:

.. code-block:: ruby

   provides 'my_app'

   require_plugin('kernel')

   my_app Mash.new
   my_app[:version] = shell_out('my_app -v').stdout
   my_app[:message] = 'Using #{kernel[:version]}'

and then Ohai 7:

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

and then Ohai 7:

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

.. end_tag

The Ohai 7 DSL
-----------------------------------------------------
Ohai 6 had a key architectural limitation that treated a plugin as a monolithic block of code. This blocked the ability to implement improvements, such as differentiating data that was collected by Ohai as critical or optional. Ohai 7 introduces a new DSL that makes it easier to write custom plugins with better code organization.

Two important pieces of this DSL:

* ``collect_data()`` blocks enable better organization for platform-specific situations
* ``depends`` and ``provides`` statements enable easier dependency management among plugins

Attribute name-based user interaction
-----------------------------------------------------
Ohai 6 required users to know the file path for each plugin in order to use it. Ohai 7 only requires users to know the attribute for which Ohai should collect data. Ohai 7 will figure out where the required plugins are located.

Disable plugins
-----------------------------------------------------
.. tag config_rb_ohai

Ohai configuration settings can be added to the client.rb file.

.. end_tag

Use the following setting to disable plugins:

.. list-table::
   :widths: 200 300
   :header-rows: 1

   * - Setting
     - Description
   * - ``Ohai::Config[:disabled_plugins]``
     - An array of Ohai plugins to be disabled on a node. For example:

       .. code-block:: ruby

          Ohai::Config[:disabled_plugins] = [:MyPlugin]

       or:

       .. code-block:: ruby

          Ohai::Config[:disabled_plugins] = [:MyPlugin, :MyPlugin, :MyPlugin]

       or to disable both Ohai 6 and Ohai 7 versions:

       .. code-block:: ruby

          Ohai::Config[:disabled_plugins] = [:MyPlugin, :MyPlugin, "my_ohai_6_plugin"]
