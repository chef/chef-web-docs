.. THIS PAGE IS IDENTICAL TO docs.chef.io/kitchen.html BY DESIGN
.. THIS PAGE IS LOCATED AT THE /release/devkit/ PATH.

=====================================================
Kitchen
=====================================================

.. include:: ../../includes_test_kitchen/includes_test_kitchen.rst

The key concepts in Kitchen are:

* A platform is the operating system or target environment on which a cookbook is to be tested
* A suite is the chef-client configuration, a run-list, and (optionally) node attributes
* An instance is the combination of a specific platform and a specific suite, with each instance being assigned an auto-generated name
* A driver is the lifecycle that implements the actions associated with a specific instance---create the instance, do what is needed to converge on that instance (such as installing the chef-client, uploading cookbooks, starting the chef-client run, and so on), setup anything else needed for testing, verify one (or more) suites post-converge, and then destroy that instance 
* A provisioner is the component on which the chef-client code will be run, either using chef-zero or chef-solo via the ``chef_zero`` and ``chef_solo`` provisioners, respectively

Bento
=====================================================
.. include:: ../../includes_bento/includes_bento.rst

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
.. include:: ../../includes_test_kitchen/includes_test_kitchen_drivers.rst

kitchen (executable)
=====================================================
.. include:: ../../includes_ctl_kitchen/includes_ctl_kitchen.rst

.. note:: For more information about the ``kitchen`` command line tool, see :doc:`kitchen </ctl_kitchen>`. 

.kitchen.yml
=====================================================
.. include:: ../../includes_test_kitchen/includes_test_kitchen_yml.rst

.. note:: For more information about the .kitchen.yml file, see :doc:`kitchen.yml </config_yml_kitchen>`. 

Syntax
-----------------------------------------------------
.. include:: ../../includes_test_kitchen/includes_test_kitchen_yml_syntax.rst

Work with Proxies
--------------------------------------------------------------------------
.. include:: ../../includes_test_kitchen/includes_test_kitchen_yml_syntax_proxy.rst

For more information ...
=====================================================
For more information about test-driven development and Kitchen:

* `kitchen.ci <http://kitchen.ci>`_
* `Getting Started with Kitchen <http://kitchen.ci/docs/getting-started/>`_
* `Test-Driven Infrastructure with Chef, 2nd Edition <http://shop.oreilly.com/product/0636920030973.do>`_, by Stephen Nelson-Smith (O'Reilly Media)
* `How Can I Combine Berks and Local Cookbooks? <https://coderwall.com/p/j72egw/organise-your-site-cookbooks-with-berkshelf-and-this-trick>`_
        
