.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


To launch a new |amazon ec2| instance with the ``webserver`` role, enter:

.. code-block:: bash

   $ knife ec2 server create -r "role[webserver]" -I ami-2d4aa444 --flavor m1.small -G www,default -x ubuntu -N server01