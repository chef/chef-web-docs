.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

Use knife to add a recipe to the run-list for a node. For example:

.. code-block:: bash

   $ knife node run list add NODENAME "recipe[apache2]"

More than one recipe can be added:

.. code-block:: bash

   % knife node run list add NODENAME "recipe[apache2],recipe[mysql],role[ssh]"

which creates a run-list similar to:

.. code-block:: ruby

   run_list:
      recipe[apache2]
      recipe[mysql]
      role[ssh]
