.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

The mdadm command can be used to create RAID arrays. For example, a RAID 5 array named ``/dev/sd0`` with 4, and a superblock type of ``0.90`` would be similar to:

.. code-block:: ruby

   mdadm '/dev/sd0' do
     devices [ '/dev/s1', '/dev/s2', '/dev/s3', '/dev/s4' ]
     level 5
     metadata '0.90'
     chunk 32
     action :create
   end
