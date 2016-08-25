.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

Publish cookbooks to |supermarket|, but with custom credentials:

.. code-block:: javascript

   "delivery-truck":{
     "publish": {
       "supermarket": "https://supermarket.chef.io",
       "supermarket-custom-credentials": "true"
     }
   }

This publishing option requires the ``supermarket_user`` and ``supermarket_key`` credentials to be available from the ``delivery-secrets`` data bag on the |chef server| that is part of this |delivery| configuration.
