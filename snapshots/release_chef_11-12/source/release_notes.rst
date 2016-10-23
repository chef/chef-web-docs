=====================================================
Release Notes: chef-client 11.12
=====================================================

.. include:: ../../includes_chef/includes_chef.rst

What's New
=====================================================
The following items are new for chef-client 11.12 and/or are changes from previous versions. The short version:

* **Ohai 7.0** Ohai 7 is part of the chef-client 11-12 install
* **New windows_package resource** Use the **windows_package** resource to manage packages on the Microsoft Windows platform.
* **New guard_interpreter attribute** Use the ``guard_interpreter`` attribute to specify a **script**-based resource---**bash**, **csh**, **perl**, **powershell_script**, **python**, and **ruby**---that will be used to evaluate a string command.
* **New reboot_pending? Recipe DSL method** Use the ``reboot_pending?`` method to test if a Microsoft Windows node requires a reboot.
* **New convert_boolean_true attribute** Use the ``convert_boolean_true`` attribute to return ``0`` (true) or ``1`` (false) based on certain conditions in a **powershell_script** resource block.
* **knife ssl check** Use the ``knife ssl check`` subcommand to verify SSL configuration for the Chef server.
* **knife ssl fetch** Use the ``knife ssl fetch`` subcommand to copy SSL certificates from an HTTPS server to the ``trusted_certs_dir`` directory.
* **New options for knife client subcommands** New options allow the creation and deletion of the chef-validator.
* **New options for chef-client** A new option allows a run-list to be specified, and then set permanently.
* **Weekdays as symbols** The **cron** resource allows weekdays to be entered as a symbol, e.g. ``:monday`` or ``:friday``.
* **Generate the public/private key pair on a node** The ``local_key_generation`` setting has been added to the client.rb file. When ``true``, key pairs will be generated on the node and the public key will be sent to the Chef server.
* **knife cookbook test and .chefignore files** The ``knife cookbook test`` subcommand will respect the settings in a chefignore file.
* **knife bootstrap -V -V** The ``knife bootstrap`` command can set the initial chef-client run to be logged at the debug level.
* **Sensitive property added to common resource properties** Use the ``sensitive`` property with the **template** and **file** resources to ensure that sensitive data is not logged by the chef-client.
* **cron resource accepts symbols for weekday property** Symbols---``:sunday``, ``:monday``, ``:tuesday``, ``:wednesday``, ``:thursday``, ``:friday``, ``:saturday``---may be used with the ``weekday`` property and the **cron** resource.

Ohai 7
-----------------------------------------------------
.. include:: ../../includes_ohai/includes_ohai.rst

.. include:: ../../includes_ohai/includes_ohai_platforms.rst

.. note:: See the `Ohai 7 documentation <https://docs.chef.io/release/ohai-7/>`_ and `release notes <https://docs.chef.io/release/ohai-7/release_notes.html>`_ for all of the details.

collect_data Method
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_dsl_ohai/includes_dsl_ohai.rst

.. include:: ../../includes_dsl_ohai/includes_dsl_ohai_method_collect_data.rst

.. include:: ../../includes_dsl_ohai/includes_dsl_ohai_method_collect_data_mash.rst

.. include:: ../../includes_dsl_ohai/includes_dsl_ohai_method_collect_data_example.rst


**windows_package**
-----------------------------------------------------
.. include:: ../../includes_resources/includes_resource_package_windows.rst

Syntax
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_package_windows_syntax.rst

Actions
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_package_windows_actions.rst

Attributes
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources/includes_resource_package_windows_attributes_12-5.rst

guard_interpreter
-----------------------------------------------------
.. include:: ../../includes_resources_common/includes_resources_common_guard_interpreter.rst

Attributes
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources_common/includes_resources_common_11-16_guard_interpreter_attributes.rst

Inheritance
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources_common/includes_resources_common_11-16_guard_interpreter_attributes_inherit.rst

Example
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_resources_common/includes_resources_common_guard_interpreter_example_default.rst

**powershell_script** Property
-----------------------------------------------------
The following property has been added to the **powershell_script** resource:

.. list-table::
   :widths: 150 450
   :header-rows: 1

   * - Attribute
     - Description
   * - ``convert_boolean_return``
     - Return ``0`` if the last line of a command is evaluated to be true or to return ``1`` if the last line is evaluated to be false.

.. include:: ../../step_resource/step_resource_powershell_convert_boolean_return.rst

reboot_pending? Method
-----------------------------------------------------
.. include:: ../../includes_dsl_recipe/includes_dsl_recipe_method_reboot_pending.rst


knife ssl check
-----------------------------------------------------
.. include:: ../../includes_knife/includes_knife_ssl_check.rst

Syntax
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_knife/includes_knife_ssl_check_syntax.rst

Options
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_knife/includes_knife_ssl_check_options.rst

Examples
+++++++++++++++++++++++++++++++++++++++++++++++++++++

**SSL certificate has valid X.509 properties**

.. include:: ../../step_knife/step_knife_ssl_check_verify_server_config.rst

**SSL certificate has invalid X.509 properties**

.. include:: ../../step_knife/step_knife_ssl_check_bad_ssl_certificate.rst

**Verify the SSL configuration for the chef-client**

.. include:: ../../step_knife/step_knife_ssl_check_verify_client_config.rst

**Verify an external server's SSL certificate**

.. include:: ../../step_knife/step_knife_ssl_check_verify_external_server.rst

knife ssl fetch
-----------------------------------------------------
.. include:: ../../includes_knife/includes_knife_ssl_fetch.rst

Syntax
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_knife/includes_knife_ssl_fetch_syntax.rst

Options
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_knife/includes_knife_ssl_fetch_options.rst

Examples
+++++++++++++++++++++++++++++++++++++++++++++++++++++

**Fetch the SSL certificates used by Knife from the Chef server**

.. include:: ../../step_knife/step_knife_ssl_fetch_knife_certificates.rst

**Fetch SSL certificates from a URL or URI**

.. include:: ../../step_knife/step_knife_ssl_fetch_from_url_or_uri.rst

**Verify Checksums**

.. include:: ../../step_knife/step_knife_ssl_fetch_verify_certificate.rst

client.rb Settings
-----------------------------------------------------
New settings have been added to the client.rb file:

.. list-table::
   :widths: 200 300
   :header-rows: 1

   * - Setting
     - Description
   * - ``local_key_generation``
     - Whether the Chef server or chef-client generates the private/public key pair. When ``true``, the chef-client generates the key pair, and then sends the public key to the Chef server. For example:

       .. code-block:: ruby

          local_key_generation false
   * - ``ssl_verify_mode``
     - Set the verify mode for HTTPS requests.
       
       * Use ``:verify_none`` to do no validation of SSL certificates.
       * Use ``:verify_peer`` to do validation of all SSL certificates, including the Chef server connections, S3 connections, and any HTTPS **remote_file** resource URLs used in the chef-client run. This is the recommended setting.


knife Options
-----------------------------------------------------
New options have been added to the following knife subcommands:

knife bootstrap
+++++++++++++++++++++++++++++++++++++++++++++++++++++

``-V -V``
   Run the initial chef-client run at the ``debug`` log-level (e.g. ``chef-client -l debug``).

knife client bulk delete
+++++++++++++++++++++++++++++++++++++++++++++++++++++

``-D``, ``--delete-validators``
   Force the deletion of the client when it is also a chef-validator.

knife client create
+++++++++++++++++++++++++++++++++++++++++++++++++++++

``--validator``
   Use to create the client as the chef-validator.

knife client delete
+++++++++++++++++++++++++++++++++++++++++++++++++++++

``-D``, ``--delete-validators``
   Force the deletion of the client when it is also a chef-validator.

knife node run list add
+++++++++++++++++++++++++++++++++++++++++++++++++++++

``-b ITEM``, ``--before ITEM``
   Add a run-list item before the specified run-list item.

chef-client Options
-----------------------------------------------------
New options have been added to the chef-client:

``-r RUN_LIST_ITEM``, ``--runlist RUN_LIST_ITEM``
   Permanently replace the current run-list with the specified run-list items.


sensitive Property
-----------------------------------------------------
A new common resource property has been added:

.. list-table::
   :widths: 200 300
   :header-rows: 1

   * - Setting
     - Description
   * - ``sensitive``
     - Ensure that sensitive resource data is not logged by the chef-client. Default value: ``false``. This setting only applies to the **file** and **template** resources.

Disable Ohai plugins
-----------------------------------------------------
.. include:: ../../includes_config/includes_config_rb_ohai.rst

Use the following setting to disable plugins:

.. list-table::
   :widths: 200 300
   :header-rows: 1

   * - Setting
     - Description
   * - ``Ohai::Config[:disabled_plugins]``
     - An array of Ohai plugins to be disabled on a node. For example:

       .. code-block:: ruby

          Ohai::Config[:disabled_plugins] = [:MyPlugin]

       or:

       .. code-block:: ruby

          Ohai::Config[:disabled_plugins] = [:MyPlugin, :MyPlugin, :MyPlugin]

       or to disable both Ohai 6 and Ohai 7 versions:

       .. code-block:: ruby

          Ohai::Config[:disabled_plugins] = [:MyPlugin, :MyPlugin, "my_ohai_6_plugin"]


Changelog
=====================================================
https://github.com/chef/chef/blob/11-stable/CHANGELOG.md
