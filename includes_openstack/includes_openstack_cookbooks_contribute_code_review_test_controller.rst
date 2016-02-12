.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


To test the controller:

.. code-block:: bash

   # Access the controller as noted above
   $ source openrc
   $ nova service-list && nova hypervisor-list
   $ glance image-list
   $ keystone user-list
   $ nova list
   $ nova boot test --image cirros --flavor 1  --security-groups=allow_ssh --key-name=mykey
   $ ssh cirros@<ip address from nova list output>

and then try to ping something like google.com
