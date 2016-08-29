.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

The ``inactive_days`` matcher tests the number of days a user must be inactive before the user account is disabled:

.. code-block:: ruby

   its('inactive_days') { should eq '' }
