.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


A ``aws_server_certificate`` resource block manages server certificates in |amazon aws|. For example:

.. code-block:: ruby

   server_certificate 'name' do
     certificate_body 'file://public_key.pem'
     private_key 'file://private_key.pem'
   end

The full syntax for all of the properties that are available to the ``aws_server_certificate`` resource is:

.. code-block:: ruby

   aws_server_certificate 'name' do
     certificate_body              String
     private_key                   String      
   end

where 

* ``aws_server_certificate`` is the resource
* ``name`` is the name of the resource block
* ``certificate_body`` and ``private_key`` are properties of this resource, with the |ruby| type shown. |see attributes|
