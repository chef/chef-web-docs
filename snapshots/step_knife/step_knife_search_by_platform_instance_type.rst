.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


To search for the instance type (flavor) of all nodes running on the Amazon EC2 platform, enter:

.. code-block:: bash

   $ knife search node 'ec2:*' -a ec2.instance_type

to return something like:

.. code-block:: bash

   4 items found
   
   ec2.instance_type:  m1.large
   id:                 ip-0A7CA19F.ec2.internal
   
   ec2.instance_type:  m1.large
   id:                 ip-0A58CF8E.ec2.internal
   
   ec2.instance_type:  m1.large
   id:                 ip-0A58E134.ec2.internal
   
   ec2.instance_type:  m1.large
   id:                 ip-0A7CFFD5.ec2.internal

