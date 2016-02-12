.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


A ``aws_vpc`` resource block typically declares VPCs in |amazon aws|. For example:

.. code-block:: ruby

   aws_vpc 'name' do
     cidr_block '10.0.0.0/24'
     internet_gateway true
     instance_tenancy :default
     main_routes '0.0.0.0/0' => :internet_gateway
     dhcp_options 'ref-dhcp-options'
     enable_dns_support true
     enable_dns_hostnames true
     aws_tags :chef_type => 'aws_vpc'
   end

The full syntax for all of the properties that are available to the ``aws_vpc`` resource is:

.. code-block:: ruby

   aws_vpc 'name' do
     cidr_block                    String
     dhcp_options                  String
     enable_dns_hostnames          TrueClass, FalseClass
     enable_dns_support            TrueClass, FalseClass
     internet_gateway              TrueClass, FalseClass
     instance_tenancy              Symbol
     main_route_table              String
     main_routes                   Hash
     vpc_id                        String
   end

where 

* ``aws_vpc`` is the resource
* ``name`` is the name of the resource block and also the name of the defined virtual network in |amazon vpc|
* ``cidr_block``, ``dhcp_options``, ``enable_dns_hostnames``, ``enable_dns_support``, ``internet_gateway``, ``instance_tenancy``, and ``main_routes`` are properties of this resource, with the |ruby| type shown. |see attributes|
