.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

The ``aws_rds_subnet_group`` resource is a driver-specific resource used by |chef provisioning|. Use the ``aws_rds_subnet_group`` resource to manage `a collection of subnets <http://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/USER_VPC.html#d0e44833>`__ that exist in an |amazon vpc| that is passed to the |amazon rds| instance. At least two subnets must be specified.
