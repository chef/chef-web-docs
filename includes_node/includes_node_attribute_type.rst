.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

The |chef client| uses six types of attributes to determine the value that is applied to a node during the |chef client| run. In addition, the |chef client| sources attribute values from up to five locations. The combination of attribute types and sources allows for up to 15 different competing values to be available to the |chef client| during the |chef client| run:

.. list-table::
   :widths: 200 300
   :header-rows: 1

   * - Attribute Type
     - Description
   * - ``default``
     - .. include:: ../../includes_node/includes_node_attribute_type_default.rst
   * - ``force_default``
     - .. include:: ../../includes_node/includes_node_attribute_type_force_default.rst
   * - ``normal``
     - .. include:: ../../includes_node/includes_node_attribute_type_normal.rst
   * - ``override``
     - .. include:: ../../includes_node/includes_node_attribute_type_override.rst
   * - ``force_override``
     - .. include:: ../../includes_node/includes_node_attribute_type_force_override.rst
   * - ``automatic``
     - .. include:: ../../includes_node/includes_node_attribute_type_automatic.rst
