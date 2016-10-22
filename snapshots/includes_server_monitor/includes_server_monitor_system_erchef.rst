.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


The status API provides a high-level view of the health of the system with a simple endpoint: ``_status``. This endpoint can be accessed using cURL and GNU Wget. For example:

.. code-block:: bash

   $ curl http://localhost:8000/_status

which will return something similar to:

.. code-block:: bash

   {
     "status":"pong",
     "upstreams":{"upstream_service":"pong","upstream_service":"fail",...},
   }

For each of the upstream services, ``pong`` or ``fail`` is returned. The possible upstream names are:

* ``chef_solr`` (for the **opscode-solr4** service)
* ``chef_sql`` (for the **postgresql** service)
* ``oc_chef_authz`` (for the **opscode-authz** service)

If any of the status values return ``fail``, this typically means the Chef server is unavailable for that service.
