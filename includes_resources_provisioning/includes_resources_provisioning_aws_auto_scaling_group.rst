.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

The ``aws_auto_scaling_group`` resource is a driver-specific resource used by |chef provisioning|. Use the ``aws_auto_scaling_group`` resource to manage auto scaling groups for |amazon ec2| instances. |amazon auto_scaling| ensures that the correct number of |amazon ec2| instances are available. Each auto scaling group is set to a minimum size, along with a maximum that a group does not exceed.
