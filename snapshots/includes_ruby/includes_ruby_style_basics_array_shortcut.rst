.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

The ``%w`` syntax is a Ruby shortcut for creating an array without requiring quotes and commas around the elements.

For example:

.. code-block:: ruby

   if %w{debian ubuntu}.include?(node['platform'])
     # do debian/ubuntu things with the Ruby array %w{} shortcut
   end 

.. 
.. The ``%w`` array will use single-quotes, will not have access to code interpolation, and may only use a limited set of escape characters: ``\``.
.. 
.. .. note:: Use an upper-case W---``%W``---to create an array with double-quotes, access to code interpolation, and access to all escape characters.
..  

.. future example: step_resource_package_use_whitespace_array
.. future example: step_resource_template_use_whitespace_array
