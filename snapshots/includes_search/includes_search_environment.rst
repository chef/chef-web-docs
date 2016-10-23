.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

When searching, an environment is an attribute. This allows search results to be limited to a specified environment by using Boolean operators and extra search terms. For example, to use knife to search for all of the servers running CentOS in an environment named "QA", enter the following:

.. code-block:: bash

   knife search node "chef_environment:QA AND platform:centos"

Or, to include the same search in a recipe, use a code block similar to:

.. code-block:: ruby

   qa_nodes = search(:node,"chef_environment:QA")      
   qa_nodes.each do |qa_node|                          
       # Do useful work specific to qa nodes only
   end

