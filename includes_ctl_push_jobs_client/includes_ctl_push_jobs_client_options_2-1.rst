.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


This command has the following syntax::

   push-jobs-client OPTION VALUE OPTION VALUE ...

This command has the following options:

``--allow_unencrypted``
   Allow unencrypted connections to 1.x servers

``-c CONFIG``, ``--config CONFIG``
   |config chef-client| The |chef client| and |push jobs| client use the same configuration file: |client rb|. Default value: ``Chef::Config.platform_specific_path("/etc/chef/client.rb")``.

``-d DIR``, ``-file_dir DIR``
   Set the directory for temporary files. Default value: ``/tmp/chef-push``.

``-h``, ``--help``
   |help subcommand|

``-k KEY_FILE``, ``--client-key KEY_FILE``
   |client_key|

``-l LEVEL``, ``--log_level LEVEL``
   |log_level|

``-L LOCATION``, ``--logfile LOCATION``
   |log_location| This is recommended when starting any executable as a daemon.

``-N NODE_NAME``, ``--node-name NODE_NAME``
   |name node|

``-S URL``, ``--server URL``
   |chef_server_url|

``-v``, ``--version``
   |version push jobs|
