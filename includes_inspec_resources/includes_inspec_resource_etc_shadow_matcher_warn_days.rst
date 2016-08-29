.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

The ``warn_days`` matcher tests the number of days a user is warned about an expiring password:

.. code-block:: ruby

   its('warn_days') { should eq 7 }
