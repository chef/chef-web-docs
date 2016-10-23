=====================================================
Release Notes: chef-client 12.13
=====================================================

.. include:: ../../includes_chef/includes_chef.rst

What's New
=====================================================
The following items are new for chef-client 12.13 and/or are changes from previous versions. The short version:

* **Ohai 8.18 includes new plugin for gathering available user shells** Other additions include a new hardware plugin for OSX that gathers system information and detection of VMWare and VirtualBox installations.
* **New Chef client option to override any config key/value pair** Use ``chef-client --config-option`` to override any config setting from the command line.

--config-option
-----------------------------------------------------
Use the ``--config-option`` option to override a single configuration option when calling a command on ``chef-client``. To override multiple configuration options, simply add additional ``--config-option`` options like in the following example:

.. code-block:: bash

   $ chef-client --config-option chef_server_url=http://example --config-option policy_name=web"


Updated Dependencies
-----------------------------------------------------
* ruby - 2.1.9 (from 2.1.8)

Updated Gems
+++++++++++++++++++++++++++++++++++++++++++++++++++++
* chef-zero - 4.8.0 (from 4.7.0)
* cheffish - 2.0.5 (from 2.0.4)
* compat_resource - 12.10.7 (from 12.10.6)
* ffi - 1.9.14 (from 1.9.10)
* ffi-yajl - 2.3.0 (from 2.2.3)
* fuzzyurl - 0.9.0 (from 0.8.0)
* mixlib-cli - 1.7.0 (from 1.6.0)
* mixlib-log - 1.7.0 (from 1.6.0)
* ohai - 8.18.0 (from 8.17.1)
* pry - 0.10.4 (from 0.10.3)
* rspec - 3.5.0 (from 3.4.0)
* rspec-core - 3.5.2 (from 3.4.4)
* rspec-expectations - 3.5.0 (from 3.4.0)
* rspec-mocks - 3.5.0 (from 3.4.1)
* rspec-support - 3.5.0 (from 3.4.1)
* simplecov - 0.12.0 (from 0.11.2)
* specinfra - 2.60.3 (from 2.59.4)
* mixlib-archive - 0.2.0 (added to package)


Changelog
=====================================================
https://github.com/chef/chef/blob/master/CHANGELOG.md
