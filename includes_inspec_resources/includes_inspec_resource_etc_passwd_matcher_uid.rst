.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

The ``uid`` matcher tests if the user identifier in the test matches a user identifier in ``/etc/passwd``:

.. code-block:: ruby

   its('uid') { should eq 1234 }
