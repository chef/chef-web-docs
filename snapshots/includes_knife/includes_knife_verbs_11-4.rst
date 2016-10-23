.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


knife includes a set of subcommands that are built around common verbs: ``create``, ``delete``, ``download``, ``list``, ``show``, and ``upload``. These subcommands allow knife to issue commands that interact with any object stored in the chef-repo or stored on the Chef server. Some important principles behind this group of subcommands includes:

* A command that works with each object in the chef-repo. The subcommands specify the desired action (the "verb"), and then directory in which that object resides (``cookbooks/``, ``data_bags/``, ``environments/``, and ``roles/``). For example: ``download cookbooks/``
* Uses the Chef server as if it were a file system, allowing the chef-repo on the Chef server to behave like a mirror of the chef-repo on the workstation. The Chef server will have the same objects as the local chef-repo. To make changes to the files on the Chef server, just download files from the Chef server or upload files from the chef-repo
* The context from which a command is run matters. For example, when working in the ``/roles`` directory, knife will know what is being worked with. Enter ``knife show base.json`` and knife will return the base role from the Chef server. From the chef-repo root, enter ``knife show roles/base.json`` to get the same result

