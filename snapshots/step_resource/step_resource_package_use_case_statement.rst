.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

The following example shows how to use a case statement to tell the chef-client which platforms and packages to install using cURL.

.. code-block:: ruby

   package 'curl'
     case node[:platform]
     when 'redhat', 'centos'
       package 'package_1'
       package 'package_2'
       package 'package_3'
     when 'ubuntu', 'debian'
       package 'package_a'
       package 'package_b'
       package 'package_c'
     end
   end

where ``node[:platform]`` for each node is identified by Ohai during every chef-client run. For example:

.. code-block:: ruby

   package 'curl'
     case node[:platform]
     when 'redhat', 'centos'
       package 'zlib-devel'
       package 'openssl-devel'
       package 'libc6-dev'
     when 'ubuntu', 'debian'
       package 'openssl'
       package 'pkg-config'
       package 'subversion'
     end
   end
