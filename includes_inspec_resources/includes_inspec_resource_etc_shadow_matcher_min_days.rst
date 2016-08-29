.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

The ``min_days`` matcher tests the minimum number of days a password must exist, before it may be changed:

.. code-block:: ruby

   its('min_days') { should eq 0 }
