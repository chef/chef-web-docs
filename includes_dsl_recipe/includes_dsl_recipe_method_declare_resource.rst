.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


Use the ``declare_resource`` method to instantiate a resource and then add it to the resource collection.

The syntax for the ``declare_resource`` method is as follows:

.. code-block:: ruby

   declare_resource(:resource_type, 'resource_name', created_at, run_context, resource_attrs_block)

where:

* ``:resource_type`` is the resource type, such as ``:file ``(for the |resource file| resource), ``:template`` (for the |resource template| resource), and so on. Any resource available to |chef| may be declared.
* ``resource_name`` the property that is the default name of the resource, typically the string that appears in the ``resource 'name' do`` block of a resource (but not always); see the Syntax section for the resource to be declared to verify the default name property.
* ``created_at`` is the caller of the resource. Use ``caller[0]`` to get the caller of the function. Defaults to the caller of this function.
* ``run_context`` is the run context of the resource colletion in which this instantiated resource will run.
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
