.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


To get a fully-functional |amazon ami| for |chef server|, do the following:

#. Login to the `AWS Marketplace <https://aws.amazon.com/marketplace>`__ using your |amazon aws| account credentials
#. `Choose an AMI <https://aws.amazon.com/marketplace/seller-profile/ref=dtl_pcp_sold_by?ie=UTF8&id=e7b7691e-634a-4d35-b729-a8b576175e8c>`__ based on the number of nodes to be under management by |chef|.
#. Configure the region, the |amazon ec2| instance type, |amazon vpc| settings, security group, and the SSH key pair.
#. Assign the |chef server| `a public IP address <http://docs.aws.amazon.com/AWSEC2/latest/UserGuide/using-instance-addressing.html#concepts-public-addresses>`__.
#. Launch the |amazon ami|.
