.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

The following example shows how to use variables within a Ruby block to set environment variables using rbenv.

.. code-block:: ruby

   node.set[:rbenv][:root] = rbenv_root
   node.set[:ruby_build][:bin_path] = rbenv_binary_path

   ruby_block 'initialize' do
     block do
       ENV['RBENV_ROOT'] = node[:rbenv][:root]
       ENV['PATH'] = "#{node[:rbenv][:root]}/bin:#{node[:ruby_build][:bin_path]}:#{ENV['PATH']}"
     end
   end
