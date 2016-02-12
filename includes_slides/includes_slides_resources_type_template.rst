.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


A file to be generated from a template:

.. code-block:: ruby
       
   template '/etc/haproxy/haproxy.cfg' do
     source 'haproxy.cfg.erb'
     owner 'root'
     group 'root'
     mode '0644'
     notifies :restart, 'service[haproxy]'
   end
