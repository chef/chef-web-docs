=====================================================
Release Notes: chef-client 12.4
=====================================================

.. include:: ../../includes_chef/includes_chef.rst

What's New
=====================================================
The following items are new for chef-client 12.4 and/or are changes from previous versions. The short version:

* **Validatorless bootstrap now requires the node name** Use of the ``-N node_name`` option with a validatorless bootstrap is now required.
* **remote_file resource supports Windows UNC paths for source location** A Microsoft Windows UNC path may be used to specify the location of a remote file.
* **Run PowerShell commands without excessive quoting** Use the ``Import-Module chef`` module to run Windows PowerShell commands without excessive quotation.
* **Logging may use the Windows Event Logger** Log files may be sent to the Windows Event Logger. Set the ``log_location`` setting in the client.rb file to ``Chef::Log::WinEvt.new``.
* **Logging may be configured to use daemon facility available to the chef-client** Log files may be sent to the syslog available to the chef-client. Set the ``log_location`` setting in the client.rb file to ``Chef::Log::Syslog.new("chef-client", ::Syslog::LOG_DAEMON)``.
* **Package locations on the Windows platform may be specified using a URL** The location of a package may be at URL when using the **windows_package** resource.
* **Package locations on the Windows platform may be specified by passing attributes to the remote_file resource** Use the ``remote_file_attributes`` attribute to pass a Hash of attributes that modifies the **remote_file** resource.
* **Public key management for users and clients** The ``knife client`` and ``knife user`` subcommands may now create, delete, edit, list, and show public keys.
* **knife client create and knife user create options have changed** With the new key management subcommands, the options for ``knife client create`` and ``knife user create`` have changed.
* **chef-client audit-mode is no longer marked as "experimental"** The recommended version of audit-mode is chef-client 12.4, where it is no longer marked as experimental. The chef-client will report audit failures independently of converge failures.

UNC paths, **remote_file**
-----------------------------------------------------
When using the **remote_file** resource, the location of a source file may be specified using a Microsoft Windows UNC. For example:

.. code-block:: ruby

   source "\\\\path\\to\\img\\sketch.png"

Import-Module chef
-----------------------------------------------------
.. include:: ../../includes_knife/includes_knife_common_windows_quotes_module.rst

client.rb Settings
-----------------------------------------------------
The following settings have changed:

.. list-table::
   :widths: 200 300
   :header-rows: 1

   * - Setting
     - Description
   * - ``log_location``
     - The location of the log file. Possible values: ``/path/to/log_location``, ``STDOUT``, ``STDERR``, ``Chef::Log::WinEvt.new`` (Windows Event Logger), or ``Chef::Log::Syslog.new("chef-client", ::Syslog::LOG_DAEMON)`` (writes to the syslog daemon facility with the originator set as ``chef-client``). The application log will specify the source as ``Chef``. Default value: ``STDOUT``.

**windows_package** Updates
-----------------------------------------------------
The **windows_package** resource has two new attributes (``checksum`` and ``remote_file_attributes``) and the ``source`` attribute now supports using a URL:

.. list-table::
   :widths: 200 300
   :header-rows: 1

   * - Attribute
     - Description
   * - ``checksum``
     - The SHA-256 checksum of the file. Use to prevent a file from being re-downloaded. When the local file matches the checksum, the chef-client does not download it. Use when a URL is specified by the ``source`` attribute.
   * - ``remote_file_attributes``
     - A package at a remote location define as a Hash of properties that modifes the properties of the **remote_file** resource.
   * - ``source``
     - Optional. The path to a package in the local file system. The location of the package may be at a URL. Default value: the ``name`` of the resource block. See "Syntax" section above for more information.

Examples:

**Specify a URL for the source attribute**

.. include:: ../../step_resource/step_resource_package_windows_source_url.rst

**Specify path and checksum**

.. include:: ../../step_resource/step_resource_package_windows_source_url_checksum.rst

**Modify remote_file resource attributes**

.. include:: ../../step_resource/step_resource_package_windows_source_remote_file_attributes.rst



knife client key
-----------------------------------------------------
.. include:: ../../includes_knife/includes_knife_client.rst

key create
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_knife/includes_knife_client_key_create.rst

Syntax
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
.. include:: ../../includes_knife/includes_knife_client_key_create_syntax.rst

Options
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
.. include:: ../../includes_knife/includes_knife_client_key_create_options.rst

key delete
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_knife/includes_knife_client_key_delete.rst

Syntax
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
.. include:: ../../includes_knife/includes_knife_client_key_delete_syntax.rst

key edit
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_knife/includes_knife_client_key_edit.rst

Syntax
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
.. include:: ../../includes_knife/includes_knife_client_key_edit_syntax.rst

Options
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
.. include:: ../../includes_knife/includes_knife_client_key_edit_options.rst

key list
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_knife/includes_knife_client_key_list.rst

Syntax
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
.. include:: ../../includes_knife/includes_knife_client_key_list_syntax.rst

Options
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
.. include:: ../../includes_knife/includes_knife_client_key_list_options.rst

key show
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_knife/includes_knife_client_key_show.rst

Syntax
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
.. include:: ../../includes_knife/includes_knife_client_key_show_syntax.rst


knife user key
-----------------------------------------------------
.. include:: ../../includes_knife/includes_knife_user.rst

key create
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_knife/includes_knife_user_key_create.rst

Syntax
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
.. include:: ../../includes_knife/includes_knife_user_key_create_syntax.rst

Options
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
.. include:: ../../includes_knife/includes_knife_user_key_create_options.rst

key delete
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_knife/includes_knife_user_key_delete.rst

Syntax
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
.. include:: ../../includes_knife/includes_knife_user_key_delete_syntax.rst

key edit
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_knife/includes_knife_user_key_edit.rst

Syntax
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
.. include:: ../../includes_knife/includes_knife_user_key_edit_syntax.rst

Options
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
.. include:: ../../includes_knife/includes_knife_user_key_edit_options.rst

key list
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_knife/includes_knife_user_key_list.rst

Syntax
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
.. include:: ../../includes_knife/includes_knife_user_key_list_syntax.rst

Options
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
.. include:: ../../includes_knife/includes_knife_user_key_list_options.rst

key show
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_knife/includes_knife_user_key_show.rst

Syntax
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
.. include:: ../../includes_knife/includes_knife_user_key_show_syntax.rst

Updated knife Options
-----------------------------------------------------
With the new key management subcommands, the options for ``knife client create`` and ``knife user create`` have changed.

knife client create
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_knife/includes_knife_client_create_options.rst

knife user create
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_knife/includes_knife_user_create_options.rst

Changelog
=====================================================
https://github.com/chef/chef/blob/12.4.1/CHANGELOG.md
