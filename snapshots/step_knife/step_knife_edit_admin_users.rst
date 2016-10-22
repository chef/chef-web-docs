.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

A user who belongs to the ``admins`` group must be removed from the group before they may be removed from an organization. To remove a user from the ``admins`` group, run the following:

.. code-block:: bash

   $ EDITOR=vi knife edit /groups/admins.json

make the required changes, and then save the file.