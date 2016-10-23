.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

The following setting is often modified from the default as part of the tuning effort for the **postgresql** service:

.. list-table::
   :widths: 200 300
   :header-rows: 1

   * - Setting
     - Description
   * - ``postgresql['max_connections']``
     - The maximum number of allowed concurrent connections. This value should only be tuned when the ``erchef['db_pool_size']`` value used by the **opscode-erchef** service is modified. Default value: ``200``.
