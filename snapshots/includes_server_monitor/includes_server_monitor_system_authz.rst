.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


The authz API provides a high-level view of the health of the **opscode-authz** service with a simple endpoint: ``_ping``. This endpoint can be accessed using cURL and GNU Wget. For example:

.. code-block:: bash

   $ curl http://localhost:9463/_ping

This command typically prints a lot of information. Use Python to use pretty-print output:

.. code-block:: bash

   $ curl http://localhost:9463/_ping | python -mjson.tool
