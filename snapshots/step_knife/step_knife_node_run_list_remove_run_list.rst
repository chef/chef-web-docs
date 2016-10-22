.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


To remove a recipe from a run-list using the fully qualified format, enter:

.. code-block:: bash

   $ knife node run_list remove NODE_NAME 'recipe[COOKBOOK::RECIPE_NAME]'
