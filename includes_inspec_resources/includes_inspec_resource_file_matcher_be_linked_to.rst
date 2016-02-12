.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

The ``be_linked_to`` matcher tests if the file is linked to the named target:

.. code-block:: ruby

   it { should be_linked_to '/etc/target-file' }
