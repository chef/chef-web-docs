.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


This command has the following syntax::

   chef-solo OPTION VALUE OPTION VALUE ...

This command has the following options:

``-c CONFIG``, ``--config CONFIG``
   |config chef-client|

``-d``, ``--daemonize``
   |daemonize|  This option may not be used in the same command with the ``--[no-]fork`` option.

   This option is only available on machines that run in |unix| or |linux| environments. For machines that are running |windows| that require similar functionality, use the ``chef-client::service`` recipe in the ``chef-client`` cookbook: http://community.opscode.com/cookbooks/chef-client. This will install a |chef client| service under |windows| using the |windows service wrapper|.

``-E ENVIRONMENT_NAME``, ``--environment ENVIRONMENT_NAME``
   |name environment|

``-f``, ``--[no-]fork``
   |fork_chef| This option may not be used in the same command with the ``--daemonize`` and ``--interval`` options.

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
   |interval| |chef_client intervals| This option may not be used in the same command with the ``--[no-]fork`` option.

``-j PATH``, ``--json-attributes PATH``
   |json attributes|

   .. include:: ../../includes_node/includes_node_ctl_run_list.rst

   .. warning:: .. include:: ../../includes_node/includes_node_ctl_attribute.rst

``-l LEVEL``, ``--log_level LEVEL``
   |log_level|

``-L LOGLOCATION``, ``--logfile c``
   |log_location| This is recommended when starting any executable as a daemon.

``--[no-]color``
   |color| Default setting: ``--color``.

``-N NODE_NAME``, ``--node-name NODE_NAME``
   |name node|

``-o RUN_LIST_ITEM``, ``--override-runlist RUN_LIST_ITEM``
   |override_runlist|

``-r RECIPE_URL``, ``--recipe-url RECIPE_URL``
   |recipe_url|

``--run-lock-timeout SECONDS``
   |run_lock_timeout| Default value: not set (indefinite). Set to ``0`` to cause a second |chef client| to exit immediately.
   
``-s SECONDS``, ``--splay SECONDS``
   |splay| |chef_client intervals|

``-u USER``, ``--user USER``
   |user chef_client|

``-v``, ``--version``
   |version chef|

``-W``, ``--why-run``
   |whyrun_mode|









