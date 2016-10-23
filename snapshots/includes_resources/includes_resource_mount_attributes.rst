.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

This resource has the following properties:

``device``
   **Ruby Type:** String

   Required for ``:umount`` and ``:remount`` actions (for the purpose of checking the mount command output for presence). The special block device or remote node, a label, or a uuid to be mounted.

``device_type``
   **Ruby Type:** Symbol

   The type of device: ``:device``, ``:label``, or ``:uuid``. Default value: ``:device``.

``domain``
   **Ruby Type:** String

   Microsoft Windows only. Use to specify the domain in which the ``username`` and ``password`` are located.
   
``dump``
   **Ruby Types:** Integer, FalseClass

   The dump frequency (in days) used while creating a file systems table (fstab) entry. Default value: ``0``.
   
``enabled``
   **Ruby Types:** TrueClass, FalseClass

   Use to specify if a mounted file system is enabled. Default value: ``false``.
   
``fsck_device``
   **Ruby Type:** String

   The fsck device on the Solaris platform. Default value: ``-``.
   
``fstype``
   **Ruby Type:** String

   Required. The file system type (fstype) of the device.
   
``ignore_failure``
   **Ruby Types:** TrueClass, FalseClass

   Continue running a recipe if a resource fails for any reason. Default value: ``false``.
   
``mount_point``
   **Ruby Type:** String

   The directory (or path) in which the device is to be mounted. Default value: the ``name`` of the resource block See "Syntax" section above for more information.
   
``mounted``
   **Ruby Types:** TrueClass, FalseClass

   Use to specify if a file system is already mounted. Default value: ``false``.
   
``notifies``
   **Ruby Type:** Symbol, 'Chef::Resource[String]'

   .. include:: ../../includes_resources_common/includes_resources_common_notification_notifies.rst

   .. include:: ../../includes_resources_common/includes_resources_common_notification_timers.rst

   .. include:: ../../includes_resources_common/includes_resources_common_notification_notifies_syntax.rst
   
``options``
   **Ruby Types:** Array, String

   An array or string that contains mount options. If this value is a string, it is converted to an array. Default value: ``defaults``.
   
``pass``
   **Ruby Types:** Integer, FalseClass

   The pass number used by the file system check (``fsck``) command while creating a file systems table (``fstab``) entry. Default value: ``2``.
   
``password``
   **Ruby Type:** String

   Microsoft Windows only. Use to specify the password for ``username``.
   
``provider``
   **Ruby Type:** Chef Class

   Optional. Explicitly specifies a provider. See "Providers" section below for more information.
   
``retries``
   **Ruby Type:** Integer

   The number of times to catch exceptions and retry the resource. Default value: ``0``.
   
``retry_delay``
   **Ruby Type:** Integer

   The retry delay (in seconds). Default value: ``2``.
   
``subscribes``
   **Ruby Type:** Symbol, 'Chef::Resource[String]'

   .. include:: ../../includes_resources_common/includes_resources_common_notification_subscribes.rst

   .. include:: ../../includes_resources_common/includes_resources_common_notification_timers.rst

   .. include:: ../../includes_resources_common/includes_resources_common_notification_subscribes_syntax.rst
   
``supports``
   **Ruby Type:** Array

   An array of options for supported mount features. Default value: ``:remount``.
   
``username``
   **Ruby Type:** String

   Microsoft Windows only. Use to specify the user name.
