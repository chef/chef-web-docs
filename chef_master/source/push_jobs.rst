=====================================================
Chef Push Jobs
=====================================================
`[edit on GitHub] <https://github.com/chef/chef-web-docs/blob/master/chef_master/source/push_jobs.rst>`__

.. tag push_jobs_summary

Chef push jobs is an extension of the Chef server that allows jobs to be run against nodes independently of a chef-client run. A job is an action or a command to be executed against a subset of nodes; the nodes against which a job is run are determined by the results of a search query made to the Chef server.

Chef push jobs uses the Chef server API and a Ruby client to initiate all connections to the Chef server. Connections use the same authentication and authorization model as any other request made to the Chef server. A knife plugin is used to initiate job creation and job tracking.

.. end_tag

Install :doc:`Push Jobs </install_push_jobs>` using the **push-jobs** cookbook and a chef-client run on each of the target nodes.

Requirements
=====================================================
Chef push jobs has the following requirements:

* An on-premises Chef server version 11.0.1 (or later); Chef push jobs is not supported when running Chef with the hosted Chef server
* To use the **push-jobs** cookbook to configure the Chef push jobs client, the chef-client must also be present on the node (because only the chef-client can use a cookbook to configure a node)
* .. tag server_firewalls_and_ports_push_jobs

  TCP protocol ports 10000 and 10002. TCP/10000 is the default heartbeat port. TCP/10002 is the command port. It may be configured in the Chef push jobs configuration file . This port allows Chef push jobs clients to communicate with the Chef push jobs server. In a configuration with both front and back ends, this port only needs to be open on the back end servers. The Chef push jobs server waits for connections from the Chef push jobs client, and never initiates a connection to a Chef push jobs client.

  .. end_tag

Platforms
-----------------------------------------------------
.. tag adopted_platforms_push_jobs

The following table lists the Foundational platforms for the Chef push jobs:

.. list-table::
   :widths: 280 100 120
   :header-rows: 1

   * - Platform
     - Architecture
     - Version
   * - CentOS
     - ``i386``
     - ``5``, ``6``
   * -
     - ``x86_64``
     - ``5``, ``6``, ``7``
   * - Debian
     - ``i386``, ``x86_64``
     - ``7``
   * - Red Hat Enterprise Linux
     - ``i386``
     - ``5``, ``6``
   * -
     - ``x86_64``
     - ``5``, ``6``, ``7``
   * - Ubuntu
     - ``x86``, ``x86_64``
     - ``12.04``, ``14.04``
   * - Microsoft Windows
     - ``x86``, ``x86_64``
     - ``2008r2``, ``2012``, ``2012r2``, ``7``, ``8``, ``8.1``, ``10``

.. end_tag

Components
=====================================================
Chef push jobs has three main components: jobs (managed by the Chef push jobs server), a client that is installed on every node in the organization, and one (or more) workstations from which job messages are initiated.

All communication between these components is done with the following:

* A heartbeat message between the Chef push jobs server and each managed node
* A knife plugin named ``knife push jobs`` with four subcommands: ``job list``, ``job start``, ``job status``, and ``node status``
* Various job messages sent from a workstation to the Chef push jobs server
* A single job message that is sent (per job) from the Chef push jobs server to one (or more) nodes that are being managed by the Chef server

The following diagram shows the various components of Chef push jobs:

.. image:: ../../images/overview_push_jobs_states.png

Jobs
-----------------------------------------------------
The Chef push jobs server is used to send job messages to one (or more) managed nodes and also to manage the list of jobs that are available to be run against nodes.

A heartbeat message is used to let all of the nodes in an organization know that the Chef push jobs server is available. The Chef push jobs server listens for heartbeat messages from each Chef push jobs client. If there is no heartbeat from a Chef push jobs client, the Chef push jobs server will mark that node as unavailable for job messages until the heartbeat resumes.

Nodes
-----------------------------------------------------
The Chef push jobs client is used to receive job messages from the Chef push jobs server and to verify the heartbeat status. The Chef push jobs client uses the same authorization / authentication model as the chef-client. The Chef push jobs client listens for heartbeat messages from the Chef push jobs server. If there is no heartbeat from the Chef push jobs server, the Chef push jobs client will finish its current job, but then stop accepting any new jobs until the heartbeat from the Chef push jobs server resumes.

Workstations
-----------------------------------------------------
A workstation is used to manage Chef push jobs jobs, including maintaining the **push-jobs** cookbook, using knife to start and stop jobs, view job status, and to manage job lists.

**push-jobs** Cookbook
=====================================================
The **push-jobs** cookbook contains attributes that are used to configure the Chef push jobs client. In addition, Chef push jobs relies on the ``whitelist`` attribute to manage the list of jobs (and commands) that are available to Chef push jobs.

Whitelist
-----------------------------------------------------
A whitelist is a list of jobs and commands that are used by Chef push jobs. A whitelist is saved as an attribute in the **push-jobs** cookbook. For example:

.. code-block:: ruby

   default['push_jobs']['whitelist'] = {
     'job_name' => 'command',
   }

The whitelist is accessed from a recipe using the ``node['push_jobs']['whitelist']`` attribute. For example:

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

Reference
=====================================================
The following sections describe the knife subcommands, the Push Jobs API, and configuration settings used by Chef push jobs.

knife push jobs
=====================================================
.. tag plugin_knife_push_jobs_summary

The ``knife push jobs`` subcommand is used by Chef push jobs to start jobs, view job status, view job lists, and view node status.

.. end_tag

.. note:: Review the list of :doc:`common options </knife_common_options>` available to this (and all) knife subcommands and plugins.

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
This argument has the following options:

``--timeout TIMEOUT``
   The maximum amount of time (in seconds) by which a job must complete, before it is stopped.

``-q QUORUM``, ``--quorum QUORUM``
   The minimum number of nodes that match the search criteria, are available, and acknowledge the job request. This can be expressed as a percentage (e.g. ``50%``) or as an absolute number of nodes (e.g. ``145``). Default value: ``100%``.

   For example, there are ten total nodes. If ``--quorum 80%`` is used and eight of those nodes acknowledge the job request, the command will be run against all of the available nodes. If two of the nodes were unavailable, the command would still be run against the remaining eight available nodes because quorum was met.

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

Use the ``job status`` argument to view the status of Chef push jobs jobs. Each job is always in one of the following states:

``new``
  New job status.

``voting``
  Waiting for nodes to commit or refuse to run the command.

``running``
  Running the command on the nodes.

``complete``
  Ran the command. Check individual node statuses to see if they completed or had issues.

``quorum_failed``
  Did not run the command on any nodes.

``crashed``
  Crashed while running the job.

``timed_out``
  Timed out while running the job.

``aborted``
  Job aborted by user.

.. end_tag

Syntax
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. tag plugin_knife_push_jobs_job_status_syntax

This argument has the following syntax:

.. code-block:: bash

   $ knife job status <job id>

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

Use the ``node status`` argument to identify nodes that Chef push jobs may interact with. Each node is always in one of the following states:

``new``
  Node has neither committed nor refused to run the command.

``ready``
  Node has committed to run the command but has not yet run it.

``running``
  Node is presently running the command.

``succeeded``
  Node successfully ran the command (an exit code of 0 was returned).

``failed``
  Node failed to run the command (an exit code of non-zero was returned).

``aborted``
  Node ran the command but stopped before completion.

``crashed``
  Node went down after it started running the job.

``nacked``
  Node was busy when asked to be part of the job.

``unavailable``
  Node went down before it started running.

``was_ready``
  Node was ready but quorum failed.

``timed_out``
  Node timed out.

.. end_tag

Syntax
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. tag plugin_knife_push_jobs_node_status_syntax

This argument has the following syntax:

.. code-block:: bash

   $ knife node status [<node> <node> ...]

.. end_tag

Options
+++++++++++++++++++++++++++++++++++++++++++++++++++++
This command does not have any specific options.

Push Jobs API
=====================================================
The Push Jobs API is used to create jobs and retrieve status using Chef push jobs, a tool that pushes jobs against a set of nodes in the organization. All requests are signed using the Chef server API and the validation key on the workstation from which the requests are made. All commands are sent to the Chef server using the ``knife exec`` subcommand.

Each authentication request must include ``/organizations/organization_name/pushy/`` as part of the name for the endpoint. For example: ``/organizations/organization_name/pushy/jobs/ID`` or ``/organizations/organization_name/pushy/node_states``.

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

jobs/ID
-----------------------------------------------------
.. tag api_push_jobs_endpoint_jobs_id

The ``/organizations/ORG_NAME/pushy/jobs/ID`` endpoint has the following methods: ``GET``.

.. end_tag

GET
+++++++++++++++++++++++++++++++++++++++++++++++++++++
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
.. tag ctl_push_jobs_client_summary

The Chef push jobs executable can be run as a command-line tool.

.. end_tag

Options
-----------------------------------------------------
This command has the following syntax::

   push-jobs-client OPTION VALUE OPTION VALUE ...

This command has the following options:

``-c CONFIG``, ``--config CONFIG``
   The configuration file to use. The chef-client and Chef push jobs client use the same configuration file: client.rb. Default value: ``Chef::Config.platform_specific_path("/etc/chef/client.rb")``.

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

opscode-push-jobs-server.rb
=====================================================
.. tag config_rb_push_jobs_server_summary

The opscode-push-jobs-server.rb file is used to specify the configuration settings used by the Chef push jobs server.

This file is the default configuration file and is located at: ``/etc/opscode-push-jobs-server``.

.. end_tag

Settings
-----------------------------------------------------
This configuration file has the following settings:

``command_port``
   The port on which a Chef push jobs server listens for requests that are to be executed on managed nodes. Default value: ``10002``.

``heartbeat_interval``
   The frequency of the Chef push jobs server heartbeat message. Default value: ``1000`` (milliseconds).

``server_heartbeat_port``
   The port on which the Chef push jobs server receives heartbeat messages from each Chef push jobs client. (This port is the ``ROUTER`` half of the ZeroMQ DEALER / ROUTER pattern.) Default value: ``10000``.

``server_name``
   The name of the Chef push jobs server.

``zeromq_listen_address``
   The IP address used by ZeroMQ. Default value: ``tcp://*``.
