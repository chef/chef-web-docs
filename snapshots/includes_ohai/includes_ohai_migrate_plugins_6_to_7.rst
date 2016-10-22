.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

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
