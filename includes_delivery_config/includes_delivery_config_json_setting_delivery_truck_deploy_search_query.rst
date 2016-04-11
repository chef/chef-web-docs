.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


If the ``config.json`` file specifies:

.. code-block:: javascript

   "delivery-truck": {
     "deploy": {
       "search": { :node, 'SEARCH_QUERY' }
     }
   }

then the search is run against all node objects on the |chef server|. For example:

.. code-block:: javascript

   "delivery-truck": {
     "deploy": {
       "search": { :node, 'role:load_balancer' }
     }
   }
