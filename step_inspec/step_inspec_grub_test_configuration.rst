.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

.. To test a configuration file and boot configuration:

.. code-block:: ruby

   describe grub_conf('/etc/grub.conf',  'default') do
     its('kernel') { should include '/vmlinuz-2.6.32-573.7.1.el6.x86_64' }
     its('initrd') { should include '/initramfs-2.6.32-573.el6.x86_64.img=1' }
     its('default') { should_not eq '1' }
     its('timeout') { should eq '5' }
   end
