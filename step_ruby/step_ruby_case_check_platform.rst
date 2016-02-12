.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

The following example shows how to use a case statement to check the platform, and for certain platforms send a notification immediately after installing the ``package_b`` package that will generate a module list:

.. code-block:: ruby

   case node[:platform]
     when 'debian', 'ubuntu'
       package 'package_a' do
         action :install
       end
     when 'centos', 'redhat', 'fedora'
       package 'package_b' do
         action :install
         notifies :run, resources(:execute => 'generate-module-list'), :immediately
       end
   end
