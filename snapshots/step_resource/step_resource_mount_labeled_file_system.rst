.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

.. To mount a labeled file system:

.. code-block:: ruby

   mount '/mnt/volume1' do
     device 'volume1'
     device_type :label
     fstype 'xfs'
     options 'rw'
   end
