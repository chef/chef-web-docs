.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


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
