.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


The following example shows how to use ``only_if`` to ensure that the chef-client will attempt to register ASP.NET only if the executable is installed on the system, on both 32- and 64-bit systems:

.. code-block:: ruby

   aspnet_regiis = "#{ENV['WinDir']}\\Microsoft.NET\\Framework\\v4.0.30319\\aspnet_regiis.exe"
   execute 'Register ASP.NET v4' do
     command "#{aspnet_regiis} -i"
     only_if { File.exists?(aspnet_regiis) }
     action :nothing
   end
   
   aspnet_regiis64 = "#{ENV['WinDir']}\\Microsoft.NET\\Framework64\\v4.0.30319\\aspnet_regiis.exe"
   execute 'Register ASP.NET v4 (x64)' do
     command "#{aspnet_regiis64} -i"
     only_if { File.exists?(aspnet_regiis64) }
     action :nothing
   end
