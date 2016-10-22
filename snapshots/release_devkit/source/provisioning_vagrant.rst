.. THIS PAGE IS IDENTICAL TO docs.chef.io/provisioning_vagrant.html BY DESIGN
.. THIS PAGE IS LOCATED AT THE /release/devkit/ PATH.

=====================================================
Vagrant Driver Resources
=====================================================

.. warning:: .. include:: ../../includes_notes/includes_notes_provisioning.rst

.. include:: ../../includes_provisioning/includes_provisioning.rst

.. include:: ../../includes_resources_provisioning/includes_resources_provisioning.rst

The following driver-specific resources are available for Vagrant and Chef provisioning:

* ``vagrant_box``
* ``vagrant_cluster``

vagrant_box
=====================================================
The ``vagrant_box`` resource is a driver-specific resource used by Chef provisioning. Use the ``vagrant_box`` resource to add and remove machines that are running in Vagrant and using VirtualBox by default.

Syntax
-----------------------------------------------------
A ``vagrant_box`` resource block typically declares a box to be created using Vagrant. For example:

.. code-block:: ruby

   vagrant_box 'opscode-centos-6.4' do
     url 'http://bento.s3.amazonaws.com/vagrant/vmware/centos-6.4.box'
     vagrant_provider 'vmware_desktop'
   end

The full syntax for all of the properties that are available to the ``vagrant_box`` resource is:

.. code-block:: ruby

   vagrant_box 'name' do
     driver_options          Hash
     vagrant_provider        String
     url                     String
   end

where 

* ``vagrant_box`` is the resource
* ``name`` is the name of the resource block and also the name of an instance in Amazon EC2
* ``driver_options``, ``vagrant_provider``, and ``url`` are properties of this resource, with the Ruby type shown. See "Properties" section below for more information about all of the properties that may be used with this resource.

Properties
-----------------------------------------------------
This Chef provisioning driver-specific resource has the following properties:

.. list-table::
   :widths: 150 450
   :header-rows: 1

   * - Property
     - Description
   * - ``driver_options``
     - **Ruby Type:** Hash

       Use to specify driver options.
   * - ``name``
     - **Ruby Type:** String

       The name of the Vagrant box.
   * - ``vagrant_provider``
     - **Ruby Type:** String

       The name of the provider for Vagrant. Default value: ``virtualbox``.
   * - ``url``
     - **Ruby Type:** String

       The URL from which the Vagrant box is downloaded.

Examples
-----------------------------------------------------
None.

vagrant_cluster
=====================================================
The ``vagrant_cluster`` resource is a driver-specific resource used by Chef provisioning. Use the ``vagrant_cluster`` resource to build a group of boxes in Vagrant using a single Vagrantfile that defines each of the boxes in the group. The ``vagrant list`` command will show all of the boxes that are configured with the Vagrantfile.

Syntax
-----------------------------------------------------
A ``vagrant_cluster`` resource block typically declares a cluster to be created or deleted. For example:

.. code-block:: ruby

.. code-block:: ruby

   vagrant_cluster '/path/to/cluster' do
     action :delete
   end

The full syntax for all of the properties that are available to the ``vagrant_cluster`` resource is:

.. code-block:: ruby

   vagrant_cluster 'name' do
     path                    String
   end

where 

* ``vagrant_cluster`` is the resource
* ``name`` is the name of the resource block and also the name of a cluster
* ``path`` is a property of this resource, with the Ruby type shown. See "Properties" section below for more information about all of the properties that may be used with this resource.

Properties
-----------------------------------------------------
This Chef provisioning driver-specific resource has the following properties:

.. list-table::
   :widths: 150 450
   :header-rows: 1

   * - Property
     - Description
   * - ``path``
     - **Ruby Type:** String

       The path to the Vagrant cluster.

Examples
-----------------------------------------------------
None.
