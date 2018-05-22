=====================================================
Fog Driver Resources
=====================================================
`[edit on GitHub] <https://github.com/chef/chef-web-docs/blob/master/chef_master/source/provisioning_fog.rst>`__

.. warning:: .. tag notes_provisioning

             This functionality is available with Chef provisioning and is packaged in the Chef development kit. Chef provisioning is a framework that allows clusters to be managed by the chef-client and the Chef server in the same way nodes are managed: with recipes. Use Chef provisioning to describe, version, deploy, and manage clusters of any size and complexity using a common set of tools.

             .. end_tag

.. tag provisioning_summary

Chef provisioning is a collection of resources that enable the creation of machines and machine infrastructures using the chef-client. It has a plugin model that allows bootstrap operations to be done against any infrastructure, such as VirtualBox, DigitalOcean, Amazon EC2, LXC, bare metal, and more.

Chef provisioning is built around two major components: the **machine** resource and drivers.

.. end_tag

.. tag resources_provisioning

A driver-specific resource is a statement of configuration policy that:

* Describes the desired state for a configuration item that is created using Chef provisioning
* Declares the steps needed to bring that item to the desired state
* Specifies a resource type---such as ``package``, ``template``, or ``service``
* Lists additional details (also known as properties), as necessary
* Are grouped into recipes, which describe working configurations

.. end_tag

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
     allow_overwrite         True, False
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
     - **Ruby Type:** True, False

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

