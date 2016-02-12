.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


A ``aws_eip_address`` resource block manages elastic IP addresses. For example:

.. code-block:: ruby

   aws_eip_address 'name' do
     machine 'ref-machine1'
     associate_to_vpc true
     public_ip '205.32.21.0'
   end

The full syntax for all of the properties that are available to the ``aws_eip_address`` resource is:

.. code-block:: ruby

   aws_eip_address 'name' do
     associate_to_vpc              TrueClass, FalseClass
     machine                       String, FalseClass
     public_ip                     String
   end

where 

* ``aws_eip_address`` is the resource
* ``name`` is the name of the resource block and also the name of an |amazon eip|
* ``associate_to_vpc``, ``machine``, and ``public_ip`` are properties of this resource, with the |ruby| type shown. |see attributes|
