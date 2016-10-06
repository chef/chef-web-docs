.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


A |supermarket| installation can use an external database running |postgresql| (9.3 or higher) and with the ``pgpsql`` and ``pg_trgm`` installed and loaded. The public |supermarket| uses |amazon rds|. To use an external database, configure the following attributes in the ``/recipes/default.rb`` recipe of the wrapper cookbook:

.. code-block:: ruby

   node.set['supermarket_omnibus']['config']['postgresql']['enable'] = false
   node.set['supermarket_omnibus']['config']['database']['user'] = 'supermarket'
   node.set['supermarket_omnibus']['config']['database']['name'] = 'supermarket'
   node.set['supermarket_omnibus']['config']['database']['host'] = 'yourcompany...rds.amazon.com'
   node.set['supermarket_omnibus']['config']['database']['port'] = '5432'
   node.set['supermarket_omnibus']['config']['database']['pool'] = '25'
   node.set['supermarket_omnibus']['config']['database']['password'] = 'topsecretneverguessit'
