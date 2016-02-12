.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

The ``content`` matcher tests if contents in the file that defines the bonded network interface match the value specified in the test. The values of the ``content`` matcher are arbitrary:

.. code-block:: ruby

   its('content') { should match('value') }
