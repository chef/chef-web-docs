.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


If the ``config.json`` file specifies:

.. code-block:: javascript

   "delivery-truck": {
     "lint": {
       "foodcritic": {
         "ignore_rules": ["RULE", "RULE", ...],
         "only_rules": ["RULE", "RULE", ...],
         "excludes": ["spec", "test"]
       }
     }
   }

then Foodcritic rules are not run against tests that are located in the specified directories, in this case the ``/spec`` and ``/test`` directories.
