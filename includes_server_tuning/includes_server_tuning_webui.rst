.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

The following setting is often modified from the default as part of the tuning effort for the |service webui| service:

.. list-table::
   :widths: 200 300
   :header-rows: 1

   * - Setting
     - Description
   * - ``opscode_webui['worker_processes']``
     - |worker_processes| This setting should be increased or decreased based on the number of users in an organization who use the |chef server| web user interface. The default value is ``2``.
