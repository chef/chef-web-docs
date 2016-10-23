.. THIS PAGE DOCUMENTS chef-client version 11.4

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

``-c CONFIG``, ``--config CONFIG``
   The configuration file to use.

``-d``, ``--daemonize``
   Run the executable as a daemon.

   This option is only available on machines that run in UNIX or Linux environments. For machines that are running Microsoft Windows that require similar functionality, use the ``chef-client::service`` recipe in the ``chef-client`` cookbook: https://supermarket.chef.io/cookbooks/chef-client. This will install a chef-client service under Microsoft Windows using the Windows Service Wrapper.

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
   The frequency (in seconds) at which the chef-client runs. When the chef-client is run at intervals, ``--splay`` values are applied first, then the chef-client run occurs, and then ``--interval`` values are applied. Default value: ``1800``.

``-j PATH``, ``--json-attributes PATH``
   The path to a file that contains JSON data.

   .. include:: ../../includes_node/includes_node_ctl_run_list.rst

   .. warning:: .. include:: ../../includes_node/includes_node_ctl_attribute.rst

``-k KEY_FILE``, ``--client_key KEY_FILE``
   The location of the file that contains the client key. Default value: ``/etc/chef/client.pem``.

``-K KEY_FILE``, ``--validation_key KEY_FILE``
   The location of the file that contains the key used when a chef-client is registered with a Chef server. A validation key is signed using the ``validation_client_name`` for authentication. Default value: ``/etc/chef/validation.pem``.

``-l LEVEL``, ``--log-level LEVEL``
   The level of logging to be stored in a log file. Possible levels: ``:auto`` (default), ``debug``, ``info``, ``warn``, ``error``, or ``fatal``. Default value: ``warn`` (when a terminal is available) or ``info`` (when a terminal is not available).

``-L LOGLOCATION``, ``--logfile LOGLOCATION``
   The location of the log file. This is recommended when starting any executable as a daemon. Default value: ``STDOUT``.

``--[no-]color``
   View colored output. Default setting: ``--color``.

``-N NODE_NAME``, ``--node-name NODE_NAME``
   The name of the node.

``-o RUN_LIST_ITEM``, ``--override-runlist RUN_LIST_ITEM``
   Replace the current run-list with the specified items.

   .. note:: This option **will** clear the list of cookbooks (and related files) that is cached on the node. (Starting in chef-client 12.0, this option **will not** clear the list of cookbooks.)

``--once``
   Run the chef-client only once and cancel ``interval`` and ``splay`` options.

``-P PID_FILE``, ``--pid PID_FILE``
   The location in which a process identification number (pid) is saved. An executable, when started as a daemon, writes the pid to the specified file. Default value: ``/tmp/name-of-executable.pid``.

``-R``, ``--enable-reporting``
   Enable Reporting, which performs data collection during a chef-client run.

``-s SECONDS``, ``--splay SECONDS``
   A random number between zero and ``splay`` that is added to ``interval``. Use splay to help balance the load on the Chef server by ensuring that many chef-client runs are not occuring at the same interval. When the chef-client is run at intervals, ``--splay`` values are applied first, then the chef-client run occurs, and then ``--interval`` values are applied.

``-S CHEF_SERVER_URL``, ``--server CHEF_SERVER_URL``
   The URL for the Chef server.

``-u USER``, ``--user USER``
   The user that owns a process. This is required when starting any executable as a daemon.

``-v``, ``--version``
   The version of the chef-client.

``-W``, ``--why-run``
   Run the executable in why-run mode, which is a type of chef-client run that does everything except modify the system. Use why-run mode to understand why the chef-client makes the decisions that it makes and to learn more about the current and proposed state of the system.


Run with Elevated Privileges
=====================================================
.. include:: ../../includes_ctl_chef_client/includes_ctl_chef_client_elevated_privileges.rst

Linux
-----------------------------------------------------
.. include:: ../../includes_ctl_chef_client/includes_ctl_chef_client_elevated_privileges_linux.rst

Windows
-----------------------------------------------------
.. include:: ../../includes_ctl_chef_client/includes_ctl_chef_client_elevated_privileges_windows.rst

Examples
=====================================================

**Start a Chef run when the chef-client is running as a daemon**

.. include:: ../../step_ctl_chef_client/step_ctl_chef_client_start_chef_run_daemon.rst

**Start a Chef run manually**

.. include:: ../../step_ctl_chef_client/step_ctl_chef_client_start_chef_run_manual.rst
