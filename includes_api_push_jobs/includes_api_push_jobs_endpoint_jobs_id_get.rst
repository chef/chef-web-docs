.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

The ``GET`` method is used to get the status of an individual job, including node state (running, complete, crashed).

This method has no parameters.

The ``POST`` method is used to start a job.

This method has no parameters.

**Request**

.. code-block:: xml

   POST /organizations/ORG_NAME/pushy/jobs

with a request body similar to:

.. code-block:: javascript

   {
     "command": "chef-client", 
     "run_timeout": 300, 
     "nodes": ["NODE1", "NODE2", "NODE3", "NODE4", "NODE5", "NODE6"]
   }

**Response**

The response is similar to:

.. code-block:: javascript

   {
     "id": "aaaaaaaaaaaa25fd67fa8715fd547d3d"
   }

.. list-table::
   :widths: 200 300
   :header-rows: 1

   * - Response Code
     - Description
   * - ``201``
     - |response code 201 created|
   * - ``400``
     - |response code 400 bad request|
   * - ``401``
     - |response code 401 unauthorized|
   * - ``403``
     - |response code 403 forbidden|
   * - ``404``
     - |response code 404 not found|

**Request**

.. code-block:: xml

   GET /organizations/ORG_NAME/pushy/jobs/ID

**Response**

The response will return something similar to:

.. code-block:: javascript

   {
     "id": "aaaaaaaaaaaa25fd67fa8715fd547d3d", 
     "command": "chef-client", 
     "run_timeout": 300, 
     "status": "running",
     "created_at": "Tue, 04 Sep 2012 23:01:02 GMT", 
     "updated_at": "Tue, 04 Sep 2012 23:17:56 GMT", 
     "nodes": {
       "running": ["NODE1", "NODE5"], 
       "complete": ["NODE2", "NODE3", "NODE4"], 
       "crashed": ["NODE6"]
     }
   }

where:

* ``nodes`` is one of the following: ``aborted`` (node ran command, stopped before completion), ``complete`` (node ran command to completion), ``crashed`` (node went down after command started running), ``nacked`` (node was busy), ``new`` (node has not accepted or rejected command), ``ready`` (node has accepted command, command has not started running), ``running`` (node has accepted command, command is running), and ``unavailable`` (node went down before command started).
* ``status`` is one of the following: ``aborted`` (the job was aborted), ``complete`` (the job completed; see ``nodes`` for individual node status), ``quorum_failed`` (the command was not run on any nodes), ``running`` (the command is running), ``timed_out`` (the command timed out), and ``voting`` (waiting for nodes; quorum not yet met).
* ``updated_at`` is the date and time at which the job entered its present ``status``

.. list-table::
   :widths: 200 300
   :header-rows: 1

   * - Response Code
     - Description
   * - ``200``
     - |response code 200 ok|
   * - ``400``
     - |response code 400 bad request|
   * - ``401``
     - |response code 401 unauthorized|
   * - ``403``
     - |response code 403 forbidden|
   * - ``404``
     - |response code 404 not found|