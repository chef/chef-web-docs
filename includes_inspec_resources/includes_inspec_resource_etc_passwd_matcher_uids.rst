.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

The ``uids`` matcher tests if the user indentifiers in the test match user identifiers in ``/etc/passwd``:

.. code-block:: ruby

   its('uids') { should eq ['1234', '1235'] }
