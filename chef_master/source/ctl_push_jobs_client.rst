=====================================================
push-jobs-client (executable)
=====================================================

.. tag push_jobs_summary

Chef push jobs is an extension of the Chef server that allows jobs to be run against nodes independently of a chef-client run. A job is an action or a command to be executed against a subset of nodes; the nodes against which a job is run are determined by the results of a search query made to the Chef server.

Chef push jobs uses the Chef server API and a Ruby client to initiate all connections to the Chef server. Connections use the same authentication and authorization model as any other request made to the Chef server. A knife plugin is used to initiate job creation and job tracking.

.. end_tag

.. tag ctl_push_jobs_client_summary

The Chef push jobs executable can be run as a command-line tool.

.. end_tag

Options
=====================================================
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

Examples
=====================================================
None.

