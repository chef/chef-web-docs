.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

This resource has the following properties:

``comment``
   **Ruby Type:** String

   One (or more) comments about the user.

``force``
   **Ruby Types:** TrueClass, FalseClass

   Force the removal of a user. May be used only with the ``:remove`` action.

   .. warning:: .. include:: ../../includes_notes/includes_notes_user_resource_force_property.rst

``gid``
   **Ruby Types:** String, Integer

   The identifier for the group.

``group``
   **Ruby Types:** String, Integer

   The ``group`` property is an alias of the ``gid`` property.

``home``
   **Ruby Type:** String

   The location of the home directory.

``ignore_failure``
   **Ruby Types:** TrueClass, FalseClass

   Continue running a recipe if a resource fails for any reason. Default value: ``false``.

``iterations``
   **Ruby Type:** Integer

   Mac OS X platform only, 10.8 (or higher). The number of iterations for a password with a SALTED-SHA512-PBKDF2 shadow hash.

``manage_home``
   **Ruby Types:** TrueClass, FalseClass

   Manage a user's home directory.

   With the ``:create`` action, a user's home directory is created based on ``HOME_DIR``. If the home directory is missing, it is created unless ``CREATE_HOME`` in ``/etc/login.defs`` is set to ``no``. When created, a skeleton set of files and sub-directories is also created in the home directory.

   With the ``:modify`` action, a user's home directory is moved to ``HOME_DIR``. If the home directory is missing, it is created unless ``CREATE_HOME`` in ``/etc/login.defs`` is set to ``no``. The contents of the user's home directory are moved to the new location.

``non_unique``
   **Ruby Types:** TrueClass, FalseClass

   Create a duplicate (non-unique) user account.

``notifies``
   **Ruby Type:** Symbol, 'Chef::Resource[String]'

   .. include:: ../../includes_resources_common/includes_resources_common_notification_notifies.rst

   .. include:: ../../includes_resources_common/includes_resources_common_notification_timers_12-5.rst

   .. include:: ../../includes_resources_common/includes_resources_common_notification_notifies_syntax.rst

``password``
   **Ruby Type:** String

   The password shadow hash. This property requires that ``ruby-shadow`` be installed. This is part of the Debian package: ``libshadow-ruby1.8``.

``provider``
   **Ruby Type:** Chef Class

   Optional. Explicitly specifies a provider. See "Providers" section below for more information.

``retries``
   **Ruby Type:** Integer

   The number of times to catch exceptions and retry the resource. Default value: ``0``.

``retry_delay``
   **Ruby Type:** Integer

   The retry delay (in seconds). Default value: ``2``.

``salt``
   **Ruby Type:** String

   Mac OS X platform only, 10.7 or higher. The salt value for a password shadow hash. Mac OS X version 10.7 uses SALTED-SHA512 and version 10.8 (and higher) uses SALTED-SHA512-PBKDF2 to calculate password shadow hashes. 

``shell``
   **Ruby Type:** String

   The login shell.

``supports``
   **Ruby Type:** Hash

   A Mash where keys represent features and values are booleans that indicate if that feature is supported. Default value: ``:manage_home => false, :non_unique => false``.

``subscribes``
   **Ruby Type:** Symbol, 'Chef::Resource[String]'

   .. include:: ../../includes_resources_common/includes_resources_common_notification_subscribes.rst

   .. include:: ../../includes_resources_common/includes_resources_common_notification_timers_12-5.rst

   .. include:: ../../includes_resources_common/includes_resources_common_notification_subscribes_syntax.rst

``system``
   **Ruby Types:** TrueClass, FalseClass

   Create a system user. This property may be used with ``useradd`` as the provider to create a system user which passes the ``-r`` flag to ``useradd``.

``uid``
   **Ruby Types:** String, Integer

   The numeric user identifier.

``username``
   **Ruby Type:** String

   The name of the user. Default value: the ``name`` of the resource block See "Syntax" section above for more information.
