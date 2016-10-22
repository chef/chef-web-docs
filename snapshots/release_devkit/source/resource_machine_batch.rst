.. THIS PAGE IS IDENTICAL TO docs.chef.io/resource_machine_batch.html BY DESIGN
.. THIS PAGE IS LOCATED AT THE /release/devkit/ PATH.

=====================================================
machine_batch
=====================================================

.. include:: ../../includes_resources/includes_resource_machine_batch.rst

.. warning:: .. include:: ../../includes_notes/includes_notes_provisioning.rst

Syntax
=====================================================
.. include:: ../../includes_resources/includes_resource_machine_batch_syntax.rst

Actions
=====================================================
.. include:: ../../includes_resources/includes_resource_machine_batch_actions.rst

In-Parallel Processing
-----------------------------------------------------
.. include:: ../../includes_provisioning/includes_provisioning_parallel.rst

Properties
=====================================================
.. include:: ../../includes_resources/includes_resource_machine_batch_attributes.rst

.. 
.. Providers
.. =====================================================
.. .. include:: ../../includes_resources_common/includes_resources_common_provider.rst
.. 
.. .. include:: ../../includes_resources_common/includes_resources_common_provider_attributes.rst
.. 
.. .. include:: ../../includes_resources/includes_resource_machine_batch_providers.rst
.. 

Examples
=====================================================
The following examples demonstrate various approaches for using resources in recipes. If you want to see examples of how Chef uses resources in recipes, take a closer look at the cookbooks that Chef authors and maintains: https://github.com/chef-cookbooks.

**Set up multiple machines, in-parallel**

.. include:: ../../step_resource/step_resource_machine_batch_setup_n_machines.rst

**Converge multiple machines, in-parallel**

.. include:: ../../step_resource/step_resource_machine_batch_converge_n_machines.rst

**Stop multiple machines, in-parallel**

.. include:: ../../step_resource/step_resource_machine_batch_stop_n_machines.rst

**Destroy multiple machines, in-parallel**

.. include:: ../../step_resource/step_resource_machine_batch_destroy_n_machines.rst

**Destroy all machines**

.. To delete all machines:

.. code-block:: ruby

   machine_batch do
     machines search(:node, '*:*').map { |n| n.name }
     action :destroy
   end

**Converge multiple machine types, in-parallel**

.. include:: ../../step_resource/step_resource_machine_batch_multiple_machine_types.rst

**Set up primary and secondary machines for high availability**

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

**Destroy EBS volumes for batch of machines, along with keys**

.. include:: ../../step_resource_provisioning/step_resource_provisioning_aws_ebs_volume_delete_machine_and_keys.rst

**Define subnets for a batch of machines on Amazon AWS**

.. include:: ../../step_resource_provisioning/step_resource_provisioning_aws_security_group_machine_batch.rst
