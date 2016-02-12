.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

The ``group`` matcher tests the group to which the user belongs:

.. code-block:: ruby

   its('group') { should eq 'root' }

where ``root`` represents the group.
