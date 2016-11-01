.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


In versions of the chef-client prior to version 12.0, this subcommand ONLY works when run against the open source Chef server; it does not run against Enterprise Chef (including hosted Enterprise Chef), or Private Chef.

Starting with Chef server 12.0, this functionality is built into the :doc:`chef-server-ctl <ctl_chef_server>` command-line tool as part of the following arguments:

* :ref:`user-create <ctl_chef_server-user-create>`
* :ref:`user-delete <ctl_chef_server-user-delete>`
* :ref:`user-edit <ctl_chef_server-user-edit>`
* :ref:`user-list <ctl_chef_server-user-list>`
* :ref:`user-show <ctl_chef_server-user-show>`

Starting with chef-client version 12.4.1, the ``knife user`` functionality is restored for the following arguments: ``user-edit``, ``user-list``, and ``user-show`` for Chef server version 12.0 (and higher).

Starting with Chef server 12.4.1, :ref:`users who are members of the server-admins group <ctl_chef_server-server-admins>` may use the ``user-create``, ``user-delete``, ``user-edit``, ``user-list``, and ``user-show`` arguements to manage user accounts on the Chef server via the ``knife user`` subcommand.

