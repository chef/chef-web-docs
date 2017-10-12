=====================================================
Push Jobs API
=====================================================
`[edit on GitHub] <https://github.com/chef/chef-web-docs/blob/master/chef_master/source/api_push_jobs.rst>`__

The Push Jobs API is used to create jobs and retrieve status using Chef push jobs, a tool that pushes jobs against a set of nodes in the organization.
All requests are signed using the Chef server API and the validation key on the workstation from which the requests are made.

Endpoints
=====================================================
Each authentication request must include ``/organizations/organization_name/pushy/`` as part of the name for the endpoint.
For example: ``/organizations/organization_name/pushy/jobs/ID`` or ``/organizations/organization_name/pushy/node_states``.

.. note:: The easiest way to send commands to the Chef server from your workstation is to use the ``knife exec`` subcommand.
          Here is an example of making a basic ``knife exec`` command against a RESTful JSON API.

          .. code-block:: bash

             $ knife exec -E 'api.get("/organizations/ORG_NAME/pushy/jobs/JOB_ID")'

          For some Push Jobs API endpoints, you need to specify certain headers. To do that you simply pass a hash into the command.

          .. code-block:: bash

             $ knife exec -E 'api.get("/organizations/ORG_NAME/pushy/jobs/JOB_ID/output/NODE_NAME/stdout", RAW, {"Accept" => "application/event-stream"})'

          where ``RAW`` is a boolean indicating whether you want the raw body returned, or JSON inflated. For Push Jobs API endpoints, we recommend ``false``.

          See `knife exec </knife_exec.html>`__ for detailed information on usage.

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
The ``POST`` method is used to start a job.

This method has no parameters.

**Request**

.. code-block:: xml

   POST /organizations/ORG_NAME/pushy/jobs

with a request body similar to:

.. code-block:: javascript

   {
     "command": "bash $PUSHY_JOB_FILE",
     "run_timeout": 300,
     "nodes": ["NODE1", "NODE2", "NODE3", "NODE4", "NODE5", "NODE6"],
     "quorum":
     "user": "rebecca",
     "dir": "/home/rebecca",
     "env": {
       "FOO": "bears"
     },
     "file": "raw:#!/bin/bash\necho \"Hello, I am $USER and I like $FOO\""
     "capture_output": true
   }

where:

* ``command`` is the command to be executed during the run.
* ``run_timeout`` is the number of seconds to wait for the run to complete.
* ``nodes`` is the list of node names you wish to run the job on.
* ``quorum`` is the number of nodes from ``nodes`` that must acknowledge the request in order for the job to run.
* ``user`` is the user you wish to run the job as on the node.
* ``dir`` is the directory you wish to run the job from on the node.
* ``env`` is a JSON object of key-value pairs to assign to the environment.
* ``file`` is a string that will be stored as a file on each node, with the path provided to the command as an environment variable.

    .. note:: The string has a required prefix of ``raw:`` or ``base64:``, indicating the encoding (if any) of the contents. The path to this file will be made available via the ``CHEF_PUSH_JOB_FILE`` environment variable.

* ``capture_output`` is a boolean indicating whether to capture the STDOUT and STDERR for this job. Capture is enabled on a per-job basis, meaning that it will affect all nodes that run the job. It is not possible to enable capture on a per-node basis.

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

jobs/ID
-----------------------------------------------------
.. tag api_push_jobs_endpoint_jobs_id

The ``/organizations/ORG_NAME/pushy/jobs/ID`` endpoint has the following methods: ``GET``.

.. end_tag

GET
+++++++++++++++++++++++++++++++++++++++++++++++++++++
The ``GET`` method is used to get the status of an individual job, including node state (running, complete, crashed).

This method accepts one optional query parameter: ``?include_file``. If set to ``true``,
then the ``file_specified`` attributed will be omitted from ``GET`` requests and the ``file``
attribute will be included with the contents of the file prefixed with ``raw:`` or ``base64:``.

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
     },
     "user": "rebecca",
     "dir": "/home/rebecca",
     "env": {},
     "file_specified": false,
     "capture_output": true
   }

where:

* ``command`` is the command that is being run.
* ``run_timeout`` is the number of seconds to wait for the run to complete.
* ``status`` is one of the following: ``aborted`` (the job was aborted), ``complete`` (the job completed; see ``nodes`` for individual node status), ``quorum_failed`` (the command was not run on any nodes), ``running`` (the command is running), ``timed_out`` (the command timed out), and ``voting`` (waiting for nodes; quorum not yet met).
* ``created_at`` is the date and time at which the job started running
* ``updated_at`` is the date and time at which the job entered its present ``status``
* ``nodes`` is one of the following: ``aborted`` (node ran command, stopped before completion), ``complete`` (node ran command to completion), ``crashed`` (node went down after command started running), ``nacked`` (node was busy), ``new`` (node has not accepted or rejected command), ``ready`` (node has accepted command, command has not started running), ``running`` (node has accepted command, command is running), and ``unavailable`` (node went down before command started).
* ``user`` is the user you wish to run the job as on the node.
* ``dir`` is the directory you wish to run the job from on the node.
* ``file_specified`` is a boolean indicated whether or not a file was passed in when the job was created.
* ``capture_output`` is a boolean indicating whether the STDOUT and STDERR is being capture for this job. If this value is false, it is omitted from the output.

**Request with ``?include_file`` parameter**

.. code-block:: xml

   GET /organizations/ORG_NAME/pushy/jobs/ID?include_file=true

**Response**

The response will return something similar to:

.. code-block:: javascript

   {
     "id": "aaaaaaaaaaaa25fd67fa8715fd547d3d",
     "command": "bash $CHEF_PUSH_JOB_FILE",
     "run_timeout": 300,
     "status": "running",
     "created_at": "Tue, 04 Sep 2012 23:01:02 GMT",
     "updated_at": "Tue, 04 Sep 2012 23:17:56 GMT",
     "nodes": {
       "complete": ["NODE1", "NODE2", "NODE3"],
     },
     "user": "rebecca",
     "dir": "/home/rebecca",
     "env": {
       "FOO": "bears"
     },
     "file": "raw:#!/bin/bash\necho \"Hi! I'm $USER and I like $FOO"
     "capture_output": true
   }

where:

* ``env`` is a JSON object of key-value pairs to assign to the environment.
* ``file`` is the contents of the file that was passed in on job creation.

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

jobs/ID/output/NODE_NAME/CHANNEL
-----------------------------------------------------
It is possible to capture the output of commands invoked by Push Jobs, both STDOUT and STDERR, by
providing the ``capture_output=true`` option when creating a job.

If capture is enabled, then the client will capture both the stdout and the stderr channels of the command.
The channel output will be sent back regardless of whether the command succeeded or failed. It will be sent in raw
form, including any terminating whitespace. If the command produced no output, then the value will be an empty string.

The two channels are treated as a pair -- for a given ``<job, node>``, either both will appear, or neither will appear.

The output is not streamed to the server as it is produced. Therefore, the output data for a given node will not
be available until the run on that node is complete.

GET
+++++++++++++++++++++++++++++++++++++++++++++++++++++
The ``GET`` method is used to get output from a channel (``STDOUT`` or ``STDERR``) for an individual job.

This method has no parameters.

The Accept header for this request must be ``application/octet-stream``.

**Request**

.. code-block:: xml

   Accept: application/octet-stream
   GET /organizations/ORG_NAME/pushy/jobs/ID/output/NODE_NAME/stdout

**Response**

The response will return something similar to:

.. code-block:: xml

    Starting Chef Client, version 12.11.18

    ...

    Converging 23 resources

    Running handlers:
    Running handlers complete
    Chef Client finished, 23/187 resources updated in 15 seconds

**Request**

.. code-block:: xml

   Accept: application/octet-stream
   GET /organizations/ORG_NAME/pushy/jobs/ID/output/NODE_NAME/stderr

**Response***

The response will return something similar to:

.. code-block:: xml

    bash: no such file or directory: /usr/local/run.sh

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

jobs_status_feed
-----------------------------------------------------
The ``/organizations/ORG_NAME/pushy/jobs_status_feed`` endpoint has the following methods: ``GET``

GET
+++++++++++++++++++++++++++++++++++++++++++++++++++++
This endpoint opens a Server-Sent-Events (SSE) feed for job starts and completions within the entire organization.

This method has no parameters.

The Accept header for this request must be ``application/event-stream``.

As specified in the SSE protocol, you may request all events since a particular ID by including the optional ``Last-Event-ID`` Header.
If this header is not included, no events will be produced until the next activity in the organization produces an event. If the ``Last-Event-ID``
header is passed but not recognized, it is assumed that the ID has already expired, and the feed will produce the events as far back as are recorded,
proceeded by a synthetic ``start_of_history``. The expiration time of organization events is 60 seconds (configurable).

**Request**

.. code-block:: xml

   Accept: text/event-stream
   Last-Event-ID: dcd37f50-2d77-4761-895b-33134dbf87d1
   GET /organizations/ORG_NAME/pushy/jobs_status_feed

**Response**

The response will return something similar to:

.. code-block:: xml

   event: start
   id: dcd37f50-2d77-4761-895b-33134dbf87d1
   data: {"timestamp":"2014-07-10 05:10:40.995958Z","job":"B","command":"chef-client","run_timeout":300,"user":"rebecca","quorum":2,"node_count":2}

   event: job_complete
   id: dcd37f50-2d77-4761-895b-33134dbf87d2
   data: {"timestamp":"2014-07-10 05:15:48.995958Z","job":"A","status":"success"}

   event: start
   id: dcd37f50-2d77-4761-895b-33134dbf87d3
   data: {"timestamp":"2014-07-10 05:17:40.995958Z","job":"C","command":"cat /etc/passwd","run_timeout":300,"user":"charles","quorum":2,"node_count":2}

   event: job_complete
   id: dcd37f50-2d77-4761-895b-33134dbf87d4
   data: {"timestamp":"2014-07-10 05:17:41.995958Z","job":"C","status":"success"}

   event: job_complete
   id: dcd37f50-2d77-4761-895b-33134dbf87d5
   data: {"timestamp":"2014-07-10 05:20:48.995958Z","job":"B","status":"success"}

.. list-table::
   :widths: 200 300
   :header-rows: 1

   * - Response Code
     - Description
   * - ``200``
     - OK. The request was successful.
   * - ``204``
     - No Content. Do not reconnect.
   * - ``400``
     - Bad request. The contents of the request are not formatted correctly.
   * - ``401``
     - Unauthorized. The user or client who made the request could not be authenticated. Verify the user/client name, and that the correct key was used to sign the request.
   * - ``403``
     - Forbidden. The user who made the request is not authorized to perform the action.
   * - ``404``
     - Not found. The requested object does not exist.

jobs_status_feed/JOBID
-----------------------------------------------------
The ``/organizations/ORG_NAME/pushy/jobs_status_feed/JOBID`` endpoint has the following methods: ``GET``

GET
+++++++++++++++++++++++++++++++++++++++++++++++++++++
This endpoint opens a Server-Sent-Events (SSE) feed with the Push Jobs server.

This method has no parameters.

The Accept header for this request must be ``application/event-stream``.

As specified in the SSE protocol, you may request all events since a particular ID by including the optional ``Last-Event-ID`` Header.
If the ID is omitted, or not recognized, the stream will start from the beginning of the job.

**Completed Jobs**

In the job feed, for a brief period after a job completes, the event stream will remain available. The request will behave as normal,
which means the client will see the stream of events from the beginning of the job (or if specified, the ``Last-Event-ID``), through to
the job completion, and then the connection will be immediately closed by the server. The amount of time before it completes is configurable,
but defaults to 5 seconds.

If a request is made for the feed after the waiting period, then the request will result in a single event, a "summary" event, which contains
the same data as requesting a named-job resource. In this case, any ``Last-Event-ID`` will be ignored.

**Request**

.. code-block:: xml

   Accept: text/event-stream
   GET /organizations/ORG_NAME/pushy/jobs_status_feed/JOBID

**Response**

The response will return something similar to:

.. code-block:: xml

   event: start
   id: dcd37f50-2d77-4761-895b-33134dbf87d1
   data: {"timestamp":"2014-07-10 05:17:40.995958Z","command":"ls /etc/chef","run_timeout":300,"user":"rebecca","quorum":2,"node_count":2}

   event: quorum_vote
   id: dcd37f50-2d77-4761-895b-33134dbf87d2
   data: {"timestamp":"2014-07-10 05:17:41.995958Z","node":"NODE1","status":"success"}

   event: quorum_vote
   id: dcd37f50-2d77-4761-895b-33134dbf87d3
   timestamp:
   data: {"timestamp":"2014-07-10 05:17:42.995958Z","node":"NODE2","status":"success"}

   event: quorum_succeeded
   id: dcd37f50-2d77-4761-895b-33134dbf87d4
   data: {"timestamp":"2014-07-10 05:17:43.995958Z"}

   event: run_start
   id: dcd37f50-2d77-4761-895b-33134dbf87d5
   data: {"timestamp":"2014-07-10 05:17:44.995958Z","node":"NODE1"}

   event: run_start
   id: dcd37f50-2d77-4761-895b-33134dbf87d6
   data: {"timestamp":"2014-07-10 05:17:45.995958Z","node":"NODE2"}

   event: run_complete
   id: dcd37f50-2d77-4761-895b-33134dbf87d7
   data: {"timestamp":"2014-07-10 05:17:46.995958Z","node":"NODE1","status":"success"}

   event: run_complete
   id: dcd37f50-2d77-4761-895b-33134dbf87d58
   data: {"timestamp":"2014-07-10 05:17:47.995958Z","node":"NODE2","status":"success"}

   event: job_complete
   id: dcd37f50-2d77-4761-895b-33134dbf87d9
   data": {"timestamp":"2014-07-10 05:17:48.995958Z","status":"complete"}

.. list-table::
   :widths: 200 300
   :header-rows: 1

   * - Response Code
     - Description
   * - ``200``
     - OK. The request was successful.
   * - ``204``
     - No Content. Do not reconnect.
   * - ``400``
     - Bad request. The contents of the request are not formatted correctly.
   * - ``401``
     - Unauthorized. The user or client who made the request could not be authenticated. Verify the user/client name, and that the correct key was used to sign the request.
   * - ``403``
     - Forbidden. The user who made the request is not authorized to perform the action.
   * - ``404``
     - Not found. The requested object does not exist.

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

