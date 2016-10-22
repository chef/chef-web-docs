.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


If the ``config.json`` file specifies:

.. code-block:: javascript

   "delivery-truck": {
     "lint": {
       "foodcritic": {
         "only_rules": ["FC002"],
         "excludes": ["DIRECTORY", "DIRECTORY", ...]
       }
     }
   }

then only the ``FC002`` Foodcritic rules is run.
