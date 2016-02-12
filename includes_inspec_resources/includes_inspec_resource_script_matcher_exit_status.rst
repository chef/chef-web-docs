.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

The ``exit_status`` matcher tests the exit status for the command:

.. code-block:: ruby

   its('exit_status') { should eq 123 }
