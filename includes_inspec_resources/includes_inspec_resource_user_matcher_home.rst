.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

The ``home`` matcher tests the home directory path for the user:

.. code-block:: ruby

   its('home') { should eq '/root' }
