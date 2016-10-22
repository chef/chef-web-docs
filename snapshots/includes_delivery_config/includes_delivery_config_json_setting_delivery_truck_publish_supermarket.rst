.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


Publish cookbooks to the public Chef Supermarket:

If the ``config.json`` file specifies the following cookbooks are published to the public Chef Supermarket:

.. code-block:: javascript

   "delivery-truck":{
     "publish": {
       "supermarket": "https://supermarket.chef.io"
     }
   }
