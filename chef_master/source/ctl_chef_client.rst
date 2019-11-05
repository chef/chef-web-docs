=====================================================
Chef Infra Client (executable)
=====================================================
`[edit on GitHub] <https://github.com/chef/chef-web-docs/blob/master/chef_master/source/ctl_chef_client.rst>`__

.. tag chef_client_summary

Chef Infra Client is an agent that runs locally on every node that is under management by Chef Infra Server. When Chef Infra Client runs, performs all of the steps required for bringing a node into the expected state, including:

* Registering and authenticating the node with Chef Infra Server
* Building the node object
* Synchronizing cookbooks
* Compiling the resource collection by loading each of the required cookbooks, including recipes, attributes, and all other dependencies
* Taking the appropriate and required actions to configure the node
* Looking for exceptions and notifications, handling each as required

.. end_tag

.. note:: The Chef Infra Client executable can be run as a daemon.

The Chef Infra Client executable is run as a command-line tool.

.. note:: .. tag config_rb_client_summary

          The client.rb file specifies how Chef Infra Client is configured on a node and has the following characteristics:

          * This file is loaded every time the chef-client executable is run.
          * On Microsoft Windows machines, the default location for this file is ``C:\chef\client.rb``. On all other systems the default location for this file is ``/etc/chef/client.rb``.
          * Use the ``--config`` option from the command line to override the default location of the configuration file.
          * This file is not created by default

          .. end_tag

Options
=====================================================
This command has the following syntax:

.. code-block:: bash

   $ chef-client OPTION VALUE OPTION VALUE ...

This command has the following options:

``-A``, ``--fatal-windows-admin-check``
   Cause a Chef Infra Client run to fail when the Chef Infra Client does not have administrator privileges in Microsoft Windows.

``-c CONFIG``, ``--config CONFIG``
   The configuration file to use.

``--config-option OPTION``
   Overrides a single configuration option.  Can be used to override multiple configuration options by adding another ``--config-option OPTION``.

   .. code-block:: ruby

      property :db_password, String, sensitive: true

``--chef-zero-host HOST``
   The host on which chef-zero is started.

``--chef-zero-port PORT``
   The port on which chef-zero listens. If a port is not specified---individually, as range of ports, or from the ``chef_zero.port`` setting in the client.rb file---the Chef Infra Client will scan for ports between 8889-9999 and will pick the first port that is available.

   Changed in Chef Client 12.0 to support specifying a range of ports.

``-d SECONDS``, ``--daemonize SECONDS``
   Run the executable as a daemon. Use ``SECONDS`` to specify the number of seconds to wait before the first daemonized Chef Infra Client run. ``SECONDS`` is set to ``0`` by default.

   This option is only available on machines that run in UNIX or Linux environments. For machines that are running Microsoft Windows that require similar functionality, use the ``chef-client::service`` recipe in the ``chef-client`` cookbook: https://supermarket.chef.io/cookbooks/chef-client. This will install a Chef Infra Client service under Microsoft Windows using the Windows Service Wrapper.

``--delete-entire-chef-repo``
   This option deletes an entire repository.  This option may only be used when running the Chef Infra Client in local mode, (``--local-mode``).  This option requires ``--recipe-url`` to be specified.

``--disable-config``
   Use to run the Chef Infra Client using default settings. This will prevent the normally-associated configuration file from being used. This setting should only be used for testing purposes and should never be used in a production setting.

``-E ENVIRONMENT_NAME``, ``--environment ENVIRONMENT_NAME``
   The name of the environment.

``-f``, ``--[no-]fork``
   Contain Chef Infra Client runs in a secondary process with dedicated RAM. When a Chef Infra Client run is complete, the RAM is returned to the master process. This option helps ensure that a Chef Infra Client uses a steady amount of RAM over time because the master process does not run recipes. This option also helps prevent memory leaks such as those that can be introduced by the code contained within a poorly designed cookbook. Use ``--no-fork`` to disable running Chef Infra Client in fork node. Default value: ``--fork``.

   Changed in Chef Client 12.0, unforked interval runs are no longer allowed.

``-F FORMAT``, ``--format FORMAT``
   .. tag ctl_chef_client_options_format

   The output format: ``doc`` (default) or ``min``.

   * Use ``doc`` to print the progress of a Chef Infra Client run using full strings that display a summary of updates as they occur.
   * Use ``min`` to print the progress of a Chef Infra Client run using single characters.

   A summary of updates is printed at the end of a Chef Infra Client run. A dot (``.``) is printed for events that do not have meaningful status information, such as loading a file or synchronizing a cookbook. For resources, a dot (``.``) is printed when the resource is up to date, an ``S`` is printed when the resource is skipped by ``not_if`` or ``only_if``, and a ``U`` is printed when the resource is updated.

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
   The frequency (in seconds) at which Chef Infra Client runs. When running Chef Infra Client at intervals, apply ``--splay`` and ``--interval`` values before a Chef Infra Client run. Default value: ``1800``.

``-j PATH``, ``--json-attributes PATH``
   The path to a file that contains JSON data. Used to setup the first client run. For all the future runs with option -i the attributes are expected to be persisted in the chef-server.

   **Run-lists**

   .. tag node_ctl_run_list

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

   **Environments**


   Use this option to set the ``chef_environment`` value for a node.

   .. note:: Any environment specified for ``chef_environment`` by a JSON file will take precedence over an environment specified by the ``--environment`` option when both options are part of the same command.

   For example, run the following:

   .. code-block:: bash

      $ chef-client -j /path/to/file.json

   where ``/path/to/file.json`` is similar to:

   .. code-block:: javascript

      {
        "chef_environment": "pre-production"
      }

   This will set the environment for the node to ``pre-production``.



   **All attributes are normal attributes**

   .. tag node_ctl_attribute

   Any other attribute type that is contained in this JSON file will be treated as a ``normal`` attribute. Setting attributes at other precedence levels is not possible. For example, attempting to update ``override`` attributes using the ``-j`` option:

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

   .. note:: This has set the ``normal`` attribute ``node['override_attributes']['apptastic']``.

   **Specify a policy**


   Use this option to use policy files by specifying a JSON file that contains the following settings:

   .. list-table::
      :widths: 200 300
      :header-rows: 1

      * - Setting
        - Description
      * - ``policy_group``
        - The name of a policy group that exists on the Chef Infra Server.
      * - ``policy_name``
        - The name of a policy, as identified by the ``name`` setting in a Policyfile.rb file.

   For example:

   .. code-block:: javascript

      {
        "policy_name": "appserver",
        "policy_group": "staging"
      }



``-k KEY_FILE``, ``--client_key KEY_FILE``
   The location of the file that contains the client key. Default value: ``/etc/chef/client.pem``.

``-K KEY_FILE``, ``--validation_key KEY_FILE``
   The location of the file that contains the key used when a Chef Infra Client is registered with a Chef Infra Server. A validation key is signed using the ``validation_client_name`` for authentication. Default value: ``/etc/chef/validation.pem``.

``-l LEVEL``, ``--log_level LEVEL``
   The level of logging to be stored in a log file. Possible levels: ``auto`` (default), ``debug``, ``info``, ``warn``, ``error``, or ``fatal``. Default value: ``warn`` (when a terminal is available) or ``info`` (when a terminal is not available).

``-L LOGLOCATION``, ``--logfile LOGLOCATION``
   The location of the log file. This is recommended when starting any executable as a daemon. Default value: ``STDOUT``.

``--lockfile LOCATION``
   Use to specify the location of the lock file, which prevents multiple Chef Infra Client processes from converging at the same time.

``--minimal-ohai``
   Run the Ohai plugins for name detection and resource/provider selection and no other Ohai plugins. Set to ``true`` during integration testing to speed up test cycles.

``--[no-]color``
   View colored output. Default setting: ``--color``.

``--[no-]fips``
   Allows OpenSSL to enforce FIPS-validated security during a Chef Infra Client run.

``--[no-]skip-cookbook-sync``
   Use cached cookbooks without overwriting local differences from the server.
   Use with caution. Useful for patching a set of cookbooks on a machine when iterating during development.

``--[no-]listen``
   Run chef-zero in socketless mode. **This is the default behavior on Chef Client 13.1 and above.**

``-n NAME``, ``--named-run-list NAME``
   The run-list associated with a policy file.

``-N NODE_NAME``, ``--node-name NODE_NAME``
   The name of the node.

``-o RUN_LIST_ITEM``, ``--override-runlist RUN_LIST_ITEM``
   Replace the current run-list with the specified items. This option will not clear the list of cookbooks (and related files) that is cached on the node. This option will not persist node data at the end of the client run.

``--once``
   Make only one Chef Infra Client run and cancel ``interval`` and ``splay`` options.

``-P PID_FILE``, ``--pid PID_FILE``
   The location in which a process identification number (pid) is saved. An executable, when started as a daemon, writes the pid to the specified file. Default value: ``/tmp/name-of-executable.pid``.

``--profile-ruby``
   Use the ``--profile-ruby`` option to dump a (large) profiling graph into ``/var/chef/cache/graph_profile.out``. Use the graph output to help identify, and then resolve performance bottlenecks in a Chef Infra Client run. This option:

   * Generates a large amount of data about a Chef Infra Client run.
   * Has a dependency on the ``ruby-prof`` gem, which is packaged as part of Chef and ChefDK.
   * Increases the amount of time required to complete a Chef Infra Client run.
   * Should not be used in a production environment.

``-r RUN_LIST_ITEM``, ``--runlist RUN_LIST_ITEM``
   Permanently replace the current run-list with the specified run-list items.

``-R``, ``--enable-reporting``
   Enable Reporting, which performs data collection during a Chef Infra Client run.

``RECIPE_FILE``
   The path to a recipe. For example, if a recipe file is in the current directory, use ``recipe_file.rb``. This is typically used with the ``--local-mode`` option.

``--recipe-url=RECIPE_URL``
   The location of a recipe when it exists at a URL. Use this option only when running Chef Infra Client with the ``--local-mode`` option.

``--run-lock-timeout SECONDS``
   The amount of time (in seconds) to wait for a Chef Infra Client lock file to be deleted. Default value: not set (indefinite). Set to ``0`` to cause a second Chef Infra Client to exit immediately.

``-s SECONDS``, ``--splay SECONDS``
   A random number between zero and ``splay`` that is added to ``interval``. Use splay to help balance the load on the Chef Infra Server by ensuring that many Chef Infra Client runs are not occurring at the same interval. When running Chef Infra Client at intervals, apply ``--splay`` and ``--interval`` values before a Chef Infra Client run.

   Changed in Chef Client 12.0 to be applied before the Chef Client run.

``-S CHEF_SERVER_URL``, ``--server CHEF_SERVER_URL``
   The URL for the Chef Infra Server.

``-u USER``, ``--user USER``
   The user that owns a process. This is required when starting any executable as a daemon.

``-v``, ``--version``
   The Chef Infra Client version.

``-W``, ``--why-run``
   Run the executable in why-run mode, which is a type of Chef Infra Client run that does everything except modify the system. Use why-run mode to understand why the Chef Infra Client makes the decisions that it makes and to learn more about the current and proposed state of the system.

``-z``, ``--local-mode``
   Run the Chef Infra Client in local mode. This allows all commands that work against the Chef Infra Server to also work against the local chef-repo.

Chef Infra Client Lock File
-----------------------------------------------------
The Chef Infra Client uses a lock file to ensure that only one Chef Infra Client run is in progress at any time. A lock file is created at the start of a Chef Infra Client run and is deleted at the end of a Chef Infra Client run. A new Chef Infra Client run looks for the presence of a lock file and, if present, will wait for that lock file to be deleted. The location of the lock file can vary by platform.

* Use the ``lockfile`` setting in the client.rb file to specify non-default locations for the lock file. (The default location is typically platform-dependent and is recommended.)
* Use the ``run_lock_timeout`` setting in the client.rb file to specify the amount of time (in seconds) to wait for the lock file associated with an in-progress Chef Infra Client run to be deleted.

Run in Local Mode
=====================================================
Local mode is a way to run the Chef Infra Client against the chef-repo on a local machine as if it were running against the Chef Infra Server. Local mode relies on chef-zero, which acts as a very lightweight instance of the Chef Infra Server. chef-zero reads and writes to the ``chef_repo_path``, which allows all commands that normally work against the Chef Infra Server to be used against the local chef-repo.

Local mode does not require a configuration file, instead it will look for a directory named ``/cookbooks`` and will set ``chef_repo_path`` to be just above that. (Local mode will honor the settings in a configuration file, if desired.) If the client.rb file is not found and no configuration file is specified, local mode will search for a config.rb file.

Local mode will store temporary and cache files under the ``<chef_repo_path>/.cache`` directory by default. This allows a normal user to run the Chef Infra Client in local mode without requiring root access.

About why-run Mode
-----------------------------------------------------
why-run mode is a way to see what Chef Infra Client would have configured, had an actual Chef Infra Client run occurred. This approach is similar to the concept of "no-operation" (or "no-op"): decide what should be done, but then don't actually do anything until it's done right. This approach to configuration management can help identify where complexity exists in the system, where inter-dependencies may be located, and to verify that everything will be configured in the desired manner.

When why-run mode is enabled, a Chef Infra Client run will occur that does everything up to the point at which configuration would normally occur. This includes getting the configuration data, authenticating to the Chef Infra Server, rebuilding the node object, expanding the run-list, getting the necessary cookbook files, resetting node attributes, identifying the resources, and building the resource collection, but does not include mapping each resource to a provider or configuring any part of the system.

.. note:: why-run mode is not a replacement for running cookbooks in a test environment that mirrors the production environment. Chef uses why-run mode to learn more about what is going on, but also Kitchen on developer systems, along with an internal OpenStack cloud and external cloud providers to test more thoroughly.

When Chef Infra Client is run in why-run mode, certain assumptions are made:

* If the **service** resource cannot find the appropriate command to verify the status of a service, why-run mode will assume that the command would have been installed by a previous resource and that the service would not be running.
* For ``not_if`` and ``only_if`` properties, why-run mode will assume these are commands or blocks that are safe to run. These conditions are not designed to be used to change the state of the system, but rather to help facilitate idempotency for the resource itself. That said, it may be possible that these attributes are being used in a way that modifies the system state
* The closer the current state of the system is to the desired state, the more useful why-run mode will be. For example, if a full run-list is run against a fresh system, that run-list may not be completely correct on the first try, but also that run-list will produce more output than a smaller run-list

For example, the **service** resource can be used to start a service. If the action is ``:start``, then the service will start if it isn't running and do nothing if it is running. If a service is installed from a package, then Chef Infra Client cannot check to see if the service is running until after the package is installed. In that case, why-run mode will indicate what Chef Infra Client would do about the state of the service after installing a package. This is important because service actions often trigger notifications to other resources, so it is important to know that these notifications are triggered correctly.


About chef-zero
-----------------------------------------------------
chef-zero is a very lightweight Chef Infra Server that runs in-memory on the local machine. This allows the Chef Infra Client to be run against the chef-repo as if it were running against the Chef Infra Server. chef-zero was `originally a standalone tool <https://github.com/chef/chef-zero>`_; it is enabled from within the Chef Infra Client by using the ``--local-mode`` option. chef-zero is very useful for quickly testing and validating the behavior of the Chef Infra Client, cookbooks, recipes, and run-lists before uploading that data to the actual Chef Infra Server.

.. note:: chef-zero does not save data between restarts. Because it is intended to be used locally, chef-zero does not perform input validation, authentication, or authorization, as these security measures are not necessary for local testing. For these reasons, we strongly recommend against using chef-zero as a persistent Chef Infra Server.

Changed in Chef Client 12.8, now chef-zero supports all Chef Server API version 12 endpoints, except ``/universe``.

Use Encrypted Data Bags
-----------------------------------------------------
.. tag data_bag

Data bags store global variables as JSON data. Data bags are indexed for searching and can be loaded by a cookbook or accessed during a search.

.. end_tag

**Create an encrypted data bag for use with Chef Infra Client local mode**

.. tag knife_data_bag_from_file_create_encrypted_local_mode

To generate an encrypted data bag item in a JSON file for use when Chef Infra Client is run in local mode (via the ``--local-mode`` option), enter:

.. code-block:: bash

   $ knife data bag from file my_data_bag /path/to/data_bag_item.json -z --secret-file /path/to/encrypted_data_bag_secret

this will create an encrypted JSON file in::

   data_bags/my_data_bag/data_bag_item.json

.. end_tag

Run in FIPS Mode
=====================================================
.. tag fips_intro_client

Federal Information Processing Standards (FIPS) is a United States government computer security standard that specifies security requirements for cryptography. The current version of the standard is FIPS 140-2. Chef Infra Client can be configured to allow OpenSSL to enforce FIPS-validated security during a Chef Infra Client run. This will disable cryptography that is explicitly disallowed in FIPS-validated software, including certain ciphers and hashing algorithms. Any attempt to use any disallowed cryptography will cause Chef Infra Client to throw an exception during a Chef Infra Client run.

.. note:: Chef uses MD5 hashes to uniquely identify files that are stored on the Chef Infra Server. MD5 is used only to generate a unique hash identifier and is not used for any cryptographic purpose.

Notes about FIPS:

* May be enabled for nodes running on Microsoft Windows and Enterprise Linux platforms
* Should only be enabled for environments that require FIPS 140-2 compliance

.. end_tag

**Bootstrap a node using FIPS**

.. tag knife_bootstrap_node_fips

.. To bootstrap a node:

.. code-block:: bash

   $ knife bootstrap 192.0.2.0 -P vanilla -x root -r 'recipe[apt],recipe[xfs],recipe[vim]' --fips

which shows something similar to:

.. code-block:: none

   OpenSSL FIPS 140 mode enabled
   ...
   192.0.2.0 Chef Infra Client finished, 12/12 resources updated in 78.942455583 seconds

.. end_tag

Run as a Service
=====================================================
The Chef Infra Client can be run as a daemon. Use the **Chef Infra Client** cookbook to configure the Chef Infra Client as a daemon. Add the ``default`` recipe to a node's run-list, and then use attributes in that cookbook to configure the behavior of the Chef Infra Client. For more information about these configuration options, see the `Chef Infra Client cookbook repository on github <https://github.com/chef-cookbooks/chef-client/>`_.

When the Chef Infra Client is run as a daemon, the following signals may be used:

``HUP``
   Use to reconfigure the Chef Infra Client.

``INT``
   Use to terminate immediately without waiting for the current Chef Infra Client run to finish.

``QUIT``
   Use to dump a stack trace, and continue to run.

``TERM``
   Use to terminate but wait for the current Chef Infra Client run to finish, and then exit.

``USR1``
   Use to wake up sleeping Chef Infra Client and trigger node convergence.

On Microsoft Windows, both the ``HUP`` and ``QUIT`` signals are not supported.

Run with Elevated Privileges
=====================================================
.. tag ctl_chef_client_elevated_privileges

The Chef Infra Client may need to be run with elevated privileges in order to get a recipe to converge correctly. On UNIX and UNIX-like operating systems this can be done by running the command as root. On Microsoft Windows this can be done by running the command prompt as an administrator.

.. end_tag

Linux
-----------------------------------------------------
On Linux, the following error sometimes occurs when the permissions used to run the Chef Infra Client are incorrect:

.. code-block:: bash

   $ chef-client
   [Tue, 29 Nov 2015 19:46:17 -0800] INFO: *** Chef 12.X.X ***
   [Tue, 29 Nov 2015 19:46:18 -0800] WARN: Failed to read the private key /etc/chef/client.pem: #<Errno::EACCES: Permission denied - /etc/chef/client.pem>

This can be resolved by running the command as root. There are a few ways this can be done:

* Log in as root and then run the Chef Infra Client
* Use ``su`` to become the root user, and then run the Chef Infra Client. For example:

   .. code-block:: bash

      $ su

   and then:

   .. code-block:: bash

      # chef-client

* Use the sudo utility

   .. code-block:: bash

      $ sudo chef-client

* Give a user access to read ``/etc/chef`` and also the files accessed by the Chef Infra Client. This requires super user privileges and, as such, is not a recommended approach

Windows
-----------------------------------------------------
.. tag ctl_chef_client_elevated_privileges_windows

On Microsoft Windows, running without elevated privileges (when they are necessary) is an issue that fails silently. It will appear that Chef Infra Client completed its run successfully, but the changes will not have been made. When this occurs, do one of the following to run Chef Infra Client as the administrator:

* Log in to the administrator account. (This is not the same as an account in the administrator's security group.)

* Run Chef Infra Client process from the administrator account while being logged into another account. Run the following command:

  .. code-block:: bash

     $ runas /user:Administrator "cmd /C chef-client"

  This will prompt for the administrator account password.

* Open a command prompt by right-clicking on the command prompt application, and then selecting **Run as administrator**. After the command window opens, Chef Infra Client can be run as the administrator

.. end_tag

Run as Non-root User
=====================================================
In large, distributed organizations the ability to modify the configuration of systems is sometimes segmented across teams, often with varying levels of access to those systems. For example, core application services may be deployed to systems by a central server provisioning team, and then developers on different teams build tooling to support specific applications. In this situation, a developer only requires limited access to machines and only needs to perform the operations that are necessary to deploy tooling for a specific application.

The default configuration of the Chef Infra Client assumes that it is run as the root user. This affords the Chef Infra Client the greatest flexibility when managing the state of any object. However, the Chef Infra Client may be run as a non-root user---i.e. "run as a user with limited system privileges"---which can be useful when the objects on the system are available to other user accounts.

When the Chef Infra Client is run as a non-root user the Chef Infra Client can perform any action allowed to that user, as long as that action does not also require elevated privileges (such as sudo or pbrun). Attempts to manage any object that requires elevated privileges will result in an error. For example, when the Chef Infra Client is run as a non-root user that is unable to create or modify users, the **user** resource will not work.

Set the Cache Path
-----------------------------------------------------
To run a Chef Infra Client in non-root mode, add the ``cache_path`` setting to the client.rb file for the node that will run as the non-root user. Set the value of ``cache_path`` to be the home directory for the user that is running the Chef Infra Client. For example:

.. code-block:: ruby

   cache_path "~/.chef/cache"

or:

.. code-block:: ruby

   cache_path File.join(File.expand_path("~"), ".chef", "cache")

.. note:: When running the Chef Infra Client using the ``--local-mode`` option, ``~/.chef/local-mode-cache`` is the default value for ``cache_path``.

Elevate Commands
-----------------------------------------------------
Another example of running the Chef Infra Client as a non-root user involves using resources to pass sudo commands as as an attribute on the resource. For example, the **service** resource uses a series of ``_command`` attributes (like ``start_command``, ``stop_command``, and so on), the **package**-based resources use the ``options`` attribute, and the **script**-based resources use the ``code`` attribute.

A command can be elevated similar to the following:

.. code-block:: ruby

   service 'apache2' do
     start_command 'sudo /etc/init.d/apache2 start'
     action :start
   end

This approach can work very well on a case-by-case basis. The challenge with this approach is often around managing the size of the ``/etc/sudoers`` file.

Run on IBM AIX
=====================================================
The Chef Infra Client may now be used to configure nodes that are running on the AIX platform, versions 7.1 (TL5 SP2 or higher, recommended) and 7.2. The **service** resource supports starting, stopping, and restarting services that are managed by System Resource Controller (SRC), as well as managing all service states with BSD-based init systems.



**System Requirements**

The Chef Infra Client has the `same system requirements </chef_system_requirements.html#chef-infra-client>`_ on the AIX platform as any other platform, with the following notes:

* Expand the file system on the AIX platform using ``chfs`` or by passing the ``-X`` flag to ``installp`` to automatically expand the logical partition (LPAR)
* The EN_US (UTF-8) character set should be installed on the logical partition prior to installing the Chef Infra Client



**Install the Chef Infra Client on the AIX platform**

The Chef Infra Client is distributed as a Backup File Format (BFF) binary and is installed on the AIX platform using the following command run as a root user:

.. code-block:: text

   # installp -aYgd chef-12.0.0-1.powerpc.bff all



**Increase system process limits**

The out-of-the-box system process limits for maximum process memory size (RSS) and number of open files are typically too low to run the Chef Infra Client on a logical partition (LPAR). When the system process limits are too low, the Chef Infra Client will not be able to create threads. To increase the system process limits:

#. Validate that the system process limits have not already been increased.
#. If they have not been increased, run the following commands as a root user:

   .. code-block:: bash

      $ chsec -f /etc/security/limits -s default -a "rss=-1"

   and then:

   .. code-block:: bash

      $ chsec -f /etc/security/limits -s default -a "data=-1"

   and then:

   .. code-block:: bash

      $ chsec -f /etc/security/limits -s default -a "nofiles=50000"

   .. note:: The previous commands may be run against the root user, instead of default. For example:

      .. code-block:: bash

         $ chsec -f /etc/security/limits -s root_user -a "rss=-1"

#. Reboot the logical partition (LPAR) to apply the updated system process limits.

When the system process limits are too low, an error is returned similar to:

.. code-block:: none

   Error Syncing Cookbooks:
   ==================================================================

   Unexpected Error:
   -----------------
   ThreadError: can't create Thread: Resource temporarily unavailable



**Install the UTF-8 character set**

The Chef Infra Client uses the EN_US (UTF-8) character set. By default, the AIX base operating system does not include the EN_US (UTF-8) character set and it must be installed prior to installing the Chef Infra Client. The EN_US (UTF-8) character set may be installed from the first disc in the AIX media or may be copied from ``/installp/ppc/*EN_US*`` to a location on the logical partition (LPAR). This topic assumes this location to be ``/tmp/rte``.

Use ``smit`` to install the EN_US (UTF-8) character set. This ensures that any workload partitions (WPARs) also have UTF-8 applied.

Remember to point ``INPUT device/directory`` to ``/tmp/rte`` when not installing from CD.

#. From a root shell type:

   .. code-block:: text

      # smit lang

   A screen similar to the following is returned:

   .. code-block:: bash

      Manage Language Environment

      Move cursor to desired item and press Enter.

      Change/Show Primary Language Environment
      Add Additional Language Environments
      Remove Language Environments
      Change/Show Language Hierarchy
      Set User Languages
      Change/Show Applications for a Language
      Convert System Messages and Flat Files

      F1=Help             F2=Refresh          F3=Cancel           F8=Image
      F9=Shell            F10=Exit            Enter=Do

#. Select ``Add Additional Language Environments`` and press ``Enter``. A screen similar to the following is returned:

   .. code-block:: bash

                         Add Additional Language Environments

      Type or select values in entry fields.
      Press Enter AFTER making all desired changes.

                                                              [Entry Fields]
        CULTURAL convention to install                                             +
        LANGUAGE translation to install                                            +
      * INPUT device/directory for software                [/dev/cd0]              +
        EXTEND file systems if space needed?                yes                    +

        WPAR Management
            Perform Operation in Global Environment         yes                    +
            Perform Operation on Detached WPARs             no                     +
                Detached WPAR Names                        [_all_wpars]            +
            Remount Installation Device in WPARs            yes                    +
            Alternate WPAR Installation Device             []

      F1=Help             F2=Refresh          F3=Cancel           F4=List
      F5=Reset            F6=Command          F7=Edit             F8=Image
      F9=Shell            F10=Exit            Enter=Do

#. Cursor over the first two entries---``CULTURAL convention to install`` and ``LANGUAGE translation to install``---and use ``F4`` to navigate through the list until ``UTF-8 English (United States) [EN_US]`` is selected. (EN_US is in capital letters!)

#. Press ``Enter`` to apply and install the language set.



**Providers**

The **service** resource has the following providers to support the AIX platform:

.. list-table::
   :widths: 150 80 320
   :header-rows: 1

   * - Long name
     - Short name
     - Notes
   * - ``Chef::Provider::Service::Aix``
     - ``service``
     - The provider that is used with the AIX platforms. Use the ``service`` short name to start, stop, and restart services with System Resource Controller (SRC).
   * - ``Chef::Provider::Service::AixInit``
     - ``service``
     -  The provider that is used to manage BSD-based init services on AIX.



**Enable a service on AIX using the mkitab command**

.. tag resource_service_aix_mkitab

The **service** resource does not support using the ``:enable`` and ``:disable`` actions with resources that are managed using System Resource Controller (SRC). This is because System Resource Controller (SRC) does not have a standard mechanism for enabling and disabling services on system boot.

One approach for enabling or disabling services that are managed by System Resource Controller (SRC) is to use the **execute** resource to invoke ``mkitab``, and then use that command to enable or disable the service.

The following example shows how to install a service:

.. code-block:: ruby

   execute "install #{node['chef_client']['svc_name']} in SRC" do
     command "mkssys -s #{node['chef_client']['svc_name']}
                     -p #{node['chef_client']['bin']}
                     -u root
                     -S
                     -n 15
                     -f 9
                     -o #{node['chef_client']['log_dir']}/client.log
                     -e #{node['chef_client']['log_dir']}/client.log -a '
                     -i #{node['chef_client']['interval']}
                     -s #{node['chef_client']['splay']}'"
     not_if "lssrc -s #{node['chef_client']['svc_name']}"
     action :run
   end

and then enable it using the ``mkitab`` command:

.. code-block:: ruby

   execute "enable #{node['chef_client']['svc_name']}" do
     command "mkitab '#{node['chef_client']['svc_name']}:2:once:/usr/bin/startsrc
                     -s #{node['chef_client']['svc_name']} > /dev/console 2>&1'"
     not_if "lsitab #{node['chef_client']['svc_name']}"
   end

.. end_tag

Configuring a Proxy Server
=====================================================
See the `proxies </proxies.html>`__ documentation for information on how to configure Chef Infra Client to use a proxy server.

Examples
=====================================================

**Run the Chef Infra Client**

.. code-block:: bash

   $ sudo chef-client

**Start a run when the Chef Infra Client is running as a daemon**

A Chef Infra Client that is running as a daemon can be woken up and started by sending the process a ``SIGUSR1``. For example, to trigger a Chef Infra Client run on a machine running Linux:

.. code-block:: bash

   $ sudo killall -USR1 chef-client

**Setting the initial run-list using a JSON file**

.. tag ctl_chef_client_bootstrap_initial_run_list

A node's initial run-list is specified using a JSON file on the host system. When running Chef Infra Client as an executable, use the ``-j`` option to tell Chef Infra Client which JSON file to use. For example:

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

.. warning:: This approach may be used to update `normal </attributes.html#attribute-types>`__ attributes, but should never be used to update any other attribute type, as all attributes updated using this option are treated as ``normal`` attributes.

.. end_tag
