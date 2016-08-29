.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

The ``max_days`` matcher tests the maximum number of days after which a password must be changed:

.. code-block:: ruby

   its('max_days') { should eq 90 }
