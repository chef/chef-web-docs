.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

This custom resource has the following properties:

.. list-table::
   :widths: 200 300
   :header-rows: 1

   * - Property
     - Description
   * - ``lacp``
     - |mode lacp| Default value: ``disable``.
   * - ``links``
     - Required. |links interface_lag|

       .. note:: If a ``netdev_lag`` resource is deleted, interfaces that are defined by this property are also deleted, unless they have been configured elsewhere.
   * - ``minimum_links``
     - |links minimum_physical_lag|
   * - ``name``
     - |name lag|
