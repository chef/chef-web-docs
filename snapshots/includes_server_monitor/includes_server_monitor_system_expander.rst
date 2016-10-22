.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

As the queue depth increases it may take longer for updates posted to the Chef server by each chef-client to be added to the search indexes on the Chef server. The depth of this queue should be monitored using the following command:

.. code-block:: bash

   $ cd /opt/opscode/embedded/service/opscode-expander/
     export PATH=$PATH:/opt/opscode/bin:/opt/opscode/embedded/bin
