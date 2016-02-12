.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

The ``maxdays`` matcher tests the maximum number of days between password changes:

.. code-block:: ruby

   its('maxdays') { should eq 99 }

where ``99`` represents the maximum number of days.
