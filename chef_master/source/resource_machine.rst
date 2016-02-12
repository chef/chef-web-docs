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
|generic resource statement|

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

.. include:: ../../step_resource/step_resource_machines_define_machine_options.rst

**Build a machine from a machine image**

.. include:: ../../step_resource/step_resource_machine_image_add_apache_to_image.rst

**Set up a VPC, route table, key pair, and machine for Amazon AWS**

.. include:: ../../step_resource_provisioning/step_resource_provisioning_aws_route_table_define_vpc_key_machine.rst
