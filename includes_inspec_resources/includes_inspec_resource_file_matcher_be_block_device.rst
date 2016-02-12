.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

The ``be_block_device`` matcher tests if the file exists as a block device, such as ``/dev/disk0`` or ``/dev/disk0s9``:

.. code-block:: ruby

   it { should be_block_device }
