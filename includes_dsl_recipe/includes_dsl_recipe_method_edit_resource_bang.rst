.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


Use the ``edit_resource`` method to find a resource in the resource collection, and then edit it. If the resource is not found, an exception is returned.

The syntax for the ``edit_resource`` method is as follows:

.. code-block:: ruby

   edit_resource!(:resource_type, 'resource_name', resource_attrs_block)

where:

* ``:resource_type`` is the resource type, such as ``:file ``(for the |resource file| resource), ``:template`` (for the |resource template| resource), and so on. Any resource available to |chef| may be declared.
* ``resource_name`` the property that is the default name of the resource, typically the string that appears in the ``resource 'name' do`` block of a resource (but not always); see the Syntax section for the resource to be declared to verify the default name property.
* ``resource_attrs_block`` is a block in which properties of the instantiated resource are declared.

For example:

.. code-block:: ruby

   edit_resource!(:template, '/x/y.txy') do
     cookbook_name: cookbook_name
   end
