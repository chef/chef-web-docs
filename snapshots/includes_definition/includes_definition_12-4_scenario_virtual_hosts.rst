.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

Two applications need to be deployed and run on a single node under the same domain and sub-domain. A Ruby on Rails application will reside as the main application at ``example.com`` and a WordPress application will reside at ``blog.example.com``. The domain is running Apache2 as the web server. The domain is expected to grow, but for now only two ``run_list`` resources are created, with the appropriate roles added to them. At some point in the future, when a new sub-domain is required, a new ``run_list`` resource would also be created.

The virtual host on the Apache2 server is only one per node, which can create challenges when a node requires updates. Using a definition helps get around this issue. For example, the ``web_app`` definition exists in the ``apache2`` cookbook, and can be used like this:

.. code-block:: ruby

   web_app 'blog_site' do
     server_name 'blog'
     server_aliases [ "blog.#{node['domain']}", node['fqdn'] ]
     docroot '/srv/www/blog_site'
   end

When the chef-client processes a recipe that contains this definition, it will find the ``web_app`` resource and will attempt to recognize it as a resource. Assuming that the ``apache2`` cookbook is available, the resources contained within that cookbook will be found and loaded, replacing the definition.
