.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

This resource has the following properties:

.. list-table::
   :widths: 200 300
   :header-rows: 1

   * - Property
     - Description
   * - ``class_name``
     - |name class_chef_handler|
   * - ``source``
     - |path chef_handler|
   * - ``arguments``
     - |arguments chef_handler| Default value: ``[]``. For example:

       .. code-block:: ruby

          arguments :key1 => 'val1'

       or:

       .. code-block:: ruby

          arguments [:key1 => 'val1', :key2 => 'val2]

   * - ``supports``
     - |supports chef_handler| Possible values: ``:exception``, ``:report``, ``:both`` (exception **and** report handlers), or ``:start``. Default value: ``{ :report => true, :exception => true }``.
