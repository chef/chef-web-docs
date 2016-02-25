.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

This resource has the following properties:
   
``code``
   **Ruby Type:** String

   |code powershell| |dsc_script no_command|
   
``command``
   **Ruby Type:** String

   |command powershell| |dsc_script no_code|
   
``configuration_data``
   **Ruby Type:** String

   |config powershell| The configuration data must be `a valid Windows Powershell data file <http://msdn.microsoft.com/en-us/library/dd878337(v=vs.85).aspx>`_. |dsc_script no_config_data_script|
   
``configuration_data_script``
   **Ruby Type:** String

   |path powershell_data_file| |dsc_script no_config_data|
   
``configuration_name``
   **Ruby Type:** String

   |name powershell_cmdlet| |dsc_script no_code|
   
``cwd``
   **Ruby Type:** String

   |cwd|
   
``environment``
   **Ruby Type:** Hash

   |environment variables|
   
``flags``
   **Ruby Type:** Hash

   |flags powershell| |dsc_script no_code| For example: ``flags ({ :EditorChoice => 'emacs', :EditorFlags => '--maximized' })``. Default value: ``nil``.
   
``ignore_failure``
   **Ruby Types:** TrueClass, FalseClass

   |ignore_failure| Default value: ``false``.
   
``imports``
   **Ruby Type:** Array

   .. warning:: This property **MUST** be used with the ``code`` attribute.

   Use to import |windows powershell_dsc_short| resources from a module.

   .. include:: ../../step_resource/step_resource_dsc_script_import_resources_all.rst

   .. include:: ../../step_resource/step_resource_dsc_script_import_resources_specific.rst

   .. include:: ../../step_resource/step_resource_dsc_script_import_resources_single.rst
   
``notifies``
   **Ruby Type:** Symbol, 'Chef::Resource[String]'

   .. include:: ../../includes_resources_common/includes_resources_common_notification_notifies.rst

   .. include:: ../../includes_resources_common/includes_resources_common_notification_timers.rst

   .. include:: ../../includes_resources_common/includes_resources_common_notification_notifies_syntax.rst
   
``retries``
   **Ruby Type:** Integer

   |retries| Default value: ``0``.
   
``retry_delay``
   **Ruby Type:** Integer

   |retry_delay| Default value: ``2``.
   
``subscribes``
   **Ruby Type:** Symbol, 'Chef::Resource[String]'

   .. include:: ../../includes_resources_common/includes_resources_common_notification_subscribes.rst

   .. include:: ../../includes_resources_common/includes_resources_common_notification_timers.rst

   .. include:: ../../includes_resources_common/includes_resources_common_notification_subscribes_syntax.rst
   
``timeout``
   **Ruby Types:** Integer

   |timeout command|
