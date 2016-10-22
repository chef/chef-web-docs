.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

This resource has the following properties:
   
``atomic_update``
   **Ruby Types:** TrueClass, FalseClass

   Perform atomic file updates on a per-resource basis. Set to ``true`` for atomic file updates. Set to ``false`` for non-atomic file updates. This setting overrides ``file_atomic_update``, which is a global setting found in the client.rb file. Default value: ``true``.
   
``backup``
   **Ruby Types:** FalseClass, Integer

   The number of backups to be kept in ``/var/chef/backup`` (for UNIX- and Linux-based platforms) or ``C:/chef/backup`` (for the Microsoft Windows platform). Set to ``false`` to prevent backups from being kept. Default value: ``5``.
   
``checksum``
   **Ruby Type:** String

   Optional, see ``use_conditional_get``. The SHA-256 checksum of the file. Use to prevent a file from being re-downloaded. When the local file matches the checksum, the chef-client does not download it.
   
``force_unlink``
   **Ruby Types:** TrueClass, FalseClass

   How the chef-client handles certain situations when the target file turns out not to be a file. For example, when a target file is actually a symlink. Set to ``true`` for the chef-client delete the non-file target and replace it with the specified file. Set to ``false`` for the chef-client to raise an error. Default value: ``false``.
   
``ftp_active_mode``
   **Ruby Types:** TrueClass, FalseClass

   Whether the chef-client uses active or passive FTP. Set to ``true`` to use active FTP. Default value: ``false``.
   
``group``
   **Ruby Types:** Integer, String

   A string or ID that identifies the group owner by group name, including fully qualified group names such as ``domain\group`` or ``group@domain``. If this value is not specified, existing groups remain unchanged and new group assignments use the default ``POSIX`` group (if available).
   
``headers()``
   **Ruby Type:** Hash

   A Hash of custom headers. Default value: ``{}``. For example:

   .. code-block:: ruby

      headers({ "Cookie" => "user=grantmc; pass=p@ssw0rd!" })

   or:

   .. code-block:: ruby

      headers({ "Referer" => "#{header}" })

   or:

   .. code-block:: ruby

      headers( "Authorization"=>"Basic #{ Base64.encode64("#{username}:#{password}").gsub("\n", "") }" )

``ignore_failure``
   **Ruby Types:** TrueClass, FalseClass

   Continue running a recipe if a resource fails for any reason. Default value: ``false``.
   
``inherits``
   **Ruby Types:** TrueClass, FalseClass

   Microsoft Windows only. Whether a file inherits rights from its parent directory. Default value: ``true``.
   
``manage_symlink_source``
   **Ruby Types:** TrueClass, FalseClass, NilClass

   Cause the chef-client to detect and manage the source file for a symlink. Possible values: ``nil``, ``true``, or ``false``. When this value is set to ``nil``, the chef-client will manage a symlink's source file and emit a warning. When this value is set to ``true``, the chef-client will manage a symlink's source file and not emit a warning. Default value: ``nil``. The default value will be changed to ``false`` in a future version.
   
``mode``
   **Ruby Types:** Integer, String

   A quoted 3-5 character string that defines the octal mode. For example: ``'755'``, ``'0755'``, or ``00755``. If ``mode`` is not specified and if the file already exists, the existing mode on the file is used. If ``mode`` is not specified, the file does not exist, and the ``:create`` action is specified, the chef-client assumes a mask value of ``'0777'`` and then applies the umask for the system on which the file is to be created to the ``mask`` value. For example, if the umask on a system is ``'022'``, the chef-client uses the default value of ``'0755'``.
       
   The behavior is different depending on the platform.
       
   UNIX- and Linux-based systems: A quoted 3-5 character string that defines the octal mode that is passed to chmod. For example: ``'755'``, ``'0755'``, or ``00755``. If the value is specified as a quoted string, it works exactly as if the ``chmod`` command was passed. If the value is specified as an integer, prepend a zero (``0``) to the value to ensure that it is interpreted as an octal number. For example, to assign read, write, and execute rights for all users, use ``'0777'`` or ``'777'``; for the same rights, plus the sticky bit, use ``01777`` or ``'1777'``.
       
   Microsoft Windows: A quoted 3-5 character string that defines the octal mode that is translated into rights for Microsoft Windows security. For example: ``'755'``, ``'0755'``, or ``00755``. Values up to ``'0777'`` are allowed (no sticky bits) and mean the same in Microsoft Windows as they do in UNIX, where ``4`` equals ``GENERIC_READ``, ``2`` equals ``GENERIC_WRITE``, and ``1`` equals ``GENERIC_EXECUTE``. This property cannot be used to set ``:full_control``. This property has no effect if not specified, but when it and ``rights`` are both specified, the effects are cumulative.
   
``notifies``
   **Ruby Type:** Symbol, 'Chef::Resource[String]'

   .. include:: ../../includes_resources_common/includes_resources_common_notification_notifies.rst

   .. include:: ../../includes_resources_common/includes_resources_common_notification_timers.rst

   .. include:: ../../includes_resources_common/includes_resources_common_notification_notifies_syntax.rst
   
``owner``
   **Ruby Types:** Integer, String

   A string or ID that identifies the group owner by user name, including fully qualified user names such as ``domain\user`` or ``user@domain``. If this value is not specified, existing owners remain unchanged and new owner assignments use the current user (when necessary).	
   
``path``
   **Ruby Type:** String

   The full path to the file, including the file name and its extension. Default value: the ``name`` of the resource block See "Syntax" section above for more information.
   
``provider``
   **Ruby Type:** Chef Class

   Optional. Explicitly specifies a provider.
   
``retries``
   **Ruby Type:** Integer

   The number of times to catch exceptions and retry the resource. Default value: ``0``.
   
``retry_delay``
   **Ruby Type:** Integer

   The retry delay (in seconds). Default value: ``2``.
   
``rights``
   **Ruby Types:** Integer, String

   Microsoft Windows only. The permissions for users and groups in a Microsoft Windows environment. For example: ``rights <permissions>, <principal>, <options>`` where ``<permissions>`` specifies the rights granted to the principal, ``<principal>`` is the group or user name, and ``<options>`` is a Hash with one (or more) advanced rights options.
   
``source``
   **Ruby Types:** String, Array

   Required. The location of the source file. The location of the source file may be HTTP (``http://``), FTP (``ftp://``), local (``file:///``), or UNC (``\\host\share\file.tar.gz``).
       
   .. include:: ../../includes_file/includes_file_remote_source_location.rst

``subscribes``
   **Ruby Type:** Symbol, 'Chef::Resource[String]'

   .. include:: ../../includes_resources_common/includes_resources_common_notification_subscribes.rst

   .. include:: ../../includes_resources_common/includes_resources_common_notification_timers.rst

   .. include:: ../../includes_resources_common/includes_resources_common_notification_subscribes_syntax.rst
   
``use_conditional_get``
   **Ruby Types:** TrueClass, FalseClass

   Enable conditional HTTP requests by using a conditional ``GET`` (with the If-Modified-Since header) or an opaque identifier (ETag). To use If-Modified-Since headers, ``use_last_modified`` must also be set to ``true``. To use ETag headers, ``use_etag`` must also be set to ``true``. Default value: ``true``.
   
``use_etag``
   **Ruby Types:** TrueClass, FalseClass

   Enable ETag headers. Set to ``false`` to disable ETag headers. To use this setting, ``use_conditional_get`` must also be set to ``true``. Default value: ``true``.
   
``use_last_modified``
   **Ruby Types:** TrueClass, FalseClass

   Enable If-Modified-Since headers. Set to ``false`` to disable If-Modified-Since headers. To use this setting, ``use_conditional_get`` must also be set to ``true``. Default value: ``true``.
   
``verify``
   **Ruby Types:** String, Block

   A block or a string that returns ``true`` or ``false``. A string, when ``true`` is executed as a system command.

   .. include:: ../../includes_resources/includes_resource_remote_file_attributes_verify.rst
