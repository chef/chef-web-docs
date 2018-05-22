=====================================================
About Resources
=====================================================
`[edit on GitHub] <https://github.com/chef/chef-web-docs/blob/master/chef_master/source/resource.rst>`__

.. tag resources_common

A resource is a statement of configuration policy that:

* Describes the desired state for a configuration item
* Declares the steps needed to bring that item to the desired state
* Specifies a resource type---such as ``package``, ``template``, or ``service``
* Lists additional details (also known as resource properties), as necessary
* Are grouped into recipes, which describe working configurations

.. end_tag

Resource Syntax
=====================================================
A resource is a Ruby block with four components: a type, a name, one (or more) properties (with values), and one (or more) actions. The syntax for a resource is like this:

.. code-block:: ruby

   type 'name' do
      attribute 'value'
      action :type_of_action
   end

Every resource has its own set of actions and properties. Most properties have default values. Some properties are available to all resources, for example those used to send notifications to other resources and guards that help ensure that some resources are idempotent.

For example, a resource that is used to install a tar.gz package for version 1.16.1 may look something like this:

.. code-block:: ruby

   package 'tar' do
     version '1.16.1'
     action :install
   end

All actions have a default value. Only non-default behaviors of actions and properties need to be specified. For example, the **package** resource's default action is ``:install`` and the name of the package defaults to the ``name`` of the resource. Therefore, it is possible to write a resource block that installs the latest tar.gz package like this:

.. code-block:: ruby

   package 'tar'

and a resource block that installs a tar.gz package for version 1.6.1 like this:

.. code-block:: ruby

   package 'tar' do
     version '1.16.1'
   end

In both cases, the Chef Client will use the default action (``:install``) to install the ``tar`` package.

Additional Information
=====================================================
See these guides for additional information about resources:

.. list-table::
   :widths: 150 450
   :header-rows: 1

   * - Topic
     - Description
   * - `Common Properties </resource_common.html>`__
     - Provides a detailed list of the common properties that are available in all resources.
   * - `Resource Reference </resource_reference.html>`_
     - A reference guide that lists both the common and individual options available to every resource that is bundled into Chef.
   * - `Custom Resources </custom_resources.html>`__
     - Shows you how to create your own Chef resources.
