.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


If the ``config.json`` file specifies:

.. code-block:: javascript

   "delivery-truck": {
     "lint": {
       "foodcritic": {
         "ignore_rules": ["FC009", "FC057", "FC058"],
         "excludes": ["DIRECTORY", "DIRECTORY", ...]
       }
     }
   }

then all Foodcritic rules except ``FC009``, ``FC057``, and ``FC058``  rules are run.
