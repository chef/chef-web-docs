.. THIS PAGE DOCUMENTS chef-client version 12.1

=====================================================
chef-client (executable)
=====================================================

.. include:: ../../includes_chef_client/includes_chef_client.rst

.. note:: The chef-client executable can be run as a daemon.

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
   Cause a chef-client run to fail when the chef-client does not have administrator privileges in Microsoft Windows.

``--audit-mode MODE``
   Enable audit-mode. Set to ``audit-only`` to skip the converge phase of the chef-client run and only perform audits. Possible values: ``audit-only``, ``disabled``, and ``enabled``. Default value: ``disabled``.

``-c CONFIG``, ``--config CONFIG``
   The configuration file to use.

``--chef-zero-host HOST``
   The host on which chef-zero is started.

``--chef-zero-port PORT``
   The port on which chef-zero listens. If a port is not specified---individually, as range of ports, or from the ``chef_zero.port`` setting in the client.rb file---the chef-client will scan for ports between 8889-9999 and will pick the first port that is available.

``-d``, ``--daemonize``
   Run the executable as a daemon.

   This option is only available on machines that run in UNIX or Linux environments. For machines that are running Microsoft Windows that require similar functionality, use the ``chef-client::service`` recipe in the ``chef-client`` cookbook: https://supermarket.chef.io/cookbooks/chef-client. This will install a chef-client service under Microsoft Windows using the Windows Service Wrapper.

``--disable-config``
   Use to run the chef-client using default settings. This will prevent the normally-associated configuration file from being used. This setting should only be used for testing purposes and should never be used in a production setting.

``-E ENVIRONMENT_NAME``, ``--environment ENVIRONMENT_NAME``
   The name of the environment.

``-f``, ``--[no-]fork``
   Contain the chef-client run in a secondary process with dedicated RAM. When the chef-client run is complete, the RAM is returned to the master process. This option helps ensure that a chef-client uses a steady amount of RAM over time because the master process does not run recipes. This option also helps prevent memory leaks such as those that can be introduced by the code contained within a poorly designed cookbook. Use ``--no-fork`` to disable running the chef-client in fork node. Default value: ``--fork``.

``-F FORMAT``, ``--format FORMAT``
   .. include:: ../../includes_ctl_chef_client/includes_ctl_chef_client_options_format.rst

``--force-formatter``
   Show formatter output instead of logger output.

``--force-logger``
   Show logger output instead of formatter output.

``-g GROUP``, ``--group GROUP``
   The name of the group that owns a process. This is required when starting any executable as a daemon.

``-h``, ``--help``
   Show help for the command.

``-i SECONDS``, ``--interval SECONDS``
   The frequency (in seconds) at which the chef-client runs. When the chef-client is run at intervals, ``--splay`` and ``--interval`` values are applied before the chef-client run. Default value: ``1800``.

``-j PATH``, ``--json-attributes PATH``
   The path to a file that contains JSON data.

   .. include:: ../../includes_node/includes_node_ctl_run_list.rst

   .. warning:: .. include:: ../../includes_node/includes_node_ctl_attribute.rst

``-k KEY_FILE``, ``--client_key KEY_FILE``
   The location of the file that contains the client key. Default value: ``/etc/chef/client.pem``.

``-K KEY_FILE``, ``--validation_key KEY_FILE``
   The location of the file that contains the key used when a chef-client is registered with a Chef server. A validation key is signed using the ``validation_client_name`` for authentication. Default value: ``/etc/chef/validation.pem``.

``-l LEVEL``, ``--log_level LEVEL``
   The level of logging to be stored in a log file. Possible levels: ``:auto`` (default), ``debug``, ``info``, ``warn``, ``error``, or ``fatal``. Default value: ``warn`` (when a terminal is available) or ``info`` (when a terminal is not available).

``-L LOGLOCATION``, ``--logfile LOGLOCATION``
   The location of the log file. This is recommended when starting any executable as a daemon. Default value: ``STDOUT``.

``--lockfile LOCATION``
   Use to specify the location of the lock file, which prevents multiple chef-client processes from converging at the same time.

``--[no-]color``
   View colored output. Default setting: ``--color``.

``-N NODE_NAME``, ``--node-name NODE_NAME``
   The name of the node.

``-o RUN_LIST_ITEM``, ``--override-runlist RUN_LIST_ITEM``
   Replace the current run-list with the specified items. This option will not clear the list of cookbooks (and related files) that is cached on the node.

``--once``
   Run the chef-client only once and cancel ``interval`` and ``splay`` options.

``-P PID_FILE``, ``--pid PID_FILE``
   The location in which a process identification number (pid) is saved. An executable, when started as a daemon, writes the pid to the specified file. Default value: ``/tmp/name-of-executable.pid``.

``-r RUN_LIST_ITEM``, ``--runlist RUN_LIST_ITEM``
   Permanently replace the current run-list with the specified run-list items.

``-R``, ``--enable-reporting``
   Enable Reporting, which performs data collection during a chef-client run.

``RECIPE_FILE``
   The path to a recipe. For example, if a recipe file is in the current directory, use ``recipe_file.rb``. This is typically used with the ``--local-mode`` option.

``--recipe-url=RECIPE_URL``
   Use to specify the location of a recipe when it exists at a URL. Use this option only when the chef-client is run with the ``--local-mode`` option.

``--run-lock-timeout SECONDS``
   The amount of time (in seconds) to wait for a chef-client lock file to be deleted. Default value: not set (indefinite). Set to ``0`` to cause a second chef-client to exit immediately.

``-s SECONDS``, ``--splay SECONDS``
   A random number between zero and ``splay`` that is added to ``interval``. Use splay to help balance the load on the Chef server by ensuring that many chef-client runs are not occuring at the same interval. When the chef-client is run at intervals, ``--splay`` and ``--interval`` values are applied before the chef-client run.

``-S CHEF_SERVER_URL``, ``--server CHEF_SERVER_URL``
   The URL for the Chef server.

``-u USER``, ``--user USER``
   The user that owns a process. This is required when starting any executable as a daemon.

``-v``, ``--version``
   The version of the chef-client.

``-W``, ``--why-run``
   Run the executable in why-run mode, which is a type of chef-client run that does everything except modify the system. Use why-run mode to understand why the chef-client makes the decisions that it makes and to learn more about the current and proposed state of the system.

``-z``, ``--local-mode``
   Run the chef-client in local mode. This allows all commands that work against the Chef server to also work against the local chef-repo.


Run in Local Mode
=====================================================
.. include:: ../../includes_chef_client/includes_chef_client_local_mode.rst

About chef-zero
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

Use following option to run the chef-client in audit-mode mode:

``--audit-mode MODE``
   Enable audit-mode. Set to ``audit-only`` to skip the converge phase of the chef-client run and only perform audits. Possible values: ``audit-only``, ``disabled``, and ``enabled``. Default value: ``disabled``.

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

Examples
=====================================================

**Run the chef-client**

.. code-block:: bash

   $ sudo chef-client

**Start a run when the chef-client is running as a daemon**

.. include:: ../../step_ctl_chef_client/step_ctl_chef_client_start_chef_run_daemon.rst

**Setting the initial run-list using a JSON file**

.. include:: ../../step_ctl_chef_client/step_ctl_chef_client_bootstrap_initial_run_list.rst
