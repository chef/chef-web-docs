.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

The ``value`` matcher tests the value assigned to the named IP address versus the value declared in the test:

.. code-block:: ruby

   its('value') { should eq 0 }
