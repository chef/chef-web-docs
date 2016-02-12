.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

.. To create an option set:

.. code-block:: ruby

   aws_dhcp_options 'ref-dhcp-options' do
     domain_name 'example.com'
     domain_name_servers %w(8.8.8.8 8.8.4.4)
     netbios_name_servers %w(8.8.8.8 8.8.4.4)
     netbios_node_type 2
     aws_tags :chef_type => 'aws_dhcp_options'
   end
