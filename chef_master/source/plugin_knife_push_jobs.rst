=====================================================
knife push jobs
=====================================================
`[edit on GitHub] <https://github.com/chef/chef-web-docs/blob/master/chef_master/source/plugin_knife_push_jobs.rst>`__

.. tag plugin_knife_push_jobs_summary

The ``knife push jobs`` subcommand is used by Chef push jobs to start jobs, view job status, view job lists, and view node status.

.. end_tag

.. note:: Review the list of :doc:`common options </knife_common_options>` available to this (and all) knife subcommands and plugins.

job list
=====================================================
.. tag plugin_knife_push_jobs_job_list

Use the ``job list`` argument to view a list of Chef push jobs jobs.

.. end_tag

Syntax
-----------------------------------------------------
.. tag plugin_knife_push_jobs_job_list_syntax

This argument has the following syntax:

.. code-block:: bash

   $ knife job list

.. end_tag

Options
-----------------------------------------------------
This command does not have any specific options.

job output
=====================================================
The ``job output`` command is used to view the output of Push jobs. The output capture flag must have been set on ``job start``; see the ``--capture`` option.

Syntax
-----------------------------------------------------
This argument has the following syntax:

.. code-block:: bash

   $ knife job output (options) JOB_ID [NODE_NAME]

Options
-----------------------------------------------------
This argument has the following options:

``--channel [stderr | stdout]``
  The output channel to capture.

Examples
-----------------------------------------------------

**View the STDOUT from my-node for job with ID 26e98ba162fa7ba6fb2793125553c7ae**

.. code-block:: bash

  $ knife job output --channel stdout 26e98ba162fa7ba6fb2793125553c7ae my-node

job start
=====================================================
.. tag plugin_knife_push_jobs_job_start

Use the ``job start`` argument to start a Chef push jobs job.

.. end_tag

Syntax
-----------------------------------------------------
.. tag plugin_knife_push_jobs_job_start_syntax

This argument has the following syntax:

.. code-block:: bash

   $ knife job start (options) COMMAND [NODE, NODE, ...]

.. end_tag

Options
-----------------------------------------------------
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

Examples
-----------------------------------------------------
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
=====================================================
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
-----------------------------------------------------
.. tag plugin_knife_push_jobs_job_status_syntax

This argument has the following syntax:

.. code-block:: bash

   $ knife job status <job id>

.. end_tag

Options
-----------------------------------------------------
This command does not have any specific options.

Examples
-----------------------------------------------------
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
=====================================================
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
-----------------------------------------------------
.. tag plugin_knife_push_jobs_node_status_syntax

This argument has the following syntax:

.. code-block:: bash

   $ knife node status [<node> <node> ...]

.. end_tag

Options
-----------------------------------------------------
This command does not have any specific options.
