.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

The ``type`` matcher tests the file system type:

.. code-block:: ruby

   its('type') { should eq  'ext4' }
