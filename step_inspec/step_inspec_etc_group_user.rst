.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

.. To test all groups to see if a specific user belongs to one (or more) groups:

.. code-block:: ruby

   describe etc_group do
     its('groups') { should include 'my_group' }
   end
