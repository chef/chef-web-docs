.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

The ``mindays`` matcher tests the minimum number of days between password changes:

.. code-block:: ruby

   its('mindays') { should eq 0 }

where ``0`` represents the maximum number of days.
