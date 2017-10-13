=====================================================
Ohai Custom Plugins
=====================================================
`[edit on GitHub] <https://github.com/chef/chef-web-docs/blob/master/chef_master/source/ohai_custom.rst>`__

.. tag ohai_custom_plugin

Custom Ohai plugins describe additional configuration attributes to be collected by Ohai and provided to the chef-client during chef runs.

.. end_tag

See `About Ohai </ohai.html>`__ for information on Ohai configuration and usage.

Syntax
=====================================================
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
=====================================================
.. tag dsl_ohai

The Ohai DSL is a Ruby DSL that is used to define an Ohai plugin and to ensure that Ohai collects the right data at the start of every chef-client run. The Ohai DSL is a small DSL with a single method that is specific to Ohai plugins. Because the Ohai DSL is a Ruby DSL, anything that can be done using Ruby can also be done when defining an Ohai plugin.

.. end_tag

collect_data
-----------------------------------------------------
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
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. tag dsl_ohai_method_collect_data_mash

Use a mash to store data. This is done by creating a new mash, and then setting an attribute to it. For example:

.. code-block:: ruby

   provides 'name_of_mash'
   name_of_mash Mash.new
   name_of_mash[:attribute] = 'value'

.. end_tag

Examples
+++++++++++++++++++++++++++++++++++++++++++++++++++++
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
-----------------------------------------------------
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
+++++++++++++++++++++++++++++++++++++++++++++++++++++
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
-----------------------------------------------------
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

Logging
=====================================================
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
-----------------------------------------------------
.. tag ohai_custom_plugin_logs_rescue

Use the ``rescue`` clause to make sure that a log message is always provided. For example:

.. code-block:: ruby

   rescue LoadError => e
     Ohai::Log.debug('ip_scopes: cannot load gem, plugin disabled: #{e}')
   end

.. end_tag

Examples
=====================================================

.. note:: See https://github.com/rackerlabs/ohai-plugins/tree/master/plugins for some great examples of custom Ohai plugins.

The following examples show different ways of building Ohai plugins.

collect_data Blocks
-----------------------------------------------------
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
-----------------------------------------------------
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
-----------------------------------------------------
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

Migrating Ohai 6 Plugins
===============================================

Ohai 7 (Chef 11.12) introduced a new and more robust plugin DSL. In Ohai/Chef 14, support for loading existing Ohai V6 plugins will be removed. It is recommended that all Ohai 6 plugins be updated for new DSL behavior in Ohai 7 as soon as possible. When migrating Ohai 6 plugins to Ohai 7, consider the following:

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
