.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

The ``mode`` matcher tests if the mode assigned to the file matches the specified value:

.. code-block:: ruby

   its('mode') { should eq 0644 }
