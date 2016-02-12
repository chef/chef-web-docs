.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

The following example shows how the ``only_if`` method can be used to tell the |chef client| to do something, but only when certain conditions are met. In this case, only if a file already exists:

.. code-block:: ruby

   script 'install_something' do
     flags '-ex'
     code <<-EOH
       /opt/ruby-enterprise/bin/bundle install --cmd=node['node_name']['directory']/cmd
     EOH
     only_if do File.exist?("node['node_name']['directory']}/cmd"  end
   end
