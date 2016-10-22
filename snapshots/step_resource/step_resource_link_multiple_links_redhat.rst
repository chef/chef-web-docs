.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

The following example shows installing a filter module on Apache. The package name is different for different platforms, and for the Red Hat Enterprise Linux family, a symbolic link is required:

.. code-block:: ruby

   include_recipe 'apache2::default'
   
   case node['platform_family']
   when 'debian'
     ...
   when 'suse'
     ...
   when 'rhel', 'fedora'
     ...
     
     
     link '/usr/lib64/httpd/modules/mod_apreq.so' do
       to      '/usr/lib64/httpd/modules/mod_apreq2.so'
       only_if 'test -f /usr/lib64/httpd/modules/mod_apreq2.so'
     end
     
     link '/usr/lib/httpd/modules/mod_apreq.so' do
       to      '/usr/lib/httpd/modules/mod_apreq2.so'
       only_if 'test -f /usr/lib/httpd/modules/mod_apreq2.so'
     end
   end
   
   ...

For the entire recipe, see https://github.com/onehealth-cookbooks/apache2/blob/68bdfba4680e70b3e90f77e40223dd535bf22c17/recipes/mod_apreq2.rb.
