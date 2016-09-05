.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

The ``uids`` matcher tests if the user indentifiers in the test match user identifiers in ``/etc/passwd``:

.. code-block:: ruby

   its('uids') { should eq ['1234', '1235'] }

or:

.. code-block:: ruby

   describe passwd.uids(0) do
     its('users') { should cmp 'root' }
     its('count') { should eq 1 }
   end
