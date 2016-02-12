=====================================================
|chef provisioning_title|
=====================================================

.. warning:: .. include:: ../../includes_notes/includes_notes_provisioning.rst

.. include:: ../../includes_provisioning/includes_provisioning.rst

In-Parallel Processing
=====================================================
.. include:: ../../includes_provisioning/includes_provisioning_parallel.rst

Drivers
=====================================================
.. include:: ../../includes_provisioning/includes_provisioning_drivers.rst

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
.. include:: ../../includes_resources/includes_resource_load_balancer_providers.rst

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
.. include:: ../../includes_resources/includes_resource_machine_providers.rst

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
.. include:: ../../includes_resources/includes_resource_machine_batch_providers.rst

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
.. include:: ../../includes_resources/includes_resource_machine_execute_providers.rst

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
.. include:: ../../includes_resources/includes_resource_machine_file_providers.rst

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
.. include:: ../../includes_resources/includes_resource_machine_image_providers.rst

Examples
+++++++++++++++++++++++++++++++++++++++++++++++++++++

**Build a machine from a machine image**

.. include:: ../../step_resource/step_resource_machine_image_add_apache_to_image.rst

AWS Driver Resources
=====================================================
.. include:: ../../includes_resources_provisioning/includes_resources_provisioning.rst

The following driver-specific resources are available for |amazon aws| and |chef provisioning|:

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

.. 
.. Getting Started
.. -----------------------------------------------------
.. Use |chef provisioning| to create machines and define how they are connected to each other. To use |chef provisioning| for configuration of these machines on |amazon aws| a node must first be created that can act as the provisioner machine. This node must
.. 
.. #. Have the |chef client| installed on it
.. #. Have |chef provisioning| installed on it, along with the ``chef-provisioning-aws`` |gem|
.. #. Be configured to talk to |amazon aws| via the |amazon aws| APIs (to request instances, load balancers, and so on)
.. #. Have credentials that allow access to perform any desired operation, such as creating and/or deleting an instance in |amazon ec2|
.. 
.. After an instance is provisioned, use a normal |chef client| run to fine-tune that machine. For example, updating configuration settings, installing packages, and so on.
.. 

Common Actions
-----------------------------------------------------
.. include:: ../../includes_resources_provisioning/includes_resources_provisioning_aws_actions.rst

aws_auto_scaling_group
-----------------------------------------------------
.. include:: ../../includes_resources_provisioning/includes_resources_provisioning_aws_auto_scaling_group.rst

Syntax
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources_provisioning/includes_resources_provisioning_aws_auto_scaling_group_syntax.rst

Properties
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources_provisioning/includes_resources_provisioning_aws_auto_scaling_group_attributes.rst

Examples
+++++++++++++++++++++++++++++++++++++++++++++++++++++
|generic resource statement|

**Define an auto scaling group**

.. include:: ../../step_resource_provisioning/step_resource_provisioning_aws_launch_config_auto_scale.rst

**Destroy auto scaling group and associated launch configuration**

.. include:: ../../step_resource_provisioning/step_resource_provisioning_aws_launch_config_auto_scale_destroy.rst


aws_cache_cluster
-----------------------------------------------------
.. include:: ../../includes_resources_provisioning/includes_resources_provisioning_aws_cache_cluster.rst

Syntax
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources_provisioning/includes_resources_provisioning_aws_cache_cluster_syntax.rst

Properties
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources_provisioning/includes_resources_provisioning_aws_cache_cluster_attributes.rst

Examples
+++++++++++++++++++++++++++++++++++++++++++++++++++++
|generic resource statement|

**Define a VPC, subnets, and security group for a cache cluster**

.. include:: ../../step_resource_provisioning/step_resource_provisioning_aws_cache_cluster_create.rst


aws_cache_replication_group
-----------------------------------------------------
.. include:: ../../includes_resources_provisioning/includes_resources_provisioning_aws_cache_replication_group.rst

Syntax
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources_provisioning/includes_resources_provisioning_aws_cache_replication_group_syntax.rst

Properties
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources_provisioning/includes_resources_provisioning_aws_cache_replication_group_attributes.rst

Examples
+++++++++++++++++++++++++++++++++++++++++++++++++++++
None.


aws_cache_subnet_group
-----------------------------------------------------
.. include:: ../../includes_resources_provisioning/includes_resources_provisioning_aws_cache_subnet_group.rst

Syntax
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources_provisioning/includes_resources_provisioning_aws_cache_subnet_group_syntax.rst

Properties
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources_provisioning/includes_resources_provisioning_aws_cache_subnet_group_attributes.rst

Examples
+++++++++++++++++++++++++++++++++++++++++++++++++++++
|generic resource statement|

**Define a cache subnet group for a cache cluster**

.. include:: ../../step_resource_provisioning/step_resource_provisioning_aws_cache_cluster_create.rst



aws_cloudsearch_domain
-----------------------------------------------------
.. include:: ../../includes_resources_provisioning/includes_resources_provisioning_aws_cloudsearch_domain.rst

Syntax
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources_provisioning/includes_resources_provisioning_aws_cloudsearch_domain_syntax.rst

Properties
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources_provisioning/includes_resources_provisioning_aws_cloudsearch_domain_attributes.rst

Examples
+++++++++++++++++++++++++++++++++++++++++++++++++++++
None.




aws_dhcp_options
-----------------------------------------------------
.. include:: ../../includes_resources_provisioning/includes_resources_provisioning_aws_dhcp_options.rst

Syntax
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources_provisioning/includes_resources_provisioning_aws_dhcp_options_syntax.rst

Properties
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources_provisioning/includes_resources_provisioning_aws_dhcp_options_attributes.rst

Examples
+++++++++++++++++++++++++++++++++++++++++++++++++++++
|generic resource statement|

**Create an option set**

.. include:: ../../step_resource_provisioning/step_resource_provisioning_aws_dhcp_options_create.rst

**Destroy an option set**

.. include:: ../../step_resource_provisioning/step_resource_provisioning_aws_dhcp_options_destroy.rst


aws_ebs_volume
-----------------------------------------------------
.. include:: ../../includes_resources_provisioning/includes_resources_provisioning_aws_ebs_volume.rst

Syntax
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources_provisioning/includes_resources_provisioning_aws_ebs_volume_syntax.rst

Properties
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources_provisioning/includes_resources_provisioning_aws_ebs_volume_attributes.rst

Examples
+++++++++++++++++++++++++++++++++++++++++++++++++++++
|generic resource statement|

**Create**

.. include:: ../../step_resource_provisioning/step_resource_provisioning_aws_ebs_volume_create_machine.rst

**Attach to a machine**

.. include:: ../../step_resource_provisioning/step_resource_provisioning_aws_ebs_volume_attach_to_machine.rst

**Reattach to a different device**

.. include:: ../../step_resource_provisioning/step_resource_provisioning_aws_ebs_volume_reattach_to_device.rst

**Reattach to a different machine**

.. include:: ../../step_resource_provisioning/step_resource_provisioning_aws_ebs_volume_reattach_to_machine.rst

**Skip a reattach attempt**

.. include:: ../../step_resource_provisioning/step_resource_provisioning_aws_ebs_volume_skip_reattach.rst

**Create and attach**

.. include:: ../../step_resource_provisioning/step_resource_provisioning_aws_ebs_volume_create_and_attach.rst

**Detach**

.. include:: ../../step_resource_provisioning/step_resource_provisioning_aws_ebs_volume_detach.rst

**Destroy volumes for batch of machines, along with keys**

.. include:: ../../step_resource_provisioning/step_resource_provisioning_aws_ebs_volume_delete_machine_and_keys.rst


aws_eip_address
-----------------------------------------------------
.. include:: ../../includes_resources_provisioning/includes_resources_provisioning_aws_eip_address.rst

Syntax
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources_provisioning/includes_resources_provisioning_aws_eip_address_syntax.rst

Properties
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources_provisioning/includes_resources_provisioning_aws_eip_address_attributes.rst

Examples
+++++++++++++++++++++++++++++++++++++++++++++++++++++
|generic resource statement|

**Associate elastic IP address**

.. include:: ../../step_resource_provisioning/step_resource_provisioning_aws_eip_address_associate.rst

**Associate elastic IP address with a machine**

.. include:: ../../step_resource_provisioning/step_resource_provisioning_aws_eip_address_associate_with_machine.rst

**Associate elastic IP address to a machine's VPC**

.. include:: ../../step_resource_provisioning/step_resource_provisioning_aws_eip_address_associate_with_vpc.rst


aws_image
-----------------------------------------------------
.. include:: ../../includes_resources_provisioning/includes_resources_provisioning_aws_image.rst

Syntax
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources_provisioning/includes_resources_provisioning_aws_image_syntax.rst

Properties
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources_provisioning/includes_resources_provisioning_aws_image_attributes.rst

Examples
+++++++++++++++++++++++++++++++++++++++++++++++++++++
None.


aws_instance
-----------------------------------------------------
.. include:: ../../includes_resources_provisioning/includes_resources_provisioning_aws_instance.rst

Syntax
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources_provisioning/includes_resources_provisioning_aws_instance_syntax.rst

Properties
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources_provisioning/includes_resources_provisioning_aws_instance_attributes.rst

Examples
+++++++++++++++++++++++++++++++++++++++++++++++++++++
None.


aws_internet_gateway
-----------------------------------------------------
.. include:: ../../includes_resources_provisioning/includes_resources_provisioning_aws_internet_gateway.rst

Syntax
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources_provisioning/includes_resources_provisioning_aws_internet_gateway_syntax.rst

Properties
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources_provisioning/includes_resources_provisioning_aws_internet_gateway_attributes.rst

Examples
+++++++++++++++++++++++++++++++++++++++++++++++++++++
|generic resource statement|

**Create an internet gateway**

.. include:: ../../step_resource_provisioning/step_resource_provisioning_aws_internet_gateway_add.rst


aws_key_pair
-----------------------------------------------------
.. include:: ../../includes_resources_provisioning/includes_resources_provisioning_aws_key_pair.rst

Syntax
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources_provisioning/includes_resources_provisioning_aws_key_pair_syntax.rst

Properties
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources_provisioning/includes_resources_provisioning_aws_key_pair_attributes.rst

Examples
+++++++++++++++++++++++++++++++++++++++++++++++++++++
|generic resource statement|

**Create a private key, regenerate it if necessary**

.. include:: ../../step_resource_provisioning/step_resource_provisioning_aws_key_pair_add.rst

**Destroy volumes for batch of machines, along with keys**

.. include:: ../../step_resource_provisioning/step_resource_provisioning_aws_ebs_volume_delete_machine_and_keys.rst

**Set up a VPC, route table, key pair, and machine**

.. include:: ../../step_resource_provisioning/step_resource_provisioning_aws_route_table_define_vpc_key_machine.rst


aws_launch_configuration
-----------------------------------------------------
.. include:: ../../includes_resources_provisioning/includes_resources_provisioning_aws_launch_configuration.rst

Syntax
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources_provisioning/includes_resources_provisioning_aws_launch_configuration_syntax.rst

Properties
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources_provisioning/includes_resources_provisioning_aws_launch_configuration_attributes.rst

Examples
+++++++++++++++++++++++++++++++++++++++++++++++++++++
|generic resource statement|

**Define an AMI instance type**

.. include:: ../../step_resource_provisioning/step_resource_provisioning_aws_launch_config_define.rst

**Define an auto scaling group**

.. include:: ../../step_resource_provisioning/step_resource_provisioning_aws_launch_config_auto_scale.rst

**Destroy auto scaling group and associated launch configuration**

.. include:: ../../step_resource_provisioning/step_resource_provisioning_aws_launch_config_auto_scale_destroy.rst


aws_load_balancer
-----------------------------------------------------
.. include:: ../../includes_resources_provisioning/includes_resources_provisioning_aws_load_balancer.rst

Syntax
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources_provisioning/includes_resources_provisioning_aws_load_balancer_syntax.rst

Properties
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources_provisioning/includes_resources_provisioning_aws_load_balancer_attributes.rst

Examples
+++++++++++++++++++++++++++++++++++++++++++++++++++++
None.


aws_network_acl
-----------------------------------------------------
.. include:: ../../includes_resources_provisioning/includes_resources_provisioning_aws_network_acl.rst

Syntax
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources_provisioning/includes_resources_provisioning_aws_network_acl_syntax.rst

Properties
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources_provisioning/includes_resources_provisioning_aws_network_acl_attributes.rst

Examples
+++++++++++++++++++++++++++++++++++++++++++++++++++++
None.


aws_network_interface
-----------------------------------------------------
.. include:: ../../includes_resources_provisioning/includes_resources_provisioning_aws_network_interface.rst

Syntax
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources_provisioning/includes_resources_provisioning_aws_network_interface_syntax.rst

Properties
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources_provisioning/includes_resources_provisioning_aws_network_interface_attributes.rst

Examples
+++++++++++++++++++++++++++++++++++++++++++++++++++++
|generic resource statement|

**Define a network interface**

.. include:: ../../step_resource_provisioning/step_resource_provisioning_aws_network_interface_define.rst


aws_rds_instance
-----------------------------------------------------
.. include:: ../../includes_resources_provisioning/includes_resources_provisioning_aws_rds_instance.rst

Syntax
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources_provisioning/includes_resources_provisioning_aws_rds_instance_syntax.rst

Properties
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources_provisioning/includes_resources_provisioning_aws_rds_instance_attributes.rst

Examples
+++++++++++++++++++++++++++++++++++++++++++++++++++++
None.


aws_rds_subnet_group
-----------------------------------------------------
.. include:: ../../includes_resources_provisioning/includes_resources_provisioning_aws_rds_subnet_group.rst

Syntax
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources_provisioning/includes_resources_provisioning_aws_rds_subnet_group_syntax.rst

Properties
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources_provisioning/includes_resources_provisioning_aws_rds_subnet_group_attributes.rst

Examples
+++++++++++++++++++++++++++++++++++++++++++++++++++++
None.





aws_route_table
-----------------------------------------------------
.. include:: ../../includes_resources_provisioning/includes_resources_provisioning_aws_route_table.rst

Syntax
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources_provisioning/includes_resources_provisioning_aws_route_table_syntax.rst

Properties
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources_provisioning/includes_resources_provisioning_aws_route_table_attributes.rst

Examples
+++++++++++++++++++++++++++++++++++++++++++++++++++++
|generic resource statement|

**Define a route table**

.. include:: ../../step_resource_provisioning/step_resource_provisioning_aws_route_table_define.rst

**Set up a VPC, route table, key pair, and machine**

.. include:: ../../step_resource_provisioning/step_resource_provisioning_aws_route_table_define_vpc_key_machine.rst


aws_s3_bucket
-----------------------------------------------------
.. include:: ../../includes_resources_provisioning/includes_resources_provisioning_aws_s3_bucket.rst

Syntax
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources_provisioning/includes_resources_provisioning_aws_s3_bucket_syntax.rst

Properties
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources_provisioning/includes_resources_provisioning_aws_s3_bucket_attributes.rst

Examples
+++++++++++++++++++++++++++++++++++++++++++++++++++++
|generic resource statement|

**Add an Amazon S3 bucket**

.. include:: ../../step_resource_provisioning/step_resource_provisioning_aws_s3_bucket_add.rst

**Delete an Amazon S3 bucket**

.. include:: ../../step_resource_provisioning/step_resource_provisioning_aws_s3_bucket_delete.rst


aws_security_group
-----------------------------------------------------
.. include:: ../../includes_resources_provisioning/includes_resources_provisioning_aws_security_group.rst

Syntax
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources_provisioning/includes_resources_provisioning_aws_security_group_syntax.rst

Properties
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources_provisioning/includes_resources_provisioning_aws_security_group_attributes.rst

Examples
+++++++++++++++++++++++++++++++++++++++++++++++++++++
|generic resource statement|

**Delete a security group**

.. include:: ../../step_resource_provisioning/step_resource_provisioning_aws_security_group_delete.rst

**Add inbound and outbound rules**

.. include:: ../../step_resource_provisioning/step_resource_provisioning_aws_security_group_inbound_and_outbound_rules.rst

**Add and edit inbound rules**

.. include:: ../../step_resource_provisioning/step_resource_provisioning_aws_security_group_inbound_rules.rst

**Add and edit outbound rules**

.. include:: ../../step_resource_provisioning/step_resource_provisioning_aws_security_group_outbound_rules.rst

**Add rules for specific ports, sources, and destinations**

.. include:: ../../step_resource_provisioning/step_resource_provisioning_aws_security_group_rules_ports_etc.rst

**Define a security group for a cache cluster**

.. include:: ../../step_resource_provisioning/step_resource_provisioning_aws_cache_cluster_create.rst

**Define a security group for a batch of machines**

.. include:: ../../step_resource_provisioning/step_resource_provisioning_aws_security_group_machine_batch.rst


aws_server_certificate
-----------------------------------------------------
.. include:: ../../includes_resources_provisioning/includes_resources_provisioning_aws_server_certificate.rst

Syntax
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources_provisioning/includes_resources_provisioning_aws_server_certificate_syntax.rst

Properties
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources_provisioning/includes_resources_provisioning_aws_server_certificate_attributes.rst

Examples
+++++++++++++++++++++++++++++++++++++++++++++++++++++
None.


aws_sns_topic
-----------------------------------------------------
.. include:: ../../includes_resources_provisioning/includes_resources_provisioning_aws_sns_topic.rst

Syntax
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources_provisioning/includes_resources_provisioning_aws_sns_topic_syntax.rst

Properties
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources_provisioning/includes_resources_provisioning_aws_sns_topic_attributes.rst

Examples
+++++++++++++++++++++++++++++++++++++++++++++++++++++
|generic resource statement|

**Create an SNS topic**

.. include:: ../../step_resource_provisioning/step_resource_provisioning_aws_sns_topic_create.rst

**Delete an SNS topic**

.. include:: ../../step_resource_provisioning/step_resource_provisioning_aws_sns_topic_delete.rst


aws_sqs_queue
-----------------------------------------------------
.. include:: ../../includes_resources_provisioning/includes_resources_provisioning_aws_sqs_queue.rst

Syntax
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources_provisioning/includes_resources_provisioning_aws_sqs_queue_syntax.rst

Properties
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources_provisioning/includes_resources_provisioning_aws_sqs_queue_attributes.rst

Examples
+++++++++++++++++++++++++++++++++++++++++++++++++++++
|generic resource statement|

**Create an SQS queue**

.. include:: ../../step_resource_provisioning/step_resource_provisioning_aws_sqs_queue_create.rst

**Delete an SQS queue**

.. include:: ../../step_resource_provisioning/step_resource_provisioning_aws_sqs_queue_delete.rst


aws_subnet
-----------------------------------------------------
.. include:: ../../includes_resources_provisioning/includes_resources_provisioning_aws_subnet.rst

Syntax
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources_provisioning/includes_resources_provisioning_aws_subnet_syntax.rst

Properties
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources_provisioning/includes_resources_provisioning_aws_subnet_attributes.rst

Examples
+++++++++++++++++++++++++++++++++++++++++++++++++++++
|generic resource statement|

**Remove the default subnet**

.. include:: ../../step_resource_provisioning/step_resource_provisioning_aws_subnet_remove_default.rst

**Add a public subnet**

.. include:: ../../step_resource_provisioning/step_resource_provisioning_aws_subnet_add_public.rst

**Define a subnet for a cache cluster**

.. include:: ../../step_resource_provisioning/step_resource_provisioning_aws_cache_cluster_create.rst

**Define subnets for a batch of machines**

.. include:: ../../step_resource_provisioning/step_resource_provisioning_aws_security_group_machine_batch.rst


aws_vpc
-----------------------------------------------------
.. include:: ../../includes_resources_provisioning/includes_resources_provisioning_aws_vpc.rst

Syntax
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources_provisioning/includes_resources_provisioning_aws_vpc_syntax.rst

Properties
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources_provisioning/includes_resources_provisioning_aws_vpc_attributes.rst

Examples
+++++++++++++++++++++++++++++++++++++++++++++++++++++
|generic resource statement|

**Add a defined virtual network (VPC)**

.. include:: ../../step_resource_provisioning/step_resource_provisioning_aws_vpc_add.rst

**Add a defined virtual network (VPC) with route table**

.. include:: ../../step_resource_provisioning/step_resource_provisioning_aws_vpc_add_route_table.rst

**Delete a VPC that has a defined route table**

.. include:: ../../step_resource_provisioning/step_resource_provisioning_aws_vpc_destroy_route_table.rst

**Set up a VPC, route table, key pair, and machine**

.. include:: ../../step_resource_provisioning/step_resource_provisioning_aws_route_table_define_vpc_key_machine.rst

**Define a VPC for a cache cluster**

.. include:: ../../step_resource_provisioning/step_resource_provisioning_aws_cache_cluster_create.rst

**Define a VPC for a batch of machines**

.. include:: ../../step_resource_provisioning/step_resource_provisioning_aws_security_group_machine_batch.rst



|fog| Driver Resources
=====================================================
.. include:: ../../includes_resources_provisioning/includes_resources_provisioning.rst

The following driver-specific resources are available for |fog| and |chef provisioning|:

* ``fog_key_pair``

fog_key_pair
-----------------------------------------------------
.. include:: ../../includes_resources_provisioning/includes_resources_provisioning_fog_key_pair.rst

Syntax
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources_provisioning/includes_resources_provisioning_fog_key_pair_syntax.rst

Properties
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources_provisioning/includes_resources_provisioning_fog_key_pair_attributes.rst

Examples
+++++++++++++++++++++++++++++++++++++++++++++++++++++
None.





|vagrant| Driver Resources
=====================================================
.. include:: ../../includes_resources_provisioning/includes_resources_provisioning.rst

The following driver-specific resources are available for |vagrant| and |chef provisioning|:

* ``vagrant_box``
* ``vagrant_cluster``

vagrant_box
-----------------------------------------------------
.. include:: ../../includes_resources_provisioning/includes_resources_provisioning_vagrant_box.rst

Syntax
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources_provisioning/includes_resources_provisioning_vagrant_box_syntax.rst

Properties
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources_provisioning/includes_resources_provisioning_vagrant_box_attributes.rst

Examples
+++++++++++++++++++++++++++++++++++++++++++++++++++++
None.

vagrant_cluster
-----------------------------------------------------
.. include:: ../../includes_resources_provisioning/includes_resources_provisioning_vagrant_cluster.rst

Syntax
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources_provisioning/includes_resources_provisioning_vagrant_cluster_syntax.rst

Properties
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources_provisioning/includes_resources_provisioning_vagrant_cluster_attributes.rst

Examples
+++++++++++++++++++++++++++++++++++++++++++++++++++++
None.