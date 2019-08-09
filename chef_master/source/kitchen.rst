=====================================================
Test Kitchen
=====================================================
`[edit on GitHub] <https://github.com/chef/chef-web-docs/blob/master/chef_master/source/kitchen.rst>`__

.. tag test_kitchen

Use `Test Kitchen <https://kitchen.ci/>`_  to automatically test cookbooks across any combination of platforms and test suites:

* Test suites are defined in a kitchen.yml file. See the `configuration </config_yml_kitchen.html>`_ documentation for options and syntax information.
* Supports cookbook testing across many cloud providers and virtualization technologies.
* Uses a comprehensive set of operating system base images from Chef's `Bento <https://github.com/chef/bento>`_ project.

.. end_tag

The key concepts in Test Kitchen are:

* A platform is the operating system or target environment on which a cookbook is to be tested
* A suite is the Chef Infra Client configuration, a Policyfile or run-list, and (optionally) node attributes
* An instance is the combination of a specific platform and a specific suite, with each instance being assigned an auto-generated name
* A driver is the lifecycle that implements the actions associated with a specific instance---create the instance, do what is needed to converge on that instance (such as installing Chef Infra Client, uploading cookbooks, starting a Chef Infra Client run, and so on), setup anything else needed for testing, verify one (or more) suites post-converge, and then destroy that instance
* A provisioner is the component on which the Chef Infra Client code will be run, either using chef-zero or chef-solo via the ``chef_zero`` and ``chef_solo`` provisioners, respectively

Bento
=====================================================
.. tag bento

`Bento <https://github.com/chef/bento>`_ is a Chef Software project that produces base testing VirtualBox, Parallels, and VMware boxes for multiple operating systems for use with Test Kitchen. By default, Test Kitchen uses the base images provided by Bento although custom images may also be built using Hashicorp Packer.

.. end_tag

Drivers
=====================================================
.. tag test_kitchen_drivers

Test Kitchen uses a driver plugin architecture to enable Test Kitchen to test instances on cloud providers such as Amazon EC2, Google Compute Engine, and Microsoft Azure. You can also test on multiple local hypervisors, such as VMware, Hyper-V, or VirtualBox.

.. note:: Chef Workstation includes many common Test Kitchen drivers.

Most drivers have driver-specific configuration settings that must be added to the kitchen.yml file before Test Kitchen will be able to use that platform during cookbook testing. For information about these driver-specific settings, please refer to the driver-specific documentation.

Some popular drivers:

.. list-table::
   :widths: 150 450
   :header-rows: 1

   * - Driver Plugin
     - Description
   * - `kitchen-cloudstack <https://github.com/test-kitchen/kitchen-cloudstack>`__
     - A driver for CloudStack.
   * - `kitchen-digitalocean <https://github.com/test-kitchen/kitchen-digitalocean>`__
     - A driver for DigitalOcean.
   * - `kitchen-docker <https://github.com/portertech/kitchen-docker>`__
     - A driver for Docker.
   * - `kitchen-dsc <https://github.com/test-kitchen/kitchen-dsc>`__
     - A driver for Windows PowerShell Desired State Configuration (DSC).
   * - `kitchen-ec2 <https://github.com/test-kitchen/kitchen-ec2>`__
     - A driver for Amazon EC2. This driver ships in Chef Workstation.
   * - `kitchen-google <https://github.com/test-kitchen/kitchen-google>`__
     - A driver for Google Compute Engine.  This driver ships in Chef Workstation
   * - `kitchen-hyperv <https://github.com/test-kitchen/kitchen-hyperv>`__
     - A driver for Hyper-V Server.
   * - `kitchen-openstack <https://github.com/test-kitchen/kitchen-openstack>`__
     - A driver for OpenStack.
   * - `kitchen-rackspace <https://github.com/test-kitchen/kitchen-rackspace>`__
     - A driver for Rackspace.
   * - `kitchen-vagrant <https://github.com/test-kitchen/kitchen-vagrant>`__
     - A driver for Vagrant. This driver ships in Chef Workstation.

.. end_tag

Validation with InSpec
=====================================================
Test Kitchen will create a VM or cloud instance, install Chef Infra Client to that system, and converge Chef Infra Client with your local cookbook. Once this is complete, you will want to perform automated validation against the infrastructure you have built to validate its configuration. Test Kitchen allows you to run InSpec tests against your converged cookbook for easy local validation of your infrastructure.

kitchen (executable)
=====================================================
.. tag ctl_kitchen_summary

kitchen is the command-line tool for Test Kitchen, an integration testing tool maintained by Chef Software. Test Kitchen runs tests against any combination of platforms using any combination of test suites. Each test, however, is done against a specific instance, which is comprised of a single platform and a single set of testing criteria. This allows each test to be run in isolation, ensuring that different behaviors within the same codebase can be tested thoroughly before those changes are committed to production.

.. note:: Any Test Kitchen subcommand that does not specify an instance will be applied to all instances.

.. end_tag

.. note:: For more information about the ``kitchen`` command line tool, see `kitchen </ctl_kitchen.html>`__.

kitchen.yml
=====================================================
.. tag test_kitchen_yml

Use a kitchen.yml file to define what is required to run Test Kitchen, including drivers, provisioners, platforms, and test suites.

.. end_tag

.. note:: For more information about the kitchen.yml file, see `kitchen.yml </config_yml_kitchen.html>`__.

Syntax
-----------------------------------------------------
.. tag test_kitchen_yml_syntax

The basic structure of a kitchen.yml file is as follows:

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
* ``provisioner_name`` specifies how Chef Infra Client will be simulated during testing. ``chef_zero``  and ``chef_solo`` are the most common provisioners used for testing cookbooks
* ``verifier_name`` specifies which application to use when running tests, such as ``inspec``
* ``transport_name`` specifies which transport to use when executing commands remotely on the test instance. ``winrm`` is the default transport on Windows. The ``ssh`` transport is the default on all other operating systems.
* ``platform-version`` is the name of a platform on which Test Kitchen will perform cookbook testing, for example, ``ubuntu-16.04`` or ``centos-7``; depending on the platform, additional driver details---for example, instance names and URLs used with cloud platforms like OpenStack or Amazon EC2---may be required
* ``platforms`` may define Chef Infra Server attributes that are common to the collection of test suites
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

For example, a very simple kitchen.yml file:

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

This file uses Vagrant as the driver, which requires no additional configuration because it's the default driver used by Test Kitchen, chef-zero as the provisioner, and a single (default) test suite that runs on Ubuntu 16.04, and CentOS 7.

.. end_tag

Work with Proxies
--------------------------------------------------------------------------
.. tag test_kitchen_yml_syntax_proxy

The environment variables ``http_proxy``, ``https_proxy``, and ``ftp_proxy`` are honored by Test Kitchen for proxies. The client.rb file is read to look for proxy configuration settings. If ``http_proxy``, ``https_proxy``, and ``ftp_proxy`` are specified in the client.rb file, Chef Infra Client will configure the ``ENV`` variable based on these (and related) settings. For example:

.. code-block:: ruby

   http_proxy 'http://proxy.example.org:8080'
   http_proxy_user 'myself'
   http_proxy_pass 'Password1'

will be set to:

.. code-block:: ruby

   ENV['http_proxy'] = 'http://myself:Password1@proxy.example.org:8080'

Test Kitchen also supports ``http_proxy`` and ``https_proxy`` in the ``kitchen.yml`` file. You can set them manually or have them read from your local environment variables:

.. code-block:: yaml

   driver:
     name: vagrant

   provisioner:
     name: chef_zero
     # Set proxy settings manually, or
     http_proxy: 'http://user:password@server:port'
     https_proxy: 'http://user:password@server:port'

     # Read from local environment variables
     http_proxy: <%= ENV['http_proxy'] %>
     https_proxy: <%= ENV['https_proxy'] %>

This will not set the proxy environment variables for applications other than Chef. The Vagrant plugin, `vagrant-proxyconf <http://tmatilai.github.io/vagrant-proxyconf/>`__, can be used to set the proxy environment variables for applications inside the VM.

.. end_tag

For more information ...
=====================================================
For more information about test-driven development and Test Kitchen:

* `kitchen.ci <https://kitchen.ci/>`_
* `Getting Started with Test Kitchen <https://kitchen.ci/docs/getting-started/introduction/>`_
