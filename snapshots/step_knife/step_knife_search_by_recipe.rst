.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

To search for recipes that are used by a node, use the ``recipes`` attribute to search for the recipe names, enter something like:

.. code-block:: bash

   $ knife search node 'recipes:recipe_name'
   
or:

.. code-block:: bash

   $ knife search node '*:*' -a recipes | grep 'recipe_name'
   
