.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

This resource has the following properties:
   
``code``
   **Ruby Type:** String

   A quoted (" ") string of code to be executed.
   
``creates``
   **Ruby Type:** String

   Prevent a command from creating a file when that file already exists.
   
``cwd``
   **Ruby Type:** String

   The current working directory.
   
``environment``
   **Ruby Type:** Hash

   A Hash of environment variables in the form of ``({"ENV_VARIABLE" => "VALUE"})``. (These variables must exist for a command to be run successfully.)
   
``flags``
   **Ruby Type:** String

   One or more command line flags that are passed to the interpreter when a command is invoked.
   
``group``
   **Ruby Types:** String, Integer

   The group name or group ID that must be changed before running a command.
   
``ignore_failure``
   **Ruby Types:** TrueClass, FalseClass

   Continue running a recipe if a resource fails for any reason. Default value: ``false``.
   
``notifies``
   **Ruby Type:** Symbol, 'Chef::Resource[String]'

   .. include:: ../../includes_resources_common/includes_resources_common_notification_notifies.rst

   .. include:: ../../includes_resources_common/includes_resources_common_notification_timers.rst

   .. include:: ../../includes_resources_common/includes_resources_common_notification_notifies_syntax.rst
   
``path``
   **Ruby Type:** Array

   An array of paths to use when searching for a command. These paths are not added to the command's environment $PATH. The default value uses the system path.

   .. warning:: .. include:: ../../includes_resources_common/includes_resources_common_resource_execute_attribute_path.rst

      For example:

      .. code-block:: ruby

         perl 'mycommand' do
           environment 'PATH' => "/my/path/to/bin:#{ENV['PATH']}"
         end


``provider``
   **Ruby Type:** Chef Class

   Optional. Explicitly specifies a provider. See "Providers" section below for more information.
   
``retries``
   **Ruby Type:** Integer

   The number of times to catch exceptions and retry the resource. Default value: ``0``.
   
``retry_delay``
   **Ruby Type:** Integer

   The retry delay (in seconds). Default value: ``2``.
   
``returns``
   **Ruby Types:** Integer, Array

   The return value for a command. This may be an array of accepted values. An exception is raised when the return value(s) do not match. Default value: ``0``.
   
``subscribes``
   **Ruby Type:** Symbol, 'Chef::Resource[String]'

   .. include:: ../../includes_resources_common/includes_resources_common_notification_subscribes.rst

   .. include:: ../../includes_resources_common/includes_resources_common_notification_timers.rst

   .. include:: ../../includes_resources_common/includes_resources_common_notification_subscribes_syntax.rst
   
``timeout``
   **Ruby Types:** Integer, Float

   The amount of time (in seconds) a command is to wait before timing out. Default value: ``3600``.
   
``user``
   **Ruby Types:** String, Integer

   The user name or user ID that should be changed before running a command.
   
``umask``
   **Ruby Types:** String, Integer

   The file mode creation mask, or umask.
