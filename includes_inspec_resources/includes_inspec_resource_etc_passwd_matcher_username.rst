.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

The ``users`` matcher tests if the user name in the test matches a user name in ``/etc/passwd``:

.. code-block:: ruby

   its('users') { should eq 'root' }
