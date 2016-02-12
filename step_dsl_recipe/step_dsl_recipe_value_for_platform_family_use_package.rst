.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

The following example shows how to use the ``platform_family?`` and ``value_for_platform_family`` methods to ensure that the right package is installed:

.. code-block:: ruby

   major_version = node['platform_version'].split('.').first.to_i
   
   if platform_family?('rhel') && major_version < 6
     include_recipe 'yum::epel'
     python_pkgs = ['python26', 'python26-devel']
     node['python']['binary'] = '/usr/bin/python26'
   else
     python_pkgs = value_for_platform_family(
                     'debian' => ['python', 'python-dev'],
                     'rhel' => ['python', 'python-devel'],
                     'freebsd' => ['python'],
                     'default' => ['python', 'python-dev']
                   )
   end
   
   python_pkgs.each do |pkg|
     package pkg do
       action :install
     end
   end
