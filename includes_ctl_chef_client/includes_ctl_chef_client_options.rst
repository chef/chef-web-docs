.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


This command has the following syntax:

.. code-block:: bash

   $ chef-client OPTION VALUE OPTION VALUE ...

This command has the following options:

``-A``, ``--fatal-windows-admin-check``
   |fatal_windows_admin_check|

``--audit-mode MODE``
   |audit_mode| Default value: ``disabled``.

``-c CONFIG``, ``--config CONFIG``
   |config chef-client|

``--chef-zero-host HOST``
   The host on which |chef zero| is started.

``--chef-zero-port PORT``
   |port chef_zero| If a port is not specified---individually, as range of ports, or from the ``chef_zero.port`` setting in the |client rb| file---the |chef client| will scan for ports between 8889-9999 and will pick the first port that is available.

``-d``, ``--daemonize``
   |daemonize| This option is only available on machines that run in |unix| or |linux| environments. For machines that are running |windows| that require similar functionality, use the ``chef-client::service`` recipe in the |cookbook chef_client| cookbook: http://community.opscode.com/cookbooks/chef-client. This will install a |chef client| service under |windows| using the |windows service wrapper|.

``--disable-config``
   Use to run the |chef client| using default settings. This will prevent the normally-associated configuration file from being used. This setting should only be used for testing purposes and should never be used in a production setting.

``-E ENVIRONMENT_NAME``, ``--environment ENVIRONMENT_NAME``
   |name environment|

``-f``, ``--[no-]fork``
   |fork_chef|

``-F FORMAT``, ``--format FORMAT``
   |format chef_ctls| 
   
   |format chef_ctls_doc|
   
   |format chef_ctls_min|
   
   |format chef_ctls_other|

``--force-formatter``
   |force_formatter|

``--force-logger``
   |force_logger|

``-g GROUP``, ``--group GROUP``
   |name group_process_owner|

``-h``, ``--help``
   |help subcommand|

``-i SECONDS``, ``--interval SECONDS``
   |interval| |chef_client intervals| Default value: ``1800``.

``-j PATH``, ``--json-attributes PATH``
   |json attributes|

   **Run-lists**

   .. include:: ../../includes_node/includes_node_ctl_run_list.rst

   **Environments**

   .. include:: ../../includes_ctl_chef_client/includes_ctl_chef_client_environment.rst

   **All attributes are normal attributes**

   .. include:: ../../includes_node/includes_node_ctl_attribute.rst

   **Specify a policy**

   .. include:: ../../includes_policy/includes_policy_ctl_run_list.rst

``-k KEY_FILE``, ``--client_key KEY_FILE``
   |client_key| Default value: ``/etc/chef/client.pem``.

``-K KEY_FILE``, ``--validation_key KEY_FILE``
   |validation_key| Default value: ``/etc/chef/validation.pem``.

``-l LEVEL``, ``--log_level LEVEL``
   |log_level| Possible levels: ``:auto`` (default), ``debug``, ``info``, ``warn``, ``error``, or ``fatal``. Default value: ``warn`` (when a terminal is available) or ``info`` (when a terminal is not available).

``-L LOGLOCATION``, ``--logfile LOGLOCATION``
   |log_location| This is recommended when starting any executable as a daemon. Default value: ``STDOUT``.

``--lockfile LOCATION``
   Use to specify the location of the lock file, which prevents multiple |chef client| processes from converging at the same time.

``--minimal-ohai``
   |minimal_ohai|

``--[no-]color``
   |color| Default setting: ``--color``.

``--[no-]listen``
   |chef_zero_no_listen|

``-n NAME``, ``--named-run-list NAME``
   |run_list policy|

``-N NODE_NAME``, ``--node-name NODE_NAME``
   |name node|

``-o RUN_LIST_ITEM``, ``--override-runlist RUN_LIST_ITEM``
   |override_runlist| This option will not clear the list of cookbooks (and related files) that is cached on the node.

``--once``
   |once|

``-P PID_FILE``, ``--pid PID_FILE``
   |path pid_file| Default value: ``/tmp/name-of-executable.pid``.

``--profile-ruby``
   .. include:: ../../includes_ctl_chef_client/includes_ctl_chef_client_profile_ruby.rst

``-r RUN_LIST_ITEM``, ``--runlist RUN_LIST_ITEM``
   |runlist_items|

``-R``, ``--enable-reporting``
   |enable_reporting|

``RECIPE_FILE``
   |path recipe_file|

``--recipe-url=RECIPE_URL``
   The location of a recipe when it exists at a URL. Use this option only when the |chef client| is run with the ``--local-mode`` option.

``--run-lock-timeout SECONDS``
   |run_lock_timeout| Default value: not set (indefinite). Set to ``0`` to cause a second |chef client| to exit immediately.

``-s SECONDS``, ``--splay SECONDS``
   |splay| |chef_client intervals|

``-S CHEF_SERVER_URL``, ``--server CHEF_SERVER_URL``
   |url chef_server|

``-u USER``, ``--user USER``
   |user chef_client|

``-v``, ``--version``
   |version chef|

``-W``, ``--why-run``
   |whyrun_mode|

``-z``, ``--local-mode``
   |local_mode|
