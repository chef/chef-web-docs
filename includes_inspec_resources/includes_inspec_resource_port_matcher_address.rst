.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

The ``addresses`` matcher tests if the specified address is associated with a port:

.. code-block:: ruby

   its('addresses') { should include '0.0.0.0' }
