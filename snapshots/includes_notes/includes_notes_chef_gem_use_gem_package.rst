.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


Another approach is to use the **gem_package** resource, and then specify the ``gem_binary`` location to the RubyGems directory that is used by Chef. For example:

.. code-block:: ruby

   gem_package 'package' do
     gem_binary Chef::Util::PathHelper.join(Chef::Config.embedded_dir,'bin','gem')
     action :install             
   end
