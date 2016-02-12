.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


To import specific resources, specify the module name, and then specify the name for each resource in that module to import:

.. code-block:: ruby

   imports 'module_name', 'resource_name_a', 'resource_name_b', ...

For example, to import all resources from a module named ``cRDPEnabled``:

.. code-block:: ruby

   imports 'cRDPEnabled'
