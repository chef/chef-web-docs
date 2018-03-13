==========================================================================
.kitchen.yml
==========================================================================
`[edit on GitHub] <https://github.com/chef/chef-web-docs/blob/master/chef_master/source/config_yml_kitchen.rst>`__

Use `Test Kitchen <http://kitchen.ci>`_  to automatically test cookbook data across any combination of platforms and test suites:

* Defined in a .kitchen.yml file
* Uses a driver plugin architecture
* Supports cookbook testing across many cloud providers and virtualization technologies
* Supports all common testing frameworks that are used by the Ruby community
* Uses a comprehensive set of base images provided by `Bento <https://github.com/chef/bento>`_


.. tag test_kitchen_yml

Use a .kitchen.yml file to define what is required to run Kitchen, including drivers, provisioners, platforms, and test suites.

.. end_tag

.. note:: This topic details functionality that is packaged with Chef development kit. See http://kitchen.ci/docs/getting-started/ for more information about Kitchen.

Syntax
==========================================================================
.. tag test_kitchen_yml_syntax

The basic structure of a .kitchen.yml file is as follows:

.. code-block:: yaml

   driver:
     name: driver_name

   provisioner:
     name: provisioner_name

   verifier:
     name: verifier_name

   transport:
     name: transport_name

   platforms:
     - name: platform-version
       driver:
         name: driver_name
     - name: platform-version

   suites:
     - name: suite_name
       run_list:
         - recipe[cookbook_name::recipe_name]
       attributes: { foo: "bar" }
       excludes:
         - platform-version
     - name: suite_name
       driver:
         name: driver_name
       run_list:
         - recipe[cookbook_name::recipe_name]
       attributes: { foo: "bar" }
       includes:
         - platform-version

where:

* ``driver_name`` is the name of a driver that will be used to create platform instances used during cookbook testing. This is the default driver used for all platforms and suites **unless** a platform or suite specifies a ``driver`` to override the default driver for that platform or suite; a driver specified for a suite will override a driver set for a platform
* ``provisioner_name`` specifies how the chef-client will be simulated during testing. ``chef_zero``  and ``chef_solo`` are the most common provisioners used for testing cookbooks
* ``verifier_name`` specifies which application to use when running tests, such as ``inspec``
* ``transport_name`` specifies which transport to use when executing commands remotely on the test instance. ``winrm`` is the default transport on Windows. The ``ssh`` transport is the default on all other operating systems.
* ``platform-version`` is the name of a platform on which Kitchen will perform cookbook testing, for example, ``ubuntu-16.04`` or ``centos-7``; depending on the platform, additional driver details---for example, instance names and URLs used with cloud platforms like OpenStack or Amazon EC2---may be required
* ``platforms`` may define Chef server attributes that are common to the collection of test suites
* ``suites`` is a collection of test suites, with each ``suite_name`` grouping defining an aspect of a cookbook to be tested. Each ``suite_name`` must specify a run-list, for example:

  .. code-block:: ruby

     run_list:
       - recipe[cookbook_name::default]
       - recipe[cookbook_name::recipe_name]

* Each ``suite_name`` grouping may specify ``attributes`` as a Hash: ``{ foo: "bar" }``
* A ``suite_name`` grouping may use ``excludes`` and ``includes`` to exclude/include one (or more) platforms. For example:

  .. code-block:: ruby

     excludes:
        - platform-version
        - platform-version       # for additional platforms

For example, a very simple .kitchen.yml file:

.. code-block:: yaml

   driver:
     name: vagrant

   provisioner:
     name: chef_zero

   platforms:
     - name: ubuntu-16.04
     - name: centos-7
     - name: debian-9

  suites:
    - name: default
      run_list:
        - recipe[apache::httpd]
      excludes:
        - debian-9

This file uses Vagrant as the driver, which requires no additional configuration because it's the default driver used by Kitchen, chef-zero as the provisioner, and a single (default) test suite that runs on Ubuntu 16.04, and CentOS 7.

.. end_tag

Provisioner Settings
==========================================================================
Test Kitchen's provisioner settings will be changing in a future version. See `Chef RFC 091 <https://github.com/chef/chef-rfc/blob/master/rfc091-deprecate-kitchen-settings.md>`_
for details. Settings that will be deprecated are listed in the descriptions below. The new recommended settings are listed in the `New Provisioner Settings </config_yml_kitchen.html#new-provisioner-settings>`__ table.

Kitchen can configure the chef-zero provisioner with the following Chef-specific settings:

.. list-table::
   :widths: 200 300
   :header-rows: 1

   * - Setting
     - Description
   * - ``attributes``
     -
   * - ``chef_client_path``
     - chef-client provisioner only.
   * - ``chef_metadata_url``
     - **This will be deprecated in a future version.**
   * - ``chef_omnibus_install_options``
     - Use to specify the package to be installed. Possible values: ``-P chef`` (for the Chef client) and ``-P chefdk`` (for the Chef client that is packaged as part of the Chef DK). Use ``-n`` to specify the nightly build. For example: ``-P chefdk`` or ``-n -P chefdk``. **This will be deprecated in a future version.** See the ``product_name``, ``product_version``, and ``channel`` settings instead.

   * - ``chef_omnibus_root``
     - Default value: ``/etc/opt`` for UNIX and Linux, ``$env:systemdrive\\opscode\\chef`` on Microsoft Windows.
   * - ``chef_omnibus_url``
     - The URL for an ``install.sh`` script that will install chef-client on the machine under test. Default value: ``https://www.chef.io/chef/install.sh``. **This will be deprecated in a future version.**
   * - ``chef_solo_path``
     - chef-solo provisioner only.
   * - ``chef_zero_host``
     - chef-client provisioner only.
   * - ``chef_zero_port``
     - chef-client provisioner only. The port on which chef-zero is to listen.
   * - ``client_rb``
     - chef-client provisioner only. A list of client.rb file settings. For example:

       .. code-block:: yaml

          client_rb:
            audit_mode: :audit_only

   * - ``clients_path``
     - The relative path to the directory in which client data is located. This data must be defined as JSON.
   * - ``cookbook_files_glob``
     - A file glob (pattern) that matches files considered to be part of the cookbook. (Typically, this value does not need to be modified from the default.)
   * - ``data_path``
     - Use to specify the path from which non-cookbook files are copied to a Kitchen instance.
   * - ``data_bags_path``
     - The relative path to a directory in which data bags and data bag items are defined. This data must be structured as if it were in the chef-repo.
   * - ``deprecations_as_errors``
     - Set to `true` to treat deprecation warning messages as error messages.
   * - ``driver``
     - Use to specify a driver for a platform. This will override the default driver.
   * - ``enforce_idempotency``
     - Use with ``multiple_converge`` > 1. Set to ``true`` to force test-kitchen to fail if last converge has any updated resources.
   * - ``encrypted_data_bag_secret_key_path``
     - The path to an RSA key file that is used to decrypt encrypted data bag items.
   * - ``environments_path``
     - The relative path to the directory in which environment data is located. This data must be defined as JSON.
   * - ``http_proxy``
     - The proxy server for HTTP connections.
   * - ``https_proxy``
     - The proxy server for HTTPS connections.
   * - ``no_proxy``
     - The comma-separated exception list of host patterns to exclude from proxying.
   * - ``install_msi_url``
     - An alternate URL for a Windows MSI package that will install chef-client on the machine under test. **This will be deprecated in a future version.** Use the ``download_url`` setting instead.
   * - ``json_attributes``
     - chef-client provisioner only.
   * - ``log_file``
     -
   * - ``multiple_converge``
     - Number of times to converge the node. Defaults to 1.
   * - ``nodes_path``
     - The relative path to the directory in which node data is located. This data must be defined as JSON.
   * - ``require_chef_omnibus``
     - Use to install the latest version of Chef client on a node. Set to ``true`` to install the latest version, ``false`` to not install Chef client (assumes the box already has it installed), or a version specifier like ``12.19.36`` to install a particular version, or simply ``12`` to install the latest 12.x package. When set to ``true`` or a version number, the ``chef_omnibus_url`` may be used to specify the URL of the ``install.sh`` that installs the specified version of Chef client. Default value: ``true``. **This will be deprecated in a future version.**  See the ``product_version`` and ``install_strategy`` settings.
   * - ``roles_path``
     - The relative path to the directory in which role data is located. This data must be defined as JSON.
   * - ``root_path``
     - The directory in which Kitchen will stage all content on the target node. This directory should be large enough to store all the content and must be writable. (Typically, this value does not need to be modified from the default value.) Default value: ``/tmp/kitchen``.
   * - ``ruby_bindir``
     - chef-client provisioner only.
   * - ``run_list``
     -
   * - ``solo_rb``
     - chef-solo provisioner only.
   * - ``retry_on_exit_code``
     - Takes an array of exit codes to indicate that kitchen should retry the converge command. Default value: ``[35, 213]``.
   * - ``max_retries``
     -  Number of times to retry the converge before passing along the failed status. Defaults value: 1.
   * - ``wait_for_retry``
     - Number of seconds to wait between converge attempts. Default value: 30.

These settings may be added to the ``provisioner`` section of the .kitchen.yml file when the provisioner is chef-zero or chef-solo.

New Provisioner Settings
--------------------------------------------------------------------------

.. list-table::
  :widths: 75 275 25 125
  :header-rows: 1

  * - New Setting
    - Description
    - Default
    - Replaces
  * - ``product_name``
    - ``chef`` or ``chefdk``. This setting must be specified in order to use the new settings. Using this setting overrides Test Kitchen's default behavior based on the ``require_chef_omnibus`` setting.
    -
    - ``chef_omnibus_install_options``
  * - ``product_version``
    - Product version number. Supports partial version numbers.
    - ``latest``
    - ``require_chef_omnibus``
  * - ``channel``
    - Artifact repository name. ``stable``, ``current`` or ``unstable``.
    - ``stable``
    - ``chef_omnibus_install_options``
  * - ``install_strategy``
    - Product install strategy. ``once`` (Don't install if any product installation detected), ``always`` or ``skip``.
    - ``once``
    - ``require_chef_omnibus``
  * - ``download_url``
    - Direct package URL. Supports all platforms.
    -
    - ``install_msi_url``
  * - ``checksum``
    - Optional setting when using ``download_url``. Validates SHA256 checksum after download.
    -
    -
  * - ``platform``
    - Override platform.
    - <auto detected>
    -
  * - ``platform_version``
    - Override platform platform.
    - <auto detected>
    -
  * - ``architecture``
    - Override platform architecture.
    - <auto detected>
    -

.. note:: There are two community provisioners for Kitchen: `kitchen-dsc <https://github.com/smurawski/kitchen-dsc>`__ and `kitchen-pester <https://github.com/smurawski/kitchen-pester>`__.

Transport Settings
==========================================================================
Kitchen can configure a transport with the following settings for either ``ssh`` or ``winrm`` transports:

.. list-table::
   :widths: 200 300
   :header-rows: 1

   * - Setting
     - Description
   * - ``connection_retries``
     - Maximum number of times to retry after a failed attempt to open a connection. The default is 5.
   * - ``connection_retry_sleep``
     - Number of seconds to wait until attempting to make another connection after a failure.
   * - ``max_wait_until_ready``
     - Maximum number of attempts to determine if the test instance is ready to accept commands. This defaults to 600.
   * - ``password``
     - The password used for authenticating to the test instance.
   * - ``port``
     - The port used to connect to the test instance. This defaults to ``22`` for the ``ssh`` transport and ``5985`` or ``5986`` for ``winrm`` using ``http`` or ``https`` respectively.
   * - ``username``
     - The username used for authenticating to the test instance. This defaults to ``administrator`` for the ``winrm`` transport and ``root`` for the ``ssh`` transport. Some drivers may change this default.

These settings may be added to the ``transport`` section of the .kitchen.yml file when the transport is SSH:

.. list-table::
   :widths: 200 300
   :header-rows: 1

   * - Setting
     - Description
   * - ``compression``
     - Wether or not to use compression. The default is ``false``.
   * - ``compression_level``
     - The default is 6 if ``compression`` is ``true``.
   * - ``connection_timeout``
     - Defaults to 15.
   * - ``keepalive``
     - Defaults to ``true``.
   * - ``keepalive_interval``
     - Defaults to 60.
   * - ``max_ssh_sessions``
     - Maximum number of parallel ssh sessions.
   * - ``ssh_key``
     - Path to an ssh key identity file.

These settings may be added to the ``transport`` section of the .kitchen.yml file when the transport is WinRM:

.. list-table::
   :widths: 200 300
   :header-rows: 1

   * - Setting
     - Description
   * - ``elevated``
     - When ``true``, all commands are executed via a scheduled task. This may eliminate access denied errors related to double hop authentication, interacting with windows updates and installing some MSIs such as sql server and .net runtimes. Defaults to ``false``.
   * - ``elevated_password``
     - The password used by the identity running the scheduled task. This may be ``null`` in the case of service accounts. Defaults to ``password``.
   * - ``elevated_username``
     - The identity that the task runs under. This may also be set to service accounts such as ``System``. This defaults to ``username``.
   * - ``rdp_port``
     - Port used making ``rdp`` connections for ``kitchen login`` commands. Defaults to 3389.
   * - ``winrm_transport``
     - The transport type used by winrm as explained `here <https://github.com/WinRb/WinRM>`__. The default is ``negotiate``. ``ssl`` and ``plaintext`` are also acceptable values.

Work with Proxies
--------------------------------------------------------------------------
.. tag test_kitchen_yml_syntax_proxy

The environment variables ``http_proxy``, ``https_proxy``, and ``ftp_proxy`` are honored by Kitchen for proxies. The client.rb file is read to look for proxy configuration settings. If ``http_proxy``, ``https_proxy``, and ``ftp_proxy`` are specified in the client.rb file, the chef-client will configure the ``ENV`` variable based on these (and related) settings. For example:

.. code-block:: ruby

   http_proxy 'http://proxy.example.org:8080'
   http_proxy_user 'myself'
   http_proxy_pass 'Password1'

will be set to:

.. code-block:: ruby

   ENV['http_proxy'] = 'http://myself:Password1@proxy.example.org:8080'

Kitchen also supports ``http_proxy`` and ```https_proxy`` in the ``.kitchen.yml`` file:

.. code-block:: yaml

   driver:
     name: vagrant

   provisioner:
     name: chef_zero
     http_proxy: http://10.0.0.1

.. end_tag

chef-client Settings
==========================================================================
A .kitchen.yml file may define chef-client-specific settings, such as whether to require the omnibus installer or the URL from which the chef-client is downloaded, or to override settings in the client.rb file:

.. code-block:: yaml

   provisioner:
     name: chef_zero *or* chef_solo
     require_chef_omnibus: true
     chef_omnibus_url: https://www.chef.io/chef/install.sh

   ...

   suites:
     - name: config
       run_list:
       ...
       attributes:
         chef_client:
           load_gems:
             chef-handler-updated-resources:
               require_name: "chef/handler/updated_resources"
           config:
             log_level: ":debug"
             ssl_verify_mode: ":verify_peer"
             start_handlers: [{class: "SimpleReport::UpdatedResources", arguments: []}]
             report_handlers: [{class: "SimpleReport::UpdatedResources", arguments: []}]
             exception_handlers: [{class: "SimpleReport::UpdatedResources", arguments: []}]
         ohai:
           disabled_plugins: ["passwd"]

where:

* ``require_chef_omnibus`` is used to ensure that the omnibus installer will be used to install the chef-client to all platform instances; ``require_chef_omnibus`` may also be set to ``latest``, which means the newest version of the chef-client for that platform will be used for cookbook testing
* ``chef_omnibus_url`` is used to specify the URL from which the chef-client is downloaded
* All of the ``attributes`` for the ``config`` test suite contain specific client.rb settings for use with this test suite

Driver Settings
==========================================================================
Driver-specific configuration settings may be required. Use a block similar to:

.. code-block:: yaml

   driver:
     name: driver_name
     optional_settings: values

Specific ``optional_settings: values`` may be specified.

Bento
--------------------------------------------------------------------------
.. tag bento

`Bento <https://github.com/chef/bento>`_ is a project that contains a set of base images that are used by Chef for internal testing and to provide a comprehensive set of base images for use with Kitchen. By default, Kitchen uses the base images provided by Bento. (Custom images may also be built using Packer.)

.. end_tag

Drivers
--------------------------------------------------------------------------
.. tag test_kitchen_drivers

Kitchen uses a driver plugin architecture to enable Kitchen to simulate testing on cloud providers, such as Amazon EC2, OpenStack, and Rackspace, and also on non-cloud platforms, such as Microsoft Windows. Each driver is responsible for managing a virtual instance of that platform so that it may be used by Kitchen during cookbook testing.

.. note:: The Chef development kit includes the ``kitchen-vagrant`` driver.

Most drivers have driver-specific configuration settings that must be added to the .kitchen.yml file before Kitchen will be able to use that platform during cookbook testing. For information about these driver-specific settings, please refer to the driver-specific documentation.

Some popular drivers:

.. list-table::
   :widths: 150 450
   :header-rows: 1

   * - Driver Plugin
     - Description
   * - `kitchen-all <https://rubygems.org/gems/kitchen-all>`__
     - A driver for everything, or "all the drivers in a single Ruby gem".
   * - `kitchen-bluebox <https://github.com/blueboxgroup/kitchen-bluebox>`__
     - A driver for Blue Box.
   * - `kitchen-cloudstack <https://github.com/test-kitchen/kitchen-cloudstack>`__
     - A driver for CloudStack.
   * - `kitchen-digitalocean <https://github.com/test-kitchen/kitchen-digitalocean>`__
     - A driver for DigitalOcean.
   * - `kitchen-docker <https://github.com/portertech/kitchen-docker>`__
     - A driver for Docker.
   * - `kitchen-dsc <https://github.com/test-kitchen/kitchen-dsc>`__
     - A driver for Windows PowerShell Desired State Configuration (DSC).
   * - `kitchen-ec2 <https://github.com/test-kitchen/kitchen-ec2>`__
     - A driver for Amazon EC2.
   * - `kitchen-fog <https://github.com/TerryHowe/kitchen-fog>`__
     - A driver for Fog, a Ruby gem for interacting with various cloud providers.
   * - `kitchen-google <https://github.com/anl/kitchen-google>`__
     - A driver for Google Compute Engine.
   * - `kitchen-hyperv <https://github.com/test-kitchen/kitchen-hyperv>`__
     - A driver for Hyper-V Server.
   * - `kitchen-joyent <https://github.com/test-kitchen/kitchen-joyent>`__
     - A driver for Joyent.
   * - `kitchen-linode <https://github.com/ssplatt/kitchen-linode>`__
     - A driver for Linode.
   * - `kitchen-opennebula <https://github.com/test-kitchen/kitchen-opennebula>`__
     - A driver for OpenNebula.
   * - `kitchen-openstack <https://github.com/test-kitchen/kitchen-openstack>`__
     - A driver for OpenStack.
   * - `kitchen-pester <https://github.com/test-kitchen/kitchen-pester>`__
     - A driver for Pester, a testing framework for Microsoft Windows.
   * - `kitchen-rackspace <https://github.com/test-kitchen/kitchen-rackspace>`__
     - A driver for Rackspace.
   * - `kitchen-terraform <https://github.com/newcontext-oss/kitchen-terraform>`__
     - A driver for Terraform.
   * - `kitchen-vagrant <https://github.com/test-kitchen/kitchen-vagrant>`__
     - A driver for Vagrant. The default driver packaged with the Chef development kit.

.. end_tag

kitchen-vagrant
--------------------------------------------------------------------------
.. tag test_kitchen_driver_vagrant

The ``kitchen-vagrant`` driver for Kitchen generates a single Vagrantfile for each instance of Kitchen in a sandboxed directory. The ``kitchen-vagrant`` driver supports VirtualBox and VMware Fusion, requires Vagrant 1.1.0 (or higher), and is the default driver for Test Kitchen.

.. end_tag

.. tag test_kitchen_driver_vagrant_settings

The following attributes are used to configure ``kitchen-vagrant`` for Chef:

.. list-table::
   :widths: 60 420
   :header-rows: 1

   * - Attribute
     - Description
   * - ``box``
     - Required. Use to specify the box on which Vagrant will run. Default value: computed from the platform name of the instance.
   * - ``box_check_update``
     - Use to check for box updates. Default value: ``false``.
   * - ``box_url``
     - Use to specify the URL at which the configured box is located. Default value: computed from the platform name of the instance, but only when the Vagrant provider is VirtualBox- or VMware-based.
   * - ``communicator``
     - Use to override the ``config.vm.communicator`` setting in Vagrant. For example, when a base box is a Microsoft Windows operating system that does not have SSH installed and enabled, Vagrant will not be able to boot without a custom Vagrant file. Default value: ``nil`` (assumes SSH is available).
   * - ``customize``
     - A hash of key-value pairs that define customizations that should be made to the Vagrant virtual machine. For example: ``customize: memory: 1024 cpuexecutioncap: 50``.
   * - ``guest``
     - Use to specify the ``config.vm.guest`` setting in the default Vagrantfile.
   * - ``gui``
     - Use to enable the graphical user interface for the defined platform. This is passed to the ``config.vm.provider`` setting in Vagrant, but only when the Vagrant provider is VirtualBox- or VMware-based.
   * - ``network``
     - Use to specify an array of network customizations to be applied to the virtual machine. Default value: ``[]``. For example: ``network: - ["forwarded_port", {guest: 80, host: 8080}] - ["private_network", {ip: "192.168.33.33"}]``.
   * - ``pre_create_command``
     - Use to run a command immediately prior to ``vagrant up --no-provisioner``.
   * - ``provider``
     - Use to specify the Vagrant provider. This value must match a provider name in Vagrant.
   * - ``provision``
     - Use to provision Vagrant when the instance is created. This is useful if the operating system needs customization during provisioning. Default value: ``false``.
   * - ``ssh_key``
     - Use to specify the private key file used for SSH authentication.
   * - ``synced_folders``
     - Use to specify a collection of synchronized folders on each Vagrant instance. Source paths are relative to the Kitchen root path. Default value: ``[]``. For example: ``synced_folders: - ["data/%{instance_name}", "/opt/instance_data"] - ["/host_path", "/vm_path", "create: true, type: :nfs"]``.
   * - ``vagrantfile_erb``
     - Use to specify an alternate Vagrant Embedded Ruby (ERB) template to be used by this driver.
   * - ``vagrantfiles``
     - An array of paths to one (or more) Vagrant files to be merged with the default Vagrant file. The paths may be absolute or relative to the .kitchen.yml file.
   * - ``vm_hostname``
     - Use to specify the internal hostname for the instance. This is not required when connecting to a Vagrant virtual machine. Set this to ``false`` to prevent this value from being rendered in the default Vagrantfile. Default value: computed from the platform name of the instance.

.. end_tag

.. tag test_kitchen_driver_vagrant_config

The ``kitchen-vagrant`` driver can predict the box name for Vagrant and the download URL that have been published by Chef. For example:

.. code-block:: ruby

   platforms:
   - name: ubuntu-14.04
   - name: ubuntu-16.04
   - name: centos-6
   - name: centos-7
   - name: debian-8

which will generate a configuration file similar to:

.. code-block:: ruby

   platforms:
   - name: ubuntu-14.04
     driver:
       box: bento/ubuntu-14.04
   - name: ubuntu-16.04
     driver:
       box: bento/ubuntu-16.04
   # ...

.. end_tag

Examples
==========================================================================
The following examples show actual .kitchen.yml files used in Chef-maintained cookbooks.

Chef, Chef DK
--------------------------------------------------------------------------
The following example shows the provisioner settings needed to install the Chef development kit, and then use the version of Chef that is embedded in the Chef development kit to converge the node.

To install the latest version of the Chef development kit:

.. code-block:: yaml

   provisioner:
     ...
     chef_omnibus_install_options: -P chefdk
     chef_omnibus_root: /opt/chefdk

and to install a specific version of the Chef development kit:

.. code-block:: yaml

   provisioner:
     ...
     chef_omnibus_install_options: -P chefdk
     chef_omnibus_root: /opt/chefdk
     require_chef_omnibus: 0.5.0

Microsoft Windows Platform
--------------------------------------------------------------------------
The following example shows platform settings for the Microsoft Windows platform:

.. code-block:: yaml

   ---

   platforms:
     - name: eval-win2012r2-standard
       os_type: windows
       transport:
         name: winrm
         elevated: true

If ``name`` begins with ``win`` then the ``os_type`` defaults to ``windows``. The ``winrm`` transport is the default on Windows operating systems. Here ``elevated`` is true which runs windows commands via a scheduled task to imitate a local user.

chef-client, audit-mode
--------------------------------------------------------------------------
The following example shows provisioner settings for running the chef-client in audit-mode:

.. code-block:: yaml

   ---
   driver:
     name: vagrant
     customize:
       memory: 1024
       cpus: 2

   provisioner:
     name: chef_zero
     client_rb:
       audit_mode: :enabled

   platforms:
     - name: ubuntu-14.04
       run_list:
         - recipe[audit-cis::ubuntu1404-100]
     - name: centos-7
       run_list:
         - recipe[audit-cis::centos7-100]
     - name: centos-6
       run_list:
       - recipe[audit-cis::centos6-110]

   suites:
     - name: default

where ``audit_mode`` may be ``:enabled``, ``:disabled`` (default), or ``:audit_only``.

mysql Cookbook
--------------------------------------------------------------------------
The most impressive (and thorough) .kitchen.yml file is part of the ``mysql`` cookbook. It is too big to paste into this topic, so please see it at the following links:

* `.kitchen.yml <https://github.com/chef-cookbooks/mysql/blob/master/.kitchen.yml>`__

chef-client Cookbook
--------------------------------------------------------------------------
The following .kitchen.yml file is part of the ``chef-client`` cookbook and ensures the chef-client is configured correctly.

.. code-block:: yaml

   driver:
     name: vagrant

   provisioner:
     name: chef_zero

   platforms:
     - name: centos-5.10
     - name: centos-6.5
     - name: fedora-19
     - name: ubuntu-1004
     - name: ubuntu-1204
     - name: ubuntu-1310

   suites:

   - name: service_init
     run_list:
     - recipe[minitest-handler]
     - recipe[chef-client::config]
     - recipe[chef-client_test::service_init]
     - recipe[chef-client::init_service]
     attributes: {}

   - name: service_runit
     run_list:
     - recipe[minitest-handler]
     - recipe[runit]
     - recipe[chef-client_test::service_runit]
     - recipe[chef-client::runit_service]
     attributes: {}

   - name: service_upstart
     run_list:
     - recipe[minitest-handler]
     - recipe[chef-client_test::service_upstart]
     - recipe[chef-client::upstart_service]
     excludes: ["centos-5.9"]
     attributes: {}

   - name: cron
     run_list:
     - recipe[minitest-handler]
     - recipe[chef-client::cron]
     attributes: {}

   - name: delete_validation
     run_list:
     - recipe[chef-client::delete_validation]
     attributes: {}

chef-splunk Cookbook
--------------------------------------------------------------------------
The following .kitchen.yml file is part of the ``chef-splunk`` cookbook and is used to help ensure the installation of the Splunk client and server is done correctly.

.. code-block:: yaml

   driver:
     name: vagrant
     customize:
       memory: 512

   provisioner:
     name: chef_zero

   platforms:
     - name: ubuntu-14.04
     - name: ubuntu-16.04
     - name: centos-6
     - name: centos-7

   suites:
     - name: client
       run_list:
         - recipe[chef-splunk::default]
         - recipe[test::default]
       attributes:
         dev_mode: true
         splunk:
           accept_license: true

     - name: server
       run_list:
         - recipe[chef-splunk::default]
       attributes:
         dev_mode: true
         splunk:
           is_server: true
           accept_license: true
           ssl_options:
             enable_ssl: true

     - name: disabled
       run_list:
         - recipe[chef-splunk::default]
       attributes:
         splunk:
           disabled: true

     - name: upgrade_client
       run_list:
         - recipe[chef-splunk::default]
         - recipe[chef-splunk::upgrade]
       attributes:
         dev_mode: true
         splunk:
           accept_license: true
           upgrade_enabled: true

     - name: upgrade_server
       run_list:
         - recipe[chef-splunk::default]
         - recipe[chef-splunk::upgrade]
       attributes:
         dev_mode: true
         splunk:
           accept_license: true
           upgrade_enabled: true
           is_server: true

yum Cookbook
--------------------------------------------------------------------------
The following .kitchen.yml file is part of the ``yum`` cookbook:

.. code-block:: yaml

   driver:
     name: vagrant

   provisioner:
     name: chef_zero

   platforms:
     - name: centos-5.11
     - name: centos-6.7
     - name: centos-7.2
     - name: fedora-22

   suites:
     - name: default
       run_list:
         - recipe[yum::default]
         - recipe[yum_test::test_repo]
     - name: dnf_compat
       run_list:
         - recipe[yum::dnf_yum_compat]
         - recipe[yum_test::test_dnf_compat]
       includes: fedora-22

Platform Attributes
--------------------------------------------------------------------------
The following .kitchen.yml file sets up a simple tiered configuration of the Chef server, including two front-end servers, a single back-end server, and all three add-ons (Chef push jobs, Reporting, and Chef management console). The ``platforms`` block uses an ``attributes`` section to define Chef server-specific attributes that are used by all three test suites:

.. code-block:: yaml

   ---
   driver:
     name: vagrant

   provisioner:
     name: chef_zero

   platforms:
     - name: ubuntu-16.04
       attributes:
         chef-server:
           api_fqdn: backend.chef-server.com
           backend:
             fqdn: backend.chef-server.com
             ipaddress: 123.456.789.0
           frontends:
             frontend1.chef-server.com: 123.456.789.0
             frontend2.chef-server.com: 123.456.789.0
           urls:
             private_chef: http://123.456.789.0/path/to/private-chef_11.1.4-1_amd64.deb
             manage: http://123.456.789.0/path/to/opscode-manage_1.3.1-1_amd64.deb
             reporting: http://123.456.789.0/path/to/opscode-reporting_1.1.1-1_amd64.deb
             push_jobs: http://123.456.789.0/path/to/opscode-push-jobs-server_1.1.1-1_amd64.deb

   suites:
     - name: frontend1
       driver:
         vm_hostname: frontend1.chef-server.com
         network:
         - ["private_network", {ip: "123.456.789.0"}]
         customize:
           memory: 2048
           cpus: 2
       run_list:
         - recipe[chef-server::configfile]
         - recipe[chef-server::ntp]
         - recipe[chef-server::server]
         - recipe[chef-server::frontend]
     - name: frontend2
       driver:
         vm_hostname: frontend2.chef-server.com
         network:
         - ["private_network", {ip: "123.456.789.0"}]
         customize:
           memory: 2048
           cpus: 2
       run_list:
         - recipe[chef-server::configfile]
         - recipe[chef-server::ntp]
         - recipe[chef-server::server]
         - recipe[chef-server::frontend]
     - name: backend
       driver:
         vm_hostname: backend.chef-server.com
         network:
         - ["private_network", {ip: "123.456.789.0"}]
         customize:
           memory: 8192
           cpus: 4
       run_list:
         - recipe[chef-server::configfile]
         - recipe[chef-server::ntp]
         - recipe[chef-server::server]
         - recipe[chef-server::backend]

Kitchen Converge On System Reboot
--------------------------------------------------------------------------
Test-Kitchen can handle reboots (when initiated from chef-client) by setting ``retry_on_exit_code``, ``max_retries`` and ``wait_for_retry`` attributes on the provisioner in ``.kitchen.yml`` file as follows :

.. code-block:: yaml

   ---
   provisioner:
      name: chef_zero
      require_chef_omnibus: 12.11 # need the RFC 062 exit codes
      retry_on_exit_code:
        - 35 # 35 is the exit code signaling that the node is rebooting
        - 1
      max_retries: 1
      client_rb:
        exit_status: :enabled # Opt-in to the standardized exit codes
        client_fork: false  # Forked instances don't return the real exit code

**One note on linux nodes**: The shutdown command blocks (as opposed to the windows variant which registers the reboot and returns right away), so once the timeout period passes, chef-client and the node are in a race to see who can exit/shutdown first - so you may or may not get the exit code out of linux instances. In that case, you can add ``1`` to the ``retry_on_exit_code`` array and that should catch both cases.

Please refer `YAML documentation <https://symfony.com/doc/current/components/yaml/yaml_format.html#collections>`__ to set ``retry_on_exit_code`` attribute.
