.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

The ``gid`` matcher tests the group identifier:

.. code-block:: ruby

   its('gid') { should eq 1234 } }

where ``1234`` represents the user identifier.
