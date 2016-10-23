.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


The following example shows how pass a value to a template using the ``variables`` property in the **template** resource. The template file is similar to:

.. code-block:: ruby

   [tcpout]
   defaultGroup = splunk_indexers_<%= node['splunk']['receiver_port'] %>
   disabled=false
   
   [tcpout:splunk_indexers_<%= node['splunk']['receiver_port'] %>]
   server=<% @splunk_servers.map do |s| -%><%= s['ipaddress'] %>:<%= s['splunk']['receiver_port'] %> <% end.join(', ') -%>
   <% @outputs_conf.each_pair do |name, value| -%>
   <%= name %> = <%= value %>
   <% end -%>

The recipe then uses the ``variables`` attribute to find the values for ``splunk_servers`` and ``outputs_conf``, before passing them into the template:

.. code-block:: ruby

   template "#{splunk_dir}/etc/system/local/outputs.conf" do
     source 'outputs.conf.erb'
     mode '0755'
     variables :splunk_servers => splunk_servers, :outputs_conf => node['splunk']['outputs_conf']
     notifies :restart, 'service[splunk]'
   end

This example can be found in the ``client.rb`` recipe and the ``outputs.conf.erb`` template files that are located in the `chef-splunk cookbook <https://github.com/chef-cookbooks/chef-splunk/>`_  that is maintained by Chef.
