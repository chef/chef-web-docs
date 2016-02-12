.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


To delete a |rackspace| instance with an Instance ID of ``12345678``, enter:

.. code-block:: bash

   $ knife rackspace server delete 12345678

to return:

.. code-block:: bash

   Instance ID: 12345678
   Host ID: testexample
   Name: slice12345678
   Flavor: 1GB server
   Image: Ubuntu 10.04 LTS (lucid)
   Public DNS Name: 1-1-1-1.static.cloud-ips.com
   Public IP Address: 1.1.1.1
   Private IP Address: 192.168.1.1

Confirm the deletion:

.. code-block:: bash

   Do you really want to delete this server? (Y/N) Y
   WARNING: Deleted server 12345678 named slice12345678