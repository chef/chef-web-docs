.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

The ``aws_vpc`` resource is a driver-specific resource used by |chef provisioning|. Use the ``aws_vpc`` resource to `launch resources into a defined virtual network <http://aws.amazon.com/documentation/vpc/>`__ with |amazon vpc| (the networking layer of |amazon ec2|).

This defined virtual network is dedicated to a specific |amazon aws| account and is logically isolated from other defined virtual network in |amazon aws|. |amazon ec2| instances may be launched into the defined virtual network and it may be configured for specific IP address ranges, subnets, routing tables, network gateways, and security settings.

Use this resource along with the

* ``aws_subnet`` resource to define instances that are contained within walled-off sub-sections of a defined virtual network
* ``aws_security_group`` resource to define which instances can talk to each other
* ``aws_route_table`` resource to define where traffic is located when an instance in a subnet talks to a specific IP address
