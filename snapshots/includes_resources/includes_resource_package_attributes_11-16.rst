.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

This resource has the following properties:

``allow_downgrade``
   **Ruby Types:** TrueClass, FalseClass

   **yum_package** resource only. Downgrade a package to satisfy requested version requirements. Default value: ``false``.

``arch``
   **Ruby Types:** String, Array

   **yum_package** resource only. The architecture of the package to be installed or upgraded. This value can also be passed as part of the package name.

``default_release``
   **Ruby Type:** String

   **apt_package** resource only. The default release. For example: ``stable``.

``flush_cache``
   **Ruby Type:** Array

   **yum_package** resource only. Flush the in-memory cache before or after a Yum operation that installs, upgrades, or removes a package. Default value: ``{ :before => false, :after => false }``.

   .. note:: The ``flush_cache`` property does not flush the local Yum cache! Use Yum tools---``yum clean headers``, ``yum clean packages``, ``yum clean all``---to clean the local Yum cache.

``gem_binary``
   **Ruby Type:** String

   A property for the ``gem_package`` provider that is used to specify a gems binary.

``ignore_failure``
   **Ruby Types:** TrueClass, FalseClass

   Continue running a recipe if a resource fails for any reason. Default value: ``false``.

``notifies``
   **Ruby Type:** Symbol, 'Chef::Resource[String]'

   .. include:: ../../includes_resources_common/includes_resources_common_notification_notifies.rst

   .. include:: ../../includes_resources_common/includes_resources_common_notification_timers_12-5.rst

   .. include:: ../../includes_resources_common/includes_resources_common_notification_notifies_syntax.rst

``options``
   **Ruby Type:** String

   One (or more) additional options that are passed to the command.

``package_name``
   **Ruby Types:** String, Array

   The name of the package. Default value: the ``name`` of the resource block See "Syntax" section above for more information.

``provider``
   **Ruby Type:** Chef Class

   Optional. Explicitly specifies a provider. See "Providers" section below for more information.

``response_file``
   **Ruby Type:** String

   **apt_package** and **dpkg_package** resources only. The direct path to the file used to pre-seed a package.

``response_file_variables``
   **Ruby Type:** Hash

   **apt_package** and **dpkg_package** resources only. A Hash of response file variables in the form of ``{"VARIABLE" => "VALUE"}``.

``retries``
   **Ruby Type:** Integer

   The number of times to catch exceptions and retry the resource. Default value: ``0``.

``retry_delay``
   **Ruby Type:** Integer

   The retry delay (in seconds). Default value: ``2``.

``source``
   **Ruby Type:** String

   Optional. The path to a package in the local file system.

``subscribes``
   **Ruby Type:** Symbol, 'Chef::Resource[String]'

   .. include:: ../../includes_resources_common/includes_resources_common_notification_subscribes.rst

   .. include:: ../../includes_resources_common/includes_resources_common_notification_timers_12-5.rst

   .. include:: ../../includes_resources_common/includes_resources_common_notification_subscribes_syntax.rst

``timeout``
   **Ruby Types:** String, Integer

   The amount of time (in seconds) to wait before timing out.

``version``
   **Ruby Types:** String, Array

   The version of a package to be installed or upgraded.
