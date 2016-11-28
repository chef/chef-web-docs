=====================================================
Release Notes: chef-client 12.4
=====================================================

.. tag chef

Chef is a powerful automation platform that transforms infrastructure into code. Whether you’re operating in the cloud, on-premises, or in a hybrid environment, Chef automates how infrastructure is configured, deployed, and managed across your network, no matter its size.

This diagram shows how you develop, test, and deploy your Chef code.

.. image:: ../../images/start_chef.svg
   :width: 700px
   :align: center

.. end_tag

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
.. tag knife_common_windows_quotes_module

The chef-client version 12.4 release adds an optional feature to the Microsoft Installer Package (MSI) for Chef. This feature enables the ability to pass quoted strings from the Windows PowerShell command line without the need for triple single quotes (``''' '''``). This feature installs a Windows PowerShell module (typically in ``C:\opscode\chef\modules``) that is also appended to the ``PSModulePath`` environment variable. This feature is not enabled by default. To activate this feature, run the following command from within Windows PowerShell:

.. code-block:: bash

   $ Import-Module chef

or add ``Import-Module chef`` to the profile for Windows PowerShell located at:

.. code-block:: bash

   ~\Documents\WindowsPowerShell\Microsoft.PowerShell_profile.ps1

This module exports cmdlets that have the same name as the command-line tools---chef-client, knife, chef-apply---that are built into Chef.

For example:

.. code-block:: bash

   $ knife exec -E 'puts ARGV' """&s0meth1ng"""

is now:

.. code-block:: bash

   $ knife exec -E 'puts ARGV' '&s0meth1ng'

and:

.. code-block:: bash

   $ knife node run_list set test-node '''role[ssssssomething]'''

is now:

.. code-block:: bash

   $ knife node run_list set test-node 'role[ssssssomething]'

To remove this feature, run the following command from within Windows PowerShell:

.. code-block:: bash

   $ Remove-Module chef

.. end_tag

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

.. tag resource_package_windows_source_url

.. To install a package using a URL for the source:

.. code-block:: ruby

   windows_package '7zip' do
     source 'http://www.7-zip.org/a/7z938-x64.msi'
   end

.. end_tag

**Specify path and checksum**

.. tag resource_package_windows_source_url_checksum

.. To install a package using a URL for the source and specifying a checksum:

.. code-block:: ruby

   windows_package '7zip' do
     source 'http://www.7-zip.org/a/7z938-x64.msi'
     checksum '7c8e873991c82ad9cfc123415254ea6101e9a645e12977dcd518979e50fdedf3'
   end

.. end_tag

**Modify remote_file resource attributes**

.. tag resource_package_windows_source_remote_file_attributes

The **windows_package** resource may specify a package at a remote location using the ``remote_file_attributes`` property. This uses the **remote_file** resource to download the contents at the specified URL and passes in a Hash that modifes the properties of the :doc:`remote_file resource <resource_remote_file>`.

For example:

.. code-block:: ruby

   windows_package '7zip' do
     source 'http://www.7-zip.org/a/7z938-x64.msi'
     remote_file_attributes ({
       :path => 'C:\\7zip.msi',
       :checksum => '7c8e873991c82ad9cfc123415254ea6101e9a645e12977dcd518979e50fdedf3'
     })
   end

.. end_tag

knife client key
-----------------------------------------------------
.. tag knife_client_25

The ``knife client`` subcommand is used to manage an API client list and their associated RSA public key-pairs. This allows authentication requests to be made to the Chef server by any entity that uses the Chef server API, such as the chef-client and knife.

.. end_tag

key create
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. tag knife_client_key_create

Use the ``key create`` argument to create a public key.

.. end_tag

Syntax
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
.. tag knife_client_key_create_syntax

This argument has the following syntax:

.. code-block:: bash

   $ knife client key create CLIENT_NAME (options)

.. end_tag

Options
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
.. tag knife_client_key_create_options

This argument has the following options:

``-e DATE``, ``--expiration-date DATE``
   The expiration date for the public key, specified as an ISO 8601 formatted string: ``YYYY-MM-DDTHH:MM:SSZ``. If this option is not specified, the public key will not have an expiration date. For example: ``2013-12-24T21:00:00Z``.

``-f FILE``, ``--file FILE``
   Save a private key to the specified file name. If the ``--public-key`` option is not specified the Chef server will generate a private key.

``-k NAME``, ``--key-name NAME``
   The name of the public key.

``-p FILE_NAME``, ``--public-key FILE_NAME``
   The path to a file that contains the public key. If this option is not specified, and only if ``--key-name`` is specified, the Chef server will generate a public/private key pair.

.. end_tag

key delete
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. tag knife_client_key_delete

Use the ``key delete`` argument to delete a public key.

.. end_tag

Syntax
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
.. tag knife_client_key_delete_syntax

This argument has the following syntax:

.. code-block:: bash

   $ knife client key delete CLIENT_NAME KEY_NAME

.. end_tag

key edit
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. tag knife_client_key_edit

Use the ``key edit`` argument to modify or rename a public key.

.. end_tag

Syntax
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
.. tag knife_client_key_edit_syntax

This argument has the following syntax:

.. code-block:: bash

   $ knife client key edit CLIENT_NAME KEY_NAME (options)

.. end_tag

Options
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
.. tag knife_client_key_edit_options

This argument has the following options:

``-c``, ``--create-key``
   Generate a new public/private key pair and replace an existing public key with the newly-generated public key. To replace the public key with an existing public key, use ``--public-key`` instead.

``-e DATE``, ``--expiration-date DATE``
   The expiration date for the public key, specified as an ISO 8601 formatted string: ``YYYY-MM-DDTHH:MM:SSZ``. If this option is not specified, the public key will not have an expiration date. For example: ``2013-12-24T21:00:00Z``.

``-f FILE``, ``--file FILE``
   Save a private key to the specified file name. If the ``--public-key`` option is not specified the Chef server will generate a private key.

``-k NAME``, ``--key-name NAME``
   The name of the public key.

``-p FILE_NAME``, ``--public-key FILE_NAME``
   The path to a file that contains the public key. If this option is not specified, and only if ``--key-name`` is specified, the Chef server will generate a public/private key pair.

.. end_tag

key list
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. tag knife_client_key_list

Use the ``key list`` argument to view a list of public keys for the named client.

.. end_tag

Syntax
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
.. tag knife_client_key_list_syntax

This argument has the following syntax:

.. code-block:: bash

   $ knife client key list CLIENT_NAME (options)

.. end_tag

Options
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
.. tag knife_client_key_list_options

This argument has the following options:

``-e``, ``--only-expired``
   Show a list of public keys that have expired.

``-n``, ``--only-non-expired``
   Show a list of public keys that have not expired.

``-w``, ``--with-details``
   Show a list of public keys, including URIs and expiration status.

.. end_tag

key show
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. tag knife_client_key_show

Use the ``key show`` argument to view details for a specific public key.

.. end_tag

Syntax
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
.. tag knife_client_key_show_syntax

This argument has the following syntax:

.. code-block:: bash

   $ knife client key show CLIENT_NAME KEY_NAME

.. end_tag

knife user key
-----------------------------------------------------
.. tag knife_user_24

The ``knife user`` subcommand is used to manage the list of users and their associated RSA public key-pairs.

.. end_tag

key create
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. tag knife_user_key_create

Use the ``key create`` argument to create a public key.

.. end_tag

Syntax
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
.. tag knife_user_key_create_syntax

This argument has the following syntax:

.. code-block:: bash

   $ knife user key create USER_NAME (options)

.. end_tag

Options
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
.. tag knife_user_key_create_options

This argument has the following options:

``-e DATE``, ``--expiration-date DATE``
   The expiration date for the public key, specified as an ISO 8601 formatted string: ``YYYY-MM-DDTHH:MM:SSZ``. If this option is not specified, the public key will not have an expiration date. For example: ``2013-12-24T21:00:00Z``.

``-f FILE``, ``--file FILE``
   Save a private key to the specified file name.

``-k NAME``, ``--key-name NAME``
   The name of the public key.

``-p FILE_NAME``, ``--public-key FILE_NAME``
   The path to a file that contains the public key. If this option is not specified, and only if ``--key-name`` is specified, the Chef server will generate a public/private key pair.

.. end_tag

key delete
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. tag knife_user_key_delete

Use the ``key delete`` argument to delete a public key.

.. end_tag

Syntax
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
.. tag knife_user_key_delete_syntax

This argument has the following syntax:

.. code-block:: bash

   $ knife user key delete USER_NAME KEY_NAME

.. end_tag

key edit
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. tag knife_user_key_edit

Use the ``key edit`` argument to modify or rename a public key.

.. end_tag

Syntax
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
.. tag knife_user_key_edit_syntax

This argument has the following syntax:

.. code-block:: bash

   $ knife user key edit USER_NAME KEY_NAME (options)

.. end_tag

Options
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
.. tag knife_user_key_edit_options

This argument has the following options:

``-c``, ``--create-key``
   Generate a new public/private key pair and replace an existing public key with the newly-generated public key. To replace the public key with an existing public key, use ``--public-key`` instead.

``-e DATE``, ``--expiration-date DATE``
   The expiration date for the public key, specified as an ISO 8601 formatted string: ``YYYY-MM-DDTHH:MM:SSZ``. If this option is not specified, the public key will not have an expiration date. For example: ``2013-12-24T21:00:00Z``.

``-f FILE``, ``--file FILE``
   Save a private key to the specified file name. If the ``--public-key`` option is not specified the Chef server will generate a private key.

``-k NAME``, ``--key-name NAME``
   The name of the public key.

``-p FILE_NAME``, ``--public-key FILE_NAME``
   The path to a file that contains the public key. If this option is not specified, and only if ``--key-name`` is specified, the Chef server will generate a public/private key pair.

.. end_tag

key list
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. tag knife_user_key_list

Use the ``key list`` argument to view a list of public keys for the named user.

.. end_tag

Syntax
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
.. tag knife_user_key_list_syntax

This argument has the following syntax:

.. code-block:: bash

   $ knife user key list USER_NAME (options)

.. end_tag

Options
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
.. tag knife_user_key_list_options

This argument has the following options:

``-e``, ``--only-expired``
   Show a list of public keys that have expired.

``-n``, ``--only-non-expired``
   Show a list of public keys that have not expired.

``-w``, ``--with-details``
   Show a list of public keys, including URIs and expiration status.

.. end_tag

key show
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. tag knife_user_key_show

Use the ``key show`` argument to view details for a specific public key.

.. end_tag

Syntax
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
.. tag knife_user_key_show_syntax

This argument has the following syntax:

.. code-block:: bash

   $ knife user key show USER_NAME KEY_NAME

.. end_tag

Updated knife Options
-----------------------------------------------------
With the new key management subcommands, the options for ``knife client create`` and ``knife user create`` have changed.

knife client create
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. tag knife_client_create_options

This argument has the following options:

``-a``, ``--admin``
   Create a client as an admin client. This is required for any user to access Open Source Chef as an administrator.  This option only works when used with the open source Chef server and will have no effect when used with Enterprise Chef or Chef server 12.x.

``-f FILE``, ``--file FILE``
   Save a private key to the specified file name.

``-k``, ``--prevent-keygen``
   Create a user without a public key. This key may be managed later by using the ``knife user key`` subcommands.

   .. note:: .. tag notes_knife_prevent_keygen

             This option is valid only with Chef server API, version 1.0, which was released with Chef server 12.1. If this option or the ``--user-key`` option are not passed in the command, the Chef server will create a user with a public key named ``default`` and will return the private key. For the Chef server versions earlier than 12.1, this option will not work; a public key is always generated unless ``--user-key`` is passed in the command.

             .. end_tag

``-p FILE``, ``--public-key FILE``
   The path to a file that contains the public key. This option may not be passed in the same command with ``--prevent-keygen``. When using Open Source Chef a default key is generated if this option is not passed in the command. For Chef server version 12.x, see the ``--prevent-keygen`` option.

``--validator``
   Create the client as the chef-validator. Default value: ``true``.

.. end_tag

knife user create
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. tag knife_user_create_options

This argument has the following options:

``-a``, ``--admin``
   Create a client as an admin client. This is required for any user to access Open Source Chef as an administrator. This option only works when used with the open source Chef server and will have no effect when used with Enterprise Chef or Chef server 12.x.

``-f FILE_NAME``, ``--file FILE_NAME``
   Save a private key to the specified file name.

``-k``, ``--prevent-keygen``
   Create a user without a public key. This key may be managed later by using the ``knife user key`` subcommands.

   .. note:: .. tag notes_knife_prevent_keygen

             This option is valid only with Chef server API, version 1.0, which was released with Chef server 12.1. If this option or the ``--user-key`` option are not passed in the command, the Chef server will create a user with a public key named ``default`` and will return the private key. For the Chef server versions earlier than 12.1, this option will not work; a public key is always generated unless ``--user-key`` is passed in the command.

             .. end_tag

``-p PASSWORD``, ``--password PASSWORD``
   The user password. This option only works when used with the open source Chef server and will have no effect when used with Enterprise Chef or Chef server 12.x.

``--user-key FILE_NAME``
   The path to a file that contains the public key. When using Open Source Chef a default key is generated if this option is not passed in the command. For Chef server version 12.x, see the ``--prevent-keygen`` option.

.. end_tag

Changelog
=====================================================
https://github.com/chef/chef/blob/12.4.1/CHANGELOG.md
