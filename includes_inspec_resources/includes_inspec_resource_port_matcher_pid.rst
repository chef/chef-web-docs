.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

The ``pid`` matcher tests the process identifier (PID):

.. code-block:: ruby

   its('pid') { should eq '27808' }
