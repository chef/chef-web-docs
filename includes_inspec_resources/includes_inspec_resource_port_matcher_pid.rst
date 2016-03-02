.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

The ``pids`` matcher tests the process identifiers (PIDs):

.. code-block:: ruby

   its('pids') { should eq ['27808'] }
