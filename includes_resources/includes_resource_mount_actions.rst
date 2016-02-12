.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

This resource has the following actions:

``:disable``
   |resource action disable mount|

``:enable``
   |resource action enable mount|

``:mount``
   Default. |resource action mount mount|

``:nothing``
   |resource action nothing|

``:remount``
   |resource action remount mount|

``:umount``
   |resource action umount mount|

.. note:: Order matters when passing multiple actions. For example: ``action [:mount, :enable]`` ensures that the file system is mounted before it is enabled.
