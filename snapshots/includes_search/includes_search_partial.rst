.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

A partial search query allows a search query to be made against specific attribute keys that are stored on the Chef server. A partial search query can search the same set of objects on the Chef server as a full search query, including specifying an object index and providing a query that can be matched to the relevant index. While a full search query will return an array of objects that match (each object containing a full set of attributes for the node), a partial search query will return only the values for the attributes that match. One primary benefit of using a partial search query is that it requires less memory and network bandwidth while the chef-client processes the search results.

.. note:: To use the ``partial_search`` method in a recipe, that recipe must contain a dependency on the ``partial_search`` cookbook.

To create a partial search query, use the ``partial_search`` method, and then specify the key paths for the attributes to be returned. Each key path should be specified as an array of strings and is mapped to an arbitrary short name. For example:

.. code-block:: ruby

   partial_search(:node, 'role:web',
     :keys => { 'name' => [ 'name' ],
                'ip'   => [ 'ipaddress' ],
                'kernel_version' => [ 'kernel', 'version' ]
              }
   ).each do |result|
     puts result['name']
     puts result['ip']
     puts result['kernel_version']
   end

In the previous example, two attributes will be extracted (on the Chef server) from any node that matches the search query. The result will be a simple hash with keys ``name``, ``ip``, and ``kernel_version``.
