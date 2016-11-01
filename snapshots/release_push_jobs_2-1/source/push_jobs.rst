

=====================================================
Chef Push Jobs 2.1
=====================================================

.. tag push_jobs_1

Chef push jobs is an extension of the Chef server that allows jobs to be run against nodes independently of a chef-client run. A job is an action or a command to be executed against a subset of nodes; the nodes against which a job is run are determined by the results of a search query made to the Chef server.

Chef push jobs uses the Chef server API and a Ruby client to initiate all connections to the Chef server. Connections use the same authentication and authorization model as any other request made to the Chef server. A knife plugin is used to initiate job creation and job tracking.

.. end_tag

Install :doc:`Push Jobs <install_push_jobs>` using the **push-jobs** cookbook and a chef-client run on each of the target nodes.

Requirements
=====================================================
Chef push jobs has the following requirements:

* An on-premises Chef server version 12.6 (or later); Chef push jobs is not supported when running Chef with the hosted Chef server
* To use the **push-jobs** cookbook to configure the Chef push jobs client, the chef-client must also be present on the node (because only the chef-client can use a cookbook to configure a node)
* .. tag server_firewalls_and_ports_push_jobs

  TCP protocol ports 10000 and 10002. TCP/10000 is the default heartbeat port. TCP/10002 is the command port. It may be configured in the Chef push jobs configuration file . This port allows Chef push jobs clients to communicate with the Chef push jobs server. In a configuration with both front and back ends, this port only needs to be open on the back end servers. The Chef push jobs server waits for connections from the Chef push jobs client, and never initiates a connection to a Chef push jobs client.

  .. end_tag

Components
=====================================================
Chef push jobs has three main components: jobs (managed by the Chef push jobs server), a client that is installed on every node in the organization, and one (or more) workstations from which job messages are initiated.

All communication between these components is done with the following:

* A heartbeat message between the Chef push jobs server and each managed node
* A knife plugin named ``knife push jobs`` with four subcommands: ``job list``, ``job start``, ``job status``, ``job output``, and ``node status``
* Various job messages sent from a workstation to the Chef push jobs server
* A single job message that is sent (per job) from the Chef push jobs server to one (or more) nodes that are being managed by the Chef server

The following diagram shows the various components of Chef push jobs:

.. image:: ../../images/overview_push_jobs_states.png

Jobs
-----------------------------------------------------
.. tag push_jobs_component_jobs

The Chef push jobs server is used to send job messages to one (or more) managed nodes and also to manage the list of jobs that are available to be run against nodes.

A heartbeat message is used to let all of the nodes in an organization know that the Chef push jobs server is available. The Chef push jobs server listens for heartbeat messages from each Chef push jobs client. If there is no heartbeat from a Chef push jobs client, the Chef push jobs server will mark that node as unavailable for job messages until the heartbeat resumes.

.. end_tag

Nodes
-----------------------------------------------------
.. tag push_jobs_component_nodes

The Chef push jobs client is used to receive job messages from the Chef push jobs server and to verify the heartbeat status. The Chef push jobs client uses the same authorization / authentication model as the chef-client. The Chef push jobs client listens for heartbeat messages from the Chef push jobs server. If there is no heartbeat from the Chef push jobs server, the Chef push jobs client will finish its current job, but then stop accepting any new jobs until the heartbeat from the Chef push jobs server resumes.

.. end_tag

Workstations
-----------------------------------------------------
.. tag push_jobs_component_workstations

A workstation is used to manage Chef push jobs jobs, including maintaining the **push-jobs** cookbook, using knife to start and stop jobs, view job status, and to manage job lists.

.. end_tag

**push-jobs** Cookbook
=====================================================
The **push-jobs** cookbook contains attributes that are used to configure the Chef push jobs client. In addition, Chef push jobs relies on the ``whitelist`` attribute to manage the list of jobs (and commands) that are available to Chef push jobs.

Whitelist
-----------------------------------------------------
.. tag push_jobs_whitelist

A whitelist is a list of jobs and commands that are used by Chef push jobs. A whitelist is saved as an attribute in the **push-jobs** cookbook. For example:

.. code-block:: ruby

   default['push_jobs']['whitelist'] = {
     'job_name' => 'command',
   }

The whitelist is accessed from a recipe using the ``node['push_jobs']['whitelist]`` attribute. For example:

.. code-block:: ruby

   template 'name' do
     source 'name'
     ...
     variables(:whitelist => node['push_jobs']['whitelist'])
   end

Use the ``knife exec`` subcommand to add a job to the whitelist. For example:

.. code-block:: bash

   $ knife exec -E 'nodes.transform("name:A_NODE_NAME") do |n|
       n.set["push_jobs"]["whitelist"]["ntpdate"] = "ntpdate -u time"
     end'

where ``["ntpdate"] = "ntpdate -u time"`` is added to the whitelist:

.. code-block:: ruby

   default['push_jobs']['whitelist'] = {
     "ntpdate" => "ntpdate -u time",
   }

.. end_tag

..
.. Commented out, probably move to new file(s)
..
.. Messages
.. =====================================================
.. xxxxx sends two types of messages: heartbeat and job.
..
.. Heartbeat Messages
.. -----------------------------------------------------
.. .. include:: ../../includes_push_jobs/includes_push_jobs_messages_heartbeat.rst
..
.. Job Messages
.. -----------------------------------------------------
.. .. include:: ../../includes_push_jobs/includes_push_jobs_messages_jobs.rst

Reference
=====================================================
The following sections describe the knife subcommands, environment variables available to your commands, the Push Jobs API, and configuration settings used by Chef push jobs.

knife push jobs
=====================================================
.. tag plugin_knife_push_jobs_1

The ``knife push jobs`` subcommand is used by Chef push jobs to start jobs, view job status, view job lists, and view node status.

.. end_tag

.. note:: Review the list of :doc:`common options <knife_common_options>` available to this (and all) knife subcommands and plugins.

.. Install this plugin
.. -----------------------------------------------------
.. .. include:: ../../step_plugin_knife/step_plugin_knife_push_jobs_install_rubygem.rst

job list
-----------------------------------------------------
.. tag plugin_knife_push_jobs_job_list

Use the ``job list`` argument to view a list of Chef push jobs jobs.

.. end_tag

Syntax
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. tag plugin_knife_push_jobs_job_list_syntax

This argument has the following syntax:

.. code-block:: bash

   $ knife job list

.. end_tag

Options
+++++++++++++++++++++++++++++++++++++++++++++++++++++
This command does not have any specific options.

job output
-----------------------------------------------------
.. tag plugin_knife_push_jobs_job_output

The ``job output`` command is used to view the output of Push jobs. The output capture flag must have been set on ``job start``; see the ``--capture`` option.

.. end_tag

Syntax
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. tag plugin_knife_push_jobs_job_output_syntax

This argument has the following syntax:

.. code-block:: bash

   $ knife job output (options) JOB_ID [NODE_NAME]

.. end_tag

Options
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. tag plugin_knife_push_jobs_job_output_options

This argument has the following options:

``--channel [stderr | stdout]``
  The output channel to capture.

.. end_tag

Examples
+++++++++++++++++++++++++++++++++++++++++++++++++++++

**View the STDOUT for job with ID 26e98ba162fa7ba6fb2793125553c7ae**

.. code-block:: bash

   $ knife job output 26e98ba162fa7ba6fb2793125553c7ae --channel stdout

job start
-----------------------------------------------------
.. tag plugin_knife_push_jobs_job_start

Use the ``job start`` argument to start a Chef push jobs job.

.. end_tag

Syntax
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. tag plugin_knife_push_jobs_job_start_syntax

This argument has the following syntax:

.. code-block:: bash

   $ knife job start (options) COMMAND [NODE, NODE, ...]

.. end_tag

Options
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. tag 1_4

This argument has the following options:

``--timeout TIMEOUT``
   The maximum amount of time (in seconds) by which a job must complete, before it is stopped.

``-q QUORUM``, ``--quorum QUORUM``
   The minimum number of nodes that match the search criteria, are available, and acknowledge the job request. This can be expressed as a percentage (e.g. ``50%``) or as an absolute number of nodes (e.g. ``145``). Default value: ``100%``.

   For example, there are ten total nodes. If ``--quorum 80%`` is used and eight of those nodes acknowledge the job request, the command will be run against all of the available nodes. If two of the nodes were unavailable, the command would still be run against the remaining eight available nodes because quorum was met.

``-b``, ``--nowait``
   Exit immediately after starting a job instead of waiting for it to complete.

``--with-env ENVIRONMENT``
   Accept a JSON blob of environment variables and use those to set the variables for the client. For example ``'{"test": "foo"}'`` will set the push client environment variable "test" to "foo".

``--in-dir DIR``
   Execute the remote command in the directory ``DIR``.

``--file DATAFILE``
  Send the file to the client. Cleaned

``--capture``
  Capture stdin and stdout for this job.

.. end_tag

Examples
+++++++++++++++++++++++++++++++++++++++++++++++++++++

**Run a job**

.. tag plugin_knife_push_jobs_job_start_run_job

To run a job named ``add-glasses`` against a node named ``ricardosalazar``, run the following command:

.. code-block:: bash

   $ knife job start add-glasses 'ricardosalazar'

.. end_tag

**Run a job using quorum percentage**

.. tag plugin_knife_push_jobs_job_start_search_by_quorum

To search for nodes assigned the role ``webapp``, and where 90% of those nodes must be available, run the following command:

.. code-block:: bash

   $ knife job start --quorum 90% 'chef-client' --search 'role:webapp'

.. end_tag

**Run a job using node names**

.. tag plugin_knife_push_jobs_job_start_search_by_nodes

To search for a specific set of nodes (named ``chico``, ``harpo``, ``groucho``, ``gummo``, ``zeppo``), and where 90% of those nodes must be available, run the following command:

.. code-block:: bash

   $ knife job start --quorum 90% 'chef-client' chico harpo groucho gummo zeppo

to return something similar to:

.. code-block:: bash

   Started. Job ID: GUID12345abc
     quorum_failed
     Command: chef-client
     Created_at: date
     unavailable: zeppo
     was_ready:
       gummo
       groucho
       chico
       harpo
     On_timeout: 3600
     Status: quorum_failed

.. note:: If quorum had been set at 80% (``--quorum 80%``), then quorum would have passed with the previous example.

.. end_tag

job status
-----------------------------------------------------
.. tag plugin_knife_push_jobs_job_status

Use the ``job status`` argument to view the status of Chef push jobs jobs. Each job is always in one of the following states: ``new``, ``voting``, ``running``, ``complete``, ``quorum_failed``, ``crashed``, ``aborted``, or ``timed_out``.

.. end_tag

Syntax
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. tag plugin_knife_push_jobs_job_status_syntax

This argument has the following syntax:

.. code-block:: bash

   $ knife job status

.. end_tag

Options
+++++++++++++++++++++++++++++++++++++++++++++++++++++
This command does not have any specific options.

Examples
+++++++++++++++++++++++++++++++++++++++++++++++++++++

**View job status by job identifier**

.. tag plugin_knife_push_jobs_job_status_by_id

To view the status of a job that has the identifier of ``235``, run the following command:

.. code-block:: bash

   $ knife job status 235

to return something similar to:

.. code-block:: bash

   Node name   Status      Last updated
   foo         Failed      2012-05-04 00:00
   bar         Done        2012-05-04 00:01

.. end_tag

node status
-----------------------------------------------------
.. tag plugin_knife_push_jobs_node_status

Use the ``node status`` argument to identify nodes that Chef push jobs may interact with. Each node is always in one of the following states: ``new``, ``ready``, ``running``, ``succeeded``, ``failed``, ``aborted``, ``unavailable``, ``nacked``, ``crashed``, ``was_ready``, or ``timed_out``.

.. end_tag

Syntax
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. tag plugin_knife_push_jobs_node_status_syntax

This argument has the following syntax:

.. code-block:: bash

   $ knife node status

.. end_tag

Options
+++++++++++++++++++++++++++++++++++++++++++++++++++++
This command does not have any specific options.

Environment Variables
=====================================================
The following are environment variables that are automatically made available within the context of
the job you are running.

.. list-table::
   :widths: 200 300
   :header-rows: 1

   * - Environment Variable
     - Description
   * - ``CHEF_PUSH_JOB_FILE``
     - The path to the temporary file containing the string you passed using the ``--file`` parameter.
   * - ``CHEF_PUSH_NODE_NAME``
     - The name of the node you are currently running on.
   * - ``CHEF_PUSH_JOB_ID``
     - The ID for the job currently running.

Push Jobs API
=====================================================
.. tag api_push_jobs_1

The Push Jobs API is used to create jobs and retrieve status using Chef push jobs, a tool that pushes jobs against a set of nodes in the organization. All requests are signed using the Chef server API and the validation key on the workstation from which the requests are made. All commands are sent to the Chef server using the ``knife exec`` subcommand.

.. end_tag

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
.. tag 1_summary

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

.. end_tag

jobs/ID
-----------------------------------------------------
.. tag api_push_jobs_endpoint_jobs_id

The ``/organizations/ORG_NAME/pushy/jobs/ID`` endpoint has the following methods: ``GET``.

.. end_tag

GET
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. tag 1

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

.. end_tag

jobs/ID/output/NODE_NAME/CHANNEL
-----------------------------------------------------
.. tag api_push_jobs_endpoint_jobs_output

It is possible to capture the output of commands invoked by Push Jobs, both STDOUT and STDERR, by
providing the ``capture_output=true`` option when creating a job.

If capture is enabled, then the client will capture both the stdout and the stderr channels of the command.
The channel output will be sent back regardless of whether the command succeeded or failed. It will be sent in raw
form, including any terminating whitespace. If the command produced no output, then the value will be an empty string.

The two channels are treated as a pair -- for a given ``<job, node>``, either both will appear, or neither will appear.

The output is not streamed to the server as it is produced. Therefore, the output data for a given node will not
be available until the run on that node is complete.

.. end_tag

GET
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. tag api_push_jobs_endpoint_jobs_output_get

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

.. end_tag

jobs_status_feed
-----------------------------------------------------
.. tag api_push_jobs_endpoint_jobs_status_feed

The ``/organizations/ORG_NAME/pushy/jobs_status_feed`` endpoint has the following methods: ``GET``

.. end_tag

GET
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. tag api_push_jobs_endpoint_jobs_status_feed_get

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

.. end_tag

jobs_status_feed/JOBID
-----------------------------------------------------
.. tag api_push_jobs_endpoint_jobs_status_feed_id

The ``/organizations/ORG_NAME/pushy/jobs_status_feed/JOBID`` endpoint has the following methods: ``GET``

.. end_tag

GET
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. tag api_push_jobs_endpoint_jobs_status_feed_id_get

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

push-jobs-client
=====================================================
.. tag ctl_push_jobs_client_3

The Chef push jobs executable can be run as a command-line tool.

.. end_tag

Options
-----------------------------------------------------
.. tag 1_2

This command has the following syntax::

   push-jobs-client OPTION VALUE OPTION VALUE ...

This command has the following options:

``--allow_unencrypted``
   Allow unencrypted connections to 1.x servers

``-c CONFIG``, ``--config CONFIG``
   The configuration file to use. The chef-client and Chef push jobs client use the same configuration file: client.rb. Default value: ``Chef::Config.platform_specific_path("/etc/chef/client.rb")``.

``-d DIR``, ``-file_dir DIR``
   Set the directory for temporary files. Default value: ``/tmp/chef-push``.

``-h``, ``--help``
   Show help for the command.

``-k KEY_FILE``, ``--client-key KEY_FILE``
   The location of the file that contains the client key.

``-l LEVEL``, ``--log_level LEVEL``
   The level of logging to be stored in a log file.

``-L LOCATION``, ``--logfile LOCATION``
   The location of the log file. This is recommended when starting any executable as a daemon.

``-N NODE_NAME``, ``--node-name NODE_NAME``
   The name of the node.

``-S URL``, ``--server URL``
   The URL for the Chef server.

``-v``, ``--version``
   The version of Chef push jobs.

.. end_tag

opscode-push-jobs-server.rb
=====================================================
.. tag config_rb_push_jobs_server_1

The opscode-push-jobs-server.rb file is used to specify the configuration settings used by the Chef push jobs server.

This file is the default configuration file and is located at: ``/etc/opscode-push-jobs-server``.

.. end_tag

Settings
-----------------------------------------------------
.. tag 1_1

This configuration file has the following settings:

``command_port``
   The port on which a Chef push jobs server listens for requests that are to be executed on managed nodes. Default value: ``10002``.

``heartbeat_interval``
   The frequency of the Chef push jobs server heartbeat message. Default value: ``1000`` (milliseconds).

``keep_alive_time``
   The number of seconds between keepalive messages being sent on the event stream. Default value: ``15`` (seconds).

``org_feed_expiration``
   The number of seconds before an organization event expires. Default value:: ``60`` (seconds).

``server_heartbeat_port``
   The port on which the Chef push jobs server receives heartbeat messages from each Chef push jobs client. (This port is the ``ROUTER`` half of the ZeroMQ DEALER / ROUTER pattern.) Default value: ``10000``.

``server_name``
   The name of the Chef push jobs server.

``wait_complete_time``
   The number of seconds that a job waits around after it completes, allowing it to provide a full event stream instead of a summary. Default value: ``5`` (seconds).

``zeromq_listen_address``
   The IP address used by ZeroMQ. Default value: ``tcp://*``.

.. end_tag

