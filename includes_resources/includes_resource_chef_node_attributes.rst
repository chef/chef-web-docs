.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

This resource has the following properties:

``automatic_attributes``
   .. include:: ../../includes_node/includes_node_attribute_type_automatic.rst

   Default value: ``{}``.

``chef_environment``
   The |chef server| environment in which this node should exist (or does exist).

``chef_server``
   |chef_server_url|

``complete``
   Use to specify if this resource defines a node completely. When ``true``, any property not specified by this resource will be reset to default property values.

``default_attributes``
   .. include:: ../../includes_node/includes_node_attribute_type_default.rst

   Default value: ``{}``.

``ignore_failure``
   **Ruby Types:** TrueClass, FalseClass

   |ignore_failure| Default value: ``false``.

``name``
   The name of the node.

``normal_attributes``
   .. include:: ../../includes_node/includes_node_attribute_type_normal.rst

   Default value: ``{}``.

``notifies``
   **Ruby Type:** Symbol, 'Chef::Resource[String]'

   |notifies|

   .. include:: ../../includes_resources_common/includes_resources_common_notifications_syntax_notifies.rst

   .. include:: ../../includes_resources_common/includes_resources_common_notifications_timers.rst

``override_attributes``
   .. include:: ../../includes_node/includes_node_attribute_type_override.rst

   Default value: ``{}``.

``raw_json``
   The node as |json| data. For example:
       
   .. code-block:: javascript
       
      {
        "overrides": {},
        "name": "latte",
        "chef_type": "node",
        "json_class": "Chef::Node",
        "attributes": {
          "hardware_type": "laptop"
        },
        "run_list": [
          "recipe[apache2]"
        ],
        "defaults": {}
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
