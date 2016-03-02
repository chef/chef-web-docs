.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

The ``options`` matcher tests the mount options for the file system from the ``fstab`` table:

.. code-block:: ruby

  its('options') { should eq ['rw', 'mode=620'] }
