.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


|search index| The following search indexes are built:

.. list-table::
   :widths: 200 300
   :header-rows: 1

   * - Search Index Name
     - Description
   * - ``client``
     - |chef api client|
   * - ``DATA_BAG_NAME``
     - |search index_data_bag| The name of the search index is the name of the data bag. For example, if the name of the data bag was "admins" then a corresponding search query might look something like ``search(:admins, "*:*")``.
   * - ``environment``
     - |search index_environment|
   * - ``node``
     - |search index_node|
   * - ``role``
     - |search index_role|
