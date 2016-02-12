.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

The |service erchef| service's ``erchef.log`` file contains a history of API requests that have been processed by |erchef|. These logs can be rotated quickly, therefore it is generally best to sort them by date, and then find the most recently updated log file:

.. code-block:: bash

   $ ls -lrt /var/log/opscode/opscode-erchef/erchef.log.*

The following is an example log entry:

.. code-block:: ruby

   2013-08-06T08:54:32Z erchef@127.0.0.1 INFO org_name=srwjedoqqoypgmvafmoi; req_id=g3IAA2QAEGVyY2hlZkAx

where important fields in this log include:

* The HTTP method (``POST``)
* The HTTP path (``/organizations/srwjedoqqoypgmvafmoi/environments``)
* The message (``{created,<<"_default">>}``)
* The organization name (``org_name=srwjedoqqoypgmvafmoi``)
* The timestamp (``2013-08-06T08:54:32Z``)
* The name of the user and/or |chef client| which made the request (``pivotal``)

In addition, the log file may contain additional entries that detail the amounts of time spent interacting with other services:

* ``authz_time`` (the time spent talking to the |service authz| service)
* ``couchdb_time`` (the time spent talking to the |service couchdb| service)
* ``rdbms_time`` (the time spent talking to the |service postgresql| service)
* ``req_time`` (the request time)
* ``solr_time`` (the time spent talking to the |service solr| service)

