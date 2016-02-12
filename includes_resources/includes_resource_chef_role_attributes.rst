.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

This resource has the following properties:

``chef_server``
   |chef_server_url|

``complete``
   Use to specify if this resource defines a role completely. When ``true``, any property not specified by this resource will be reset to default property values.

``default_attributes``
   |attribute_type default| Default value: ``{}``.

``description``
   |description role|

``env_run_lists``
   The environment-specific run-list for a role. Default value: ``[]``. For example: ``["env_run_lists[webserver]"]``

``ignore_failure``
   **Ruby Types:** TrueClass, FalseClass

   |ignore_failure| Default value: ``false``.

``name``
   The name of the role.

``notifies``
   **Ruby Type:** Symbol, 'Chef::Resource[String]'

   |notifies|

   .. include:: ../../includes_resources_common/includes_resources_common_notifications_syntax_notifies.rst

   .. include:: ../../includes_resources_common/includes_resources_common_notifications_timers.rst

``override_attributes``
   |attribute_type override| Default value: ``{}``.

``raw_json``
   The role as |json| data. For example:
       
   .. code-block:: javascript
       
     {
       "name": "webserver",
       "chef_type": "role",
       "json_class": "Chef::Role",
       "default_attributes": {},
       "description": "A webserver",
       "run_list": [
         "recipe[apache2]"
       ],
       "override_attributes": {}
     }

``retries``
   **Ruby Type:** Integer

   |retries| Default value: ``0``.

``retry_delay``
   **Ruby Type:** Integer

   |retry_delay| Default value: ``2``.

``run_list``
   |run-list| Default value: ``[]``. For example: ``["recipe[default]","recipe[apache2]"]``

``subscribes``
   **Ruby Type:** Symbol, 'Chef::Resource[String]'

   |subscribes|

   .. include:: ../../includes_resources_common/includes_resources_common_notifications_syntax_subscribes.rst

   |subscribes timers|
