.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

This resource has the following actions:

``:create``
   Default. Create a registry key. If a registry key already exists (but does not match), update that registry key to match.

``:create_if_missing``
   Create a registry key if it does not exist. Also, create a registry key value if it does not exist.

``:delete``
   Delete the specified values for a registry key.

``:delete_key``
   Delete the specified registry key and all of its subkeys.

``:nothing``
   .. include:: ../../includes_resources_common/includes_resources_common_actions_nothing.rst

.. note:: .. include:: ../../includes_notes/includes_notes_registry_key_resource_recursive.rst
