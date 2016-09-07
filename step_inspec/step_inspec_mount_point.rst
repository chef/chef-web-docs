.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

.. To test a mount point on '/':

.. code-block:: ruby

   describe mount('/') do
     it { should be_mounted }
     its('device') { should eq  '/dev/mapper/VolGroup-lv_root' }
     its('type') { should eq  'ext4' }
     its('options') { should eq ['rw', 'mode=620'] }
   end
