.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


To delete a role, enter a command similar to:

.. code-block:: bash

   $ knife raw -m DELETE /roles/role-foo.json

to return something similar to:

.. code-block:: bash

   {
     "name":"role-foo",
     "json_class":"Chef::Role",
     "chef_type":"role"
   }
