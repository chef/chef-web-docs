.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


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
