.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


A ``fog_key_pair`` resource block typically declares a key pair for use with |fog|, a |ruby| |gem| for interacting with various cloud providers. For example:

.. code-block:: ruby

   fog_key_pair 'name' do
     private_key_options({
       :format => :pem,
       :type => :rsa,
       :regenerate_if_different => true
     })
     allow_overwrite true
   end

The full syntax for all of the properties that are available to the ``fog_key_pair`` resource is:

.. code-block:: ruby

   fog_key_pair 'name' do
     allow_overwrite         TrueClass, FalseClass
     driver                  Chef::Provisioning::Driver
     private_key_options     Hash
     private_key_path        String
     public_key_path         String
   end

where 

* ``fog_key_pair`` is the resource
* ``name`` is the name of the resource block and also the name of an instance in |amazon ec2|
* ``allow_overwrite``, ``driver``, ``private_key_options``, ``private_key_path``, and ``public_key_path`` are properties of this resource, with the |ruby| type shown. |see attributes|
