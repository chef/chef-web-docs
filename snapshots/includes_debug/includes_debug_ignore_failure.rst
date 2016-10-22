.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


All resources share a set of common actions, attributes, and so on. Use the following attribute in a resource to help identify where an issue within a recipe may be located:

.. list-table::
   :widths: 60 420
   :header-rows: 1

   * - Attribute
     - Description
   * - ``ignore_failure``
     - Continue running a recipe if a resource fails for any reason. Default value: ``false``.
