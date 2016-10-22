.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

.. To mount a local block device:

.. code-block:: ruby

   mount '/mnt/local' do
     device '/dev/sdb1'
     fstype 'ext3'
   end
