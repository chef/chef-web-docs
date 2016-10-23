.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

This resource has the following properties:
   
``attributes``
   Use to specify a hash of attributes to be applied to the machine image.
   
``chef_environment``
   The name of the environment.
   
``complete``
   Use to specify if all of the attributes specified in ``attributes`` represent a complete specification for the machine image. When true, any attributes not specified in ``attributes`` will be reset to their default values.
   
``ignore_failure``
   **Ruby Types:** TrueClass, FalseClass

   Continue running a recipe if a resource fails for any reason. Default value: ``false``.
   
``image_options``
   **Ruby Type:** Hash

   Use to specify options that are used with this machine image.
   
``name``
   The name of the machine image.
   
``notifies``
   **Ruby Type:** Symbol, 'Chef::Resource[String]'

   .. include:: ../../includes_resources_common/includes_resources_common_notification_notifies.rst

   .. include:: ../../includes_resources_common/includes_resources_common_notification_timers.rst

   .. include:: ../../includes_resources_common/includes_resources_common_notification_notifies_syntax.rst
   
``raw_json``
   The machine image as JSON data. For example:
       
   .. code-block:: javascript
       
      {
       
      }
   
``recipe``
   Use to add a recipe to the run-list for the machine image. Each ``recipe`` adds a single recipe to the run-list. The order in which ``recipe`` defines the run-list is the order in which Chef will execute the run-list on the machine image.
   
``remove_recipe``
   Use to remove a recipe from the run-list for the machine image.
   
``remove_role``
   Use to remove a role from the run-list for the machine image.
   
``retries``
   **Ruby Type:** Integer

   The number of times to catch exceptions and retry the resource. Default value: ``0``.
   
``retry_delay``
   **Ruby Type:** Integer

   The retry delay (in seconds). Default value: ``2``.
   
``role``
   Use to add a role to the run-list for the machine image.
   
``run_list``
   Use to specify the run-list to be applied to the machine image.
	   
   .. include:: ../../includes_node/includes_node_run_list.rst
       
   .. include:: ../../includes_node/includes_node_run_list_format.rst
   
``subscribes``
   **Ruby Type:** Symbol, 'Chef::Resource[String]'

   .. include:: ../../includes_resources_common/includes_resources_common_notification_subscribes.rst

   .. include:: ../../includes_resources_common/includes_resources_common_notification_timers.rst

   .. include:: ../../includes_resources_common/includes_resources_common_notification_subscribes_syntax.rst
   
``tags``
   Use to specify the list of tags to be applied to the machine image. Any tag not specified in this list will be removed.
