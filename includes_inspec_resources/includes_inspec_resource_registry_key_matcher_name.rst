.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

The ``name`` matcher tests the value for the specified registry setting:

.. code-block:: ruby

   its('name') { should eq 'value' }
