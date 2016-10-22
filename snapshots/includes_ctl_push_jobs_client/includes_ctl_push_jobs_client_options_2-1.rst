.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


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
