.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


.. code-block:: ruby

   package 'haproxy' do
     action :install
   end
   
   template '/etc/haproxy/haproxy.cfg' do
     source 'haproxy.cfg.erb'
     owner 'root'
     group 'root'
     mode '0644'
     notifies :restart, 'service[haproxy]'
   end

.. code-block:: ruby

   service 'haproxy' do
     supports :restart => :true
     action [:start, :enable]
   end
