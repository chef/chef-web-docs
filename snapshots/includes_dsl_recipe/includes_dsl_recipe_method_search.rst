.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

Use the ``search`` method to perform a search query against the Chef server from within a recipe.

The syntax for the ``search`` method is as follows:

.. code-block:: ruby

   search(:index, 'query')

where:

* ``:index`` is of name of the index on the Chef server against which the search query will run: ``:client``, ``:data_bag_name``, ``:environment``, ``:node``, and ``:role``
* ``'query'`` is a valid search query against an object on the Chef server (see below for more information about how to build the query)

For example, using the results of a search query within a variable:

.. code-block:: ruby

   webservers = search(:node, 'role:webserver')

and then using the results of that query to populate a template:

.. code-block:: ruby

   template '/tmp/list_of_webservers' do
     source 'list_of_webservers.erb'
     variables(:webservers => webservers)
   end
