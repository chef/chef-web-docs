.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

To search for cookbooks on a node, use the ``recipes`` attribute followed by the ``cookbook::recipe`` pattern, escaping both of the ``:`` characters. For example:

.. code-block:: bash

   $ knife search node 'recipes:cookbook_name\:\:recipe_name'

