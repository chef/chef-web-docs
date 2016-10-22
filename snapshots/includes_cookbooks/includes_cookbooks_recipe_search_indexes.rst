.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

The results of a search query can be loaded into a recipe. For example, a very simple search query (in a recipe) might look like this:

.. code-block:: ruby

   search(:node, 'attribute:value')

A search query can be assigned to variables and then used elsewhere in a recipe. For example, to search for all nodes that have a role assignment named ``webserver``, and then render a template which includes those role assignments:

.. code-block:: ruby

   webservers = search(:node, 'role:webserver')
   
   template '/tmp/list_of_webservers' do
     source 'list_of_webservers.erb'
     variables(:webservers => webservers)
   end
