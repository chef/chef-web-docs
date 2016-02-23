.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

This resource has the following properties:
   
``checksum``
   **Ruby Type:** String

   |checksum remote_file| Use when a URL is specified by the ``source`` property.
   
``ignore_failure``
   **Ruby Types:** TrueClass, FalseClass

   |ignore_failure| Default value: ``false``.
   
``installer_type``
   **Ruby Type:** Symbol

   |type package| Possible values: ``:custom`` (such as installing a non-.msi file that embeds an .msi-based installer), ``:inno`` (|inno setup|), ``:installshield`` (|installshield|), ``:msi`` (|microsoft installer package|), ``:nsis`` (|nsis|), ``:wise`` (|wise|).

   
``notifies``
   **Ruby Type:** Symbol, 'Chef::Resource[String]'

   .. include:: ../../includes_resources_common/includes_resources_common_notification_notifies.rst

   .. include:: ../../includes_resources_common/includes_resources_common_notification_timers_12-5.rst

   .. include:: ../../includes_resources_common/includes_resources_common_notification_notifies_syntax.rst
   
``options``
   **Ruby Type:** String

   |command options|
   
``provider``
   **Ruby Type:** Chef Class

   Optional. |provider resource_parameter| |see providers|
   
``remote_file_attributes``
   **Ruby Type:** Hash

   |remote_file_attributes|
   
``retries``
   **Ruby Type:** Integer

   |retries| Default value: ``0``.
   
``retry_delay``
   **Ruby Type:** Integer

   |retry_delay| Default value: ``2``.
   
``returns``
   **Ruby Types:** String, Integer, Array

   |returns| This code signals a successful ``:install`` action. Default value: ``0``.
   
``source``
   **Ruby Type:** String

   Optional. |source resource package| The location of the package may be at a URL. |resource_block_default| |see syntax|

   .. include:: ../../includes_resources/includes_resource_package_windows_attributes_source_displayname.rst

``subscribes``
   **Ruby Type:** Symbol, 'Chef::Resource[String]'

   .. include:: ../../includes_resources_common/includes_resources_common_notification_subscribes.rst

   .. include:: ../../includes_resources_common/includes_resources_common_notification_timers_12-5.rst

   .. include:: ../../includes_resources_common/includes_resources_common_notification_subscribes_syntax.rst
   
``timeout``
   **Ruby Types:** String, Integer

   |timeout| Default value: ``600`` (seconds).
