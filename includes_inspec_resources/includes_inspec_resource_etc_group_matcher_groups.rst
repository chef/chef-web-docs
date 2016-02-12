.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

The ``groups`` matcher tests all groups for the named user:

.. code-block:: ruby

   its('groups') { should include 'my_group' }
