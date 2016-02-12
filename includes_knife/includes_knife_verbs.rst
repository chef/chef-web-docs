.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


|knife| includes a set of subcommands that are built around common verbs: ``delete``, ``deps``, ``diff``, ``download``, ``edit``, ``list``, ``show``, ``upload``, ``xargs``. These subcommands allow |knife| to issue commands that interact with any object stored in the |chef repo| or stored on the |chef server|. Some important principles behind this group of subcommands includes:

* A command that works with each object in the |chef repo|. The subcommands specify the desired action (the "verb"), and then directory in which that object resides (``clients``, ``cookbooks/``, ``data_bags/``, ``environments/``, ``nodes``, ``roles/``, and ``users``). For example: ``download cookbooks/``
* A command that works with certain objects in |chef server oec|, including ``acls``, ``groups``, and ``containers``
* Uses the |chef server| as if it were a file system, allowing the |chef repo| on the |chef server| to behave like a mirror of the |chef repo| on the workstation. The |chef server| will have the same objects as the local |chef repo|. To make changes to the files on the |chef server|, just download files from the |chef server| or upload files from the |chef repo|
* The context from which a command is run matters. For example, when working in the ``roles/`` directory, |knife| will know what is being worked with. Enter ``knife show base.json`` and |knife| will return the base role from the |chef server|. From the |chef repo| root, enter ``knife show roles/base.json`` to get the same result
* Parallel requests can be made to the |chef server| and are configurable on a per-command basis
