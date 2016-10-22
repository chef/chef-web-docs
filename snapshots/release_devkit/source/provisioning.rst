.. THIS PAGE IS IDENTICAL TO docs.chef.io/provisioning.html BY DESIGN
.. THIS PAGE IS LOCATED AT THE /release/devkit/ PATH.

=====================================================
Chef Provisioning
=====================================================

.. warning:: .. include:: ../../includes_notes/includes_notes_provisioning.rst

.. include:: ../../includes_provisioning/includes_provisioning.rst

In-Parallel Processing
=====================================================
.. include:: ../../includes_provisioning/includes_provisioning_parallel.rst

Drivers
=====================================================
The following drivers are available for Chef provisioning:

.. list-table::
   :widths: 120 400
   :header-rows: 1

   * - Driver
     - Description
   * - `Amazon Web Services <https://github.com/chef/chef-provisioning-aws>`__
     - A Chef provisioning driver for Amazon Web Services (AWS).
   * - `Docker <https://github.com/chef/chef-provisioning-docker>`__
     - A Chef provisioning driver for Docker.
   * - `Fog <https://github.com/chef/chef-provisioning-fog>`__
     - A Chef provisioning driver for Fog.
   * - `Hanlon <https://github.com/chef/chef-provisioning-hanlon>`__
     - A Chef provisioning driver for Hanlon.
   * - `LXC <https://github.com/chef/chef-provisioning-lxc>`__
     - A Chef provisioning driver for LXC.
   * - `Microsoft Azure <https://github.com/chef/chef-provisioning-azure>`__
     - A Chef provisioning driver for Microsoft Azure.
   * - `OpenNebula <https://github.com/blackberry/chef-provisioning-opennebula>`__
     - A Chef provisioning driver for OpenNebula.
   * - `SSH <https://github.com/chef/chef-provisioning-ssh>`__
     - A Chef provisioning driver for SSH.
   * - `Vagrant <https://github.com/chef/chef-provisioning-vagrant>`__
     - A Chef provisioning driver for Vagrant.
   * - `vSphere <https://github.com/CenturyLinkCloud/chef-provisioning-vsphere>`__
     - A Chef provisioning driver for VMware vSphere.





Driver-specific Resources
-----------------------------------------------------
.. include:: ../../includes_resources_provisioning/includes_resources_provisioning.rst

Machine Resources
=====================================================
.. include:: ../../includes_resources_common/includes_resources_common.rst


load_balancer
-----------------------------------------------------
.. include:: ../../includes_resources/includes_resource_load_balancer.rst

Syntax
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_load_balancer_syntax.rst

Actions
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_load_balancer_actions.rst

Properties
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_load_balancer_attributes.rst

Providers
+++++++++++++++++++++++++++++++++++++++++++++++++++++
This resource has the following providers:

``Chef::Provider::LoadBalancer``, ``load_balancer``
   The default provider for all recipes.

Examples
+++++++++++++++++++++++++++++++++++++++++++++++++++++
None.


machine
-----------------------------------------------------
.. include:: ../../includes_resources/includes_resource_machine.rst

Syntax
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_machine_syntax.rst

Actions
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_machine_actions.rst

Properties
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_machine_attributes.rst

Providers
+++++++++++++++++++++++++++++++++++++++++++++++++++++
This resource has the following providers:

``Chef::Provider::Machine``, ``machine``
   The default provider for all recipes.

Examples
+++++++++++++++++++++++++++++++++++++++++++++++++++++

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

**Build a machine from a machine image**

.. include:: ../../step_resource/step_resource_machine_image_add_apache_to_image.rst


machine_batch
-----------------------------------------------------
.. include:: ../../includes_resources/includes_resource_machine_batch.rst

Syntax
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_machine_batch_syntax.rst

Actions
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_machine_batch_actions.rst

Properties
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_machine_batch_attributes.rst

Providers
+++++++++++++++++++++++++++++++++++++++++++++++++++++
This resource has the following providers:

``Chef::Provider::MachineBatch``, ``machine_batch``
   The default provider for all recipes.

Examples
+++++++++++++++++++++++++++++++++++++++++++++++++++++

**Set up multiple machines, in-parallel**

.. include:: ../../step_resource/step_resource_machine_batch_setup_n_machines.rst

**Converge multiple machines, in-parallel**

.. include:: ../../step_resource/step_resource_machine_batch_converge_n_machines.rst

**Stop multiple machines, in-parallel**

.. include:: ../../step_resource/step_resource_machine_batch_stop_n_machines.rst

**Destroy multiple machines, in-parallel**

.. include:: ../../step_resource/step_resource_machine_batch_destroy_n_machines.rst

**Converge multiple machine types, in-parallel**

.. include:: ../../step_resource/step_resource_machine_batch_multiple_machine_types.rst


machine_execute
-----------------------------------------------------
.. include:: ../../includes_resources/includes_resource_machine_execute.rst

Syntax
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_machine_execute_syntax.rst

Actions
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_machine_execute_actions.rst

Properties
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_machine_execute_attributes.rst

Providers
+++++++++++++++++++++++++++++++++++++++++++++++++++++
This resource has the following providers:

``Chef::Provider::MachineExecute``, ``machine_execute``
   The default provider for all recipes.

Examples
+++++++++++++++++++++++++++++++++++++++++++++++++++++
None.


machine_file
-----------------------------------------------------
.. include:: ../../includes_resources/includes_resource_machine_file.rst

Syntax
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_machine_file_syntax.rst

Actions
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_machine_file_actions.rst

Properties
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_machine_file_attributes.rst

Providers
+++++++++++++++++++++++++++++++++++++++++++++++++++++
This resource has the following providers:

``Chef::Provider::MachineFile``, ``machine_file``
   The default provider for all recipes.

Examples
+++++++++++++++++++++++++++++++++++++++++++++++++++++

**Get a remote file onto a new machine**

.. include:: ../../step_resource/step_resource_machine_file_get_remote_file.rst


machine_image
-----------------------------------------------------
.. include:: ../../includes_resources/includes_resource_machine_image.rst

Syntax
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_machine_image_syntax.rst

Actions
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_machine_image_actions.rst

Properties
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_machine_image_attributes.rst

Providers
+++++++++++++++++++++++++++++++++++++++++++++++++++++
This resource has the following providers:

``Chef::Provider::MachineImage``, ``machine_image``
   The default provider for all recipes.

Examples
+++++++++++++++++++++++++++++++++++++++++++++++++++++

**Build a machine from a machine image**

.. include:: ../../step_resource/step_resource_machine_image_add_apache_to_image.rst

AWS Driver Resources
=====================================================
.. include:: ../../includes_resources_provisioning/includes_resources_provisioning.rst

The following Chef provisioning driver-specific resources are available for Amazon Web Services (AWS):

* ``aws_auto_scaling_group``
* ``aws_cache_cluster``
* ``aws_cache_replication_group``
* ``aws_cache_subnet_group``
* ``aws_cloudsearch_domain``
* ``aws_dhcp_options``
* ``aws_ebs_volume``
* ``aws_eip_address``
* ``aws_image``
* ``aws_instance``
* ``aws_internet_gateway``
* ``aws_key_pair``
* ``aws_launch_configuration``
* ``aws_load_balancer``
* ``aws_network_acl``
* ``aws_network_interface``
* ``aws_rds_instance``
* ``aws_rds_subnet_group``
* ``aws_route_table``
* ``aws_s3_bucket``
* ``aws_security_group``
* ``aws_server_certificate``
* ``aws_sns_topic``
* ``aws_sqs_queue``
* ``aws_subnet``
* ``aws_vpc``

For more information about these driver-specific resources, see :doc:`AWS Driver Resources </provisioning_aws>`.

Fog Driver Resources
=====================================================
.. include:: ../../includes_resources_provisioning/includes_resources_provisioning.rst

The following Chef provisioning driver-specific resources are available for Fog:

* ``fog_key_pair``

For more information about these driver-specific resources, see :doc:`Fog Driver Resources </provisioning_fog>`.

Vagrant Driver Resources
=====================================================
.. include:: ../../includes_resources_provisioning/includes_resources_provisioning.rst

The following Chef provisioning driver-specific resources are available for Vagrant:

* ``vagrant_box``
* ``vagrant_cluster``

For more information about these driver-specific resources, see :doc:`Vagrant Driver Resources </provisioning_vagrant>`.
