.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

.. To setup multiple machines in-parallel:

.. code-block:: ruby

   machine_batch do
     action :setup
     machines 'a', 'b', 'c', 'd', 'e'
   end
