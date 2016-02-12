.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

The ``aws_image`` resource is a driver-specific resource used by |chef provisioning|. Use the ``aws_image`` resource to manage |amazon ami| `images <http://docs.aws.amazon.com/AWSEC2/latest/UserGuide/AMIs.html>`__ that exist in |amazon ec2|. An image includes a template for the root volume of an instance (operating system, application server, application, for example), launch permissions, and a block mappping device that attaches volumes to the instance when it is launched.
