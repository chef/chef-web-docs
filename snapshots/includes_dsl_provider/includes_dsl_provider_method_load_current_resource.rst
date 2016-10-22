.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


The ``load_current_resource`` method is used to construct the curent state of the resource on the node. This is in contrast to the ``new_resource`` method which represents the desired state of the resource on the node. Both methods are constructed the same way. Properties should be loaded from the node's state.

For example:

.. code-block:: ruby

   def load_current_resource

     @current_resource = Chef::Resource::MyResource.new(new_resource.name)

     current_resource.path(new_resource.path)
     # Most other current_resource properites will be found by inspecting the system (e.g. Wwhat is
     # the current version of the installed package?  What are the existing file modes?)
     current_resource.mode(File.stat(new_resource.path).mode)
     current_resource
   end

where:

* ``load_current_resource`` returns the ``current_resource`` (and builds the instance variable)
* ``@current_resource`` is an instance variable that creates a ``current_resource`` with the same name as ``new_resource``
* ``current_resource.path(new_resource.path)`` sets the new resource paths to be the same as the current resource paths
* ``current_resource.mode(File.stat(new_resource.path).mode)`` inspects the system for properties of the current resource
* ``current_resource`` returns the current resource and allows the ``new_resource`` to be compared to check for idempotentcy
