.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

The ``group`` matcher tests if the group to which a file belongs matches the specified value:

.. code-block:: ruby

   its('group') { should eq 'admins' }
