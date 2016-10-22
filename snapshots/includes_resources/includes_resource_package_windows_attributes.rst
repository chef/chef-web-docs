.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

This resource has the following properties:
   
``checksum``
   **Ruby Type:** String

   The SHA-256 checksum of the file. Use to prevent a file from being re-downloaded. When the local file matches the checksum, the chef-client does not download it. Use when a URL is specified by the ``source`` property.
   
``ignore_failure``
   **Ruby Types:** TrueClass, FalseClass

   Continue running a recipe if a resource fails for any reason. Default value: ``false``.
   
``installer_type``
   **Ruby Type:** Symbol

   A symbol that specifies the type of package. Possible values: ``:custom`` (such as installing a non-.msi file that embeds an .msi-based installer), ``:inno`` (Inno Setup), ``:installshield`` (InstallShield), ``:msi`` (Microsoft Installer Package (MSI)), ``:nsis`` (Nullsoft Scriptable Install System (NSIS)), ``:wise`` (Wise).

   
``notifies``
   **Ruby Type:** Symbol, 'Chef::Resource[String]'

   .. include:: ../../includes_resources_common/includes_resources_common_notification_notifies.rst

   .. include:: ../../includes_resources_common/includes_resources_common_notification_timers.rst

   .. include:: ../../includes_resources_common/includes_resources_common_notification_notifies_syntax.rst
   
``options``
   **Ruby Type:** String

   One (or more) additional options that are passed to the command.
   
``provider``
   **Ruby Type:** Chef Class

   Optional. Explicitly specifies a provider. See "Providers" section below for more information.
   
``remote_file_attributes``
   **Ruby Type:** Hash

   A package at a remote location define as a Hash of properties that modifes the properties of the **remote_file** resource.
   
``retries``
   **Ruby Type:** Integer

   The number of times to catch exceptions and retry the resource. Default value: ``0``.
   
``retry_delay``
   **Ruby Type:** Integer

   The retry delay (in seconds). Default value: ``2``.
   
``returns``
   **Ruby Types:** String, Integer, Array

   A comma-delimited list of return codes that indicate the success or failure of the command that was run remotely. This code signals a successful ``:install`` action. Default value: ``0``.
   
``source``
   **Ruby Type:** String

   Optional. The path to a package in the local file system. The location of the package may be at a URL. Default value: the ``name`` of the resource block See "Syntax" section above for more information.

   If the ``source`` property is not specified, the package name MUST be exactly the same as the display name found in **Add/Remove programs** or exacty the same as the ``DisplayName`` property in the appropriate registry key:
   
   .. code-block:: ruby
   
      HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\Uninstall
      HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Uninstall
      HKEY_LOCAL_MACHINE\Software\Wow6464Node\Microsoft\Windows\CurrentVersion\Uninstall
   
   .. note:: If there are multiple versions of a package installed with the same display name, all of those packages will be removed unless a version is provided in the ``version`` property or unless it can be discovered in the installer file specified by the ``source`` property.

``subscribes``
   **Ruby Type:** Symbol, 'Chef::Resource[String]'

   .. include:: ../../includes_resources_common/includes_resources_common_notification_subscribes.rst

   .. include:: ../../includes_resources_common/includes_resources_common_notification_timers.rst

   .. include:: ../../includes_resources_common/includes_resources_common_notification_subscribes_syntax.rst
   
``timeout``
   **Ruby Types:** String, Integer

   The amount of time (in seconds) to wait before timing out. Default value: ``600`` (seconds).
