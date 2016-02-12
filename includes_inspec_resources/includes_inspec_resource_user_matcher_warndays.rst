.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

The ``warndays`` matcher tests the number of days a user is warned before a password must be changed:

.. code-block:: ruby

   its('warndays') { should eq 5 }

where ``5`` represents the number of days a user is warned.
