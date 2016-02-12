.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

The ``be_character_device`` matcher tests if the file exists as a character device (that corresponds to a block device), such as ``/dev/rdisk0`` or ``/dev/rdisk0s9``:

.. code-block:: ruby

   it { should be_character_device }
