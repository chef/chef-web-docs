.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

The ``expiry_dates`` matcher tests the number of days a user account has been disabled:

.. code-block:: ruby

   its('expiry_dates') { should eq '' }
