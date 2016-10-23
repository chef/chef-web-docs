.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


The following example shows how to use ``only_if`` to only remove a recipe named ``recipe[ntp::undo]``, but only when that recipe is part of the ``recipe[ntp::default]`` run-list:

.. code-block:: ruby

   ruby_block 'remove ntp::undo from run list' do
     block do
       node.run_list.remove('recipe[ntp::undo]')
     end
     only_if { node.run_list.include?('recipe[ntp::default]') }
   end