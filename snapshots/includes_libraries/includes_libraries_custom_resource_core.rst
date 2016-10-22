.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

.. This topic is NOT the same as the LWRP resource topic; keep separate.

A resource that is defined in the ``/libraries`` directory may leverage core chef-client resources by using the following syntax:

.. code-block:: ruby

   Chef::Resource::name_of_resource.new('name', run_context)

or:

.. code-block:: ruby

   Chef::Resource::name_of_resource.new(:action)
