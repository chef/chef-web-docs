.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

This resource has the following properties:
   
``attributes``
   Use to specify a hash of attributes to be applied to the machine image.
   
``chef_environment``
   |name environment|
   
``complete``
   Use to specify if all of the attributes specified in ``attributes`` represent a complete specification for the machine image. When true, any attributes not specified in ``attributes`` will be reset to their default values.
   
``ignore_failure``
   **Ruby Types:** TrueClass, FalseClass

   |ignore_failure| Default value: ``false``.
   
``image_options``
   **Ruby Type:** Hash

   Use to specify options that are used with this machine image.
   
``name``
   The name of the machine image.
   
``notifies``
   **Ruby Type:** Symbol, 'Chef::Resource[String]'

   |notifies|

   .. include:: ../../includes_resources_common/includes_resources_common_notifications_syntax_notifies.rst

   .. include:: ../../includes_resources_common/includes_resources_common_notifications_timers.rst
   
``raw_json``
   The machine image as |json| data. For example:
       
   .. code-block:: javascript
       
      {
       
      }
   
``recipe``
   Use to add a recipe to the run-list for the machine image. Each ``recipe`` adds a single recipe to the run-list. The order in which ``recipe`` defines the run-list is the order in which |chef| will execute the run-list on the machine image.
   
``remove_recipe``
   Use to remove a recipe from the run-list for the machine image.
   
``remove_role``
   Use to remove a role from the run-list for the machine image.
   
``retries``
   **Ruby Type:** Integer

   |retries| Default value: ``0``.
   
``retry_delay``
   **Ruby Type:** Integer

   |retry_delay| Default value: ``2``.
   
``role``
   Use to add a role to the run-list for the machine image.
   
``run_list``
   Use to specify the run-list to be applied to the machine image.
	   
   .. include:: ../../includes_node/includes_node_run_list.rst
       
   .. include:: ../../includes_node/includes_node_run_list_format.rst
   
``subscribes``
   **Ruby Type:** Symbol, 'Chef::Resource[String]'

   |subscribes|

   .. include:: ../../includes_resources_common/includes_resources_common_notifications_syntax_subscribes.rst

   |subscribes timers|
   
``tags``
   Use to specify the list of tags to be applied to the machine image. Any tag not specified in this list will be removed.
