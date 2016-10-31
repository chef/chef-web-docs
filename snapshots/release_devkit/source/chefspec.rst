


=====================================================
ChefSpec
=====================================================

.. include:: ../../includes_chefspec/includes_chefspec.rst

ChefSpec is a framework that tests resources and recipes as part of a simulated chef-client run. ChefSpec tests execute very quickly. When used as part of the cookbook authoring workflow, ChefSpec tests are often the first indicator of problems that may exist within a cookbook.

.. 
.. The following topic needs to be better before it can be uncommented, along with an H1 (=====) header added.
..
.. .. include:: ../../includes_chefspec/includes_chefspec_compare_to_resource.rst
..

Run ChefSpec
=====================================================
ChefSpec is packaged as part of the Chef development kit. To run ChefSpec:

.. code-block:: bash

   $ chef exec rspec

Unit Tests
=====================================================
.. include:: ../../includes_rspec/includes_rspec.rst

ChefSpec is built on the RSpec DSL.

Syntax
-----------------------------------------------------
.. include:: ../../includes_rspec/includes_rspec_syntax.rst

context
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_rspec/includes_rspec_syntax_context.rst

let
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_rspec/includes_rspec_syntax_let.rst

Require ChefSpec
-----------------------------------------------------
A ChefSpec unit test must contain the following statement at the top of the test file:

.. code-block:: ruby

   require 'chefspec'

Examples
=====================================================
The ChefSpec repo on github has `an impressive collection of examples <https://github.com/sethvargo/chefspec/tree/master/examples>`_. For all of the core chef-client resources, for guards, attributes, multiple actions, and so on. Take a look at those examples and use them as a starting point for building your own unit tests. Some of them are included below, for reference here.

file Resource
-----------------------------------------------------
**Recipe**

.. code-block:: ruby

   file '/tmp/explicit_action' do
     action :delete
   end

   file '/tmp/with_attributes' do
     user 'user'
     group 'group'
     backup false
     action :delete
   end

   file 'specifying the identity attribute' do
     path   '/tmp/identity_attribute'
    action :delete
   end

**Unit Test**

.. code-block:: ruby

   require 'chefspec'

   describe 'file::delete' do
     let(:chef_run) { ChefSpec::SoloRunner.new(platform: 'ubuntu', version: '16.04').converge(described_recipe) }

     it 'deletes a file with an explicit action' do
       expect(chef_run).to delete_file('/tmp/explicit_action')
       expect(chef_run).to_not delete_file('/tmp/not_explicit_action')
     end

     it 'deletes a file with attributes' do
       expect(chef_run).to delete_file('/tmp/with_attributes').with(backup: false)
       expect(chef_run).to_not delete_file('/tmp/with_attributes').with(backup: true)
     end

     it 'deletes a file when specifying the identity attribute' do
       expect(chef_run).to delete_file('/tmp/identity_attribute')
     end
   end

template Resource
-----------------------------------------------------
**Recipe**

.. code-block:: ruby

   template '/tmp/default_action'

   template '/tmp/explicit_action' do
     action :create
   end

   template '/tmp/with_attributes' do
     user 'user'
     group 'group'
     backup false
   end

   template 'specifying the identity attribute' do
     path '/tmp/identity_attribute'
   end

**Unit Test**

.. code-block:: ruby

   require 'chefspec'

   describe 'template::create' do
     let(:chef_run) { ChefSpec::SoloRunner.new(platform: 'ubuntu', version: '16.04').converge(described_recipe) }

     it 'creates a template with the default action' do
       expect(chef_run).to create_template('/tmp/default_action')
       expect(chef_run).to_not create_template('/tmp/not_default_action')
     end

     it 'creates a template with an explicit action' do
       expect(chef_run).to create_template('/tmp/explicit_action')
     end

     it 'creates a template with attributes' do
       expect(chef_run).to create_template('/tmp/with_attributes').with(
         user: 'user',
         group: 'group',
         backup: false,
       )

       expect(chef_run).to_not create_template('/tmp/with_attributes').with(
         user: 'bacon',
         group: 'fat',
         backup: true,
       )
     end

     it 'creates a template when specifying the identity attribute' do
       expect(chef_run).to create_template('/tmp/identity_attribute')
     end
   end

package Resource
-----------------------------------------------------
**Recipe**

.. code-block:: ruby

   package 'explicit_action' do
     action :remove
   end

   package 'with_attributes' do
     version '1.0.0'
     action :remove
   end

   package 'specifying the identity attribute' do
     package_name 'identity_attribute'
     action :remove
   end

**Unit Test**

.. code-block:: ruby

   require 'chefspec'

   describe 'package::remove' do
     let(:chef_run) { ChefSpec::SoloRunner.new(platform: 'ubuntu', version: '16.04').converge(described_recipe) }

     it 'removes a package with an explicit action' do
       expect(chef_run).to remove_package('explicit_action')
       expect(chef_run).to_not remove_package('not_explicit_action')
     end

     it 'removes a package with attributes' do
       expect(chef_run).to remove_package('with_attributes').with(version: '1.0.0')
       expect(chef_run).to_not remove_package('with_attributes').with(version: '1.2.3')
     end

     it 'removes a package when specifying the identity attribute' do
       expect(chef_run).to remove_package('identity_attribute')
     end
   end

chef_gem Resource
-----------------------------------------------------
**Recipe**

.. code-block:: ruby

   chef_gem 'default_action'

   chef_gem 'explicit_action' do
     action :install
   end

   chef_gem 'with_attributes' do
     version '1.0.0'
   end

   chef_gem 'specifying the identity attribute' do
     package_name 'identity_attribute'
   end

**Unit Test**

.. code-block:: ruby

   require 'chefspec'

   describe 'chef_gem::install' do
     let(:chef_run) { ChefSpec::SoloRunner.new(platform: 'ubuntu', version: '16.04').converge(described_recipe) }

     it 'installs a chef_gem with the default action' do
       expect(chef_run).to install_chef_gem('default_action')
       expect(chef_run).to_not install_chef_gem('not_default_action')
     end

     it 'installs a chef_gem with an explicit action' do
       expect(chef_run).to install_chef_gem('explicit_action')
     end

     it 'installs a chef_gem with attributes' do
       expect(chef_run).to install_chef_gem('with_attributes').with(version: '1.0.0')
       expect(chef_run).to_not install_chef_gem('with_attributes').with(version: '1.2.3')
     end

     it 'installs a chef_gem when specifying the identity attribute' do
       expect(chef_run).to install_chef_gem('identity_attribute')
     end
   end

directory Resource
-----------------------------------------------------
**Recipe**

.. code-block:: ruby

   directory '/tmp/default_action'

   directory '/tmp/explicit_action' do
     action :create
   end

   directory '/tmp/with_attributes' do
     user 'user'
     group 'group'
   end

   directory 'specifying the identity attribute' do
     path '/tmp/identity_attribute'
   end

**Unit Test**

.. code-block:: ruby

   require 'chefspec'

   describe 'directory::create' do
     let(:chef_run) { ChefSpec::SoloRunner.new(platform: 'ubuntu', version: '16.04').converge(described_recipe) }

     it 'creates a directory with the default action' do
       expect(chef_run).to create_directory('/tmp/default_action')
       expect(chef_run).to_not create_directory('/tmp/not_default_action')
     end

     it 'creates a directory with an explicit action' do
       expect(chef_run).to create_directory('/tmp/explicit_action')
     end

     it 'creates a directory with attributes' do
       expect(chef_run).to create_directory('/tmp/with_attributes').with(
         user: 'user',
         group: 'group',
       )

       expect(chef_run).to_not create_directory('/tmp/with_attributes').with(
         user: 'bacon',
         group: 'fat',
       )
     end

     it 'creates a directory when specifying the identity attribute' do
       expect(chef_run).to create_directory('/tmp/identity_attribute')
     end
   end

Guards
-----------------------------------------------------
**Recipe**

.. code-block:: ruby

   service 'true_guard' do
     action  :start
     only_if { 1 == 1 }
   end

   service 'false_guard' do
     action :start
     not_if { 1 == 1 }
   end

   service 'action_nothing_guard' do
     action :nothing
   end

**Unit Test**

.. code-block:: ruby

   require 'chefspec'

   describe 'guards::default' do
     let(:chef_run) { ChefSpec::SoloRunner.new(platform: 'ubuntu', version: '16.04').converge(described_recipe) }

     it 'includes resource that have guards that evalute to true' do
       expect(chef_run).to start_service('true_guard')
     end

     it 'excludes resources that have guards evaluated to false' do
       expect(chef_run).to_not start_service('false_guard')
     end

     it 'excludes resource that have action :nothing' do
       expect(chef_run).to_not start_service('action_nothing_guard')
     end
   end

include_recipe Method
-----------------------------------------------------
**Recipe**

.. code-block:: ruby

   include_recipe 'include_recipe::other'

**Unit Test**

.. code-block:: ruby

   require 'chefspec'

   describe 'include_recipe::default' do
     let(:chef_run) { ChefSpec::SoloRunner.new(platform: 'ubuntu', version: '16.04').converge(described_recipe) }

     it 'includes the `other` recipe' do
       expect(chef_run).to include_recipe('include_recipe::other')
     end

     it 'does not include the `not` recipe' do
       expect(chef_run).to_not include_recipe('include_recipe::not')
     end
   end

Multiple Actions
-----------------------------------------------------
**Recipe**

.. code-block:: ruby

   service 'resource' do
     action :start
   end

   service 'resource' do
     action :nothing
   end

**Unit Test**

.. code-block:: ruby

   require 'chefspec'

   describe 'multiple_actions::sequential' do
     let(:chef_run) { ChefSpec::SoloRunner.new(platform: 'ubuntu', version: '16.04', log_level: :fatal).converge(described_recipe) }

     it 'executes both actions' do
       expect(chef_run).to start_service('resource')
     end

     it 'does not match other actions' do
       expect(chef_run).to_not disable_service('resource')
     end
   end

For more information ...
=====================================================
For more information about ChefSpec:

* `ChefSpec GitHub Repo <https://github.com/sethvargo/chefspec>`_

.. * `RSpec Documentation <https://relishapp.com/rspec/rspec-core/v/3-4/docs/command-line>`_
