=====================================================
kitchen (executable)
=====================================================
`[edit on GitHub] <https://github.com/chef/chef-web-docs/blob/master/chef_master/source/ctl_kitchen.rst>`__

.. tag ctl_kitchen_summary

kitchen is the command-line tool for Kitchen, an integration testing tool used by the chef-client. Kitchen runs tests against any combination of platforms using any combination of test suites. Each test, however, is done against a specific instance, which is comprised of a single platform and a single set of testing criteria. This allows each test to be run in isolation, ensuring that different behaviors within the same codebase can be tested thoroughly before those changes are committed to production.

.. note:: Any Kitchen subcommand that does not specify an instance will be applied to all instances.

.. end_tag

.. note:: This topic details functionality that is packaged with Chef development kit. See http://kitchen.ci/docs/getting-started/ for more information about Kitchen.

Fuzzy Matching
=====================================================
Fuzzy matching can be used with all commands because kitchen uses regular expressions to search. For example, a fully qualified name:

.. code-block:: bash

   $ kitchen list default-ubuntu-1404 --bare

will return something similar to:

.. code-block:: bash

   client-ubuntu-1404

A partial name:

.. code-block:: bash

   $ kitchen list ubuntu --bare

will return something similar to:

.. code-block:: bash

   client-ubuntu-1404
   server-ubuntu-1404

A short string:

.. code-block:: bash

   $ kitchen list ub --bare

will return something similar to:

.. code-block:: bash

   client-ubuntu-1404
   server-ubuntu-1404

An integer:

.. code-block:: bash

   $ kitchen list 4 --bare

will return something similar to:

.. code-block:: bash

   client-ubuntu-1404
   server-ubuntu-1404

A single-quoted Ruby regular expression:

.. code-block:: bash

   $ kitchen list '^cli.*-65$' --bare

will return something similar to:

.. code-block:: bash

   client-centos-65

kitchen converge
=====================================================
Use the ``converge`` subcommand to converge one (or more) instances. Instances are based on the list of platforms in the .kitchen.yml file. This process will install the chef-client on an instance using the omnibus installer, upload cookbook files and minimal configuration to the instance, and then start a chef-client run using the run-list and attributes specified in the .kitchen.yml file.

Kitchen will skip unnecessary steps. For example, if the chef-client is already installed to the instance, Kitchen will not re-install the chef-client. That said, Kitchen will always upload the cookbook files and minimal configuration. This ensures that cookbook testing is being done correctly.

The following exit codes are used by Kitchen:

* ``0`` means the operation was successful
* Any non-zero value means at least one part of the operation was unsuccessful

In general, use the ``test`` subcommand to verify the end-to-end quality of a cookbook. Use the ``converge`` and ``verify`` subcommands during the normal the day-to-day development of a cookbook.

Syntax
-----------------------------------------------------
This subcommand has the following syntax:

.. code-block:: bash

   $ kitchen converge PLATFORMS (options)

Options
-----------------------------------------------------
This subcommand has the following options:

``-c``, ``--concurrency``
   The number of allowed concurrent connections. Default: ``9999`` (all instances, effectively).

``-l``, ``--log-level``
   The level of logging to be stored in a log file. Options (in order of priority): ``:debug``, ``:info``, ``:warn``, ``:error``, and ``:fatal``. Default: ``info``.

``PLATFORMS``
   Run Kitchen against one or more platforms listed in the .kitchen.yml file. Use ``all`` to run Kitchen against all platforms. Use a Ruby regular expression to glob two or more platforms into a single run.

   .. tag ctl_kitchen_common_option_platforms

   For example, if a .kitchen.yml file contains the following:

   .. code-block:: javascript

       - name: centos-5.10
       - name: centos-6.5
       - name: fedora-19
       - name: ubuntu-1004
       - name: ubuntu-1204
       - name: ubuntu-1310

   then a regular expression like ``(04|5)`` would run Kitchen against ``centos-5.10``, ``centos-6.5``, ``ubuntu-1004``, and ``ubuntu-1204``. A regular expression like ``(ubuntu)`` would run Kitchen against ``ubuntu-1004``, ``ubuntu-1204``, and ``ubuntu-1310``. A regular expression like ``(fedora-19)`` would run Kitchen against only ``fedora-19``. Default: ``all``.

   .. end_tag

Examples
-----------------------------------------------------

**Converge the default CentOS instance**

To converge the default CentOS instance, run the following:

.. code-block:: bash

   $ kitchen converge default-centos-71

The chef-client is downloaded the first time this command is run. The output of the command is similar to:

.. code-block:: bash

   -----> Starting Kitchen (v1.4.2)
   -----> Converging <default-centos-71>...
          Preparing files for transfer
          Preparing cookbooks from project directory
          Removing non-cookbook files before transfer
          Preparing nodes
   -----> Installing Chef Omnibus (true)
          downloading https://www.chef.io/chef/install.sh
            to file /tmp/install.sh
          ...
          Downloading Chef ...
          Installing Chef ...
          Thank you for installing Chef!
          Transferring files to <default-centos-71>
          [2014-06-27T18:41:04+00:00] INFO: Forking chef instance to converge...
          Starting Chef Client, version 12.4.1
          [2014-06-27T18:45:18+00:00] INFO: *** Chef 12.4.1 ***
          [2014-06-27T18:45:18+00:00] INFO: Chef-client pid: 3226
          [2014-06-27T18:45:25+00:00] INFO: Setting the run_list to ["recipe[chef-repo::default]"] from CLI options
          [2014-06-27T18:45:25+00:00] INFO: Run List is [recipe[chef-repo::default]]
          [2014-06-27T18:45:25+00:00] INFO: Run List expands to [chef-repo::default]
          [2014-06-27T18:45:25+00:00] INFO: Starting Chef Run for default-centos-71
          [2014-06-27T18:45:25+00:00] INFO: Running start handlers
          [2014-06-27T18:42:40+00:00] INFO: Start handlers complete.
          Compiling Cookbooks...
          Converging 1 resources
          Recipe: chef-repo::default
            * file[/root/test.txt] action create... INFO: Processing file[/root/test.txt]
              action create (chef-repo::default line 10)
          [2014-06-27T18:42:40+00:00] INFO: file[/root/test.txt] created file /root/test.txt
            - create new file /root/test.txt... INFO: file[/root/test.txt] updated file contents /root/test.txt
            - update content in file /root/test.txt from none to d9c88f
          --- /root/test.txt	2014-06-27 18:42:40.695889276 +0000
          +++ /tmp/.test.txt20140627-2810-1xdx98p	2014-06-27 18:42:40.695889276 +0000
          @@ -1 +1,2 @@
          +This file created by Chef!
            - restore selinux security context
          [2014-06-27T18:42:40+00:00] INFO: Chef Run complete in 0.168252291 seconds
          Running handlers:
          [2014-06-27T18:42:40+00:00] INFO: Running report handlers
          Running handlers complete
          [2014-06-27T18:42:40+00:00] INFO: Report handlers complete
          Chef Client finished, 1/1 resources updated in 7.152725504 seconds
          Finished converging <default-centos-71> (0m8.43s).
   -----> Kitchen is finished. (0m15.96s)

**Converge the default Ubuntu instance**

To converge the default Ubuntu instance, run the following:

.. code-block:: bash

   $ kitchen converge default-ubuntu-1404

The chef-client is downloaded the first time this command is run. The output of the command is similar to:

.. code-block:: bash

   -----> Starting Kitchen (v1.4.2)
   -----> Converging <default-ubuntu-1404>...
          Preparing files for transfer
          Preparing cookbooks from project directory
          Removing non-cookbook files before transfer
          Preparing nodes
   -----> Installing Chef Omnibus (true)
          downloading https://www.chef.io/chef/install.sh
            to file /tmp/install.sh
          ...
          Downloading Chef ...
          Installing Chef ...
          Thank you for installing Chef!
          Transferring files to <default-ubuntu-1404>
          [2014-06-27T18:48:01+00:00] INFO: Forking chef instance to converge...
          Starting Chef Client, version 12.4.1
          [2014-06-27T18:48:01+00:00] INFO: *** Chef 12.4.1 ***
          [2014-06-27T18:48:01+00:00] INFO: Chef-client pid: 1246
          [2014-06-27T18:48:03+00:00] INFO: Setting the run_list to ["recipe[chef-repo::default]"] from CLI options
          [2014-06-27T18:48:03+00:00] INFO: Run List is [recipe[chef-repo::default]]
          [2014-06-27T18:48:03+00:00] INFO: Run List expands to [chef-repo::default]
          [2014-06-27T18:48:03+00:00] INFO: Starting Chef Run for default-ubuntu-1404
          [2014-06-27T18:48:03+00:00] INFO: Running start handlers
          [2014-06-27T18:48:03+00:00] INFO: Start handlers complete.
          Compiling Cookbooks...
          Converging 1 resources
          Recipe: chef-repo::default
            * file[/home/vagrant/test.txt] action create... INFO: Processing file[/home/vagrant/test.txt]
              action create (chef-repo::default line 10)
          [2014-06-27T18:48:03+00:00] INFO: file[/home/vagrant/test.txt] created file /home/vagrant/test.txt
            - create new file /home/vagrant/test.txt... INFO: file[/home/vagrant/test.txt] updated file contents /home/vagrant/test.txt
            - update content in file /home/vagrant/test.txt from none to d9c88f
          --- /home/vagrant/test.txt	2014-06-27 18:48:03.233096345 +0000
           +++ /tmp/.test.txt20140627-1246-178u9dg	2014-06-27 18:48:03.233096345 +0000
          @@ -1 +1,2 @@
          +This file created by Chef!
          [2014-06-27T18:48:03+00:00] INFO: Chef Run complete in 0.015439954 seconds
          Running handlers:
          [2014-06-27T18:48:03+00:00] INFO: Running report handlers
          Running handlers complete
          [2014-06-27T18:48:03+00:00] INFO: Report handlers complete
          Chef Client finished, 1/1 resources updated in 1.955915841 seconds
          Finished converging <default-ubuntu-1404> (0m15.67s).
   -----> Kitchen is finished. (0m15.96s)

kitchen create
=====================================================
Use the ``create`` subcommand to create one (or more) instances. Instances are based on the list of platforms and suites in the .kitchen.yml file.

Syntax
-----------------------------------------------------
This subcommand has the following syntax:

.. code-block:: bash

   $ kitchen create PLATFORMS (options)

Options
-----------------------------------------------------
This subcommand has the following options:

``-c``, ``--concurrency``
   The number of allowed concurrent connections. Default: ``9999`` (all instances, effectively).

``-l``, ``--log-level``
   The level of logging to be stored in a log file. Options (in order of priority): ``:debug``, ``:info``, ``:warn``, ``:error``, and ``:fatal``. Default: ``info``.

``PLATFORMS``
   Run Kitchen against one or more platforms listed in the .kitchen.yml file. Use ``all`` to run Kitchen against all platforms. Use a Ruby regular expression to glob two or more platforms into a single run.

   .. tag ctl_kitchen_common_option_platforms

   For example, if a .kitchen.yml file contains the following:

   .. code-block:: javascript

       - name: centos-5.10
       - name: centos-6.5
       - name: fedora-19
       - name: ubuntu-1004
       - name: ubuntu-1204
       - name: ubuntu-1310

   then a regular expression like ``(04|5)`` would run Kitchen against ``centos-5.10``, ``centos-6.5``, ``ubuntu-1004``, and ``ubuntu-1204``. A regular expression like ``(ubuntu)`` would run Kitchen against ``ubuntu-1004``, ``ubuntu-1204``, and ``ubuntu-1310``. A regular expression like ``(fedora-19)`` would run Kitchen against only ``fedora-19``. Default: ``all``.

   .. end_tag

Examples
-----------------------------------------------------

**Create the default CentOS instance**

To create the default CentOS instance, run the following:

.. code-block:: bash

   $ kitchen create default-centos-71

CentOS is downloaded the first time this command is run, after which Vagrant is started. (This may take a few minutes.)

The output of the command is similar to:

.. code-block:: bash

   -----> Starting Kitchen (v1.4.2)
   -----> Creating <default-centos-71>...
          Bringing machine 'default' up with 'virtualbox' provider...
          ==> default: Box 'opscode-centos-6.5' could not be found. Attempting to find and install...
              default: Box Provider: virtualbox
              default: Box Version: >= 0
          ==> default: Adding box 'opscode-centos-6.5' (v0) for provider: virtualbox
              default: Downloading: https://opscode-vm-bento.s3.amazonaws.com/vagrant/virtualbox/opscode_centos-6.5_chef-provisionerless.box
          ==> default: Successfully added box 'opscode-centos-6.5' (v0) for 'virtualbox'!
          ==> default: Importing base box 'opscode-centos-6.5'...
          ==> default: Matching MAC address for NAT networking...
          ==> default: Setting the name of the VM: default-centos-71_default_1403650129063_53517
          ==> default: Clearing any previously set network interfaces...
          ==> default: Preparing network interfaces based on configuration...
              default: Adapter 1: nat
          ==> default: Forwarding ports...
              default: 22 => 2222 (adapter 1)
          ==> default: Booting VM...
          ==> default: Waiting for machine to boot. This may take a few minutes...
              default: SSH address: 127.0.0.1:2222
              default: SSH username: vagrant
              default: SSH auth method: private key
              default: Warning: Connection timeout. Retrying...
          ==> default: Machine booted and ready!
          ==> default: Checking for guest additions in VM...
          ==> default: Setting hostname...
          ==> default: Machine not provisioning because `--no-provision` is specified.
          Vagrant instance <default-centos-71> created.
          Finished creating <default-centos-71> (4m0.59s).
   -----> Kitchen is finished. (11m29.76s)

**Create the default Ubuntu instance**

To create the default Ubuntu instance, run the following:

.. code-block:: bash

   $ kitchen create default-ubuntu-1404

Ubuntu is downloaded the first time this command is run, after which Vagrant is started. (This may take a few minutes.)

The output of the command is similar to:

.. code-block:: bash

   -----> Starting Kitchen (v1.4.2)
   -----> Creating <default-ubuntu-1404>...
          Bringing machine 'default' up with 'virtualbox' provider...
          ==> default: Box 'opscode-ubuntu-12.04' could not be found. Attempting to find and install...
              default: Box Provider: virtualbox
              default: Box Version: >= 0
          ==> default: Adding box 'opscode-ubuntu-12.04' (v0) for provider: virtualbox
              default: Downloading: https://opscode-vm-bento.s3.amazonaws.com/vagrant/virtualbox/opscode_ubuntu-12.04_chef-provisionerless.box
          ==> default: Successfully added box 'opscode-ubuntu-12.04' (v0) for 'virtualbox'!
          ==> default: Importing base box 'opscode-ubuntu-12.04'...
          ==> default: Matching MAC address for NAT networking...
          ==> default: Setting the name of the VM: default-ubuntu-1404_default_1403651715173_54200
          ==> default: Fixed port collision for 22 => 2222. Now on port 2200.
          ==> default: Clearing any previously set network interfaces...
          ==> default: Preparing network interfaces based on configuration...
              default: Adapter 1: nat
          ==> default: Forwarding ports...
              default: 22 => 2200 (adapter 1)
          ==> default: Booting VM...
   ==> default: Waiting for machine to boot. This may take a few minutes...
              default: SSH username: vagrant
              default: SSH auth method: private key
              default: Warning: Connection timeout. Retrying...
          ==> default: Machine booted and ready!
          ==> default: Checking for guest additions in VM...
          ==> default: Setting hostname...
          ==> default: Machine not provisioning because `--no-provision` is specified.
          Vagrant instance <default-ubuntu-1404> created.
          Finished creating <default-ubuntu-1404> (4m1.59s).
   -----> Kitchen is finished. (10m58.24s)

kitchen destroy
=====================================================
Use the ``destroy`` subcommand to delete one (or more) instances. Instances are based on the list of platforms and suites in the .kitchen.yml file.

Syntax
-----------------------------------------------------
This subcommand has the following syntax:

.. code-block:: bash

   $ kitchen destroy PLATFORMS (options)

Options
-----------------------------------------------------
This subcommand has the following options:

``-c``, ``--concurrency``
   The number of allowed concurrent connections. Default: ``9999`` (all instances, effectively).

``-l``, ``--log-level``
   The level of logging to be stored in a log file. Options (in order of priority): ``:debug``, ``:info``, ``:warn``, ``:error``, and ``:fatal``. Default: ``info``.

``PLATFORMS``
   Run Kitchen against one or more platforms listed in the .kitchen.yml file. Use ``all`` to run Kitchen against all platforms. Use a Ruby regular expression to glob two or more platforms into a single run.

   .. tag ctl_kitchen_common_option_platforms

   For example, if a .kitchen.yml file contains the following:

   .. code-block:: javascript

       - name: centos-5.10
       - name: centos-6.5
       - name: fedora-19
       - name: ubuntu-1004
       - name: ubuntu-1204
       - name: ubuntu-1310

   then a regular expression like ``(04|5)`` would run Kitchen against ``centos-5.10``, ``centos-6.5``, ``ubuntu-1004``, and ``ubuntu-1204``. A regular expression like ``(ubuntu)`` would run Kitchen against ``ubuntu-1004``, ``ubuntu-1204``, and ``ubuntu-1310``. A regular expression like ``(fedora-19)`` would run Kitchen against only ``fedora-19``. Default: ``all``.

   .. end_tag

Examples
-----------------------------------------------------
None.

kitchen diagnose
=====================================================
Use the ``diagnose`` subcommand to show a computed diagnostic configuration for one (or more) instances. This subcommand will make all implicit configuration settings explicit because it echoes back all of the configuration data as YAML.

Syntax
-----------------------------------------------------
This subcommand has the following syntax:

.. code-block:: bash

   $ kitchen diagnose PLATFORMS (options)

Options
-----------------------------------------------------
This subcommand has the following options:

``--all``
   Include all diagnostics. Default: ``false``.

``--instances``
   Include instance diagnostics. Default: ``true``.

``-l``, ``--log-level``
   The level of logging to be stored in a log file. Options (in order of priority): ``:debug``, ``:info``, ``:warn``, ``:error``, and ``:fatal``. Default: ``info``.

``--loader``
   Include data loader diagnostics. Default: ``false``.

``PLATFORMS``
   Run Kitchen against one or more platforms listed in the .kitchen.yml file. Use ``all`` to run Kitchen against all platforms. Use a Ruby regular expression to glob two or more platforms into a single run.

   .. tag ctl_kitchen_common_option_platforms

   For example, if a .kitchen.yml file contains the following:

   .. code-block:: javascript

       - name: centos-5.10
       - name: centos-6.5
       - name: fedora-19
       - name: ubuntu-1004
       - name: ubuntu-1204
       - name: ubuntu-1310

   then a regular expression like ``(04|5)`` would run Kitchen against ``centos-5.10``, ``centos-6.5``, ``ubuntu-1004``, and ``ubuntu-1204``. A regular expression like ``(ubuntu)`` would run Kitchen against ``ubuntu-1004``, ``ubuntu-1204``, and ``ubuntu-1310``. A regular expression like ``(fedora-19)`` would run Kitchen against only ``fedora-19``. Default: ``all``.

   .. end_tag

Examples
-----------------------------------------------------

**Diagnose an instance**

Use the ``--loader`` option to include diagnostic data in the output:

.. code-block:: yaml

   ---
   loader:
     combined_config:
       filename:
       raw_data:
         driver:
           name: vagrant
           socket: tcp://192.0.2.0:1234
       provisioner:
        #...

or:

.. code-block:: yaml

   ---
   loader:
     global_config:
       filename: "/Users/username/.kitchen/config.yml"
       raw_data: #...
     project_config:
       filename: "/Users/username/Projects/sandbox/path/to/kitchen.yml"
       raw_data: #...
     local_config:

**Diagnose an instance using --instances option**

Use the ``--instances`` option to track instances, which are based on the list of platforms and suites in the .kitchen.yml file:

.. code-block:: yaml

   ---
   instances
     default-ubuntu-1204
       busser:
         root_path: /tmp/busser
         ruby_bindir: /opt/chef/embedded/bin
         sudo: true

**Diagnose an instance using --loader option**

This command returns data as YAML:

.. code-block:: yaml

   ---
   timestamp: 2014-04-15 18:59:58.460470000 Z
   kitchen-version: 1.2.2.dev
   instances:
     default-ubuntu-1404
       # ...
     default-centos-65
       # ...

When Kitchen is being used to test cookbooks, Kitchen will track state data:

.. code-block:: yaml

   ---
   instances:
     default-ubuntu-1404
       state_file:
         hostname: 192.0.2.0
         last_action: create
         port: '22'
         ssh_key: "/Users/username/path/to/key"
         username: vagrant
     default-centos-65
       # ...

and will track information that was given to a driver:

.. code-block:: yaml

   ---
   instances:
     default-ubuntu-1404
       driver:
         box: opscode-ubuntu-12.04
         box_url: https://URL/path/to/filename.box
         kitchen_root: "/Users/username/Projects/sandbox/"

and will track information about provisioners:

.. code-block:: yaml

   ---
   instances:
     default-ubuntu-1404
       provisioner:
         attributes: {}
         chef_omnibus_url: https://www.chef.io/chef/install.sh
         clients_path:
         name: chef_zero

kitchen driver create
=====================================================
Use the ``driver create`` subcommand to create a new Kitchen driver in the RubyGems project.

Syntax
-----------------------------------------------------
This subcommand has the following syntax:

.. code-block:: bash

   $ kitchen driver create NAME

Options
-----------------------------------------------------
This subcommand has the following options:

``-l``, ``--license``
   The license for the RubyGems file. Possible values: ``apachev2``, ``lgplv3``, ``mit``, and ``reserved``. Default: ``apachev2``.

Examples
-----------------------------------------------------
None.

kitchen driver discover
=====================================================
Use the ``driver discover`` subcommand to discover Kitchen driver that have been published to RubyGems. This subcommand will return all RubyGems that are match ``kitchen-*``.

Syntax
-----------------------------------------------------
This subcommand has the following syntax:

.. code-block:: bash

   $ kitchen driver discover

Options
-----------------------------------------------------
This subcommand does not have any options.

Examples
-----------------------------------------------------
None.

kitchen exec
=====================================================
Use the ``exec`` subcommand to execute a command on a remote instance.

Syntax
-----------------------------------------------------
This subcommand has the following syntax:

.. code-block:: bash

   $ kitchen exec PLATFORMS (options)

Options
-----------------------------------------------------
This subcommand has the following options:

``-c REMOTE_COMMAND``
   Use to specify a remote command to be run via SSH.

``PLATFORMS``
   Run Kitchen against one or more platforms listed in the .kitchen.yml file. Use ``all`` to run Kitchen against all platforms. Use a Ruby regular expression to glob two or more platforms into a single run.

   .. tag ctl_kitchen_common_option_platforms

   For example, if a .kitchen.yml file contains the following:

   .. code-block:: javascript

       - name: centos-5.10
       - name: centos-6.5
       - name: fedora-19
       - name: ubuntu-1004
       - name: ubuntu-1204
       - name: ubuntu-1310

   then a regular expression like ``(04|5)`` would run Kitchen against ``centos-5.10``, ``centos-6.5``, ``ubuntu-1004``, and ``ubuntu-1204``. A regular expression like ``(ubuntu)`` would run Kitchen against ``ubuntu-1004``, ``ubuntu-1204``, and ``ubuntu-1310``. A regular expression like ``(fedora-19)`` would run Kitchen against only ``fedora-19``. Default: ``all``.

   .. end_tag

Examples
-----------------------------------------------------
None.

kitchen init
=====================================================
Use the ``init`` subcommand to create an initial Kitchen environment, including:

* Creating a .kitchen.yml file
* Appending Kitchen to the RubyGems file, .gitignore, and .thor
* Creating the ``test/integration/default`` directory

Syntax
-----------------------------------------------------
This subcommand has the following syntax:

.. code-block:: bash

   $ kitchen init

Options
-----------------------------------------------------
This subcommand has the following options:

``--create_gemfile``
   Create a RubyGems file, if one does not already exist. Default: ``false``.

``-D``, ``--driver``
   Add one (or more) Kitchen drivers to a RubyGems file. Default: ``kitchen-vagrant``.

``-l``, ``--log-level``
   The level of logging to be stored in a log file. Options (in order of priority): ``:debug``, ``:info``, ``:warn``, ``:error``, and ``:fatal``. Default: ``info``.

``-P``, ``--provisioner``
   The default provisioner that is used by Kitchen.

``PLATFORMS``
   Run Kitchen against one or more platforms listed in the .kitchen.yml file. Use ``all`` to run Kitchen against all platforms. Use a Ruby regular expression to glob two or more platforms into a single run.

   .. tag ctl_kitchen_common_option_platforms

   For example, if a .kitchen.yml file contains the following:

   .. code-block:: javascript

       - name: centos-5.10
       - name: centos-6.5
       - name: fedora-19
       - name: ubuntu-1004
       - name: ubuntu-1204
       - name: ubuntu-1310

   then a regular expression like ``(04|5)`` would run Kitchen against ``centos-5.10``, ``centos-6.5``, ``ubuntu-1004``, and ``ubuntu-1204``. A regular expression like ``(ubuntu)`` would run Kitchen against ``ubuntu-1004``, ``ubuntu-1204``, and ``ubuntu-1310``. A regular expression like ``(fedora-19)`` would run Kitchen against only ``fedora-19``. Default: ``all``.

   .. end_tag

Examples
-----------------------------------------------------

**Create the Kitchen environment**

.. code-block:: bash

   $ kitchen init --driver=kitchen-vagrant

will return something similar to:

.. code-block:: bash

   create .kitchen.yml
   create test/integration/default
   create .gitignore
   append .gitignore
   append .gitignore
   run    gem install kitchen-vagrant from "."
   Fetching: kitchen-vagrant-0.12.0.gem (100%)
   Successfully installed kitchen-vagrant-0.12.0
   1 gem installed

kitchen list
=====================================================
Use the ``list`` subcommand to view the list of instances. Instances are based on the list of platforms in the .kitchen.yml file. Kitchen will auto-name instances by combining a suite name with a platform name. For example, if a suite is named ``default`` and a platform is named ``ubuntu-10.04``, then the instance would be ``default-ubuntu-10.04``. This ensures that Kitchen instances have safe DNS and hostname records.

Syntax
-----------------------------------------------------
This subcommand has the following syntax:

.. code-block:: bash

   $ kitchen list PLATFORMS (options)

Options
-----------------------------------------------------
This subcommand has the following options:

``-b``, ``--bare``
   Print the name of each instance, one instance per line. Default: ``false``.

``-l``, ``--log-level``
   The level of logging to be stored in a log file. Options (in order of priority): ``:debug``, ``:info``, ``:warn``, ``:error``, and ``:fatal``. Default: ``info``.

``PLATFORMS``
   Run Kitchen against one or more platforms listed in the .kitchen.yml file. Use ``all`` to run Kitchen against all platforms. Use a Ruby regular expression to glob two or more platforms into a single run.

   .. tag ctl_kitchen_common_option_platforms

   For example, if a .kitchen.yml file contains the following:

   .. code-block:: javascript

       - name: centos-5.10
       - name: centos-6.5
       - name: fedora-19
       - name: ubuntu-1004
       - name: ubuntu-1204
       - name: ubuntu-1310

   then a regular expression like ``(04|5)`` would run Kitchen against ``centos-5.10``, ``centos-6.5``, ``ubuntu-1004``, and ``ubuntu-1204``. A regular expression like ``(ubuntu)`` would run Kitchen against ``ubuntu-1004``, ``ubuntu-1204``, and ``ubuntu-1310``. A regular expression like ``(fedora-19)`` would run Kitchen against only ``fedora-19``. Default: ``all``.

   .. end_tag

Examples
-----------------------------------------------------

**View a list of Kitchen instances**

To view the list of Kitchen instances:

.. code-block:: bash

   $ kitchen list

A list will be returned, similar to:

.. code-block:: bash

   Instance              Driver   Provisioner   Last Action
   default-ubuntu-10.04  vagrant  chef_zero     created
   default-centos-6.5    vagrant  chef_zero     created

or:

.. code-block:: bash

   Instance              Driver   Provisioner   Last Action
   default-ubuntu-10.04  vagrant  chef_zero     converged
   default-centos-6.5    vagrant  chef_zero     created

or:

.. code-block:: bash

   Instance              Driver   Provisioner   Last Action
   default-ubuntu-10.04  vagrant  chef_zero     verified
   default-centos-6.5    vagrant  chef_zero     created

or:

.. code-block:: bash

   Instance              Driver   Provisioner   Last Action
   default-ubuntu-10.04  vagrant  chef_zero     created
   default-centos-6.5    vagrant  chef_zero     <not created>

or if there are multiple suites defined, such as ``default`` and ``test``:

.. code-block:: bash

   Instance              Driver   Provisioner   Last Action
   default-ubuntu-10.04  vagrant  chef_zero     <not created>
   default-centos-6.5    vagrant  chef_zero     <not created>
   test-ubuntu-10.04     vagrant  chef_zero     <not created>
   test-centos-6.5       vagrant  chef_zero     <not created>

kitchen login
=====================================================
Use the ``login`` subcommand to log in to a single instance. Instances are based on the list of platforms and suites in the .kitchen.yml file. After logging in successfully, the instance can be interacted with just like any other virtual machine, including adding or removing packages, starting or stopping services, and so on. It's a sandbox. Make any change necessary to help improve the coverage for cookbook testing.

Syntax
-----------------------------------------------------
This subcommand has the following syntax:

.. code-block:: bash

   $ kitchen login PLATFORM (options)

Options
-----------------------------------------------------
This subcommand has the following options:

``-l``, ``--log-level``
   The level of logging to be stored in a log file. Options (in order of priority): ``:debug``, ``:info``, ``:warn``, ``:error``, and ``:fatal``. Default: ``info``.

``PLATFORMS``
   Run Kitchen against one or more platforms listed in the .kitchen.yml file. Use ``all`` to run Kitchen against all platforms. Use a Ruby regular expression to glob two or more platforms into a single run.

   .. tag ctl_kitchen_common_option_platforms

   For example, if a .kitchen.yml file contains the following:

   .. code-block:: javascript

       - name: centos-5.10
       - name: centos-6.5
       - name: fedora-19
       - name: ubuntu-1004
       - name: ubuntu-1204
       - name: ubuntu-1310

   then a regular expression like ``(04|5)`` would run Kitchen against ``centos-5.10``, ``centos-6.5``, ``ubuntu-1004``, and ``ubuntu-1204``. A regular expression like ``(ubuntu)`` would run Kitchen against ``ubuntu-1004``, ``ubuntu-1204``, and ``ubuntu-1310``. A regular expression like ``(fedora-19)`` would run Kitchen against only ``fedora-19``. Default: ``all``.

   .. end_tag

Examples
-----------------------------------------------------
To login to the default Ubuntu instance, run the following:

.. code-block:: bash

   $ kitchen login default-ubuntu-14.04

to return something similar to:

.. code-block:: bash

   Welcome to Ubuntu 14.04.2 LTS (GNU/Linux 3.5.0-23-generic x86_64)
   Last login: Mon Mar 28 17:34:26 2014 from 127.0.0.5
   vagrant@default-ubuntu-14.04:~$

kitchen setup
=====================================================
Use the ``setup`` subcommand to set up one (or more) instances. Instances are based on the list of platforms in the .kitchen.yml file.

Syntax
-----------------------------------------------------
This subcommand has the following syntax:

.. code-block:: bash

   $ kitchen setup PLATFORMS (options)

Options
-----------------------------------------------------
This subcommand has the following options:

``-c``, ``--concurrency``
   The number of allowed concurrent connections. Default: ``9999`` (all instances, effectively).

``-l``, ``--log-level``
   The level of logging to be stored in a log file. Options (in order of priority): ``:debug``, ``:info``, ``:warn``, ``:error``, and ``:fatal``. Default: ``info``.

``PLATFORMS``
   Run Kitchen against one or more platforms listed in the .kitchen.yml file. Use ``all`` to run Kitchen against all platforms. Use a Ruby regular expression to glob two or more platforms into a single run.

   .. tag ctl_kitchen_common_option_platforms

   For example, if a .kitchen.yml file contains the following:

   .. code-block:: javascript

       - name: centos-5.10
       - name: centos-6.5
       - name: fedora-19
       - name: ubuntu-1004
       - name: ubuntu-1204
       - name: ubuntu-1310

   then a regular expression like ``(04|5)`` would run Kitchen against ``centos-5.10``, ``centos-6.5``, ``ubuntu-1004``, and ``ubuntu-1204``. A regular expression like ``(ubuntu)`` would run Kitchen against ``ubuntu-1004``, ``ubuntu-1204``, and ``ubuntu-1310``. A regular expression like ``(fedora-19)`` would run Kitchen against only ``fedora-19``. Default: ``all``.

   .. end_tag

Examples
-----------------------------------------------------
None.

kitchen test
=====================================================
Use the ``test`` subcommand to test one (or more) verified instances. Instances are based on the list of platforms and suites in the .kitchen.yml file. This subcommand will create a new instance (cleaning up a previous instance, if necessary), converge that instance, set up the test harness, verify the instance using that test harness, and then destroy the instance.

In general, use the ``test`` subcommand to verify the end-to-end quality of a cookbook. Use the ``converge`` and ``verify`` subcommands during the normal the day-to-day development of a cookbook.

Syntax
-----------------------------------------------------
This subcommand has the following syntax:

.. code-block:: bash

   $ kitchen test PLATFORMS (options)

Options
-----------------------------------------------------
This subcommand has the following options:

``--auto-init``
   Invoke the ``init`` command if .kitchen.yml is missing. Default: ``false``.

``-c NUMBER``, ``--concurrency NUMBER``
   The number of allowed concurrent connections. Use this option to limit the number of instances that are tested concurrently. For example, ``--concurrency 6`` will set this limit to six concurrent instances. Default: ``9999`` (all instances, effectively).

``-d``, ``--destroy``
   The destroy strategy used at the conclusion of a Kitchen run. Possible values: ``always`` (always destroy instances), ``never`` (never destroy instances), or ``passing`` (only destroy instances that passed). Default: ``passing``.

``-l``, ``--log-level``
   The level of logging to be stored in a log file. Options (in order of priority): ``:debug``, ``:info``, ``:warn``, ``:error``, and ``:fatal``. Default: ``info``.

``PLATFORMS``
   Run Kitchen against one or more platforms listed in the .kitchen.yml file. Use ``all`` to run Kitchen against all platforms. Use a Ruby regular expression to glob two or more platforms into a single run.

   .. tag ctl_kitchen_common_option_platforms

   For example, if a .kitchen.yml file contains the following:

   .. code-block:: javascript

       - name: centos-5.10
       - name: centos-6.5
       - name: fedora-19
       - name: ubuntu-1004
       - name: ubuntu-1204
       - name: ubuntu-1310

   then a regular expression like ``(04|5)`` would run Kitchen against ``centos-5.10``, ``centos-6.5``, ``ubuntu-1004``, and ``ubuntu-1204``. A regular expression like ``(ubuntu)`` would run Kitchen against ``ubuntu-1004``, ``ubuntu-1204``, and ``ubuntu-1310``. A regular expression like ``(fedora-19)`` would run Kitchen against only ``fedora-19``. Default: ``all``.

   .. end_tag

Examples
-----------------------------------------------------

**Test the default Ubuntu instance**

To test the default Ubuntu instance, run the following:

.. code-block:: bash

   $ kitchen test default-ubuntu-14.04

to return something similar to:

.. code-block:: bash

   -----> Starting Kitchen (v1.0.0)
   -----> Cleaning up any prior instances of <default-ubuntu-14.04>
   -----> Destroying <default-ubuntu-14.04>...
   ...
   Finished destroying <default-ubuntu-14.04> (0m3.06s).
   -----> Testing <default-ubuntu-14.04>
   -----> Creating <default-ubuntu-14.04>...
   Bringing machine 'default' up with 'virtualbox' provider...
   ...
   Vagrant instance <default-ubuntu-14.04> created.
   Finished creating <default-ubuntu-14.04> (0m46.22s).
   -----> Converging <default-ubuntu-14.04>...
   ...
   -----> Installing Chef Omnibus (true)
   downloading https://www.chef.io/chef/install.sh
   ...
   Installing Chef
   ...
   Setting up chef (11.12.0-1.ubuntu.12.04) ...
   Thank you for installing Chef!
   ...
   Starting Chef Client, version 11.12.0
   ...
   Converging 2 resources
   Recipe: git::default
     * package[git] action install[date/time] INFO: Processing package[git] action install (git::default line 10)

       - install version 1:2.3.4.5-6 of package git

     * log[log_description] action write[date/time] INFO: Processing log[log_description] action write (git::default line 5)
   ...
   Chef Client finished, 2 resources updated
   Finished converging <default-ubuntu-14.04> (0m45.17s).
   -----> Starting Kitchen (v1.0.0)
   -----> Setting up <default-ubuntu-14.04>
   Fetching: <name of test tool> (100%)
   Successfully installed <name of test tool>
   # gems installed
   -----> Setting up <name of test tool>
   ...
   -----> Running <name of test tool> test suite
    ✓ <test result>

   2 tests, 0 failures
        Finished verifying <default-ubuntu-14.04> (2m1.12s).
   -----> Kitchen is finished. (2m3.45s)
   $ echo $?
   0

**Test an instance using --concurrency option**

Use the ``--concurrency`` option to control the number of instances that are tested concurrently on the local workstation. The default setting is to test all instances, but the practical setting depends on the capabilities of the local machine itself. The following examples will limit the number of instances to four:

.. code-block:: bash

   $ kitchen test --concurrency=4

or:

.. code-block:: bash

   $ kitchen test --concurrency 4

or:

.. code-block:: bash

   $ kitchen test -c=4

or:

.. code-block:: bash

   $ kitchen test -c 4

kitchen verify
=====================================================
Use the ``verify`` subcommand to verify one (or more) instances. Instances are based on the list of platforms and suites in the .kitchen.yml file.

In general, use the ``test`` subcommand to verify the end-to-end quality of a cookbook. Use the ``converge`` and ``verify`` subcommands during the normal the day-to-day development of a cookbook.

Syntax
-----------------------------------------------------
This subcommand has the following syntax:

.. code-block:: bash

   $ kitchen verify PLATFORMS (options)

Options
-----------------------------------------------------
This subcommand has the following options:

``-c``, ``--concurrency``
   The number of allowed concurrent connections. Default: ``9999`` (all instances, effectively).

``-l``, ``--log-level``
   The level of logging to be stored in a log file. Options (in order of priority): ``:debug``, ``:info``, ``:warn``, ``:error``, and ``:fatal``. Default: ``info``.

``PLATFORMS``
   Run Kitchen against one or more platforms listed in the .kitchen.yml file. Use ``all`` to run Kitchen against all platforms. Use a Ruby regular expression to glob two or more platforms into a single run.

   .. tag ctl_kitchen_common_option_platforms

   For example, if a .kitchen.yml file contains the following:

   .. code-block:: javascript

       - name: centos-5.10
       - name: centos-6.5
       - name: fedora-19
       - name: ubuntu-1004
       - name: ubuntu-1204
       - name: ubuntu-1310

   then a regular expression like ``(04|5)`` would run Kitchen against ``centos-5.10``, ``centos-6.5``, ``ubuntu-1004``, and ``ubuntu-1204``. A regular expression like ``(ubuntu)`` would run Kitchen against ``ubuntu-1004``, ``ubuntu-1204``, and ``ubuntu-1310``. A regular expression like ``(fedora-19)`` would run Kitchen against only ``fedora-19``. Default: ``all``.

   .. end_tag

Examples
-----------------------------------------------------

**Verify the default Ubuntu instance**

To verify the default Ubuntu instance, run the following:

.. code-block:: bash

   $ kitchen verify default-ubuntu-10.04

to return something similar to:

.. code-block:: bash

   -----> Starting Kitchen (v1.0.0)
   -----> Setting up <default-ubuntu-10.04>
   Fetching: <name of test tool> (100%)
   Successfully installed <name of test tool>
   # gems installed
   -----> Setting up <name of test tool>
   ...
   -----> Running <name of test tool> test suite
    ✓ <test result>

   2 tests, 0 failures
        Finished verifying <default-ubuntu-10.04> (2m1.12s).
   -----> Kitchen is finished. (2m3.45s)
   $ echo $?
   0

or:

.. code-block:: bash

   -----> Starting Kitchen (v1.0.0)
   -----> Setting up <default-ubuntu-10.04>
   Fetching: <name of test tool> (100%)
   Successfully installed <name of test tool>
   # gems installed
   -----> Setting up <name of test tool>
   ...
   -----> Running <name of test tool> test suite
    - <test result>

   2 tests, 1 failures
   ... exit code was 1
   $ echo $?
   10

kitchen version
=====================================================
Use the ``version`` subcommand to print the version of Kitchen.

Syntax
-----------------------------------------------------
This subcommand has the following syntax:

.. code-block:: bash

   $ kitchen version

Options
-----------------------------------------------------
This subcommand does not have any options.

Examples
-----------------------------------------------------

**Verify the version of Kitchen**

To view the version of Kitchen:

.. code-block:: bash

   $ kitchen version

will return something similar to:

.. code-block:: bash

   Text Kitchen version 1.0.0
