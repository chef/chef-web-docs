.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

.. To filter a list of groups for a specific user:

.. code-block:: ruby

   describe etc_group.where(name: 'my_group') do
     its('users') { should include 'my_user' }
   end
