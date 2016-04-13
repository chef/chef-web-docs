.. THIS PAGE DOCUMENTS chef-client version 11.14

=====================================================
|chef client_exe| (executable)
=====================================================

.. include:: ../../includes_chef_client/includes_chef_client.rst

.. note:: |daemonize chef_client|

.. include:: ../../includes_ctl_chef_client/includes_ctl_chef_client.rst

.. note:: .. include:: ../../includes_config/includes_config_rb_client.rst

Syntax
=====================================================
This command has the following syntax:

.. code-block:: bash

   $ chef-client OPTION VALUE OPTION VALUE ...


Options
=====================================================
This command has the following options:

``-A``, ``--fatal-windows-admin-check``
   |fatal_windows_admin_check|

``--chef-zero-port PORT``
   |port chef_zero|

``-F FORMAT``, ``--format FORMAT``
   .. include:: ../../includes_ctl_chef_client/includes_ctl_chef_client_options_format.rst

``--force-formatter``
   |force_formatter|

``--force-logger``
   |force_logger|

``-g GROUP``, ``--group GROUP``
   |name group_process_owner|

``-h``, ``--help``
   |help subcommand|

``-i SECONDS``, ``--interval SECONDS``
   |interval| |chef_client intervals_11-16| Default value: ``1800``.

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
   |override_runlist|

   .. note:: This option **will** clear the list of cookbooks (and related files) that is cached on the node. (Starting in |chef client| 12.0, this option **will not** clear the list of cookbooks.)

``--once``
   |once|

``-P PID_FILE``, ``--pid PID_FILE``
   |path pid_file| Default value: ``/tmp/name-of-executable.pid``.

``-r RUN_LIST_ITEM``, ``--runlist RUN_LIST_ITEM``
   |run_list_items|

``-R``, ``--enable-reporting``
   |enable_reporting|

``RECIPE_FILE``
   |path recipe_file|

``--run-lock-timeout SECONDS``
   |run_lock_timeout| Default value: not set (indefinite). Set to ``0`` to cause a second |chef client| to exit immediately.

``-s SECONDS``, ``--splay SECONDS``
   |splay| |chef_client intervals_11-16|

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


Run in Local Mode
=====================================================
.. include:: ../../includes_chef_client/includes_chef_client_local_mode.rst

About |chef zero|
-----------------------------------------------------
.. include:: ../../includes_chef/includes_chef_zero.rst

Use Encrypted Data Bags
-----------------------------------------------------
.. include:: ../../includes_data_bag/includes_data_bag.rst

**Create an encrypted data bag for use with chef-client local mode**

.. include:: ../../step_knife/step_knife_data_bag_from_file_create_encrypted_local_mode.rst

Run with Elevated Privileges
=====================================================
.. include:: ../../includes_ctl_chef_client/includes_ctl_chef_client_elevated_privileges.rst

Linux
-----------------------------------------------------
.. include:: ../../includes_ctl_chef_client/includes_ctl_chef_client_elevated_privileges_linux.rst

Windows
-----------------------------------------------------
.. include:: ../../includes_ctl_chef_client/includes_ctl_chef_client_elevated_privileges_windows.rst

Run as Non-root User
=====================================================
.. include:: ../../includes_ctl_chef_client/includes_ctl_chef_client_non_root.rst

Set the Cache Path
-----------------------------------------------------
.. include:: ../../includes_ctl_chef_client/includes_ctl_chef_client_non_root_set_cache_path.rst

Elevate Commands
-----------------------------------------------------
.. include:: ../../includes_ctl_chef_client/includes_ctl_chef_client_non_root_use_attributes.rst

Examples
=====================================================

**Run the chef-client**

.. code-block:: bash

   $ sudo chef-client

**Start a run when the chef-client is running as a daemon**

.. include:: ../../step_ctl_chef_client/step_ctl_chef_client_start_chef_run_daemon.rst

**Setting the initial run-list using a JSON file**

.. include:: ../../step_ctl_chef_client/step_ctl_chef_client_bootstrap_initial_run_list.rst