.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

The ``property_name`` matcher tests the named property for the specified value:

.. code-block:: ruby

   its('property_name') { should eq 'property_value' }
