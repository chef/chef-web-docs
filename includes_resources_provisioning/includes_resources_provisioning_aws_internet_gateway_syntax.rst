.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


A ``aws_internet_gateway`` resource block manages internet gateways. For example:

.. code-block:: ruby

   aws_internet_gateway 'name' do
     internet_gateway_id '1234567890'
   end

The full syntax for all of the properties that are available to the ``aws_internet_gateway`` resource is:

.. code-block:: ruby

   aws_internet_gateway 'name' do
     internet_gateway_id           String
   end

where 

* ``aws_internet_gateway`` is the resource
* ``name`` is the name of the resource block and also the name of an internet gateway for a defined virtual network within |amazon vpc|
* ``internet_gateway_id`` is a property of this resource, with the |ruby| type shown. |see attributes|
