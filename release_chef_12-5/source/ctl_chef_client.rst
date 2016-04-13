.. THIS PAGE DOCUMENTS chef-client version 12.5

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

``--audit-mode MODE``
   |audit_mode| Default value: ``disabled``.

``-c CONFIG``, ``--config CONFIG``
   |config chef-client|

``--chef-zero-host HOST``
   The host on which |chef zero| is started.

``--chef-zero-port PORT``
   |port chef_zero| If a port is not specified---individually, as range of ports, or from the ``chef_zero.port`` setting in the |client rb| file---the |chef client| will scan for ports between 8889-9999 and will pick the first port that is available.

``-d``, ``--daemonize``
   |daemonize|

   |daemonize windows|

``--disable-config``
   Use to run the |chef client| using default settings. This will prevent the normally-associated configuration file from being used. This setting should only be used for testing purposes and should never be used in a production setting.

``-E ENVIRONMENT_NAME``, ``--environment ENVIRONMENT_NAME``
   |name environment|

``-f``, ``--[no-]fork``
   |fork_chef|

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

``-r RUN_LIST_ITEM``, ``--runlist RUN_LIST_ITEM``
   |run_list_items|

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


|chef client| Lock File
-----------------------------------------------------
.. include:: ../../includes_chef_client/includes_chef_client_lockfile.rst

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

Run in Audit Mode
=====================================================
.. include:: ../../includes_chef_client/includes_chef_client_audit_mode.rst

Use following option to run the |chef client| in |chef client_audit| mode:

``--audit-mode MODE``
   |audit_mode| Default value: ``disabled``.

Run as a Service
=====================================================
.. include:: ../../includes_ctl_chef_client/includes_ctl_chef_client_daemonized.rst

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

Run on IBM AIX
=====================================================
.. include:: ../../includes_ctl_chef_client/includes_ctl_chef_client_aix.rst

**System Requirements**

.. include:: ../../includes_ctl_chef_client/includes_ctl_chef_client_aix_requirements.rst

**Install the chef-client on the AIX platform**

.. include:: ../../includes_ctl_chef_client/includes_ctl_chef_client_aix_setup.rst

**Increase system process limits**

.. include:: ../../includes_ctl_chef_client/includes_ctl_chef_client_aix_system_process_limits.rst

**Install the UTF-8 character set**

.. include:: ../../includes_install/includes_install_chef_client_aix_en_us.rst

**Providers**

.. include:: ../../includes_ctl_chef_client/includes_ctl_chef_client_aix_providers.rst

**Enable a service on AIX using the mkitab command**

.. include:: ../../step_resource/step_resource_service_aix_mkitab.rst

Configuring a Proxy Server
=====================================================
See the :doc:`proxies </proxies>` documentation for information on how to configure chef-client to use a proxy server.

Examples
=====================================================

**Run the chef-client**

.. code-block:: bash

   $ sudo chef-client

**Start a run when the chef-client is running as a daemon**

.. include:: ../../step_ctl_chef_client/step_ctl_chef_client_start_chef_run_daemon.rst

**Setting the initial run-list using a JSON file**

.. include:: ../../step_ctl_chef_client/step_ctl_chef_client_bootstrap_initial_run_list.rst
