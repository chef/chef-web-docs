.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

.. To setup primary and secondary machines:

.. code-block:: ruby

   machine_batch do
     machines %w(primary secondary web1 web2)
   end
   
   machine_batch do
     machine 'primary' do
       recipe 'initial_ha_setup'
     end
   end
   
   machine_batch do
     machine 'secondary' do
       recipe 'initial_ha_setup'
     end
   end
   
   machine_batch do
     %w(primary secondary).each do |name|
       machine name do
         recipe 'rest_of_setup'
       end
     end
   end
