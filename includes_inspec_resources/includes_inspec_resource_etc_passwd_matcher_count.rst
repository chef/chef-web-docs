.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

The ``count`` matcher tests the number of times the named user appears in ``/etc/passwd``:

.. code-block:: ruby

   its('count') { should eq 1 }
