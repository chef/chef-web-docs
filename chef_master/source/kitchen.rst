=====================================================
Kitchen
=====================================================
`[edit on GitHub] <https://github.com/chef/chef-web-docs/blob/master/chef_master/source/kitchen.rst>`__

.. tag test_kitchen

Use `Test Kitchen <http://kitchen.ci>`_  to automatically test cookbook data across any combination of platforms and test suites:

* Defined in a .kitchen.yml file. See the `configuration </config_yml_kitchen.html>`_ documentation for options and syntax information.
* Uses a driver plugin architecture
* Supports cookbook testing across many cloud providers and virtualization technologies
* Supports all common testing frameworks that are used by the Ruby community
* Uses a comprehensive set of base images provided by `Bento <https://github.com/chef/bento>`_

.. end_tag

The key concepts in Kitchen are:

* A platform is the operating system or target environment on which a cookbook is to be tested
* A suite is the chef-client configuration, a run-list, and (optionally) node attributes
* An instance is the combination of a specific platform and a specific suite, with each instance being assigned an auto-generated name
* A driver is the lifecycle that implements the actions associated with a specific instance---create the instance, do what is needed to converge on that instance (such as installing the chef-client, uploading cookbooks, starting the chef-client run, and so on), setup anything else needed for testing, verify one (or more) suites post-converge, and then destroy that instance
* A provisioner is the component on which the chef-client code will be run, either using chef-zero or chef-solo via the ``chef_zero`` and ``chef_solo`` provisioners, respectively

Bento
=====================================================
.. tag bento

`Bento <https://github.com/chef/bento>`_ is a project that contains a set of base images that are used by Chef for internal testing and to provide a comprehensive set of base images for use with Kitchen. By default, Kitchen uses the base images provided by Bento. (Custom images may also be built using Packer.)

.. end_tag

Test Frameworks
=====================================================
An integration test is an executable test that fails when the assumptions defined by the test are proven to be false. Each test is written in Ruby and must be located in the ``/tests`` directory within the cookbook to be tested.

The following frameworks are good options for building integration tests with Kitchen:

.. list-table::
   :widths: 150 450
   :header-rows: 1

   * - Test Framework
     - Description
   * - `Bats <https://github.com/sstephenson/bats>`_
     - bats (or Bash Automated Testing System) is an testing framework for Bash. Bats is also the default framework for Kitchen.
   * - `Minitest <https://github.com/seattlerb/minitest>`_
     - A small, fast, testing framework.
   * - `Rspec <http://rspec.info>`_
     - The primary testing framework for Ruby, using the words ``describe`` and ``it`` to express tests as conversation. bats, Minitest, Serverspec are all based on RSpec.
   * - `Serverspec <http://serverspec.org>`_
     - RSpec-based tests for servers.

The syntax used for the tests depends on the testing framework. RSpec-based testing is similar to the following:

.. code-block:: ruby

   it 'what_the_test_does' do
     # Ruby code that defines the test
   end

For example:

.. code-block:: ruby

   it 'contains the default configuration settings' do
     file(File.join(node['chef_client']['conf_dir'], 'client.rb')).must_match('^chef_server_url')
     file(File.join(node['chef_client']['conf_dir'], 'client.rb')).must_match('^validation_client_name')
   end

or:

.. code-block:: ruby

   it 'converts ssl_verify_mode to a symbol' do
     file(File.join(node['chef_client']['conf_dir'], 'client.rb')).must_match('^ssl_verify_mode :verify_peer')
   end

or:

.. code-block:: ruby

   it 'disables ohai plugins' do
     regexp = 'Ohai::Config\[:disabled_plugins\] =\s+\["passwd"\]'
     file(File.join(node['chef_client']['conf_dir'], 'client.rb')).must_match(/#{regexp}/)
   end

Handlers can also be run as part of cookbook testing. At the top of the test file, use:

.. code-block:: ruby

   require File.expand_path('../support/helpers', __FILE__)

to specify the handler, and then include the handler within the test:

.. code-block:: ruby

   it 'enables exception_handlers' do
     file(File.join(node['chef_client']['conf_dir'], 'client.rb')).must_match(
       '^exception_handlers << Report::UpdateResource.new'
     )
   end

Busser
-----------------------------------------------------
Busser is a test setup and execution framework that is designed to work on remote nodes whose system dependencies cannot be relied upon. Kitchen uses Busser to run post-convergence tests via a plugin architecture that supports different test frameworks. Busser is installed automatically as part of Kitchen.

Drivers
=====================================================
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

kitchen (executable)
=====================================================
.. tag ctl_kitchen_summary

kitchen is the command-line tool for Kitchen, an integration testing tool used by the chef-client. Kitchen runs tests against any combination of platforms using any combination of test suites. Each test, however, is done against a specific instance, which is comprised of a single platform and a single set of testing criteria. This allows each test to be run in isolation, ensuring that different behaviors within the same codebase can be tested thoroughly before those changes are committed to production.

.. note:: Any Kitchen subcommand that does not specify an instance will be applied to all instances.

.. end_tag

.. note:: For more information about the ``kitchen`` command line tool, see `kitchen </ctl_kitchen.html>`__.

.kitchen.yml
=====================================================
.. tag test_kitchen_yml

Use a .kitchen.yml file to define what is required to run Kitchen, including drivers, provisioners, platforms, and test suites.

.. end_tag

.. note:: For more information about the .kitchen.yml file, see `kitchen.yml </config_yml_kitchen.html>`__.

Syntax
-----------------------------------------------------
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
* ``platform-version`` is a the name of a platform on which Kitchen will perform cookbook testing, for example, ``ubuntu-12.04`` or ``centos-6.4``; depending on the platform, additional driver details---for example, instance names and URLs used with cloud platforms like OpenStack or Amazon EC2---may be required
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
     - name: ubuntu-12.04
     - name: centos-6.4
     - name: debian-7.1.0

  suites:
    - name: default
      run_list:
        - recipe[apache::httpd]
      excludes:
        - debian-7.1.0

This file uses Vagrant as the driver, which requires no additional configuration because it's the default driver used by Kitchen, chef-zero as the provisioner, and a single (default) test suite that runs on Ubuntu 12.04, and CentOS 6.4.

.. end_tag

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

For more information ...
=====================================================
For more information about test-driven development and Kitchen:

* `kitchen.ci <http://kitchen.ci>`_
* `Getting Started with Kitchen <http://kitchen.ci/docs/getting-started/>`_
* `How Can I Combine Berks and Local Cookbooks? <https://coderwall.com/p/j72egw/organise-your-site-cookbooks-with-berkshelf-and-this-trick>`_
