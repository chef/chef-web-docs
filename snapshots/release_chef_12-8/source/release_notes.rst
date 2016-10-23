=====================================================
Release Notes: chef-client 12.8
=====================================================

.. include:: ../../includes_chef/includes_chef.rst

What's New
=====================================================
The following items are new for chef-client 12.8 and/or are changes from previous versions. The short version:

* **Support for OpenSSL validation of FIPS** The chef-client can be configured to allow OpenSSL to enforce FIPS-validated security during a chef-client run.
* **Support for multiple configuration files** The chef-client supports reading multiple configuration files by putting them inside a ``.d`` configuration directory.
* **New launchd resource** Use the **launchd** resource to manage system-wide services (daemons) and per-user services (agents) on the Mac OS X platform.
* **chef-zero support for Chef Server API endpoints** chef-zero now supports using all Chef server API version 12 endpoints, with the exception of ``/universe``.
* **Updated support for OpenSSL** OpenSSL is updated to version 1.0.1.
* **Ohai auto-detects hosts for Azure instances** Ohai will auto-detect hosts for instances that are hosted by Microsoft Azure.
* **gem attribute added to metadata.rb** Specify a gem dependency to be installed via the **chef_gem** resource after all cookbooks are synchronized, but before any other cookbook loading is done.


FIPS Mode
-----------------------------------------------------
.. include:: ../../includes_chef_client/includes_chef_client_fips_mode.rst

Enable FIPS Mode
+++++++++++++++++++++++++++++++++++++++++++++++++++++
Allowing OpenSSL to enforce FIPS-validated security may be enabled by using any of the following ways:

* Set the ``fips`` configuration setting to ``true`` in the client.rb or knife.rb files
* Set the ``--fips`` command-line option when running any knife command or the chef-client executable
* Set the ``--fips`` command-line option when bootstrapping a node using the ``knife bootstrap`` command

Command Option
+++++++++++++++++++++++++++++++++++++++++++++++++++++
The following command-line option may be used to with a knife or chef-client executable command:

``--[no-]fips``
  Allows OpenSSL to enforce FIPS-validated security during the chef-client run.

**Bootstrap a node using FIPS**

.. include:: ../../step_knife/step_knife_bootstrap_node_fips.rst

Configuration Setting
+++++++++++++++++++++++++++++++++++++++++++++++++++++
The following configuration setting may be set in the knife.rb, client.rb, or config.rb files:

``fips``
  Allows OpenSSL to enforce FIPS-validated security during the chef-client run. Set to ``true`` to enable FIPS-validated security.


.d Directories
-----------------------------------------------------
.. include:: ../../includes_config/includes_config_rb_client_dot_d_directories.rst


launchd
-----------------------------------------------------
.. include:: ../../includes_resources/includes_resource_launchd.rst

Syntax
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_launchd_syntax.rst

Actions
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_launchd_actions.rst

Properties
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_launchd_attributes.rst

Examples
+++++++++++++++++++++++++++++++++++++++++++++++++++++

**Create a Launch Daemon from a cookbook file**

.. include:: ../../step_resource/step_resource_launchd_create_from_cookbook.rst

**Create a Launch Daemon using keys**

.. include:: ../../step_resource/step_resource_launchd_create_using_keys.rst

**Remove a Launch Daemon**

.. include:: ../../step_resource/step_resource_launchd_remove.rst

gem, metadata.rb
-----------------------------------------------------
.. include:: ../../includes_config/includes_config_rb_metadata_settings_gem.rst


Changelog
=====================================================
https://github.com/chef/chef/blob/master/CHANGELOG.md
