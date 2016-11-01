

=====================================================
chef-client (executable)
=====================================================

.. tag chef_client_26

A chef-client is an agent that runs locally on every node that is under management by Chef. When a chef-client is run, it will perform all of the steps that are required to bring the node into the expected state, including:

* Registering and authenticating the node with the Chef server
* Building the node object
* Synchronizing cookbooks
* Compiling the resource collection by loading each of the required cookbooks, including recipes, attributes, and all other dependencies
* Taking the appropriate and required actions to configure the node
* Looking for exceptions and notifications, handling each as required

.. end_tag

.. note:: The chef-client executable can be run as a daemon.

.. tag ctl_chef_client_25

The chef-client executable is run as a command-line tool.

.. end_tag

.. note:: .. tag config_rb_client_27

          A client.rb file is used to specify the configuration details for the chef-client.

          * This file is loaded every time this executable is run
          * On UNIX- and Linux-based machines, the default location for this file is ``/etc/chef/client.rb``; on Microsoft Windows machines, the default location for this file is ``C:\chef\client.rb``; use the ``--config`` option from the command line to change this location
          * This file is not created by default
          * When a client.rb file is present in the default location, the settings contained within that client.rb file will override the default configuration settings

          .. end_tag

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

``--chef-zero-port PORT``
   The port on which chef-zero listens.

``-F FORMAT``, ``--format FORMAT``
   .. tag ctl_chef_client_options_format

   The output format: ``doc`` (default) or ``min``.

   * Use ``doc`` to print the progress of the chef-client run using full strings that display a summary of updates as they occur.
   * Use ``min`` to print the progress of the chef-client run using single characters.

   A summary of updates is printed at the end of the chef-client run. A dot (``.``) is printed for events that do not have meaningful status information, such as loading a file or synchronizing a cookbook. For resources, a dot (``.``) is printed when the resource is up to date, an ``S`` is printed when the resource is skipped by ``not_if`` or ``only_if``, and a ``U`` is printed when the resource is updated.

   Other formatting options are available when those formatters are configured in the client.rb file using the ``add_formatter`` option.

   .. end_tag

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

   .. tag node_ctl_run_list

   .. This file documents specifc behavior related to the -j option in the chef-client, chef-solo, and chef-shell executables.

   Use this option to define a ``run_list`` object. For example, a JSON file similar to:

   .. code-block:: javascript

      "run_list": [
        "recipe[base]",
        "recipe[foo]",
        "recipe[bar]",
        "role[webserver]"
      ],

   may be used by running ``chef-client -j path/to/file.json``.

   In certain situations this option may be used to update ``normal`` attributes.

   .. end_tag

   .. warning:: .. tag node_ctl_attribute

                .. This file documents specifc behavior related to the -j option in the chef-client, chef-solo, and chef-shell executables.

                Any other attribute type that is contained in this JSON file will be treated as a ``normal`` attribute. For example, attempting to update ``override`` attributes using the ``-j`` option:

                .. code-block:: javascript

                   { 
                     "name": "dev-99",
                     "description": "Install some stuff",
                     "override_attributes": {
                       "apptastic": {
                         "enable_apptastic": "false",
                         "apptastic_tier_name": "dev-99.bomb.com"
                       }  
                     }  
                   }

                will result in a node object similar to:

                .. code-block:: javascript

                   { 
                     "name": "maybe-dev-99",
                     "normal": {
                     "name": "dev-99",
                       "description": "Install some stuff",
                       "override_attributes": {
                         "apptastic": {
                           "enable_apptastic": "false",
                           "apptastic_tier_name": "dev-99.bomb.com"
                         }  
                       }  
                     }
                   }

                .. end_tag

``-k KEY_FILE``, ``--client_key KEY_FILE``
   The location of the file that contains the client key. Default value: ``/etc/chef/client.pem``.

``-K KEY_FILE``, ``--validation_key KEY_FILE``
   The location of the file that contains the key used when a chef-client is registered with a Chef server. A validation key is signed using the ``validation_client_name`` for authentication. Default value: ``/etc/chef/validation.pem``.

``-l LEVEL``, ``--log_level LEVEL``
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

``RECIPE_FILE``
   The path to a recipe. For example, if a recipe file is in the current directory, use ``recipe_file.rb``. This is typically used with the ``--local-mode`` option.

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

``-z``, ``--local-mode``
   Run the chef-client in local mode. This allows all commands that work against the Chef server to also work against the local chef-repo.

Run in Local Mode
=====================================================
.. tag chef_client_local_mode

Local mode is a way to run the chef-client against the chef-repo on a local machine as if it were running against the Chef server. Local mode relies on chef-zero, which acts as a very lightweight instance of the Chef server. chef-zero reads and writes to the ``chef_repo_path``, which allows all commands that normally work against the Chef server to be used against the local chef-repo.

Local mode does not require a configuration file, instead it will look for a directory named ``/cookbooks`` and will set ``chef_repo_path`` to be just above that. (Local mode will honor the settings in a configuration file, if desired.) If the client.rb file is not found and no configuration file is specified, local mode will search for a knife.rb file.

Local mode will store temporary and cache files under the ``<chef_repo_path>/.cache`` directory by default. This allows a normal user to run the chef-client in local mode without requiring root access.

.. end_tag

About chef-zero
-----------------------------------------------------
.. tag chef_zero

chef-zero is a very lightweight Chef server that runs in-memory on the local machine. This allows the chef-client to be run against the chef-repo as if it were running against the Chef server. chef-zero was `originally a standalone tool <https://github.com/chef/chef-zero>`_; it is enabled from within the chef-client by using the ``--local-mode`` option. chef-zero is very useful for quickly testing and validating the behavior of the chef-client, cookbooks, recipes, and run-lists before uploading that data to the actual Chef server.

.. end_tag

Run with Elevated Privileges
=====================================================
.. tag ctl_chef_client_elevated_privileges

The chef-client may need to be run with elevated privileges in order to get a recipe to converge correctly. On UNIX and UNIX-like operating systems this can be done by running the command as root. On Microsoft Windows this can be done by running the command prompt as an administrator.

.. end_tag

Linux
-----------------------------------------------------
.. tag ctl_chef_client_elevated_privileges_linux

On Linux, the following error sometimes occurs when the permissions used to run the chef-client are incorrect:

.. code-block:: bash

   $ chef-client
   [Tue, 29 Nov 2015 19:46:17 -0800] INFO: *** Chef 12.X.X ***
   [Tue, 29 Nov 2015 19:46:18 -0800] WARN: Failed to read the private key /etc/chef/client.pem: #<Errno::EACCES: Permission denied - /etc/chef/client.pem>

This can be resolved by running the command as root. There are a few ways this can be done:

* Log in as root and then run the chef-client
* Use ``su`` to become the root user, and then run the chef-client. For example:

   .. code-block:: bash

      $ su

   and then:

   .. code-block:: bash

      $ chef-client

* Use the sudo utility

   .. code-block:: bash

      $ sudo chef-client

* Give a user access to read ``/etc/chef`` and also the files accessed by the chef-client. This requires super user privileges and, as such, is not a recommended approach

.. end_tag

Windows
-----------------------------------------------------
.. tag ctl_chef_client_elevated_privileges_windows

On Microsoft Windows, running without elevated privileges (when they are necessary) is an issue that fails silently. It will appear that the chef-client completed its run successfully, but the changes will not have been made. When this occurs, do one of the following to run the chef-client as the administrator:

* Log in to the administrator account. (This is not the same as an account in the administrator's security group.)

* Run the chef-client process from the administrator account while being logged into another account. Run the following command:

   .. code-block:: bash

      $ runas /user:Administrator "cmd /C chef-client"

   This will prompt for the administrator account password.

* Open a command prompt by right-clicking on the command prompt application, and then selecting **Run as administrator**. After the command window opens, the chef-client can be run as the administrator

.. end_tag

Run as Non-root User
=====================================================
.. tag ctl_chef_client_non_root

In large, distributed organizations the ability to modify the configuration of systems is sometimes segmented across teams, often with varying levels of access to those systems. For example, core application services may be deployed to systems by a central server provisioning team, and then developers on different teams build tooling to support specific applications. In this situation, a developer only requires limited access to machines and only needs to perform the operations that are necessary to deploy tooling for a specific application.

The default configuration of the chef-client assumes that it is run as the root user. This affords the chef-client the greatest flexibility when managing the state of any object. However, the chef-client may be run as a non-root user---i.e. "run as a user with limited system privileges"---which can be useful when the objects on the system are available to other user accounts.

When the chef-client is run as a non-root user the chef-client can perform any action allowed to that user, as long as that action does not also require elevated privileges (such as sudo or pbrun). Attempts to manage any object that requires elevated privileges will result in an error. For example, when the chef-client is run as a non-root user that is unable to create or modify users, the **user** resource will not work.

.. end_tag

Set the Cache Path
-----------------------------------------------------
.. tag ctl_chef_client_non_root_set_cache_path

To run a chef-client in non-root mode, add the ``cache_path`` setting to the client.rb file for the node that will run as the non-root user. Set the value of ``cache_path`` to be the home directory for the user that is running the chef-client. For example:

.. code-block:: ruby

   cache_path "~/.chef/cache"

or:

.. code-block:: ruby

   cache_path File.join(File.expand_path("~"), ".chef", "cache")

.. note:: When running the chef-client using the ``--local-mode`` option, ``~/.chef/local-mode-cache`` is the default value for ``cache_path``.

.. end_tag

Elevate Commands
-----------------------------------------------------
.. tag ctl_chef_client_non_root_use_attributes

Another example of running the chef-client as a non-root user involves using resources to pass sudo commands as as an attribute on the resource. For example, the **service** resource uses a series of ``_command`` attributes (like ``start_command``, ``stop_command``, and so on), the **package**-based resources use the ``options`` attribute, and the **script**-based resources use the ``code`` attribute.

A command can be elevated similar to the following:

.. code-block:: ruby

   service 'apache2' do
     start_command 'sudo /etc/init.d/apache2 start'
     action :start
   end

This approach can work very well on a case-by-case basis. The challenge with this approach is often around managing the size of the ``/etc/sudoers`` file.

.. end_tag

Examples
=====================================================

**Run the chef-client**

.. code-block:: bash

   $ sudo chef-client

**Start a run when the chef-client is running as a daemon**

.. tag ctl_chef_client_start_chef_run_daemon

A chef-client that is running as a daemon can be woken up and started by sending the process a ``SIGUSR1``. For example, to trigger a chef-client run on a machine running Linux:

.. code-block:: bash

   $ sudo killall -USR1 chef-client

.. end_tag

**Setting the initial run-list using a JSON file**

.. tag ctl_chef_client_bootstrap_initial_run_list

A node's initial run-list is specified using a JSON file on the host system. When running the chef-client as an executable, use the ``-j`` option to tell the chef-client which JSON file to use. For example:

.. code-block:: bash

   $ chef-client -j /etc/chef/file.json --environment _default

where ``file.json`` is similar to:

.. code-block:: javascript

   {
     "resolver": {
       "nameservers": [ "10.0.0.1" ],
       "search":"int.example.com"
     },
     "run_list": [ "recipe[resolver]" ]
   }

and where ``_default`` is the name of the environment that is assigned to the node.

.. warning:: This approach may be used to update ``normal`` attributes, but should never be used to update any other attribute type, as all attributes updated using this option are treated as ``normal`` attributes.

.. end_tag

