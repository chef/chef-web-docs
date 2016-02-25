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
   .. include:: ../../includes_node/includes_node_attribute_type_default.rst

   Default value: ``{}``.

``description``
   |description environment|

``ignore_failure``
   **Ruby Types:** TrueClass, FalseClass

   |ignore_failure| Default value: ``false``.

``name``
   |name environment|

``notifies``
   **Ruby Type:** Symbol, 'Chef::Resource[String]'

   .. include:: ../../includes_resources_common/includes_resources_common_notification_notifies.rst

   .. include:: ../../includes_resources_common/includes_resources_common_notification_timers.rst

   .. include:: ../../includes_resources_common/includes_resources_common_notification_notifies_syntax.rst

``override_attributes``
   .. include:: ../../includes_node/includes_node_attribute_type_override.rst

   Default value: ``{}``.

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

   .. include:: ../../includes_resources_common/includes_resources_common_notification_subscribes.rst

   .. include:: ../../includes_resources_common/includes_resources_common_notification_timers.rst

   .. include:: ../../includes_resources_common/includes_resources_common_notification_subscribes_syntax.rst
