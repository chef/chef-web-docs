
64-bit versions of |windows| have a 32-bit compatibility layer that redirects access by a 32-bit application to the ``System32`` directory to a different location.

The 32-bit version of the |chef client| (i.e, all versions prior to 12.9) is subject to the file redirection policy.

For example, consider the following script:

.. code-block:: ruby

   process_type = ENV['PROCESSOR_ARCHITECTURE'] == 'AMD64' ? '64-bit' : '32-bit'
   system32_dir = ::File.join(ENV['SYSTEMROOT'], 'system32')
   test_dir = ::File.join(system32_dir, 'cheftest')
   test_file = ::File.join(test_dir, 'chef_architecture.txt')

   directory test_dir do
   end

   file test_file do
      content "Chef made me, I come from a #{process_type} process."
   end

When running with a 32-bit version of |chef client|, the script will write the ``chef_architecture`` file to the ``C:\Windows\SysWow64`` directory. But when running the native 64-bit |chef client|, it will write the file to the ``C:\Windows\System32`` directory, as expected.

For more information, see: |url msdn_file_redirection|.
