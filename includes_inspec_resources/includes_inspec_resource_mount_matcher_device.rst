.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

The ``device`` matcher tests the device from the ``fstab`` table:

.. code-block:: ruby

   its('device') { should eq  '/dev/mapper/VolGroup-lv_root' }
