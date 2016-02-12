.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


If you are using ``chef-sugar``---a `community cookbook <https://supermarket.chef.io/cookbooks/chef-sugar>`__---it must be version 3.0.1 (or higher) to use the previous example. If you are using an older version of ``chef-sugar``, the following workaround is required:

.. code-block:: ruby

   chef_gem 'gem_name' do
     compile_time true if Chef::Resource::ChefGem.instance_methods(false).include?(:compile_time)
   end

See this `blog post <http://jtimberman.housepub.org/blog/2015/03/20/chef-gem-compile-time-compatibility/>`__ for more background on this behavior.
