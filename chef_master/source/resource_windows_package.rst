=====================================================
windows_package resource
=====================================================
`[edit on GitHub] <https://github.com/chef/chef-web-docs/blob/master/chef_master/source/resource_windows_package.rst>`__

.. tag resource_package_windows

Use the **windows_package** resource to manage Microsoft Installer Package (MSI) packages for the Microsoft Windows platform.

.. end_tag

Syntax
=====================================================
.. tag resource_package_windows_syntax

A **windows_package** resource block manages a package on a node, typically by installing it. The simplest use of the **windows_package** resource is:

.. code-block:: ruby

   windows_package 'package_name'

which will install the named package using all of the default options and the default action (``:install``).

The full syntax for all of the properties that are available to the **windows_package** resource is:

.. code-block:: ruby

  windows_package 'name' do
    checksum                    String
    installer_type              Symbol
    options                     String
    package_name                String, Array
    remote_file_attributes      Hash
    returns                     String, Integer, Array # default value: [0]
    source                      String
    timeout                     String, Integer # default value: 600
    version                     String, Array
    action                      Symbol # defaults to :install if not specified
  end

where:

* ``windows_package`` is the resource.
* ``name`` is the name given to the resource block.
* ``action`` identifies which steps the chef-client will take to bring the node into the desired state.
* ``checksum``, ``installer_type``, ``options``, ``package_name``, ``remote_file_attributes``, ``returns``, ``source``, ``timeout``, and ``version`` are the properties available to this resource.

.. end_tag

Actions
=====================================================
.. tag resource_package_windows_actions

The windows_package resource has the following actions:

``:install``
   Default. Install a package. If a version is specified, install the specified version of the package.

``:nothing``
   .. tag resources_common_actions_nothing

   This resource block does not act unless notified by another resource to take action. Once notified, this resource block either runs immediately or is queued up to run at the end of the Chef Client run.

   .. end_tag

``:remove``
   Remove a package.

.. end_tag

Properties
=====================================================
.. tag resource_package_windows_properties

The windows_package resource has the following properties:

``checksum``
   **Ruby Type:** String

   The SHA-256 checksum of the file. Use to prevent a file from being re-downloaded. When the local file matches the checksum, the chef-client does not download it. Use when a URL is specified by the ``source`` property.

``installer_type``
   **Ruby Type:** Symbol

   A symbol that specifies the type of package. Possible values: ``:custom`` (such as installing a non-.msi file that embeds an .msi-based installer), ``:inno`` (Inno Setup), ``:installshield`` (InstallShield), ``:msi`` (Microsoft Installer Package (MSI)), ``:nsis`` (Nullsoft Scriptable Install System (NSIS)), ``:wise`` (Wise).

``options``
   **Ruby Type:** String

   One (or more) additional options that are passed to the command.

``package_name``
   **Ruby Type:** String, Array

   The name of the package. Defaults to the name of the resource block unless specified.

``remote_file_attributes``
   **Ruby Type:** Hash

   A package at a remote location define as a Hash of properties that modifies the properties of the **remote_file** resource.

``returns``
   **Ruby Type:** Integer, Array of integers | **Default Value:** ``0``

   A comma-delimited list of return codes that indicate the success or failure of the command that was run remotely. This code signals a successful ``:install`` action.

``source``
   **Ruby Type:** String

   Optional. The path to a package in the local file system. The location of the package may be at a URL. Default value: the ``name`` of the resource block. See the "Syntax" section above for more information.

   If the ``source`` property is not specified, the package name MUST be exactly the same as the display name found in **Add/Remove programs** or exactly the same as the ``DisplayName`` property in the appropriate registry key, which may be one of the following:

   .. code-block:: ruby

      HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\Uninstall
      HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Uninstall
      HKEY_LOCAL_MACHINE\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall

   .. note:: If there are multiple versions of a package installed with the same display name, all of those packages will be removed unless a version is provided in the ``version`` property or unless it can be discovered in the installer file specified by the ``source`` property.

``timeout``
   **Ruby Type:** String, Integer | **Default Value:** ``600`` (seconds)

   The amount of time (in seconds) to wait before timing out.

``version``
   **Ruby Type:** String, Array

   The version of a package to be installed or upgraded.

.. end_tag

Common Resource Functionality
=====================================================

Chef resources include common properties, notifications, and resource guards.

Common Properties
-----------------------------------------------------

.. tag resources_common_properties

The following properties are common to every resource:

``ignore_failure``
  **Ruby Type:** true, false | **Default Value:** ``false``

  Continue running a recipe if a resource fails for any reason.

``retries``
  **Ruby Type:** Integer | **Default Value:** ``0``

  The number of attempts to catch exceptions and retry the resource.

``retry_delay``
  **Ruby Type:** Integer | **Default Value:** ``2``

  The retry delay (in seconds).

``sensitive``
  **Ruby Type:** true, false | **Default Value:** ``false``

  Ensure that sensitive resource data is not logged by the chef-client.

.. end_tag

Notifications
-----------------------------------------------------

``notifies``
  **Ruby Type:** Symbol, 'Chef::Resource[String]'

  .. tag resources_common_notification_notifies

  A resource may notify another resource to take action when its state changes. Specify a ``'resource[name]'``, the ``:action`` that resource should take, and then the ``:timer`` for that action. A resource may notify more than one resource; use a ``notifies`` statement for each resource to be notified.

  .. end_tag

.. tag resources_common_notification_timers

A timer specifies the point during the Chef Client run at which a notification is run. The following timers are available:

``:before``
   Specifies that the action on a notified resource should be run before processing the resource block in which the notification is located.

``:delayed``
   Default. Specifies that a notification should be queued up, and then executed at the end of the Chef Client run.

``:immediate``, ``:immediately``
   Specifies that a notification should be run immediately, per resource notified.

.. end_tag

.. tag resources_common_notification_notifies_syntax

The syntax for ``notifies`` is:

.. code-block:: ruby

  notifies :action, 'resource[name]', :timer

.. end_tag

``subscribes``
  **Ruby Type:** Symbol, 'Chef::Resource[String]'

.. tag resources_common_notification_subscribes

A resource may listen to another resource, and then take action if the state of the resource being listened to changes. Specify a ``'resource[name]'``, the ``:action`` to be taken, and then the ``:timer`` for that action.

Note that ``subscribes`` does not apply the specified action to the resource that it listens to - for example:

.. code-block:: ruby

 file '/etc/nginx/ssl/example.crt' do
   mode '0600'
   owner 'root'
 end

 service 'nginx' do
   subscribes :reload, 'file[/etc/nginx/ssl/example.crt]', :immediately
 end

In this case the ``subscribes`` property reloads the ``nginx`` service whenever its certificate file, located under ``/etc/nginx/ssl/example.crt``, is updated. ``subscribes`` does not make any changes to the certificate file itself, it merely listens for a change to the file, and executes the ``:reload`` action for its resource (in this example ``nginx``) when a change is detected.

.. end_tag

.. tag resources_common_notification_timers

A timer specifies the point during the Chef Client run at which a notification is run. The following timers are available:

``:before``
   Specifies that the action on a notified resource should be run before processing the resource block in which the notification is located.

``:delayed``
   Default. Specifies that a notification should be queued up, and then executed at the end of the Chef Client run.

``:immediate``, ``:immediately``
   Specifies that a notification should be run immediately, per resource notified.

.. end_tag

.. tag resources_common_notification_subscribes_syntax

The syntax for ``subscribes`` is:

.. code-block:: ruby

   subscribes :action, 'resource[name]', :timer

.. end_tag

Guards
-----------------------------------------------------

.. tag resources_common_guards

A guard property can be used to evaluate the state of a node during the execution phase of the chef-client run. Based on the results of this evaluation, a guard property is then used to tell the chef-client if it should continue executing a resource. A guard property accepts either a string value or a Ruby block value:

* A string is executed as a shell command. If the command returns ``0``, the guard is applied. If the command returns any other value, then the guard property is not applied. String guards in a **powershell_script** run Windows PowerShell commands and may return ``true`` in addition to ``0``.
* A block is executed as Ruby code that must return either ``true`` or ``false``. If the block returns ``true``, the guard property is applied. If the block returns ``false``, the guard property is not applied.

A guard property is useful for ensuring that a resource is idempotent by allowing that resource to test for the desired state as it is being executed, and then if the desired state is present, for the chef-client to do nothing.

.. end_tag
.. tag resources_common_guards_properties

The following properties can be used to define a guard that is evaluated during the execution phase of the chef-client run:

``not_if``
  Prevent a resource from executing when the condition returns ``true``.

``only_if``
  Allow a resource to execute only if the condition returns ``true``.

.. end_tag

Examples
=====================================================
The following examples demonstrate various approaches for using resources in recipes:

**Install a package**

.. tag resource_windows_package_install

.. To install a package:

.. code-block:: ruby

   windows_package '7zip' do
     action :install
     source 'C:\7z920.msi'
   end

.. end_tag

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

.. tag resource_package_windows_source_remote_file_properties

The **windows_package** resource may specify a package at a remote location using the ``remote_file_attributes`` property. This uses the **remote_file** resource to download the contents at the specified URL and passes in a Hash that modifies the properties of the `remote_file resource </resource_remote_file.html>`__.

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

**Download a nsis (Nullsoft) package resource**

.. tag resource_package_windows_download_nsis_package

.. To download a nsis (Nullsoft) package resource:

.. code-block:: ruby

   windows_package 'Mercurial 3.6.1 (64-bit)' do
     source 'http://mercurial.selenic.com/release/windows/Mercurial-3.6.1-x64.exe'
     checksum 'febd29578cb6736163d232708b834a2ddd119aa40abc536b2c313fc5e1b5831d'
   end

.. end_tag

**Download a custom package**

.. tag resource_package_windows_download_custom_package

.. To download a custom package:

.. code-block:: ruby

   windows_package 'Microsoft Visual C++ 2005 Redistributable' do
     source 'https://download.microsoft.com/download/6/B/B/6BB661D6-A8AE-4819-B79F-236472F6070C/vcredist_x86.exe'
     installer_type :custom
     options '/Q'
   end

.. end_tag
