=====================================================
About Ohai
=====================================================
`[edit on GitHub] <https://github.com/chef/chef-web-docs/blob/master/chef_master/source/ohai.rst>`__

.. tag ohai_summary

Ohai is a tool that is used to detect attributes on a node, and then provide these attributes to the chef-client at the start of every chef-client run. Ohai is required by the chef-client and must be present on a node. (Ohai is installed on a node as part of the chef-client install process.)

The types of attributes Ohai collects include (but are not limited to):

* Platform details
* Network usage
* Memory usage
* CPU data
* Kernel data
* Host names
* Fully qualified domain names
* Virtualization data
* Cloud provider metadata
* Other configuration details

Attributes that are collected by Ohai are automatic level attributes, in that these attributes are used by the chef-client to ensure that these attributes remain unchanged after the chef-client is done configuring the node.

.. end_tag

Ohai collects data for many platforms, including AIX, Darwin, Linux, FreeBSD, OpenBSD, NetBSD, Solaris, and any Microsoft Windows operating system based off the ``Windows_NT`` kernel and has access to ``win32`` or ``win64`` sub-systems.

View the :doc:`release notes </release_notes_ohai>` for the latest information on Ohai.

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

Changed in Chef Client 12.0, so that attributes may be modified for named precedence levels, all precedence levels, and be fully assigned.

Blacklist Attributes
-----------------------------------------------------
.. tag node_attribute_blacklist

.. warning:: When attribute blacklist settings are used, any attribute defined in a blacklist will not be saved and any attribute that is not defined in a blacklist will be saved. Each attribute type is blacklisted independently of the other attribute types. For example, if ``automatic_attribute_blacklist`` defines attributes that will not be saved, but ``normal_attribute_blacklist``, ``default_attribute_blacklist``, and ``override_attribute_blacklist`` are not defined, then all normal attributes, default attributes, and override attributes will be saved, as well as the automatic attributes that were not specifically excluded through blacklisting.

Attributes that should be saved by a node may be blacklisted in the client.rb file. The blacklist is a Hash of keys that specify each attribute to be filtered out.

Attributes are blacklisted by attribute type, with each attribute type being blacklisted independently. Each attribute type---``automatic``, ``default``, ``normal``, and ``override``---may define blacklists by using the following settings in the client.rb file:

.. list-table::
   :widths: 200 300
   :header-rows: 1


   * - Setting
     - Description
   * - ``automatic_attribute_blacklist``
     - A hash that blacklists ``automatic`` attributes, preventing blacklisted attributes from being saved. For example: ``['network/interfaces/eth0']``. Default value: ``nil``, all attributes are saved. If the array is empty, all attributes are saved.
   * - ``default_attribute_blacklist``
     - A hash that blacklists ``default`` attributes, preventing blacklisted attributes from being saved. For example: ``['filesystem/dev/disk0s2/size']``. Default value: ``nil``, all attributes are saved. If the array is empty, all attributes are saved.
   * - ``normal_attribute_blacklist``
     - A hash that blacklists ``normal`` attributes, preventing blacklisted attributes from being saved. For example: ``['filesystem/dev/disk0s2/size']``. Default value: ``nil``, all attributes are saved. If the array is empty, all attributes are saved.
   * - ``override_attribute_blacklist``
     - A hash that blacklists ``override`` attributes, preventing blacklisted attributes from being saved. For example: ``['map - autohome/size']``. Default value: ``nil``, all attributes are saved. If the array is empty, all attributes are saved.

.. warning:: The recommended practice is to use only ``automatic_attribute_blacklist`` for blacklisting attributes. This is primarily because automatic attributes generate the most data, but also that normal, default, and override attributes are typically much more important attributes and are more likely to cause issues if they are blacklisted incorrectly.

For example, normal attribute data similar to:

.. code-block:: javascript

   {
     "filesystem" => {
       "/dev/disk0s2" => {
         "size" => "10mb"
       },
       "map - autohome" => {
         "size" => "10mb"
       }
     },
     "network" => {
       "interfaces" => {
         "eth0" => {...},
         "eth1" => {...},
       }
     }
   }

To blacklist the ``filesystem`` attributes and allow the other attributes to be saved, update the client.rb file:

.. code-block:: ruby

   normal_attribute_blacklist ['filesystem']

When a blacklist is defined, any attribute of that type that is not specified in that attribute blacklist **will** be saved. So based on the previous blacklist for normal attributes, the ``filesystem`` and ``map - autohome`` attributes will not be saved, but the ``network`` attributes will.

For attributes that contain slashes (``/``) within the attribute value, such as the ``filesystem`` attribute ``'/dev/diskos2'``, use an array. For example:

.. code-block:: ruby

   automatic_attribute_blacklist [['filesystem','/dev/diskos2']]

.. end_tag

Whitelist Attributes
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. tag node_attribute_whitelist

.. warning:: When attribute whitelist settings are used, only the attributes defined in a whitelist will be saved and any attribute that is not defined in a whitelist will not be saved. Each attribute type is whitelisted independently of the other attribute types. For example, if ``automatic_attribute_whitelist`` defines attributes to be saved, but ``normal_attribute_whitelist``, ``default_attribute_whitelist``, and ``override_attribute_whitelist`` are not defined, then all normal attributes, default attributes, and override attributes are saved, as well as the automatic attributes that were specifically included through whitelisting.

Attributes that should be saved by a node may be whitelisted in the client.rb file. The whitelist is a hash of keys that specifies each attribute to be saved.

Attributes are whitelisted by attribute type, with each attribute type being whitelisted independently. Each attribute type---``automatic``, ``default``, ``normal``, and ``override``---may define whitelists by using the following settings in the client.rb file:

.. list-table::
   :widths: 200 300
   :header-rows: 1

   * - Setting
     - Description
   * - ``automatic_attribute_whitelist``
     - A hash that whitelists ``automatic`` attributes, preventing non-whitelisted attributes from being saved. For example: ``['network/interfaces/eth0']``. Default value: ``nil``, all attributes are saved. If the hash is empty, no attributes are saved.
   * - ``default_attribute_whitelist``
     - A hash that whitelists ``default`` attributes, preventing non-whitelisted attributes from being saved. For example: ``['filesystem/dev/disk0s2/size']``. Default value: ``nil``, all attributes are saved. If the hash is empty, no attributes are saved.
   * - ``normal_attribute_whitelist``
     - A hash that whitelists ``normal`` attributes, preventing non-whitelisted attributes from being saved. For example: ``['filesystem/dev/disk0s2/size']``. Default value: ``nil``, all attributes are saved. If the hash is empty, no attributes are saved.
   * - ``override_attribute_whitelist``
     - A hash that whitelists ``override`` attributes, preventing non-whitelisted attributes from being saved. For example: ``['map - autohome/size']``. Default value: ``nil``, all attributes are saved. If the hash is empty, no attributes are saved.

.. warning:: The recommended practice is to only use ``automatic_attribute_whitelist`` to whitelist attributes. This is primarily because automatic attributes generate the most data, but also that normal, default, and override attributes are typically much more important attributes and are more likely to cause issues if they are whitelisted incorrectly.

For example, normal attribute data similar to:

.. code-block:: javascript

   {
     "filesystem" => {
       "/dev/disk0s2" => {
         "size" => "10mb"
       },
       "map - autohome" => {
         "size" => "10mb"
       }
     },
     "network" => {
       "interfaces" => {
         "eth0" => {...},
         "eth1" => {...},
       }
     }
   }

To whitelist the ``network`` attributes and prevent the other attributes from being saved, update the client.rb file:

.. code-block:: ruby

   normal_attribute_whitelist ['network/interfaces/']

When a whitelist is defined, any attribute of that type that is not specified in that attribute whitelist **will not** be saved. So based on the previous whitelist for normal attributes, the ``filesystem`` and ``map - autohome`` attributes will not be saved, but the ``network`` attributes will.

Leave the value empty to prevent all attributes of that attribute type from being saved:

.. code-block:: ruby

   normal_attribute_whitelist []

For attributes that contain slashes (``/``) within the attribute value, such as the ``filesystem`` attribute ``'/dev/diskos2'``, use an array. For example:

.. code-block:: ruby

   automatic_attribute_whitelist [['filesystem','/dev/diskos2']]

.. end_tag

Default Plugins
=====================================================
The following list shows the type of plugins that are included with Ohai. See the ``ohai/lib/ohai/plugins`` directory in the version of Ohai installed on your system for the full list:

.. code-block:: ruby

   aix
     cpu.rb
     filesystem.rb
     kernel.rb
     memory.rb
     network.rb
     platform.rb
     uptime.rb
     virtualization.rb
   azure.rb
   bsd
    filesystem.rb
    virtualization.rb
   c.rb
   chef.rb
   cloud.rb
   cloud_v2.rb
   command.rb
   darwin
     cpu.rb
     filesystem.rb
     memory.rb
     network.rb
     platform.rb
     system_profiler.rb
   digital_ocean.rb
   dmi.rb
   dragonflybsd
    cpu.rb
    memory.rb
    network.rb
    os.rb
    platform.rb
   ec2.rb
   elixir.rb
   erlang.rb
   eucalyptus.rb
   freebsd
     cpu.rb
     memory.rb
     network.rb
     os.rb
     platform.rb
   gce.rb
   go.rb
   groovy.rb
   hostname.rb
   init_package.rb
   ip_scopes.rb
   java.rb
   joyent.rb
   kernel.rb
   keys.rb
   languages.rb
   linode.rb
   linux
     block_device.rb
     cpu.rb
     filesystem.rb
     filesystem2.rb
     fips.rb
     hostnamectl.rb
     lsb.rb
     machineid.rb
     mdadm.rb
     memory.rb
     network.rb
     platform.rb
     sessons.rb
     virtualization.rb
   lua.rb
   mono.rb
   netbsd
     cpu.rb
     memory.rb
     network.rb
     platform.rb
   network.rb
   network_listeners.rb
   nodejs.rb
   ohai.rb
   ohai_time.rb
   openbsd
     cpu.rb
     memory.rb
     network.rb
     platform.rb
   openstack.rb
   os.rb
   packages.rb
   passwd.rb
   perl.rb
   php.rb
   platform.rb
   powershell.rb
   ps.rb
   python.rb
   rackspace.rb
   root_group.rb
   ruby.rb
   rust.rb
   scala.rb
   shard.rb
   shells.rb
   sigar
     cpu.rb
     filesystem.rb
     memory.rb
     network_route.rb
     network.rb
     platform.rb
   softlayer.rb
   solaris2
     cpu.rb
     dmi.rb
     filesystem.rb
     memory.rb
     network.rb
     platform.rb
     virtualization.rb
     zpools.rb
   ssh_host_key.rb
   sysconf.rb
   timezone.rb
   uptime.rb
   virtualbox.rb
   virtualization.rb
   windows
     cpu.rb
     drivers.rb
     filesystem.rb
     fips.rb
     memory.rb
     network.rb
     platform.rb
     virtualization.rb

Custom Plugins
=====================================================
.. tag ohai_custom_plugin

A custom Ohai plugin describes a set of attributes to be collected by Ohai, and then provided to the chef-client at the start of the chef-client run.

.. end_tag

.. note:: See https://github.com/rackerlabs/ohai-plugins/tree/master/plugins for some great examples of custom Ohai plugins.

.. warning:: The syntax for custom plugins changed significantly between Ohai 6 and later versions. This page is about plugins after Ohai 6. While Chef has worked to ensure backwards compatibility for all Ohai 6 plugins, a plan should be put in place to update the syntax for all Ohai 6 plugins so they are usable with the new pattern. Once updated, please test and verify those plugins before running them in a production environment.

Syntax
-----------------------------------------------------
.. tag ohai_custom_plugin_syntax

The syntax for an Ohai plugin is as follows:

.. code-block:: ruby

   Ohai.plugin(:Name) do
     include Ohai::Name
     provides 'attribute', 'attribute/subattribute'
     depends 'attribute', 'attribute'

     def shared_method
       # some Ruby code that defines the shared method
       attribute my_data
     end

     collect_data(:default) do
       # some Ruby code
       attribute my_data
     end

     collect_data(:platform...) do
       # some Ruby code that defines platform-specific requirements
       attribute my_data
     end

   end

where

* Required. ``(:Name)`` is used to identify the plugin; when two plugins have the same ``(:Name)``, those plugins are joined together and run as if they were a single plugin. This value must be a valid Ruby class name, starting with a capital letter and containing only alphanumeric characters
* ``include`` is a standard Ruby method that allows an Ohai plugin to include a class, such as ``Ohai::Mixin::ModuleName``
* Required. ``provides`` is a comma-separated list of one (or more) attributes that are defined by this plugin. This attribute will become an automatic attribute (i.e. ``node[:attribute]``) after it is collected by Ohai at the start of the chef-client run. An attribute can also be defined using an ``attribute/subattribute`` pattern

New in Chef Client 12.0.

* ``depends`` is a comma-separated list of one (or more) attributes that are collected by another plugin; as long as the value is collected by another Ohai plugin, it can be used by any plugin
* ``shared_method`` defines code that can be shared among one (or more) ``collect_data`` blocks; for example, instead of defining a mash for each ``collect_data`` block, the code can be defined as a shared method, and then called from any ``collect_data`` block
* ``collect_data`` is a block of Ruby code that is called by Ohai when it runs; one (or more) ``collect_data`` blocks can be defined in a plugin, but only a single ``collect_data`` block is ever run.
* ``collect_data(:default)`` is the code block that runs when a node's platform is not defined by a platform-specific ``collect_data`` block
* ``collect_data(:platform)`` is a platform-specific code block that is run when a match exists between the node's platform and this ``collect_data`` block; only one ``collect_data`` block may exist for each platform; possible values: ``:aix``, ``:darwin``, ``:freebsd``, ``:hpux``, ``:linux``, ``:openbsd``, ``:netbsd``, ``:solaris2``, ``:windows``, or any other value from ``RbConfig::CONFIG['host_os']``
* ``my_data`` is  string (``a string value``) or an empty mash (``{ :setting_a => 'value_a', :setting_b => 'value_b' }``). This is used to define the data that should be collected by the plugin

For example, the following plugin looks up data on virtual machines hosted in Amazon EC2, Google Compute Engine, Rackspace, Eucalyptus, Linode, OpenStack, and Microsoft Azure:

.. code-block:: ruby

   Ohai.plugin(:Cloud) do
     provides 'cloud'

     depends 'ec2'
     depends 'gce'
     depends 'rackspace'
     depends 'eucalyptus'
     depends 'linode'
     depends 'openstack'
     depends 'azure'

     def create_objects
       cloud Mash.new
       cloud[:public_ips] = Array.new
       cloud[:private_ips] = Array.new
     end

     ...

     def on_gce?
       gce != nil
     end

     def get_gce_values
       cloud[:public_ipv4] = []
       cloud[:local_ipv4] = []

       public_ips = gce['instance']['networkInterfaces'].collect do |interface|
         if interface.has_key?('accessConfigs')
           interface['accessConfigs'].collect{|ac| ac['externalIp']}
         end
       end.flatten.compact

       private_ips = gce['instance']['networkInterfaces'].collect do |interface|
         interface['ip']
       end.compact

       cloud[:public_ips] += public_ips
       cloud[:private_ips] += private_ips
       cloud[:public_ipv4] +=  public_ips
       cloud[:public_hostname] = nil
       cloud[:local_ipv4] += private_ips
       cloud[:local_hostname] = gce['instance']['hostname']
       cloud[:provider] = 'gce'
     end

     ...

     # with following similar code blocks for each cloud provider

where

* ``provides`` defines the ``cloud`` attribute, which is then turned into an object using the ``create_objects`` shared method, which then generates a hash based on public or private IP addresses
* if the cloud provider is Google Compute Engine, then based on the IP address for the node, the ``cloud`` attribute data is populated into a hash

To see the rest of the code in this plugin, go to: https://github.com/chef/ohai/blob/master/lib/ohai/plugins/cloud.rb.

.. end_tag

Ohai DSL Methods
-----------------------------------------------------
.. tag dsl_ohai

The Ohai DSL is a Ruby DSL that is used to define an Ohai plugin and to ensure that Ohai collects the right data at the start of every chef-client run. The Ohai DSL is a small DSL with a single method that is specific to Ohai plugins. Because the Ohai DSL is a Ruby DSL, anything that can be done using Ruby can also be done when defining an Ohai plugin.

.. end_tag

collect_data
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. tag dsl_ohai_method_collect_data

The ``collect_data`` method is a block of Ruby code that is called by Ohai when it runs. One (or more) ``collect_data`` blocks can be defined in a plugin, but only a single ``collect_data`` block is ever run. The ``collect_data`` block that is run is determined by the platform on which the node is running, which is then matched up against the available ``collect_data`` blocks in the plugin.

* A ``collect_data(:default)`` block is used when Ohai is not able to match the platform of the node with a ``collect_data(:platform)`` block in the plugin
* A ``collect_data(:platform)`` block is required for each platform that requires non-default behavior

When Ohai runs, if there isn't a matching ``collect_data`` block for a platform, the ``collect_data(:default)`` block is used. The syntax for the ``collect_data`` method is:

.. code-block:: ruby

   collect_data(:default) do
     # some Ruby code
   end

or:

.. code-block:: ruby

   collect_data(:platform) do
     # some Ruby code
   end

where:

* ``:default`` is the name of the default ``collect_data`` block
* ``:platform`` is the name of a platform, such as ``:aix`` for AIX or ``:windows`` for Microsoft Windows

.. end_tag

Use a Mash
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
.. tag dsl_ohai_method_collect_data_mash

Use a mash to store data. This is done by creating a new mash, and then setting an attribute to it. For example:

.. code-block:: ruby

   provides 'name_of_mash'
   name_of_mash Mash.new
   name_of_mash[:attribute] = 'value'

.. end_tag

Examples
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
.. tag dsl_ohai_method_collect_data_example

The following examples show how to use the ``collect_data`` block:

.. code-block:: ruby

   Ohai.plugin(:Azure) do
     provides 'azure'

     collect_data do
       azure_metadata_from_hints = hint?('azure')
       if azure_metadata_from_hints
         Ohai::Log.debug('azure_metadata_from_hints is present.')
         azure Mash.new
         azure_metadata_from_hints.each {|k, v| azure[k] = v }
       else
         Ohai::Log.debug('No hints present for azure.')
         false
       end
     end
   end

or:

.. code-block:: ruby

   require 'ohai/mixin/ec2_metadata'
   extend Ohai::Mixin::Ec2Metadata

   Ohai.plugin do
     provides 'openstack'

     collect_data do
       if hint?('openstack') || hint?('hp')
         Ohai::Log.debug('ohai openstack')
         openstack Mash.new
         if can_metadata_connect?(EC2_METADATA_ADDR,80)
           Ohai::Log.debug('connecting to the OpenStack metadata service')
           self.fetch_metadata.each {|k, v| openstack[k] = v }
           case
           when hint?('hp')
             openstack['provider'] = 'hp'
           else
             openstack['provider'] = 'openstack'
           end
         else
           Ohai::Log.debug('unable to connect to the OpenStack metadata service')
         end
       else
         Ohai::Log.debug('NOT ohai openstack')
       end
     end
   end

.. end_tag

require
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. tag dsl_ohai_method_require

The ``require`` method is a standard Ruby method that can be used to list files that may be required by a platform, such as an external class library. As a best practice, even though the ``require`` method is often used at the top of a Ruby file, it is recommended that the use of the ``require`` method be used as part of the platform-specific ``collect_data`` block. For example, the Ruby WMI is required with Microsoft Windows:

.. code-block:: ruby

   collect_data(:windows) do
     require 'ruby-wmi'
     WIN32OLE.codepage = WIN32OLE::CP_UTF8

     kernel Mash.new

     host = WMI::Win32_OperatingSystem.find(:first)
     kernel[:os_info] = Mash.new
     host.properties_.each do |p|
       kernel[:os_info][p.name.wmi_underscore.to_sym] = host.send(p.name)
     end

     ...

   end

Ohai will attempt to fully qualify the name of any class by prepending ``Ohai::`` to the loaded class. For example both:

.. code-block:: ruby

   require Ohai::Mixin::ShellOut

and:

.. code-block:: ruby

   require Mixin::ShellOut

are both understood by the Ohai in the same way: ``Ohai::Mixin::ShellOut``.

When a class is an external class (and therefore should not have ``Ohai::`` prepended), use ``::`` to let the Ohai know. For example:

.. code-block:: ruby

   ::External::Class::Library

.. end_tag

/common Directory
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
.. tag dsl_ohai_method_require_common

The ``/common`` directory stores code that is used across all Ohai plugins. For example, a file in the ``/common`` directory named ``virtualization.rb`` that includes code like the following:

.. code-block:: ruby

   module Ohai
     module Common
       module Virtualization

         def host?(virtualization)
           !virtualization.nil? && virtualization[:role].eql?('host')
         end

         def open_virtconn(system)
           begin
             require 'libvirt'
             require 'hpricot'
           rescue LoadError => e
             Ohai::Log.debug('Cannot load gem: #{e}.')
           end

           emu = (system.eql?('kvm') ? 'qemu' : system)
           virtconn = Libvirt::open_read_only('#{emu}:///system')
         end

         ...

         def networks(virtconn)
           networks = Mash.new
           virtconn.list_networks.each do |n|
             nv = virtconn.lookup_network_by_name n
             networks[n] = Mash.new
             networks[n][:xml_desc] = (nv.xml_desc.split('\n').collect {|line| line.strip}).join
             ['bridge_name','uuid'].each {|a| networks[n][a] = nv.send(a)}
             #xdoc = Hpricot networks[n][:xml_desc]
           end
           networks
         end

         ...

       end
     end
   end

can then be leveraged in a plugin by using the ``require`` method to require the ``virtualization.rb`` file and then later calling each of the methods in the required module:

.. code-block:: ruby

   require 'ohai/common/virtualization'

   Ohai.plugin(:Virtualization) do
     include Ohai::Common::Virtualization

     provides 'virtualization'
     %w{ capabilities domains networks storage }.each do |subattr|
       provides 'virtualization/#{subattr}'
     end

     collect_data(:linux) do
       virtualization Mash.new

       ...

       if host?(virtualization)
         v = open_virtconn(virtualization[:system])

         virtualization[:libvirt_version] = libvirt_version(v)
         virtualization[:nodeinfo] = nodeinfo(v)
         virtualization[:uri] = uri(v)
         virtualization[:capabilities] = capabilities(v)
         virtualization[:domains] = domains(v)
         virtualization[:networks] = networks(v)
         virtualization[:storage] = storage(v)

         close_virtconn(v)
       end

.. end_tag

Shared Methods
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. tag dsl_ohai_method_shared_methods

A shared method defines behavior that may be used by more than one ``collect_data`` block, such as a data structure, a hash, or a mash. The syntax for a shared method is:

.. code-block:: ruby

   def a_shared_method
     # some Ruby code that defines the shared method
   end

For example, the following shared method is used to collect data about various cloud providers, depending on the cloud provider and the type of IP address:

.. code-block:: ruby

   def create_objects
     cloud Mash.new
     cloud[:public_ips] = Array.new
     cloud[:private_ips] = Array.new
   end

and then later on in the same plugin, the ``cloud`` object can be reused:

.. code-block:: ruby

   def get_linode_values
     cloud[:public_ips] << linode['public_ip']
     cloud[:private_ips] << linode['private_ip']
     cloud[:public_ipv4] = linode['public_ipv4']
     cloud[:public_hostname] = linode['public_hostname']
     cloud[:local_ipv4] = linode['local_ipv4']
     cloud[:local_hostname] = linode['local_hostname']
     cloud[:provider] = 'linode'
   end

and

.. code-block:: ruby

   def get_azure_values
     cloud[:vm_name] = azure['vm_name']
     cloud[:public_ips] << azure['public_ip']
     cloud[:public_fqdn] = azure['public_fqdn']
     cloud[:public_ssh_port] = azure['public_ssh_port'] if azure['public_ssh_port']
     cloud[:public_winrm_port] = azure['public_winrm_port'] if azure['public_winrm_port']
     cloud[:provider] = 'azure'
   end

and so on, for each of the various cloud providers.

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

Log Entries
-----------------------------------------------------
.. tag ohai_custom_plugin_logs

Use the ``Ohai::Log`` class in an Ohai plugin to define log entries that are created by Ohai. The syntax for a log message is as follows:

.. code-block:: ruby

   Ohai::Log.log_type('message')

where

* ``log_type`` can be ``.debug``, ``.info``, ``.warn``, ``.error``, or ``.fatal``
* ``'message'`` is the message that is logged.

For example:

.. code-block:: ruby

   Ohai.plugin do
     provides 'openstack'

     collect_data do
       if hint?('openstack') || hint?('hp')
         Ohai::Log.debug('ohai openstack')
         openstack Mash.new
         if can_metadata_connect?(EC2_METADATA_ADDR,80)
           Ohai::Log.debug('connecting to the OpenStack metadata service')
           self.fetch_metadata.each {|k, v| openstack[k] = v }
           case
           when hint?('hp')
             openstack['provider'] = 'hp'
           else
             openstack['provider'] = 'openstack'
           end
         else
           Ohai::Log.debug('unable to connect to the OpenStack metadata service')
         end
       else
         Ohai::Log.debug('NOT ohai openstack')
       end
     end
   end

.. end_tag

rescue
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. tag ohai_custom_plugin_logs_rescue

Use the ``rescue`` clause to make sure that a log message is always provided. For example:

.. code-block:: ruby

   rescue LoadError => e
     Ohai::Log.debug('ip_scopes: cannot load gem, plugin disabled: #{e}')
   end

.. end_tag

Examples
-----------------------------------------------------
The following examples show different ways of building Ohai plugins.

collect_data Blocks
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. tag ohai_custom_plugin_example_multiple_collect_data_blocks

The following Ohai plugin uses multiple ``collect_data`` blocks and shared methods to define platforms:

.. code-block:: ruby

   Ohai.plugin(:Hostname) do
     provides 'domain', 'fqdn', 'hostname'

     def from_cmd(cmd)
       so = shell_out(cmd)
       so.stdout.split($/)[0]
     end

     def collect_domain
       if fqdn
         fqdn =~ /.+?\.(.*)/
         domain $1
       end
     end

     collect_data(:aix, :hpux) do
       hostname from_cmd('hostname -s')
       fqdn from_cmd('hostname')
       domain collect_domain
     end

     collect_data(:darwin, :netbsd, :openbsd) do
       hostname from_cmd('hostname -s')
       fqdn from_cmd('hostname')
       domain collect_domain
     end

     collect_data(:freebsd) do
       hostname from_cmd('hostname -s')
       fqdn from_cmd('hostname -f')
       domain collect_domain
     end

     collect_data(:linux) do
       hostname from_cmd('hostname -s')
       begin
         fqdn from_cmd('hostname --fqdn')
       rescue
         Ohai::Log.debug('hostname -f returned an error, probably no domain is set')
       end
       domain collect_domain
     end

     collect_data(:solaris2) do
       require 'socket'

       hostname from_cmd('hostname')

       fqdn_lookup = Socket.getaddrinfo(hostname, nil, nil, nil, nil, Socket::AI_CANONNAME).first[2]
       if fqdn_lookup.split('.').length > 1
         # we received an fqdn
         fqdn fqdn_lookup
       else
         # default to assembling one
         h = from_cmd('hostname')
         d = from_cmd('domainname')
         fqdn '#{h}.#{d}'
       end

       domain collect_domain
     end

     collect_data(:windows) do
       require 'ruby-wmi'
       require 'socket'

       host = WMI::Win32_ComputerSystem.find(:first)
       hostname '#{host.Name}'

       info = Socket.gethostbyname(Socket.gethostname)
       if info.first =~ /.+?\.(.*)/
         fqdn info.first
       else
         # host is not in dns. optionally use:
         # C:\WINDOWS\system32\drivers\etc\hosts
         fqdn Socket.gethostbyaddr(info.last).first
       end

      domain collect_domain
     end
   end

.. end_tag

Use a mixin Library
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. tag ohai_custom_plugin_example_use_mixin_library

The following Ohai example shows a plugin can use a ``mixin`` library and also depend on another plugin:

.. code-block:: ruby

   require 'ohai/mixin/os'

   Ohai.plugin(:Os) do
     provides 'os', 'os_version'
     depends 'kernel'

     collect_data do
       os collect_os
       os_version kernel[:release]
     end
   end

.. end_tag

Get Kernel Values
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. tag ohai_custom_plugin_example_kernels

The following Ohai example shows part of a file that gets initial kernel attribute values:

.. code-block:: ruby

   Ohai.plugin(:Kernel) do
     provides 'kernel', 'kernel/modules'

     def init_kernel
       kernel Mash.new
       [['uname -s', :name], ['uname -r', :release],
       ['uname -v', :version], ['uname -m', :machine]].each do |cmd, property|
         so = shell_out(cmd)
         kernel[property] = so.stdout.split($/)[0]
       end
       kernel
     end

     ...

     collect_data(:darwin) do
       kernel init_kernel
       kernel[:os] = kernel[:name]

       so = shell_out('sysctl -n hw.optional.x86_64')
       if so.stdout.split($/)[0].to_i == 1
         kernel[:machine] = 'x86_64'
       end

       modules = Mash.new
       so = shell_out('kextstat -k -l')
       so.stdout.lines do |line|
         if line =~ /(\d+)\s+(\d+)\s+0x[0-9a-f]+\s+0x([0-9a-f]+)\s+0x[0-9a-f]+\s+([a-zA-Z0-9\.]+) \(([0-9\.]+)\)/
           kext[$4] = { :version => $5, :size => $3.hex, :index => $1, :refcount => $2 }
         end
       end

       kernel[:modules] = modules
     end

     ...

.. end_tag

Ohai 6 vs. Newer Plugins
-----------------------------------------------------
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

ohai Resource
=====================================================
.. tag resources_common_generic

A :doc:`resource </resource>` defines the desired state for a single configuration item present on a node that is under management by Chef. A resource collection---one (or more) individual resources---defines the desired state for the entire node. During a `chef-client run </chef_client.html#the-chef-client-run>`_, the current state of each resource is tested, after which the chef-client will take any steps that are necessary to repair the node and bring it back into the desired state.

.. end_tag

.. tag resource_ohai_summary

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
* ``action`` identifies the steps the chef-client will take to bring the node into the desired state
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
.. tag resource_ohai_attributes

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

   .. tag resources_common_notification_timers

   A timer specifies the point during the chef-client run at which a notification is run. The following timers are available:

   ``:before``
      Specifies that the action on a notified resource should be run before processing the resource block in which the notification is located.

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

   Optional. The name of an Ohai plugin to be reloaded. If this property is not specified, the chef-client will reload all plugins.

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

   .. tag resources_common_notification_timers

   A timer specifies the point during the chef-client run at which a notification is run. The following timers are available:

   ``:before``
      Specifies that the action on a notified resource should be run before processing the resource block in which the notification is located.

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
This resource has the following providers:

``Chef::Provider::Ohai``, ``ohai``
   The default provider for all platforms.

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

.. tag resource_ohai_reload_after_create_user

.. To reload Ohai configuration after a new user is created:

.. code-block:: ruby

   ohai 'reload_passwd' do
     action :nothing
     plugin 'etc'
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

Default Location
-----------------------------------------------------
To change the directory in which plugins are located edit the attributes file in the ``ohai`` cookbook for the ``node[:ohai][:plugin_path]`` attribute. Change the value to the desired directory path. For example:

.. code-block:: ruby

   default[:ohai][:plugin_path] = "/etc/chef/ohai_plugins"

Upload Custom Plugins
-----------------------------------------------------
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

Add Ohai to a Run-list
-----------------------------------------------------
The ``ohai`` recipe can be added to a run-list. First, ensure that any custom Ohai plugins are loaded and available to recipes. When the chef-client runs, the plugins will be copied into place and then loaded and merged with the node. This does cause Ohai to be run twice, which can increase the total run time for the chef-client.

ohai Command Line Tool
=====================================================
.. tag ctl_ohai_summary

ohai is the command-line interface for Ohai, a tool that is used to detect attributes on a node, and then provide these attributes to the chef-client at the start of every chef-client run.

.. end_tag

Options
-----------------------------------------------------
.. tag ctl_ohai_options

This command has the following syntax:

.. code-block:: bash

   $ ohai OPTION

This tool has the following options:

``ATTRIBUTE_NAME ATTRIBUTE NAME ...``
   Use to have Ohai show only output for named attributes.

``-d PATH``, ``--directory PATH``
   The directory in which Ohai plugins are located. For example: ``/etc/ohai/plugins``.

``-h``, ``--help``
   Show help for the command.

``-l LEVEL``, ``--log_level LEVEL``
   The level of logging to be stored in a log file.

``-L LOGLOCATION``, ``--logfile c``
   The location of the log file.

``-v``, ``--version``
   The version of Ohai.

.. end_tag

Examples
-----------------------------------------------------
None.

Ohai Settings in client.rb
=====================================================

.. tag config_rb_ohai

Ohai configuration settings can be added to the client.rb file.

.. end_tag

.. tag config_rb_ohai_settings

``ohai.directory``
   The directory in which Ohai plugins are located.

``ohai.disabled_plugins``
   An array of Ohai plugins to be disabled on a node. The list of plugins included in Ohai can be found in the ``ohai/lib/ohai/plugins`` directory. For example, disabling a single plugin:

   .. code-block:: ruby

      ohai.disabled_plugins = [
        :MyPlugin
      ]

    or disabling multiple plugins:

   .. code-block:: ruby

      ohai.disabled_plugins = [
        :MyPlugin,
        :MyPlugin,
        :MyPlugin
      ]

   and to disable multiple plugins, including Ohai 6 plugins:

   .. code-block:: ruby

      ohai.disabled_plugins = [
		:MyPlugin,
        :MyPlugin,
        'my_ohai_6_plugin'
      ]

   When a plugin is disabled, the chef-client log file will contain entries similar to:

   .. code-block:: ruby

      [2014-06-13T23:49:12+00:00] DEBUG: Skipping disabled plugin MyPlugin

``ohai.hints_path``
   The path to the file that contains hints for Ohai.

``ohai.log_level``
   The level of logging to be stored in a log file.

``ohai.log_location``
   The location of the log file.

``ohai.plugin_path``
   An array of paths at which Ohai plugins are located. Default value: ``[<CHEF_GEM_PATH>/ohai-9.9.9/lib/ohai/plugins]``. When custom Ohai plugins are added, the paths must be added to the array. For example, a single plugin:

   .. code-block:: ruby

      ohai.plugin_path << '/etc/chef/ohai_plugins'

   and for multiple plugins:

   .. code-block:: ruby

      ohai.plugin_path += [
        '/etc/chef/ohai_plugins',
        '/path/to/other/plugins'
        ]

``ohai.version``
   The version of Ohai.

.. note:: The Ohai executable ignores settings in the client.rb file when Ohai is run independently of the chef-client.

.. end_tag
