.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


To show the status for nodes on which the chef-client did not run successfully within the past hour, enter:

.. code-block:: bash

   $ knife status --hide-healthy
   
to return something like:

.. code-block:: bash

   1 hour ago, i-256f884f, ubuntu 12.04, ec2-67-202-63-102.compute-1.amazonaws.com, 67.202.63.102, role[web].
   1 hour ago, i-a47823c9, ubuntu 10.04, ec2-174-129-127-206.compute-1.amazonaws.com, 184.129.143.111, role[lb].
