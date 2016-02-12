.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

The ``owner`` matcher tests if the owner of the file matches the specified value:

.. code-block:: ruby

   its('owner') { should eq 'root' }
