

=====================================================
Push Jobs API
=====================================================

.. tag api_push_jobs_1

The Push Jobs API is used to create jobs and retrieve status using Chef push jobs, a tool that pushes jobs against a set of nodes in the organization. All requests are signed using the Chef server API and the validation key on the workstation from which the requests are made. All commands are sent to the Chef server using the ``knife exec`` subcommand.

.. end_tag

Endpoints 
=====================================================
.. tag api_push_jobs_endpoint

Each authentication request must include ``/organizations/organization_name/pushy/`` as part of the name for the endpoint. For example: ``/organizations/organization_name/pushy/jobs/ID`` or ``/organizations/organization_name/pushy/node_states``.

.. end_tag

connect/NODE_NAME
-----------------------------------------------------
.. tag api_push_jobs_endpoint_node_name

The ``/organizations/ORG_NAME/pushy/node_states/NODE_NAME`` endpoint has the following methods: ``GET``.

.. end_tag

GET
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. tag api_push_jobs_endpoint_node_name_get

The ``GET`` method is used to get the status (``up`` or ``down``) for an individual node.

This method has no parameters.

**Request**

.. code-block:: xml

   GET /organizations/ORG_NAME/pushy/node_states/NODE_NAME

**Response**

The response is similar to:

.. code-block:: javascript

   {
     "node_name": "FIONA", 
     "status": "down", 
     "updated_at": "Tue, 04 Sep 2012 23:17:56 GMT"
   }

where ``updated_at`` shows the date and time at which a node's status last changed.

.. list-table::
   :widths: 200 300
   :header-rows: 1

   * - Response Code
     - Description
   * - ``200``
     - OK. The request was successful.
   * - ``400``
     - Bad request. The contents of the request are not formatted correctly.
   * - ``401``
     - Unauthorized. The user or client who made the request could not be authenticated. Verify the user/client name, and that the correct key was used to sign the request.
   * - ``403``
     - Forbidden. The user who made the request is not authorized to perform the action.
   * - ``404``
     - Not found. The requested object does not exist.

.. end_tag

jobs
-----------------------------------------------------
.. tag api_push_jobs_endpoint_jobs

The ``/organizations/ORG_NAME/pushy/jobs`` endpoint has the following methods: ``GET`` and ``POST``.

.. end_tag

GET
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. tag api_push_jobs_endpoint_jobs_get

The ``GET`` method is used to get a list of jobs.

This method has no parameters.

**Request**

.. code-block:: xml

   GET /organizations/ORG_NAME/pushy/jobs

**Response**

The response is similar to:

.. code-block:: javascript

   {
     "aaaaaaaaaaaa25fd67fa8715fd547d3d",
     "aaaaaaaaaaaa6af7b14dd8a025777cf0"
   }

.. list-table::
   :widths: 200 300
   :header-rows: 1

   * - Response Code
     - Description
   * - ``200``
     - OK. The request was successful.
   * - ``400``
     - Bad request. The contents of the request are not formatted correctly.
   * - ``401``
     - Unauthorized. The user or client who made the request could not be authenticated. Verify the user/client name, and that the correct key was used to sign the request.
   * - ``403``
     - Forbidden. The user who made the request is not authorized to perform the action.
   * - ``404``
     - Not found. The requested object does not exist.

.. end_tag

POST
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. tag api_push_jobs_endpoint_jobs_post

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
     - Created. The object was created.
   * - ``400``
     - Bad request. The contents of the request are not formatted correctly.
   * - ``401``
     - Unauthorized. The user or client who made the request could not be authenticated. Verify the user/client name, and that the correct key was used to sign the request.
   * - ``403``
     - Forbidden. The user who made the request is not authorized to perform the action.
   * - ``404``
     - Not found. The requested object does not exist.

.. end_tag

jobs/ID
-----------------------------------------------------
.. tag api_push_jobs_endpoint_jobs_id

The ``/organizations/ORG_NAME/pushy/jobs/ID`` endpoint has the following methods: ``GET``.

.. end_tag

GET
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. tag api_push_jobs_endpoint_jobs_id_get

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
     - Created. The object was created.
   * - ``400``
     - Bad request. The contents of the request are not formatted correctly.
   * - ``401``
     - Unauthorized. The user or client who made the request could not be authenticated. Verify the user/client name, and that the correct key was used to sign the request.
   * - ``403``
     - Forbidden. The user who made the request is not authorized to perform the action.
   * - ``404``
     - Not found. The requested object does not exist.

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
     - OK. The request was successful.
   * - ``400``
     - Bad request. The contents of the request are not formatted correctly.
   * - ``401``
     - Unauthorized. The user or client who made the request could not be authenticated. Verify the user/client name, and that the correct key was used to sign the request.
   * - ``403``
     - Forbidden. The user who made the request is not authorized to perform the action.
   * - ``404``
     - Not found. The requested object does not exist.

.. end_tag

node_states
-----------------------------------------------------
.. tag api_push_jobs_endpoint_node_states

The ``/organizations/ORG_NAME/pushy/node_states`` endpoint has the following methods: ``GET``.

.. end_tag

GET
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. tag api_push_jobs_endpoint_node_states_get

The ``GET`` method is used to get a list of nodes and their status (``up`` or ``down``).

This method has no parameters.

**Request**

.. code-block:: xml

   GET /organizations/ORG_NAME/pushy/node_states

**Response**

The response is similar to:

.. code-block:: javascript

   {
     {
       "node_name": "FARQUAD", 
       "status": "up", 
       "updated_at": "Tue, 04 Sep 2012 23:17:56 GMT"
     }
     {
       "node_name": "DONKEY", 
       "status": "up", 
       "updated_at": "Tue, 04 Sep 2012 23:17:56 GMT"
     }
     {
       "node_name": "FIONA", 
       "status": "down", 
       "updated_at": "Tue, 04 Sep 2012 23:17:56 GMT"
     }
   }

The following values are possible: ``up`` or ``down``.

.. list-table::
   :widths: 200 300
   :header-rows: 1

   * - Response Code
     - Description
   * - ``200``
     - OK. The request was successful.
   * - ``400``
     - Bad request. The contents of the request are not formatted correctly.
   * - ``401``
     - Unauthorized. The user or client who made the request could not be authenticated. Verify the user/client name, and that the correct key was used to sign the request.
   * - ``403``
     - Forbidden. The user who made the request is not authorized to perform the action.
   * - ``404``
     - Not found. The requested object does not exist.

.. end_tag

node_states/NODE_NAME
-----------------------------------------------------
.. tag api_push_jobs_endpoint_node_name

The ``/organizations/ORG_NAME/pushy/node_states/NODE_NAME`` endpoint has the following methods: ``GET``.

.. end_tag

GET
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. tag api_push_jobs_endpoint_node_name_get

The ``GET`` method is used to get the status (``up`` or ``down``) for an individual node.

This method has no parameters.

**Request**

.. code-block:: xml

   GET /organizations/ORG_NAME/pushy/node_states/NODE_NAME

**Response**

The response is similar to:

.. code-block:: javascript

   {
     "node_name": "FIONA", 
     "status": "down", 
     "updated_at": "Tue, 04 Sep 2012 23:17:56 GMT"
   }

where ``updated_at`` shows the date and time at which a node's status last changed.

.. list-table::
   :widths: 200 300
   :header-rows: 1

   * - Response Code
     - Description
   * - ``200``
     - OK. The request was successful.
   * - ``400``
     - Bad request. The contents of the request are not formatted correctly.
   * - ``401``
     - Unauthorized. The user or client who made the request could not be authenticated. Verify the user/client name, and that the correct key was used to sign the request.
   * - ``403``
     - Forbidden. The user who made the request is not authorized to perform the action.
   * - ``404``
     - Not found. The requested object does not exist.

.. end_tag

