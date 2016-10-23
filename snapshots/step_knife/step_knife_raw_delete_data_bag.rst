.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


To delete a data bag, enter a command similar to:

.. code-block:: bash

   $ knife raw -m DELETE /data/foo

to return something similar to:

.. code-block:: bash

   {
     "name":"foo",
     "json_class":"Chef::DataBag",
     "chef_type":"data_bag"
   }