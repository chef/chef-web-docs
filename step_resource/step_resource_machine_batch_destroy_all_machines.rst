.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

.. To delete all machines:

.. code-block:: ruby

   machine_batch do
     machines search(:node, '*:*').map { |n| n.name }
     action :destroy
   end
