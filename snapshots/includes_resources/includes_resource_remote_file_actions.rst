.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

This resource has the following actions:

``:create``
   Default. Create a file. If a file already exists (but does not match), update that file to match.

   .. warning:: .. include:: ../../includes_notes/includes_notes_selinux_file_based_resources.rst

``:create_if_missing``
   Create a file only if the file does not exist. When the file exists, nothing happens.

``:delete``
   Delete a file.

``:nothing``
   .. include:: ../../includes_resources_common/includes_resources_common_actions_nothing.rst

``:touch``
   Touch a file. This updates the access (atime) and file modification (mtime) times for a file. (This action may be used with this resource, but is typically only used with the **file** resource.)
