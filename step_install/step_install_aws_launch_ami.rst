.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

Click the 'Launch with Ec2 Console' button next to the desired region

Configure the |amazon ec2| instance type, |amazon vpc| settings, SSH key pair, IAM Role and assign `a public IP address <http://docs.aws.amazon.com/AWSEC2/latest/UserGuide/using-instance-addressing.html#concepts-public-addresses>`__.

   .. note:: You must assign the previously created IAM role or another role with full marketplace access unless you're launching from the IC Marketplace

Optionally add additional storage or increase the root volume size.

Configure security group to include the required ports for access.
