=====================================================
Release Notes: Chef Push Jobs 2.1
=====================================================

.. include:: ../../includes_push_jobs/includes_push_jobs.rst

What's New
=====================================================
The following items are new for Chef push jobs:

* **Push Jobs client 2.1** is backwards-compatible with the Chef push jobs 1.x server when the ``allow_unencrypted`` option to be set to ``true`` in ``/etc/chef/opscode-push-jobs-server.rb``.
* Allow the job execution environment to be set. This includes user, working directory, environment variables and a data file to be set.
* STDOUT/STDERR can now optionally be captured from job execution and return it to the server. Users can retrieve the output via the ``knife job output`` command.
* We now provide two SSE feed endpoints; one provides fine grained per-job events, while the other provides a per-org feed of jobs starting and completing.
* Command communication now uses libsodium based encryption via zeromq4's CurveZMQ. This replaces the signing protocol used in 1.x. All zeromq packets are fully encrypted and signed, except for the server heartbeat broadcast, which is signed, but in the clear.

Important Notes
-----------------------------------------------------
* **Push Jobs 2.1 is not currently supported for use with Chef Automate**.
* **Push Jobs Server 2.X is not compatible with Push Jobs Client 1.X**. We recommend that you upgrade all your Push Jobs Clients to 2.X before performing an upgrade of your Push Jobs Server.

Encryption
=====================================================
All command channel communication is encrypted via SSL or `CurveZMQ <http://rfc.zeromq.org/spec:26a>`_. CurveZMQ is based on the `CurveCP protocol <http://curvecp.org/security.html>`_. The one exception to this is the server heartbeat, which is broadcast in the clear (but is still signed with the server key for integrity).

Command Output Capture
=====================================================
Both the ``knife-push`` library and the Chef Push Jobs API provide options to direct the client to capture the job output and return it to the server for inspection:

.. code-block:: bash

   $ knife job start --capture "echo foobar" node1
   Started. Job ID: 26e98ba162fa7ba6fb2793125553c7ae
   .Complete.

   $ knife job output --channel stdout 26e98ba162fa7ba6fb2793125553c7ae node1
   foobar


Environment Control
=====================================================
The user has a lot more control over the execution environment of the remote command with three new options available to the ``knife push jobs start`` command.

This includes:

* Environment variables (``--with-env``)
* Execution directory (``--in-dir``)
* Data file sent from the user to the push client (``--file``)

.. code-block:: bash

   $ knife job start --file .chef/knife.rb --capture --with-env '{"test": "foo"}' --in-dir "/tmp" --as-user daemon "print_execution_environment" node2
   Started. Job ID: 26e98ba162fac37787292637362808cb
   ...

   $ knife job output --channel stdout 26e98ba162fac37787292637362808cb node2
   {"HOME"=>"/home/vagrant",
   ...
   "CHEF_PUSH_JOB_FILE"=>"/tmp/pushy/pushy_file20150813-14250-125xv4u",
   "CHEF_PUSH_JOB_ID"=>"26e98ba162fac37787292637362808cb",
   "CHEF_PUSH_NODE_NAME"=>"test",
   "PWD"=>"/srv/piab/mounts/opscode-pushy-client",
   "SHELL"=>"/bin/bash",
   "test"=>"foo"}

In addition to environment variables specified with the ``--with-env`` flag, there are three new special environment variables that are made available to you automatically:

* ``CHEF_PUSH_JOB_FILE`` - The path to the temporary file containing the string you passed using the ``--file`` parameter.
* ``CHEF_PUSH_NODE_NAME`` - The name of the node this instance of the push job is being run on.
* ``CHEF_PUSH_JOB_ID`` - The ID for the job currently being run.

Server Sent Event Feeds
=====================================================
There are two new endpoints that provide feeds for the state of jobs on the server. There's an organization-level feed that provides high level job start/completion information, and a per job feed that provides node level state changes for a particular job. As of this release, these feeds are only available via the :doc:`Chef Push Jobs API </api_push_jobs>`.

Here is a quick example of what an organization-level feed might look like.

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
