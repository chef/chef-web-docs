.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


Chef Analytics stores Ohai data for every chef-client run. This data often takes up a considerable amount of disk space in PostgreSQL, which may lead to capacity and performance issues. A ``purge-nodes`` command has been added to ``opscode-analytics-ctl``, which destructively removes node data from PostgreSQL.

To purge the Chef Analytics database of node information, run the following commands:

.. code-block:: bash

   $ opscode-analytics-ctl stop
   $ opscode-analytics-ctl start postgresql
   $ opscode-analytics-ctl purge-nodes

This command may take some time to run. Upon completion, restart Chef Analytics:

.. code-block:: bash

   $ opscode-analytics-ctl start
