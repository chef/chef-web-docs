.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

This resource has the following properties:

``chef_server``
   |chef_server_url|

``complete``
   Use to specify if this resource defines an environment completely. When ``true``, any property not specified by this resource will be reset to default property values.

``cookbook_versions``
   The cookbook versions used with the environment. Default value: ``{}``.

``default_attributes``
   |attribute_type default| Default value: ``{}``.

``description``
   |description environment|

``ignore_failure``
   **Ruby Types:** TrueClass, FalseClass

   |ignore_failure| Default value: ``false``.

``name``
   |name environment|

``notifies``
   **Ruby Type:** Symbol, 'Chef::Resource[String]'

   |notifies|

   .. include:: ../../includes_resources_common/includes_resources_common_notifications_syntax_notifies.rst

   .. include:: ../../includes_resources_common/includes_resources_common_notifications_timers.rst

``override_attributes``
   |attribute_type override| Default value: ``{}``.

``raw_json``
   The environment as |json| data. For example:
       
   .. code-block:: javascript
       
      {
        "name":"backend",
        "description":"",
        "cookbook_versions":{},
        "json_class":"Chef::Environment",
        "chef_type":"environment",
        "default_attributes":{},
        "override_attributes":{}
      }

``retries``
   **Ruby Type:** Integer

   |retries| Default value: ``0``.

``retry_delay``
   **Ruby Type:** Integer

   |retry_delay| Default value: ``2``.

``subscribes``
   **Ruby Type:** Symbol, 'Chef::Resource[String]'

   |subscribes|

   .. include:: ../../includes_resources_common/includes_resources_common_notifications_syntax_subscribes.rst

   |subscribes timers|
