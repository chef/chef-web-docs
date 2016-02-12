.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

The following example shows how to install the |crond app| application using two resources and a variable:

.. code-block:: ruby

   # the following code sample comes from the ``cron`` cookbook:
   # https://github.com/chef-cookbooks/cron

   cron_package = case node['platform']
     when 'redhat', 'centos', 'scientific', 'fedora', 'amazon'
       node['platform_version'].to_f >= 6.0 ? 'cronie' : 'vixie-cron'
     else
       'cron'
     end
   
   package cron_package do
     action :install
   end
   
   service 'crond' do
     case node['platform']
     when 'redhat', 'centos', 'scientific', 'fedora', 'amazon'
       service_name 'crond'
     when 'debian', 'ubuntu', 'suse'
       service_name 'cron'
     end
     action [:start, :enable]
   end

where 

* ``cron_package`` is a variable that is used to identify which platforms apply to which install packages
* the |resource package| resource uses the ``cron_package`` variable to determine how to install the |crond app| application on various nodes (with various platforms)
* the |resource service| resource enables the |crond app| application on nodes that have |redhat|, |centos|, |redhat enterprise linux|, |fedora|, or |amazon aws|, and the |cron| service on nodes that run |debian|, |ubuntu|, or |suse|
