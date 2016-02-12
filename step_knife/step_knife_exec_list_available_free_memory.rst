.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


To show the available free memory for all nodes, enter:

.. code-block:: bash

   $ knife exec -E 'nodes.all {|n| puts "#{n.name} has #{n.memory.total} free memory"}'

