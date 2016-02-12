.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


This command has the following syntax:

.. code-block:: bash

   $ chef-client OPTION VALUE OPTION VALUE ...

This command has the following options:

``-A``, ``--fatal-windows-admin-check``
   |fatal_windows_admin_check|

``--chef-zero-port PORT``
   |port chef_zero| If a port is not specified---individually, as range of ports, or from the ``chef_zero.port`` setting in the |client rb| file---the |chef client| will scan for ports between 8889-9999 and will pick the first port that is available.

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

   .. include:: ../../includes_node/includes_node_ctl_run_list.rst

   .. warning:: .. include:: ../../includes_node/includes_node_ctl_attribute.rst

``-k KEY_FILE``, ``--client_key KEY_FILE``
   |client_key| Default value: ``/etc/chef/client.pem``.

``-K KEY_FILE``, ``--validation_key KEY_FILE``
   |validation_key| Default value: ``/etc/chef/validation.pem``.

``-l LEVEL``, ``--log_level LEVEL``
   |log_level| Possible levels: ``:auto`` (default), ``debug``, ``info``, ``warn``, ``error``, or ``fatal``. Default value: ``warn`` (when a terminal is available) or ``info`` (when a terminal is not available).

``-L LOGLOCATION``, ``--logfile LOGLOCATION``
   |log_location| This is recommended when starting any executable as a daemon. Default value: ``STDOUT``.

``--[no-]color``
   |color| Default setting: ``--color``.

``-N NODE_NAME``, ``--node-name NODE_NAME``
   |name node|

``-o RUN_LIST_ITEM``, ``--override-runlist RUN_LIST_ITEM``
   |override_runlist| This option will not clear the list of cookbooks (and related files) that is cached on the node.

``--once``
   |once|

``-P PID_FILE``, ``--pid PID_FILE``
   |path pid_file| Default value: ``/tmp/name-of-executable.pid``.

``-r RUN_LIST_ITEM``, ``--runlist RUN_LIST_ITEM``
   |runlist_items|

``-R``, ``--enable-reporting``
   |enable_reporting|

``RECIPE_FILE``
   |path recipe_file|

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
