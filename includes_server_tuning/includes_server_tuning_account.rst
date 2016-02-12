.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

The following setting is often modified from the default as part of the tuning effort for the |service account| service:

.. list-table::
   :widths: 200 300
   :header-rows: 1

   * - Setting
     - Description
   * - ``opscode_account['worker_processes']``
     - |worker_processes| This value should be increased if requests made to the |service account| service are timing out, but only if the front-end machines have available CPU and RAM. Default value: ``4``.

