.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.
.. This file is hooked into a slide deck


In the custom resource, add the following custom properties:

.. code-block:: ruby

   property :instance_name, String, name_property: true
   property :port, Fixnum, required: true

where

* ``String`` and ``Fixnum`` are Ruby types (all custom properties must have an assigned Ruby type)
* ``name_property: true`` allows the value for this property to be equal to the ``'name'`` of the resource block

The ``instance_name`` property is then used within the custom resource in many locations, including defining paths to configuration files, services, and virtual hosts.
