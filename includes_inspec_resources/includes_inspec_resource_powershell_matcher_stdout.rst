.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

The ``stdout`` matcher tests results of the command as returned in standard output (stdout):

.. code-block:: ruby

   its('stdout') { should eq '/^1$/' }
