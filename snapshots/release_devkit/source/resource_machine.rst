.. THIS PAGE IS IDENTICAL TO docs.chef.io/resource_machine.html BY DESIGN
.. THIS PAGE IS LOCATED AT THE /release/devkit/ PATH.

=====================================================
machine
=====================================================

.. include:: ../../includes_resources/includes_resource_machine.rst

.. warning:: .. include:: ../../includes_notes/includes_notes_provisioning.rst

Syntax
=====================================================
.. include:: ../../includes_resources/includes_resource_machine_syntax.rst

Actions
=====================================================
.. include:: ../../includes_resources/includes_resource_machine_actions.rst

In-Parallel Processing
-----------------------------------------------------
.. include:: ../../includes_provisioning/includes_provisioning_parallel.rst

Properties
=====================================================
.. include:: ../../includes_resources/includes_resource_machine_attributes.rst

.. 
.. Providers
.. =====================================================
.. .. include:: ../../includes_resources_common/includes_resources_common_provider.rst
.. 
.. .. include:: ../../includes_resources_common/includes_resources_common_provider_attributes.rst
.. 
.. .. include:: ../../includes_resources/includes_resource_machine_providers.rst
.. 

Examples
=====================================================
The following examples demonstrate various approaches for using resources in recipes. If you want to see examples of how Chef uses resources in recipes, take a closer look at the cookbooks that Chef authors and maintains: https://github.com/chef-cookbooks.

**Build machines dynamically**

.. include:: ../../step_resource/step_resource_machines_build_machines_dynamically.rst

**Get a remote file onto a new machine**

.. include:: ../../step_resource/step_resource_machine_file_get_remote_file.rst

**Build machines that depend on each other**

.. include:: ../../step_resource/step_resource_machines_codependent_servers.rst

**Use a loop to build many machines**

.. include:: ../../step_resource/step_resource_machines_use_a_loop_to_create_many_machines.rst

**Converge multiple machine types, in-parallel**

.. include:: ../../step_resource/step_resource_machine_batch_multiple_machine_types.rst

**Define machine_options for a driver**

.. To define machine options:

.. code-block:: ruby

   require 'chef/provisioning_driver'
   
   machine 'wario' do
     recipe 'apache'
   
     machine_options :driver_options => {
      :base_image => {
        :name => 'ubuntu',
        :repository => 'ubuntu',
        :tag => '14.04'
        },
   
      :command => '/usr/sbin/httpd'
     }
   
   end

where ``provisioning_driver`` and ``:driver_options`` specify the actual ``driver`` that is being used to build the machine.

**Build a machine from a machine image**

.. include:: ../../step_resource/step_resource_machine_image_add_apache_to_image.rst

**Set up a VPC, route table, key pair, and machine for Amazon AWS**

.. include:: ../../step_resource_provisioning/step_resource_provisioning_aws_route_table_define_vpc_key_machine.rst
