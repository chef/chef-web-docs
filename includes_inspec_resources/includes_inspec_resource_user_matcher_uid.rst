.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

The ``uid`` matcher tests the user identifier:

.. code-block:: ruby

   its('uid') { should eq 1234 } }

where ``1234`` represents the user identifier.
