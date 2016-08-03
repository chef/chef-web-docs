.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


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
     - |response code 200 ok|
   * - ``400``
     - |response code 400 bad request|
   * - ``401``
     - |response code 401 unauthorized|
   * - ``403``
     - |response code 403 forbidden|
   * - ``404``
     - |response code 404 not found|
