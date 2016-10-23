.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


The following example installs Windows PowerShell 2.0 on systems that do not already have it installed. Microsoft Windows platform helper methods are used to define specific behaviors for specific platform versions:

.. code-block:: ruby

   case node['platform']
   when 'windows'
   
     require 'chef/win32/version'
     windows_version = Chef::ReservedNames::Win32::Version.new
   
     if (windows_version.windows_server_2008_r2? || windows_version.windows_7?) && windows_version.core?
   
       windows_feature 'NetFx2-ServerCore' do
         action :install
       end
       windows_feature 'NetFx2-ServerCore-WOW64' do
         action :install
         only_if { node['kernel']['machine'] == 'x86_64' }
       end
   
     elsif windows_version.windows_server_2008? || windows_version.windows_server_2003_r2? ||
         windows_version.windows_server_2003? || windows_version.windows_xp?
   
       if windows_version.windows_server_2008?
         windows_feature 'NET-Framework-Core' do
           action :install
         end

       else
         windows_package 'Microsoft .NET Framework 2.0 Service Pack 2' do
           source node['ms_dotnet2']['url']
           checksum node['ms_dotnet2']['checksum']
           installer_type :custom
           options '/quiet /norestart'
           action :install
         end
       end
     else
       log '.NET Framework 2.0 is already enabled on this version of Windows' do
         level :warn
       end
     end
   else
     log '.NET Framework 2.0 cannot be installed on platforms other than Windows' do
       level :warn
     end
   end

The previous example is from the `ms_dotnet2 cookbook <https://github.com/juliandunn/ms_dotnet2>`_, created by community member ``juliandunn``.
