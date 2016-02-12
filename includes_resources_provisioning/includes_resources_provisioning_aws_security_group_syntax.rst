.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


A ``aws_security_group`` resource manages security groups in |amazon aws|. For example:

.. code-block:: ruby

   aws_security_group 'name' do
     vpc 'ref-vpc'
     inbound_rules '0.0.0.0/0' => [ 22, 80 ]
     outbound_rules [
       {:port => 22..22, :protocol => :tcp, :destinations => ['0.0.0.0/0'] }
     ]
     aws_tags :chef_type => 'aws_security_group'
   end

The full syntax for all of the properties that are available to the ``aws_security_group`` resource is:

.. code-block:: ruby

   aws_security_group 'name' do
     aws_tags                      Hash
     description                   String
     inbound_rules                 Hash, Array
     outbound_rules                Hash, Array
     security_group_id             String
     vpc                           String
   end

where 

* ``aws_security_group`` is the resource
* ``name`` is the name of the resource block and also the name of a security group in |amazon aws|
* ``inbound_rules``, ``outbound_rules``, and ``vpc`` are properties of this resource, with the |ruby| type shown. |see attributes|
