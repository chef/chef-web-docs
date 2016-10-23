.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


The following example shows how a template can be used to apply consistent proxy settings for all nodes of the same type:

.. code-block:: ruby

   template "#{node[:matching_node][:dir]}/sites-available/site_proxy.conf" do
     source 'site_proxy.matching_node.conf.erb'
     owner 'root'
     group 'root'
     mode '0755'
     variables(
       :ssl_certificate =>    "#{node[:matching_node][:dir]}/shared/certificates/site_proxy.crt",
       :ssl_key =>            "#{node[:matching_node][:dir]}/shared/certificates/site_proxy.key",
       :listen_port =>        node[:site][:matching_node_proxy][:listen_port],
       :server_name =>        node[:site][:matching_node_proxy][:server_name],
       :fqdn =>               node[:fqdn],
       :server_options =>     node[:site][:matching_node][:server][:options],
       :proxy_options =>      node[:site][:matching_node][:proxy][:options]
     )
   end

where ``matching_node`` represents a type of node (like Nginx) and ``site_proxy`` represents the type of proxy being used for that type of node (like Nexus).
