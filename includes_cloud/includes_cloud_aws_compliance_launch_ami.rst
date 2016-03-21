.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

To get a fully-functional |amazon ami| for |chef compliance|, do the following:

#. Login to the `AWS Marketplace <https://aws.amazon.com/marketplace>`__ using your |amazon aws| account credentials
#. Navigate to the |chef compliance| `product page <https://aws.amazon.com/marketplace/pp/B01B3NDVEO>`__ and accept the software terms
#. .. include:: ../../step_install/step_install_aws_create_metering_role.rst
#. Navigate back to the |chef compliance| `product page <https://aws.amazon.com/marketplace/pp/B01B3NDVEO>`__ and continue to the launch wizard.
#. .. include:: ../../step_install/step_install_aws_launch_ami.rst

   .. note:: Your security group should allow access from your workstation on ports 22 and 443

#. Launch |amazon ami|
