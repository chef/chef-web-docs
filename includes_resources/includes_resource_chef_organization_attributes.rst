.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

This resource has the following properties:

``chef_server``
   |chef_server_url|

``complete``
   Use to specify if this resource defines an organization completely. When ``true``, any property not specified by this resource will be reset to default property values.

``full_name``
   |name_rules org_full| For example: ``Chef Software, Inc.``.

``ignore_failure``
   **Ruby Types:** TrueClass, FalseClass

   |ignore_failure| Default value: ``false``.

``invites``
   Use to specify a list of users to be invited to the organization. An invitation is sent to any user in this list who is not already a member of the organization.

``members``
   Use to specify a list of users who MUST be members of the organization. These users will be added directly to the organization. The user who initiates this operation MUST also have permission to add users to the specified organization.

``members_specified``
   Use to discover if a user is a member of an organization. Will return ``true`` if the user is a member.

``name``
   |name_rules org| For example: ``chef``.

``notifies``
   **Ruby Type:** Symbol, 'Chef::Resource[String]'

   |notifies|

   .. include:: ../../includes_resources_common/includes_resources_common_notifications_syntax_notifies.rst

   .. include:: ../../includes_resources_common/includes_resources_common_notifications_timers.rst

``raw_json``
   The organization as |json| data. For example:
       
   .. code-block:: javascript
       
      {
        "name"=>"chef",
        "full_name"=>"Chef Software, Inc",
        "guid"=>"f980d1asdfda0331235s00ff36862
        ...
      }

``remove_members``
   Use to remove the specified users from an organization. Invitations that have not been accepted will be cancelled.

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
