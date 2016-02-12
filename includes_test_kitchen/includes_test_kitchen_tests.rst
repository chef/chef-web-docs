.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


An integration test is an executable test that fails when the assumptions defined by the test are proven to be false. Each test is written in |ruby| and must be located in the ``/tests`` directory within the cookbook to be tested. 

The following frameworks are good options for building integration tests with |kitchen|: 

.. list-table::
   :widths: 150 450
   :header-rows: 1

   * - Test Framework
     - Description
   * - `Bats <https://github.com/sstephenson/bats>`_
     - |bash_bats| (or Bash Automated Testing System) is an testing framework for |bash|. Bats is also the default framework for |kitchen|.
   * - `Minitest <https://github.com/seattlerb/minitest>`_
     - A small, fast, testing framework.
   * - `Rspec <http://rspec.info>`_
     - The primary testing framework for |ruby|, using the words ``describe`` and ``it`` to express tests as conversation. |bash_bats|, |minitest|, |serverspec| are all based on |rspec|. 
   * - `Serverspec <http://serverspec.org>`_
     - |rspec|-based tests for servers.

The syntax used for the tests depends on the testing framework. |rspec|-based testing is similar to the following:

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
