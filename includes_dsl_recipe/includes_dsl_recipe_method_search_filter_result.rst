.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

Use ``:filter_result`` as part of a search query against the |chef server| to return data in the form of the specified |ruby hash|.

The syntax for the ``search`` method that uses ``:filter_result`` is as follows:

.. code-block:: ruby

   search(:index, 'query',
     :filter_result => { 'foo' => [ 'abc' ],
                         'bar' => [ '123' ],
                         'baz' => [ 'sea', 'power' ]
                       }
         ).each do |result|
     puts result['foo']
     puts result['bar']
     puts result['baz']
   end

where:

* ``:index`` is of name of the index on the |chef server| against which the search query will run: ``:client``, ``:data_bag_name``, ``:environment``, ``:node``, and ``:role``
* ``'query'`` is a valid search query against an object on the |chef server|
* ``:filter_result`` defines a |ruby hash| of values to be returned

For example:

.. code-block:: ruby

   search(:node, 'role:web',
     :filter_result => { 'name' => [ 'name' ],
                         'ip' => [ 'ipaddress' ],
                         'kernel_version' => [ 'kernel', 'version' ]
                       }
         ).each do |result|
     puts result['name']
     puts result['ip']
     puts result['kernel_version']
   end
