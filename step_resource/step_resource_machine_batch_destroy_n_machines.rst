.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

.. To delete multiple machines in-parallel:

.. code-block:: ruby

   machine_batch do
     action :delete
     machines 'a', 'b', 'c', 'd', 'e'
   end
