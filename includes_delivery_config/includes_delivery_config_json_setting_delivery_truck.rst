.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


The ``delivery-truck`` setting specifies configurations for specific phases of the |delivery| pipeline.

For example, configure the ``lint.rb`` recipe to run only |foodcritic| rule ``FC002``:

.. code-block:: javascript

     "delivery-truck": {
       "lint": {
         "foodcritic": {
           "only_rules": ["FC002"]
         }
       }
     }
