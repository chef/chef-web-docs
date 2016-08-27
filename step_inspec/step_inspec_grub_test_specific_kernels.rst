.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

.. To test a specific kernel:

.. code-block:: ruby

   grub_conf('/etc/grub.conf',  'CentOS (2.6.32-573.12.1.el6.x86_64)') do
     its('kernel') { should include 'audit=1' }
   end
