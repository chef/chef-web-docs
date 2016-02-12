.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


To provision a new dual-core 1.0 GB |ubuntu| 10.04 web server with three attached disks with sizes of 25G, 50G, and 50G, enter something like:

.. code-block:: bash

   $ knife terremark server create --vcpus 2 -m 1024 -I 40 -A 'username' -K "password" 
     -r 'role[webserver]' -i ~/.ssh/ssh-identity-file.pem -N web-server-nginx --tcp 80,8080 
     --udp 5050 --disks 25,50,50