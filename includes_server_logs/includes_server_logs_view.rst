.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

The |chef server| has built-in support for easily tailing the logs that are generated. To view all the logs being generated on the |chef server|, enter the following command:

.. code-block:: bash

   $ chef-server-ctl tail

To view logs for a specific service:

.. code-block:: bash

   $ chef-server-ctl tail SERVICENAME

where ``SERVICENAME`` should be replaced with name of the service for which log files will be viewed.

Another way to view log files is to use the system utility tail:

.. code-block:: bash

   $ tail -50f /var/log/chef-server/opscode-chef/current



