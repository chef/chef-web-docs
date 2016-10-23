.. THIS PAGE IS IDENTICAL TO docs.chef.io/config_yml_kitchen.html BY DESIGN
.. THIS PAGE IS LOCATED AT THE /release/devkit/ PATH.

==========================================================================
.kitchen.yml
==========================================================================

.. include:: ../../includes_test_kitchen/includes_test_kitchen.rst

.. include:: ../../includes_test_kitchen/includes_test_kitchen_yml.rst

.. note:: This topic details functionality that is packaged with Chef development kit. See http://kitchen.ci/docs/getting-started/ for more information about Kitchen.

Syntax
==========================================================================
.. include:: ../../includes_test_kitchen/includes_test_kitchen_yml_syntax.rst

Provisioner Settings
==========================================================================
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
     - 
   * - ``chef_omnibus_install_options``
     - Use to specify the package to be installed. Possible values: ``-P chef`` (for the chef-client) and ``-P chefdk`` (for the chef-client that is packaged as part of the Chef development kit). Use ``-n`` to specify the nightly build. For example: ``-P chefdk`` or ``-n -P chefdk``.
   * - ``chef_omnibus_root``
     - Default value: ``/etc/opt`` for UNIX and Linux, ``$env:systemdrive\\opscode\\chef`` on Microsoft Windows.
   * - ``chef_omnibus_url``
     - The URL for an ``install.sh`` script that will install chef-client on the machine under test. Default value: ``https://www.chef.io/chef/install.sh``.
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
   * - ``driver``
     - Use to specify a driver for a platform. This will override the default driver.
   * - ``encrypted_data_bag_secret_key_path``
     - The path to an RSA key file that is used to decrypt encrypted data bag items.
   * - ``environments_path``
     - The relative path to the directory in which environment data is located. This data must be defined as JSON.
   * - ``http_proxy``
     - The proxy server for HTTP connections.
   * - ``https_proxy``
     - The proxy server for HTTPS connections.
   * - ``install_msi_url``
     - An alternate URL for a Windows MSI package that will install chef-client on the machine under test.
   * - ``json_attributes``
     - chef-client provisioner only. 
   * - ``log_file``
     - 
   * - ``nodes_path``
     - The relative path to the directory in which node data is located. This data must be defined as JSON.
   * - ``require_chef_omnibus``
     - Use to install the latest version of the chef-client in a node. Set to ``true`` to install the latest version, ``false`` to not install chef-client (assumes the box already has it installed), or a version specifier like ``11.8.0`` to install a particular version. When set to ``true`` or a version number, the ``chef_omnibus_url`` may be used to specify the URL of the ``install.sh`` that installs the specified version of chef-client. Default value: ``true``.
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

These settings may be added to the ``provisioner`` section of the .kitchen.yml file when the provisioner is chef-zero or chef-solo.


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
.. include:: ../../includes_test_kitchen/includes_test_kitchen_yml_syntax_proxy.rst

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
.. include:: ../../includes_bento/includes_bento.rst

Drivers
--------------------------------------------------------------------------
.. include:: ../../includes_test_kitchen/includes_test_kitchen_drivers.rst

kitchen-vagrant
--------------------------------------------------------------------------
.. include:: ../../includes_test_kitchen/includes_test_kitchen_driver_vagrant.rst

.. include:: ../../includes_test_kitchen/includes_test_kitchen_driver_vagrant_settings.rst

.. include:: ../../includes_test_kitchen/includes_test_kitchen_driver_vagrant_config.rst

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
     - name: centos-7.0
       run_list:
         - recipe[audit-cis::centos7-100]
     - name: centos-6.6
       run_list:
       - recipe[audit-cis::centos6-110]
   
   suites:
     - name: default

where ``audit_mode`` may be ``:enabled``, ``:disabled`` (default), or ``:audit_only``.

mysql Cookbook
--------------------------------------------------------------------------
The most impressive (and thorough) .kitchen.yml files are part of the ``mysql`` cookbook. They are too big to paste into this topic, so please see them at the following links:

* `.kitchen.yml <https://github.com/chef-cookbooks/mysql/blob/master/.kitchen.yml>`__
* `.kitchen.cloud.yml <https://github.com/chef-cookbooks/mysql/blob/master/.kitchen.dokken.yml>`__

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
     - name: centos-6.8
     - name: centos-7.2
     - name: omnios-r151006c
       driver:
         box: omnios-r151006c
         box_url: http://omnios.omniti.com/media/OmniOS_r151006c-r1.box

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

Multiple Cookbooks
--------------------------------------------------------------------------
The following example shows how to use the ``chef_solo`` provisioner without Berkshelf in a way that allows multiple cookbooks:

.. code-block:: yaml

   provisioner:
     name: chef_solo
     roles_path: '../../roles'
     data_bags_path: '../../data_bags'
     environments_path: '../../environments'
     cookbooks_path:
       - ../cookbooks
       - ../../site-cookbooks

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
     - name: ubuntu-12.04
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
