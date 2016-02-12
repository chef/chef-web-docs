.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

|reporting| is automatically enabled in the |chef client| (version 11.6.0 or later). In order to check if reporting data is being sent, you can check the output of the |chef client| ``INFO`` logging level for the log message confirming the data has been sent. At the end of the |chef client| run:

.. code-block:: bash

   $ chef-client -l info
   ...
   ...
   [date] INFO: Chef Run complete in 1.069059018 seconds
   [date] INFO: Running report handlers
   [date] INFO: Report handlers complete
   Chef Client finished, 2 resources updated
   [date] INFO: Sending resource update report (run-id: 51ceb817-ba7e-47e5-9bca-096fe9ef9740)

This includes the run identifier of the |chef client| run, which can be used in the `knife reporting plugin <https://docs.chef.io/plugin_knife_reporting.html>`_ or the |chef manage| to access the reporting information generated during the |chef client| run.
