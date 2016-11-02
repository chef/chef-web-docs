=====================================================
About Ohai 6  
=====================================================

.. tag ohai

Ohai is a tool that is used to detect attributes on a node, and then provide these attributes to the chef-client at the start of every chef-client run. Ohai is required by the chef-client and must be present on a node. (Ohai is installed on a node as part of the chef-client install process.)

The types of attributes Ohai collects include (but are not limited to):

* Platform details
* Network usage
* Memory usage
* CPU data
* Kernel data
* Host names
* Fully qualified domain names
* Other configuration details

Attributes that are collected by Ohai are automatic attributes, in that these attributes are used by the chef-client to ensure that these attributes remain unchanged after the chef-client is done configuring the node.

.. end_tag

.. tag ohai_platforms

Ohai collects data for many platforms, including AIX, Darwin, HP-UX, Linux, FreeBSD, OpenBSD, NetBSD, Solaris, and any Microsoft Windows operating system based off the ``Windows_NT`` kernel and has access to ``win32`` or ``win64`` sub-systems.

.. end_tag

View the :doc:`release notes </release_notes>` for Ohai 6.

Automatic Attributes
=====================================================
.. tag ohai_automatic_attribute

An automatic attribute is a specific detail about a node, such as an IP address, a host name, a list of loaded kernel modules, and so on. Automatic attributes are detected by Ohai and are then used by the chef-client to ensure that they are handled properly during every chef-client run. The most commonly accessed automatic attributes are:

.. list-table::
   :widths: 60 420
   :header-rows: 1

   * - Attribute
     - Description
   * - ``node['platform']``
     - The platform on which a node is running. This attribute helps determine which providers will be used.
   * - ``node['platform_version']``
     - The version of the platform. This attribute helps determine which providers will be used.
   * - ``node['ipaddress']``
     - The IP address for a node. If the node has a default route, this is the IPV4 address for the interface. If the node does not have a default route, the value for this attribute should be ``nil``. The IP address for default route is the recommended default value.
   * - ``node['macaddress']``
     - The MAC address for a node, determined by the same interface that detects the ``node['ipaddress']``.
   * - ``node['fqdn']``
     - The fully qualified domain name for a node. This is used as the name of a node unless otherwise set.
   * - ``node['hostname']``
     - The host name for the node.
   * - ``node['domain']``
     - The domain for the node.
   * - ``node['recipes']``
     - A list of recipes associated with a node (and part of that node's run-list).
   * - ``node['roles']``
     - A list of roles associated with a node (and part of that node's run-list).
   * - ``node['ohai_time']``
     - The time at which Ohai was last run. This attribute is not commonly used in recipes, but it is saved to the Chef server and can be accessed using the ``knife status`` subcommand.

.. end_tag

**Get a list of automatic attributes for a node**

.. tag ohai_attribute_list

The list of automatic attributes that are collected by Ohai at the start of each chef-client run vary from organization to organization, and will often vary between the various server types being configured and the platforms on which those servers are run. All attributes collected by Ohai are unmodifiable by the chef-client. To see which automatic attributes are collected by Ohai for a particular node, run the following command:

.. code-block:: bash

   ohai$ grep -R "provides" -h lib/ohai/plugins|sed 's/^\s*//g'|sed "s/\\\"/\'/g"|sort|uniq|grep ^provides

.. end_tag

.. note:: .. tag notes_see_attributes_overview

          Attributes can be configured in cookbooks (attribute files and recipes), roles, and environments. In addition, Ohai collects attribute data about each node at the start of the chef-client run. See |url docs_attributes| for more information about how all of these attributes fit together.

          .. end_tag

Attribute Persistence
-----------------------------------------------------
.. tag node_attribute_persistence

At the beginning of a chef-client run, all attributes are reset. The chef-client rebuilds them using automatic attributes collected by Ohai at the beginning of the chef-client run and then using default and override attributes that are specified in cookbooks or by roles and environments. Normal attributes are never reset. All attributes are then merged and applied to the node according to attribute precedence. At the conclusion of the chef-client run, the attributes that were applied to the node are saved to the Chef server as part of the node object.

.. end_tag

Attribute Precedence
-----------------------------------------------------
.. tag node_attribute_precedence

Attributes are always applied by the chef-client in the following order:

#. A ``default`` attribute located in a cookbook attribute file
#. A ``default`` attribute located in a recipe
#. A ``default`` attribute located in an environment
#. A ``default`` attribute located in a role
#. A ``force_default`` attribute located in a cookbook attribute file
#. A ``force_default`` attribute located in a recipe
#. A ``normal`` attribute located in a cookbook attribute file
#. A ``normal`` attribute located in a recipe
#. An ``override`` attribute located in a cookbook attribute file
#. An ``override`` attribute located in a recipe
#. An ``override`` attribute located in a role
#. An ``override`` attribute located in an environment
#. A ``force_override`` attribute located in a cookbook attribute file
#. A ``force_override`` attribute located in a recipe
#. An ``automatic`` attribute identified by Ohai at the start of the chef-client run

where the last attribute in the list is the one that is applied to the node.

.. note:: The attribute precedence order for roles and environments is reversed for ``default`` and ``override`` attributes. The precedence order for ``default`` attributes is environment, then role. The precedence order for ``override`` attributes is role, then environment. Applying environment ``override`` attributes after role ``override`` attributes allows the same role to be used across multiple environments, yet ensuring that values can be set that are specific to each environment (when required). For example, the role for an application server may exist in all environments, yet one environment may use a database server that is different from other environments.

Attribute precedence, viewed from the same perspective as the overview diagram, where the numbers in the diagram match the order of attribute precedence:

.. image:: ../../images/overview_chef_attributes_precedence.png

Attribute precedence, when viewed as a table:

.. image:: ../../images/overview_chef_attributes_table.png

.. end_tag

Custom Ohai 6 Plugins
=====================================================

.. warning:: Custom plugins change significantly in Ohai 7 (see the :doc:`release notes <release_notes>`). While Chef has worked to ensure backwards compatibility for all Ohai plugins, all plugins that were built for Ohai 6 should be updated, tested, and then verified for Ohai 7.

.. tag ohai_custom_plugin

A custom Ohai plugin describes a set of attributes to be collected by Ohai, and then provided to the chef-client at the start of the chef-client run.

.. end_tag

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
.. tag dsl_ohai_method_collect_data_mash

Use a mash to store data. This is done by creating a new mash, and then setting an attribute to it. For example:

.. code-block:: ruby

   provides 'name_of_mash'
   name_of_mash Mash.new
   name_of_mash[:attribute] = 'value'

.. end_tag

Hints
-----------------------------------------------------
.. tag ohai_hints

Ohai hints are used to tell Ohai something about the system that it is running on that it would not be able to discover itself. An Ohai hint exists if a JSON file exists in the hint directory with the same name as the hint. For example, calling ``hint?('antarctica')`` in an Ohai plugin would return an empty hash if the file ``antarctica.json`` existed in the hints directory, and return nil if the file does not exist.

.. end_tag

.. tag ohai_hints_json

If the hint file contains JSON content, it will be returned as a hash from the call to ``hint?``.

.. code-block:: javascript

   {
     "snow": true,
     "penguins": "many"
   }

.. code-block:: ruby

   antarctica_hint = hint?('antarctica')
   if antarctica_hint['snow']
     "There are #{antarctica_hint['penguins']} penguins here."
   else
     'There is no snow here, and penguins like snow.'
   end

The default directory in which hint files are located is ``/etc/chef/ohai/hints/``. Use the ``Ohai::Config[:hints_path]`` setting in the client.rb file to customize this location.

.. end_tag

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

ohai Resource
=====================================================
.. tag resources_common_generic

A resource defines the desired state for a single configuration item present on a node that is under management by Chef. A resource collection---one (or more) individual resources---defines the desired state for the entire node. During a chef-client run, the current state of each resource is tested, after which the chef-client will take any steps that are necessary to repair the node and bring it back into the desired state.

.. end_tag

.. tag resource_ohai_24

Use the **ohai** resource to reload the Ohai configuration on a node. This allows recipes that change system attributes (like a recipe that adds a user) to refer to those attributes later on during the chef-client run.

.. end_tag

Syntax
-----------------------------------------------------
.. tag resource_ohai_syntax

A **ohai** resource block reloads the Ohai configuration on a node:

.. code-block:: ruby

   ohai 'reload' do
     action :reload
   end

The full syntax for all of the properties that are available to the **ohai** resource is:

.. code-block:: ruby

   ohai 'name' do
     name                       String
     notifies                   # see description
     plugin                     String
     provider                   Chef::Provider::Ohai
     subscribes                 # see description
     action                     Symbol # defaults to :reload if not specified
   end

where

* ``ohai`` is the resource
* ``name`` is the name of the resource block
* ``:action`` identifies the steps the chef-client will take to bring the node into the desired state
* ``name``, ``plugin``,  and ``provider`` are properties of this resource, with the Ruby type shown. See "Properties" section below for more information about all of the properties that may be used with this resource.

.. end_tag

Actions
-----------------------------------------------------
.. tag resource_ohai_actions

This resource has the following actions:

``:nothing``
   .. tag resources_common_actions_nothing

   Define this resource block to do nothing until notified by another resource to take action. When this resource is notified, this resource block is either run immediately or it is queued up to be run at the end of the chef-client run.

   .. end_tag

``:reload``
   Default. Reload the Ohai configuration on a node.

.. end_tag

Attributes
-----------------------------------------------------
.. tag 10_5

This resource has the following properties:

``ignore_failure``
   **Ruby Types:** TrueClass, FalseClass

   Continue running a recipe if a resource fails for any reason. Default value: ``false``.

``name``
   **Ruby Type:** String

   Always the same value as the ``name`` of the resource block. See "Syntax" section above for more information.

``notifies``
   **Ruby Type:** Symbol, 'Chef::Resource[String]'

   .. tag resources_common_notification_notifies

   A resource may notify another resource to take action when its state changes. Specify a ``'resource[name]'``, the ``:action`` that resource should take, and then the ``:timer`` for that action. A resource may notifiy more than one resource; use a ``notifies`` statement for each resource to be notified.

   .. end_tag

   .. tag 5_3

   A timer specifies the point during the chef-client run at which a notification is run. The following timers are available:

   ``:delayed``
      Default. Specifies that a notification should be queued up, and then executed at the very end of the chef-client run.

   ``:immediate``, ``:immediately``
      Specifies that a notification should be run immediately, per resource notified.

   .. end_tag

   .. tag resources_common_notification_notifies_syntax

   The syntax for ``notifies`` is:

   .. code-block:: ruby

      notifies :action, 'resource[name]', :timer

   .. end_tag

``plugin``
   **Ruby Type:** String

   Optional. Cause Ohai to reload the specified plug-ins. The default behavior reloads all plug-ins.

``provider``
   **Ruby Type:** Chef Class

   Optional. Explicitly specifies a provider.

``retries``
   **Ruby Type:** Integer

   The number of times to catch exceptions and retry the resource. Default value: ``0``.

``retry_delay``
   **Ruby Type:** Integer

   The retry delay (in seconds). Default value: ``2``.

``subscribes``
   **Ruby Type:** Symbol, 'Chef::Resource[String]'

   .. tag resources_common_notification_subscribes

   A resource may listen to another resource, and then take action if the state of the resource being listened to changes. Specify a ``'resource[name]'``, the ``:action`` to be taken, and then the ``:timer`` for that action.

   .. end_tag

   .. tag 5_3

   A timer specifies the point during the chef-client run at which a notification is run. The following timers are available:

   ``:delayed``
      Default. Specifies that a notification should be queued up, and then executed at the very end of the chef-client run.

   ``:immediate``, ``:immediately``
      Specifies that a notification should be run immediately, per resource notified.

   .. end_tag

   .. tag resources_common_notification_subscribes_syntax

   The syntax for ``subscribes`` is:

   .. code-block:: ruby

      subscribes :action, 'resource[name]', :timer

   .. end_tag

.. end_tag

Providers
-----------------------------------------------------
.. tag resource_ohai_providers

This resource has the following providers:

``Chef::Provider::Ohai``, ``ohai``
   The default provider for all platforms.

.. end_tag

Examples
-----------------------------------------------------
The following examples demonstrate various approaches for using resources in recipes. If you want to see examples of how Chef uses resources in recipes, take a closer look at the cookbooks that Chef authors and maintains: https://github.com/chef-cookbooks.

**Reload Ohai**

.. tag resource_ohai_reload

.. To reload Ohai:

.. code-block:: ruby

   ohai 'reload' do
     action :reload
   end

.. end_tag

**Reload Ohai after a new user is created**

.. tag 10_ohai_reload_after_create_user

.. To reload Ohai configuration after a new user is created:

.. code-block:: ruby

   ohai 'reload_passwd' do
     action :nothing
     plugin 'passwd'
   end

   user 'daemonuser' do
     home '/dev/null'
     shell '/sbin/nologin'
     system true
     notifies :reload, 'ohai[reload_passwd]', :immediately
   end

   ruby_block 'just an example' do
     block do
       # These variables will now have the new values
       puts node['etc']['passwd']['daemonuser']['uid']
       puts node['etc']['passwd']['daemonuser']['gid']
     end
   end

.. end_tag

ohai Cookbook
=====================================================
.. tag ohai_download_cookbook

To download the ``ohai`` cookbook to the chef-repo run the following command:

.. code-block:: bash

   $ knife cookbook site install ohai

knife will return something similar to:

.. code-block:: bash

   INFO: Downloading ohai from the cookbooks site at version 0.9.0
   INFO: Cookbook saved: /Users/jtimberman/chef-repo/cookbooks/ohai.tar.gz
   INFO: Checking out the master branch.
   INFO: Checking the status of the vendor branch.
   INFO: Creating vendor branch.
   INFO: Removing pre-existing version.
   INFO: Uncompressing ohai version 0.9.0.
   INFO: Adding changes.
   INFO: Committing changes.
   INFO: Creating tag chef-vendor-ohai-0.9.0.
   INFO: Checking out the master branch.
   INFO: Merging changes from ohai version 0.9.0.
   [ ... SNIP ... ]
   INFO: Cookbook ohai version 0.9.0 successfully vendored!

.. end_tag

Default Location
-----------------------------------------------------
.. tag ohai_plugin_change_path

To change the directory in which plugins are located edit the attributes file in the ``ohai`` cookbook for the ``node[:ohai][:plugin_path]`` attribute. Change the value to the desired directory path. For example:

.. code-block:: ruby

   default[:ohai][:plugin_path] = "/etc/chef/ohai_plugins"

.. end_tag

Upload Custom Plugins
-----------------------------------------------------
.. tag ohai_plugin_upload

To upload the ``ohai`` cookbook to the Chef server, use knife and run the following:

.. code-block:: bash

   knife cookbook upload ohai

to return something similar to:

.. code-block:: bash

   INFO: Saving ohai
   INFO: Validating ruby files
   INFO: Validating templates
   INFO: Syntax OK
   INFO: Generating Metadata
   INFO: Uploading files
   [ ... SNIP ... ]

.. end_tag

Add Ohai to a Run-list
-----------------------------------------------------
.. tag ohai_add_to_run_list

The ``ohai`` recipe can be added to a run-list. First, ensure that any custom Ohai plugins are loaded and available to recipes. When the chef-client runs, the plugins will be copied into place and then loaded and merged with the node. This does cause Ohai to be run twice, which can increase the total run time for the chef-client.

.. end_tag

ohai Command Line Tool
=====================================================
.. tag ctl_ohai

ohai is the command-line interface for Ohai, a tool that is used to detect attributes on a node, and then provide these attributes to the chef-client at the start of every chef-client run.

.. end_tag

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
.. tag config_rb_ohai

Ohai configuration settings can be added to the client.rb file.

.. end_tag

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
