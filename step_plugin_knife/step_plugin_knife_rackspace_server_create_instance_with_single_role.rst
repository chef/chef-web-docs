.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


To launch a new |rackspace| instance with the ``webserver`` role, enter:

.. code-block:: bash

   $ knife rackspace server create -r 'role[webserver]' --server-name server01 --node-name server01 --image 49 --flavor 2
