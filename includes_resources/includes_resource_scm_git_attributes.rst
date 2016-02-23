.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

This resource has the following properties:
   
``additional_remotes``
   **Ruby Type:** Hash

   |additional_remotes|
   
``checkout_branch``
   **Ruby Type:** String

   |checkout_branch git| See ``revision``. Default value: ``deploy``.
   
``depth``
   **Ruby Type:** Integer

   |depth git_shallow_clone| The default behavior will do a full clone.
   
``destination``
   **Ruby Type:** String

   |destination resource scm| |resource_block_default| |see syntax|
   
``enable_checkout``
   **Ruby Types:** TrueClass, FalseClass

   |enable_git_checkout| Set to ``false`` when using the ``checkout_branch`` attribute to prevent the |resource scm_git| resource from attempting to check out master from master. Default value: ``true``.
   
``enable_submodules``
   **Ruby Types:** TrueClass, FalseClass

   |enable_submodules| Default value: ``false``.
   
``environment``
   **Ruby Type:** Hash

   |environment variables|

   .. note:: .. include:: ../../includes_notes/includes_notes_scm_resource_git_env_variables.rst
   
``group``
   **Ruby Types:** String, Integer

   |group deploy|
   
``ignore_failure``
   **Ruby Types:** TrueClass, FalseClass

   |ignore_failure| Default value: ``false``.
   
``notifies``
   **Ruby Type:** Symbol, 'Chef::Resource[String]'

   .. include:: ../../includes_resources_common/includes_resources_common_notification_notifies.rst

   .. include:: ../../includes_resources_common/includes_resources_common_notification_timers_12-5.rst

   .. include:: ../../includes_resources_common/includes_resources_common_notification_notifies_syntax.rst
   
``provider``
   **Ruby Type:** Chef Class

   Optional. |provider resource_parameter|
   
``reference``
   **Ruby Type:** String

   |reference resource scm|
   
``remote``
   **Ruby Type:** String

   |remote resource|
   
``repository``
   **Ruby Type:** String

   |uri repository_git|
   
``retries``
   **Ruby Type:** Integer

   |retries| Default value: ``0``.
   
``retry_delay``
   **Ruby Type:** Integer

   |retry_delay| Default value: ``2``.
   
``revision``
   **Ruby Type:** String

   |revision| See ``checkout_branch``. Default value: ``HEAD``.

   .. include:: ../../includes_resources/includes_resource_scm_git_attributes_revision.rst
   
``ssh_wrapper``
   **Ruby Type:** String

   |ssh_wrapper resource|
   
``subscribes``
   **Ruby Type:** Symbol, 'Chef::Resource[String]'

   .. include:: ../../includes_resources_common/includes_resources_common_notification_subscribes.rst

   .. include:: ../../includes_resources_common/includes_resources_common_notification_timers_12-5.rst

   .. include:: ../../includes_resources_common/includes_resources_common_notification_subscribes_syntax.rst
   
``timeout``
   **Ruby Type:** Integer

   |timeout scm| |timeout scm_value_git|
   
``user``
   **Ruby Types:** String, Integer

   |user checked_out_code| Default value: the home directory of this user, as indicated by the ``HOME`` environment variable.
