.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

This resource has the following properties:

``chef_server``
   |chef_server_url|

``clients``
   ...

``complete``
   Use to specify if this resource defines a |chef client| completely. When ``true``, any property not specified by this resource will be reset to default property values.

``groups``
   ...

``ignore_failure``
   **Ruby Types:** TrueClass, FalseClass

   |ignore_failure| Default value: ``false``.

``name``
   

``notifies``
   **Ruby Type:** Symbol, 'Chef::Resource[String]'

   |notifies|

   .. include:: ../../includes_resources_common/includes_resources_common_notifications_syntax_notifies.rst

   .. include:: ../../includes_resources_common/includes_resources_common_notifications_timers.rst

``raw_json``
   The group as |json| data. For example:
       
   .. code-block:: javascript
       
      {
	    :groupname => "chef"
      }

``remove_clients``
   ...

``remove_groups``
   ...

``remove_users``
   ...

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

``users``
   ...
