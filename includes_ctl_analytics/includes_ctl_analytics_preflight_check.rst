.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


The ``preflight-check`` subcommand is check that all configuration files have been copied over from the |chef server| when configured for a |standalone| deployment. This subcommand has the following syntax:

.. code-block:: bash

   $ opscode-analytics-ctl preflight-check

and will return details on any missing required configuration and the following exit codes:

.. list-table::
   :widths: 60 420
   :header-rows: 1

   * - Exit Code
     - Description
   * - ``0``
     - Success.
   * - ``1``
     - Error.
   * - ``2``
     - Warning.
