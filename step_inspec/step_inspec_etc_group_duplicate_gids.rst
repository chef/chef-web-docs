.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

.. To test group identifiers (GIDs) for duplicates:

.. code-block:: ruby

   describe etc_group do
     its('gids') { should_not contain_duplicates }
   end
