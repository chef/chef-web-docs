.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

This resource has the following properties:

``architecture``
   **Ruby Type:** Symbol

   The architecture of the node for which keys are to be created or deleted. Possible values: ``:i386`` (for nodes with a 32-bit registry), ``:x86_64`` (for nodes with a 64-bit registry), and ``:machine`` (to have the chef-client determine the architecture during the chef-client run). Default value: ``:machine``.

   In order to read or write 32-bit registry keys on 64-bit machines running Microsoft Windows, the ``architecture`` property must be set to ``:i386``. The ``:x86_64`` value can be used to force writing to a 64-bit registry location, but this value is less useful than the default (``:machine``) because the chef-client returns an exception if ``:x86_64`` is used and the machine turns out to be a 32-bit machine (whereas with ``:machine``, the chef-client is able to access the registry key on the 32-bit machine).

   .. note:: .. include:: ../../includes_notes/includes_notes_registry_key_architecture.rst
   
``ignore_failure``
   **Ruby Types:** TrueClass, FalseClass

   Continue running a recipe if a resource fails for any reason. Default value: ``false``.
   
``key``
   **Ruby Type:** String

   The path to the location in which a registry key is to be created or from which a registry key is to be deleted. Default value: the ``name`` of the resource block See "Syntax" section above for more information.
   The path must include the registry hive, which can be specified either as its full name or as the 3- or 4-letter abbreviation. For example, both ``HKLM\SECURITY`` and ``HKEY_LOCAL_MACHINE\SECURITY`` are both valid and equivalent. The following hives are valid: ``HKEY_LOCAL_MACHINE``, ``HKLM``, ``HKEY_CURRENT_CONFIG``, ``HKCC``, ``HKEY_CLASSES_ROOT``, ``HKCR``, ``HKEY_USERS``, ``HKU``, ``HKEY_CURRENT_USER``, and ``HKCU``.
   
``notifies``
   **Ruby Type:** Symbol, 'Chef::Resource[String]'

   .. include:: ../../includes_resources_common/includes_resources_common_notification_notifies.rst

   .. include:: ../../includes_resources_common/includes_resources_common_notification_timers_12-5.rst

   .. include:: ../../includes_resources_common/includes_resources_common_notification_notifies_syntax.rst
   
``provider``
   **Ruby Type:** Chef Class

   Optional. Explicitly specifies a provider.
   
``recursive``
   **Ruby Types:** TrueClass, FalseClass

   When creating a key, this value specifies that the required keys for the specified path are to be created. When using the ``:delete_key`` action in a recipe, and if the registry key has subkeys, then set the value for this property to ``true``.

   .. note:: .. include:: ../../includes_notes/includes_notes_registry_key_resource_recursive.rst
   
``retries``
   **Ruby Type:** Integer

   The number of times to catch exceptions and retry the resource. Default value: ``0``.
   
``retry_delay``
   **Ruby Type:** Integer

   The retry delay (in seconds). Default value: ``2``.
   
``subscribes``
   **Ruby Type:** Symbol, 'Chef::Resource[String]'

   .. include:: ../../includes_resources_common/includes_resources_common_notification_subscribes.rst

   .. include:: ../../includes_resources_common/includes_resources_common_notification_timers_12-5.rst

   .. include:: ../../includes_resources_common/includes_resources_common_notification_subscribes_syntax.rst
   
``values``
   **Ruby Types:** Hash, Array

   An array of hashes, where each Hash contains the values that are to be set under a registry key. Each Hash must contain ``:name``, ``:type``, and ``:data`` (and must contain no other key values).
       
   ``:type`` represents the values available for registry keys in Microsoft Windows. Use ``:binary`` for REG_BINARY, ``:string`` for REG_SZ, ``:multi_string`` for REG_MULTI_SZ, ``:expand_string`` for REG_EXPAND_SZ, ``:dword`` for REG_DWORD, ``:dword_big_endian`` for REG_DWORD_BIG_ENDIAN, or ``:qword`` for REG_QWORD.

   .. warning:: ``:multi_string`` must be an array, even if there is only a single string.
