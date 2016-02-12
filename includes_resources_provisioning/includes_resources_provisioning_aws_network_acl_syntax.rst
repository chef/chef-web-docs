.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


A ``aws_network_acl`` resource block typically declares ACLs for networks. For example:

.. code-block:: ruby

   aws_network_acl 'name' do
     vpc 'ref-vpc'
     inbound_rules '0.0.0.0/0' => [ 22, 80 ]
     outbound_rules [
       {:port => 22..22, :protocol => :tcp, :destinations => ['0.0.0.0/0'] }
     ]
     aws_tags :chef_type => 'aws_security_group'
   end

The full syntax for all of the properties that are available to the ``network_acl`` resource is:

.. code-block:: ruby

   aws_network_acl 'name' do
     inbound_rules                 Array, Hash
     network_acl_id                String
     outbound_rules                Array, Hash
     vpc                           String, AwsVpc, AWS::EC2::VPC     
   end

where 

* ``aws_network_acl`` is the resource
* ``name`` is the name of the resource block
* ``inbound_rules``, ``network_acl_id``, ``outbound_rules``, and ``vpc`` are properties of this resource, with the |ruby| type shown. |see attributes|
