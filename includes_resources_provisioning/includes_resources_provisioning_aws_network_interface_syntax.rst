.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


A ``aws_network_interface`` resource block manages network interfaces in |amazon aws|. For example:

.. code-block:: ruby

   aws_network_interface 'name' do
     machine 'ref-machine-eni-1'
     device_index 2
     subnet 'ref-subnet-eni'
     security_groups ['ref-sg1-eni']
     description 'ref-eni-desc'
   end

The full syntax for all of the properties that are available to the ``aws_network_interface`` resource is:

.. code-block:: ruby

   aws_network_interface 'name' do
     description                   String
     device_index                  Integer
     machine                       String, FalseClass
     network_interface_id          String
     private_ip_address            String
     subnet                        String
     security_groups               Array
   end

where 

* ``aws_network_interface`` is the resource
* ``name`` is the name of the resource block and also the name of a network interface in |amazon ec2|
* ``description``, ``device_index``, ``machine``, ``security_groups``, and ``subnet`` are properties of this resource, with the |ruby| type shown. |see attributes|
