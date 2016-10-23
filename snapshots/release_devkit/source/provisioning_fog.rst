.. THIS PAGE IS IDENTICAL TO docs.chef.io/provisioning_fog.html BY DESIGN
.. THIS PAGE IS LOCATED AT THE /release/devkit/ PATH.

=====================================================
Fog Driver Resources
=====================================================

.. warning:: .. include:: ../../includes_notes/includes_notes_provisioning.rst

.. include:: ../../includes_provisioning/includes_provisioning.rst

.. include:: ../../includes_resources_provisioning/includes_resources_provisioning.rst

The following driver-specific resources are available for Fog and Chef provisioning:

* ``fog_key_pair``

fog_key_pair
=====================================================
The ``fog_key_pair`` resource is a driver-specific resource used by Chef provisioning for use with Fog, a Ruby gem for interacting with various cloud providers, such as Amazon EC2, CloudStack, DigitalOcean, Google Cloud Platform, Joyent, OpenStack, Rackspace, SoftLayer, and vCloud Air.

Syntax
-----------------------------------------------------
A ``fog_key_pair`` resource block typically declares a key pair for use with Fog, a Ruby gem for interacting with various cloud providers. For example:

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
* ``name`` is the name of the resource block and also the name of an instance in Amazon EC2
* ``allow_overwrite``, ``driver``, ``private_key_options``, ``private_key_path``, and ``public_key_path`` are properties of this resource, with the Ruby type shown. See "Properties" section below for more information about all of the properties that may be used with this resource.

Properties
-----------------------------------------------------
This Chef provisioning driver-specific resource has the following properties:

.. list-table::
   :widths: 150 450
   :header-rows: 1

   * - Property
     - Description
   * - ``allow_overwrite``
     - **Ruby Type:** TrueClass, FalseClass

       Use to allow overwriting an existing key pair.
   * - ``driver``
     - **Ruby Type:** Chef::Provisioning::Driver

       The Chef provisioning driver.
   * - ``private_key_options``
     - **Ruby Type:** Hash

       A Hash that defines a list of parameters used when generating a private key.
   * - ``private_key_path``
     - **Ruby Type:** String

       Use to specify the location from which the private key is generated. If this value is not specified, the private key will be generated.
   * - ``public_key_path``
     - **Ruby Type:** String

       Use to specify the location from which the public key is generated. If this value is not specified, the public key will be generated.

Examples
-----------------------------------------------------
None.



