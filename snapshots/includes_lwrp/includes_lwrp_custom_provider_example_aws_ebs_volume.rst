.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


The ``aws_ebs_volume`` custom provider (found in the `aws <https://github.com/chef-cookbooks/aws>`_ cookbook) defines how the chef-client would handle a recipe that uses the ``ebs_volume`` custom resource and the ``:detach`` action. The following ``action`` block tells the chef-client what to do with the ``:detach`` action:

.. code-block:: ruby

   action :detach do
     vol = determine_volume
     return if vol[:aws_instance_id] != instance_id
     converge_by('detach volume with id: #{vol[:aws_id]}') do
       detach_volume(vol[:aws_id], new_resource.timeout)
     end
   end

and the following ``def`` block defines the ``vol`` variable called by the ``determine_volume`` method:

.. code-block:: ruby

   def determine_volume
     vol = currently_attached_volume(instance_id, new_resource.device)
     vol_id = new_resource.volume_id || volume_id_in_node_data || ( vol ? vol[:aws_id] : nil )
     raise 'volume_id attribute not set ... no volume is attached at the device' unless vol_id
   
     vol = volume_by_id(vol_id)
     raise 'No volume with id #{vol_id} exists' unless vol
   
     vol
   end
