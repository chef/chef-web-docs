.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

The ``homes`` matcher tests the absolute path to a user's home directory:

.. code-block:: ruby

   its('home') { should eq '/' }
