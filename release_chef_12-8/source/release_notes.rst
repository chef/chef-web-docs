=====================================================
Release Notes: |chef client| 12.8
=====================================================

.. include:: ../../includes_chef/includes_chef.rst

What's New
=====================================================
The following items are new for |chef client| 12.8 and/or are changes from previous versions. The short version:

* **Support for OpenSSL validation of FIPS** The |chef client| can be configured to allow |open ssl| to enforce |fips|-validated security during a |chef client| run.
* **Support for multiple configuration files** The |chef client| supports reading multiple configuration files by putting them inside a ``.d`` configuration directory.
* **New launchd resource** Use the |resource launchd| resource to manage system-wide services (daemons) and per-user services (agents) on the |mac os x| platform.
* **New property for the mdadm resource** Use the ``mdadm_defaults`` property to set the default values for ``chunk`` and ``metadata`` to ``nil``, which allows |mdadm| to apply its own default values.
* **chef-zero support for Chef Server API endpoints** |chef zero| now supports using all |api chef server| version 12 endpoints, with the exception of ``/universe``.
* **Updated support for OpenSSL** |open ssl| is updated to version 1.0.1.
* **Ohai auto-detects hosts for Azure instances** |ohai| will auto-detect hosts for instances that are hosted by |azure|.
* **gem attribute added to metadata.rb** Specify a gem dependency to be installed via the |resource chef_gem| resource after all cookbooks are synchronized, but before any other cookbook loading is done.


|fips| Mode
-----------------------------------------------------
.. include:: ../../includes_chef_client/includes_chef_client_fips_mode.rst

Enable FIPS Mode
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_chef_client/includes_chef_client_fips_mode_enable.rst

Command Option
+++++++++++++++++++++++++++++++++++++++++++++++++++++
The following command-line option may be used to with a |knife| or |chef client| executable command:

``--[no-]fips``
  |chef_client fips|

**Bootstrap a node using FIPS**

.. include:: ../../step_knife/step_knife_bootstrap_node_fips.rst

Configuration Setting
+++++++++++++++++++++++++++++++++++++++++++++++++++++
The following configuration setting may be set in the |knife rb|, |client rb|, or |config rb| files:

``fips``
  |chef_client fips| Set to ``true`` to enable |fips|-validated security.


.d Directories
-----------------------------------------------------
The |chef client| supports reading multiple configuration files by putting them inside a ``.d`` configuration directory. For example: ``/etc/chef/client.d``. All files that end in ``.rb`` in the ``.d`` directory are loaded; other non-``.rb`` files are ignored.

``.d`` directories may exist in any location where the ``client.rb``, ``config.rb``, or ``solo.rb`` files are present, such as:

* ``/etc/chef/client.d``
* ``/etc/chef/config.d``
* ``~/chef/solo.d``
* ``c:/chef/config.d``

(There is no support for a ``knife.d`` directory; use ``config.d`` instead.)

For example, when using |knife|, the following configuration files would be loaded:

* ``~/.chef/config.rb``
* ``~/.chef/config.d/company_settings.rb``
* ``~/.chef/config.d/ec2_configuration.rb``
* ``~/.chef/config.d/old_settings.rb.bak``

The ``old_settings.rb.bak`` file is ignored because it's not a configuration file. The ``config.rb``, ``company_settings.rb``, and ``ec2_configuration`` files are merged together as if they are a single configuration file.

.. note:: If multiple configuration files exists in a ``.d`` directory, ensure that the same setting has the same value in all files.


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
