.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


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
