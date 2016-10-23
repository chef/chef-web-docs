.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


64-bit versions of Microsoft Windows have a 32-bit compatibility layer that redirects attempts by 32-bit application to access the ``System32`` directory to a different location. Starting with chef-client version 12.9, the 32-bit version of the chef-client is subject to the file redirection policy.

For example, consider the following script:

.. code-block:: ruby

   process_type = ENV['PROCESSOR_ARCHITECTURE'] == 'AMD64' ? '64-bit' : '32-bit'
   system32_dir = ::File.join(ENV['SYSTEMROOT'], 'system32')
   test_dir = ::File.join(system32_dir, 'cheftest')
   test_file = ::File.join(test_dir, 'chef_architecture.txt')

   directory test_dir do
     # some directory
   end

   file test_file do
     content "Chef made me, I come from a #{process_type} process."
   end

When running a 32-bit version of chef-client, the script will write the ``chef_architecture`` file to the ``C:\Windows\SysWow64`` directory. However, when running a native 64-bit version of the chef-client, the script will write a file to the ``C:\Windows\System32`` directory, as expected.

For more information, see: |url msdn_file_redirection|.
