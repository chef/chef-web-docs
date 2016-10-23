.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

This resource has the following actions:

``:create``
   Default. Create a user with given properties. If a user already exists (but does not match), update that user to match.

``:lock``
   Lock a user's password.

``:manage``
   Manage an existing user. This action does nothing if the user does not exist.

``:modify``
   Modify an existing user. This action raises an exception if the user does not exist.

``:nothing``
   .. include:: ../../includes_resources_common/includes_resources_common_actions_nothing.rst

``:remove``
   Remove a user.

``:unlock``
   Unlock a user's password.
