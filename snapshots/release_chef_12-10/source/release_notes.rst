=====================================================
Release Notes: chef-client 12.10
=====================================================

.. tag chef

Chef is a powerful automation platform that transforms infrastructure into code. Whether you’re operating in the cloud, on-premises, or in a hybrid environment, Chef automates how infrastructure is configured, deployed, and managed across your network, no matter its size.

This diagram shows how you develop, test, and deploy your Chef code.

.. image:: ../../images/start_chef.svg
   :width: 700px
   :align: center

.. end_tag

What's New
=====================================================
The following items are new for chef-client 12.10 and/or are changes from previous versions. The short version:

* **New layout property for mdadm resource** Use the ``layout`` property to set the RAID5 parity algorithm. Possible values: ``left-asymmetric`` (or ``la``), ``left-symmetric`` (or ``ls``), ``right-asymmetric`` (or ``ra``), or ``right-symmetric`` (or ``rs``).
* **New with_run_context for the Recipe DSL** Use ``with_run_context`` to run resource blocks as part of the root or parent run context.
* **New Recipe DSL methods for declaring, deleting, editing, and finding resources** Use the ``declare_resource``, ``delete_resource``, ``edit_resource``, and ``find_resource`` methods to interact with resources in the resource collection. Use the ``delete_resource!``, ``edit_resource!``, or ``find_resource!`` methods to trigger an exception when the resource is not found in the collection.

with_run_context
-----------------------------------------------------
.. tag dsl_recipe_method_with_run_context

Use the ``with_run_context`` method to define a block that has a pointer to a location in the ``run_context`` hierarchy. Resources in recipes always run at the root of the ``run_context`` hierarchy, whereas custom resources and notification blocks always build a child ``run_context`` which contains their sub-resources.

The syntax for the ``with_run_context`` method is as follows:

.. code-block:: ruby

   with_run_context :type do
     # some arbitrary pure Ruby stuff goes here
   end

where ``:type`` may be one of the following:

* ``:root`` runs the block as part of the root ``run_context`` hierarchy
* ``:parent`` runs the block as part of the parent process in the ``run_context`` hierarchy

For example:

.. code-block:: ruby

   action :run do
     with_run_context :root do
       edit_resource(:my_thing, "accumulated state") do
         action :nothing
         my_array_property << accumulate_some_stuff
       end
     end
     log "kick it off" do
       notifies :run, "my_thing[accumulated state], :delayed
     end
   end

.. end_tag

declare_resource
-----------------------------------------------------
.. tag dsl_recipe_method_declare_resource

Use the ``declare_resource`` method to instantiate a resource and then add it to the resource collection.

The syntax for the ``declare_resource`` method is as follows:

.. code-block:: ruby

   declare_resource(:resource_type, 'resource_name', resource_attrs_block)

where:

* ``:resource_type`` is the resource type, such as ``:file ``(for the **file** resource), ``:template`` (for the **template** resource), and so on. Any resource available to Chef may be declared.
* ``resource_name`` the property that is the default name of the resource, typically the string that appears in the ``resource 'name' do`` block of a resource (but not always); see the Syntax section for the resource to be declared to verify the default name property.
* ``resource_attrs_block`` is a block in which properties of the instantiated resource are declared.

For example:

.. code-block:: ruby

   declare_resource(:file, '/x/y.txy', caller[0]) do
     action :delete
   end

is equivalent to:

.. code-block:: ruby

   file '/x/y.txt' do
     action :delete
   end

.. end_tag

delete_resource
-----------------------------------------------------
.. tag dsl_recipe_method_delete_resource

Use the ``delete_resource`` method to find a resource in the resource collection, and then delete it.

The syntax for the ``delete_resource`` method is as follows:

.. code-block:: ruby

   delete_resource(:resource_type, 'resource_name')

where:

* ``:resource_type`` is the resource type, such as ``:file ``(for the **file** resource), ``:template`` (for the **template** resource), and so on. Any resource available to Chef may be declared.
* ``resource_name`` the property that is the default name of the resource, typically the string that appears in the ``resource 'name' do`` block of a resource (but not always); see the Syntax section for the resource to be declared to verify the default name property.

For example:

.. code-block:: ruby

   delete_resource(:template, '/x/y.erb')

.. end_tag

delete_resource!
-----------------------------------------------------
.. tag dsl_recipe_method_delete_resource_bang

Use the ``delete_resource!`` method to find a resource in the resource collection, and then delete it. If the resource is not found, an exception is returned.

The syntax for the ``delete_resource!`` method is as follows:

.. code-block:: ruby

   delete_resource!(:resource_type, 'resource_name')

where:

* ``:resource_type`` is the resource type, such as ``:file ``(for the **file** resource), ``:template`` (for the **template** resource), and so on. Any resource available to Chef may be declared.
* ``resource_name`` the property that is the default name of the resource, typically the string that appears in the ``resource 'name' do`` block of a resource (but not always); see the Syntax section for the resource to be declared to verify the default name property.

For example:

.. code-block:: ruby

   delete_resource!(:file, '/x/file.txt')

.. end_tag

edit_resource
-----------------------------------------------------
.. tag dsl_recipe_method_edit_resource

Use the ``edit_resource`` method to:

* Find a resource in the resource collection, and then edit it.
* Define a resource block. If a resource block with the same name exists in the resource collection, it will be updated with the contents of the resource block defined by the ``edit_resource`` method. If a resource block does not exist in the resource collection, it will be created.

The syntax for the ``edit_resource`` method is as follows:

.. code-block:: ruby

   edit_resource(:resource_type, 'resource_name', resource_attrs_block)

where:

* ``:resource_type`` is the resource type, such as ``:file ``(for the **file** resource), ``:template`` (for the **template** resource), and so on. Any resource available to Chef may be declared.
* ``resource_name`` the property that is the default name of the resource, typically the string that appears in the ``resource 'name' do`` block of a resource (but not always); see the Syntax section for the resource to be declared to verify the default name property.
* ``resource_attrs_block`` is a block in which properties of the instantiated resource are declared.

For example:

.. code-block:: ruby

   edit_resource(:template, '/x/y.txy') do
     cookbook_name: cookbook_name
   end

and a resource block:

.. code-block:: ruby

   edit_resource(template: '/etc/aliases') do
     source 'aliases.erb'
     cookbook 'aliases'
     variables({:aliases => {} })
     notifies :run, 'execute[newaliases]'
   end

.. end_tag

edit_resource!
-----------------------------------------------------
.. tag dsl_recipe_method_edit_resource_bang

Use the ``edit_resource!`` method to:

* Find a resource in the resource collection, and then edit it.
* Define a resource block. If a resource with the same name exists in the resource collection, its properties will be updated with the contents of the resource block defined by the ``edit_resource`` method.

In both cases, if the resource is not found, an exception is returned.

The syntax for the ``edit_resource!`` method is as follows:

.. code-block:: ruby

   edit_resource!(:resource_type, 'resource_name')

where:

* ``:resource_type`` is the resource type, such as ``:file ``(for the **file** resource), ``:template`` (for the **template** resource), and so on. Any resource available to Chef may be declared.
* ``resource_name`` the property that is the default name of the resource, typically the string that appears in the ``resource 'name' do`` block of a resource (but not always); see the Syntax section for the resource to be declared to verify the default name property.
* ``resource_attrs_block`` is a block in which properties of the instantiated resource are declared.

For example:

.. code-block:: ruby

   edit_resource!(:file, '/x/y.rst')

.. end_tag

find_resource
-----------------------------------------------------
.. tag dsl_recipe_method_find_resource

Use the ``find_resource`` method to:

* Find a resource in the resource collection.
* Define a resource block. If a resource block with the same name exists in the resource collection, it will be returned. If a resource block does not exist in the resource collection, it will be created.

The syntax for the ``find_resource`` method is as follows:

.. code-block:: ruby

   find_resource(:resource_type, 'resource_name')

where:

* ``:resource_type`` is the resource type, such as ``:file ``(for the **file** resource), ``:template`` (for the **template** resource), and so on. Any resource available to Chef may be declared.
* ``resource_name`` the property that is the default name of the resource, typically the string that appears in the ``resource 'name' do`` block of a resource (but not always); see the Syntax section for the resource to be declared to verify the default name property.

For example:

.. code-block:: ruby

   find_resource(:template, '/x/y.txy')

and a resource block:

.. code-block:: ruby

   find_resource(template: '/etc/seapower') do
     source 'seapower.erb'
     cookbook 'seapower'
     variables({:seapower => {} })
     notifies :run, 'execute[newseapower]'
   end

.. end_tag

find_resource!
-----------------------------------------------------
.. tag dsl_recipe_method_find_resource_bang

Use the ``find_resource!`` method to find a resource in the resource collection. If the resource is not found, an exception is returned.

The syntax for the ``find_resource!`` method is as follows:

.. code-block:: ruby

   find_resource!(:resource_type, 'resource_name')

where:

* ``:resource_type`` is the resource type, such as ``:file ``(for the **file** resource), ``:template`` (for the **template** resource), and so on. Any resource available to Chef may be declared.
* ``resource_name`` the property that is the default name of the resource, typically the string that appears in the ``resource 'name' do`` block of a resource (but not always); see the Syntax section for the resource to be declared to verify the default name property.

For example:

.. code-block:: ruby

   find_resource!(:template, '/x/y.erb')

.. end_tag

Changelog
=====================================================
https://github.com/chef/chef/blob/master/CHANGELOG.md
