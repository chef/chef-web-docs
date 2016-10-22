.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

The following example shows how a case statement can be used to handle a situation where an application needs to be installed on multiple platforms, but where the install directories are different paths, depending on the platform:

.. code-block:: ruby

   cookbook_file 'application.pm' do
     path case node['platform']
       when 'centos','redhat'
         '/usr/lib/version/1.2.3/dir/application.pm'
       when 'arch'
         '/usr/share/version/core_version/dir/application.pm'
       else
         '/etc/version/dir/application.pm'
       end
     source "application-#{node['languages']['perl']['version']}.pm"
     owner 'root'
     group 'root'
     mode '0755'
   end
