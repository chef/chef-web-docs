.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

When using the ``search`` method in a recipe, be sure to escape meta characters, such as square brackets, like the following:

.. code-block:: ruby

   search(:node, 'run_list:recipe\[foo\:\:bar\]') do |matching_node|
     puts matching_node.to_s
   end

and NOT like this:

.. code-block:: ruby

  search(:node, 'run_list:recipe[foo::bar]') do |matching_node|
    puts matching_node.to_s
   end

If meta characters are not escaped properly, the quality of the search query may be compromised.