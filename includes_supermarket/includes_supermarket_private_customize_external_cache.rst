.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


|supermarket| installations can also use an external cache store. The public |supermarket| uses |redis| on |amazon elasticache|. One |redis| instance per private |supermarket| application server may be run safely. Use |redis| 2.8 (or higher) for a high availability pair. To use an external cache, configure the following attributes in the ``/recipes/default.rb`` recipe of the wrapper cookbook:

.. code-block:: ruby

   node.set['supermarket_omnibus']['redis']['enable'] = false
   node.set['supermarket_omnibus']['redis_url'] = 'redis://your-redis-instance:6379'
