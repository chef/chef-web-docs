.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


In versions of the chef-client prior to version 12.0, this subcommand ONLY works when run against the open source Chef server; it does not run against Enterprise Chef (including hosted Enterprise Chef), or Private Chef.

Starting with Chef server 12.0, this functionality is built into the `chef-server-ctl <https://docs.chef.io/ctl_chef_server.html>`_ command-line tool as part of the following arguments:

* `user-create <https://docs.chef.io/ctl_chef_server.html#user-create>`_
* `user-delete <https://docs.chef.io/ctl_chef_server.html#user-delete>`_
* `user-edit <https://docs.chef.io/ctl_chef_server.html#user-edit>`_
* `user-list <https://docs.chef.io/ctl_chef_server.html#user-list>`_
* `user-show <https://docs.chef.io/ctl_chef_server.html#user-show>`_

Starting with chef-client version 12.4.1, the ``knife user`` functionality is restored for the following arguments: ``user-edit``, ``user-list``, and ``user-show`` for Chef server version 12.0 (and higher).

Starting with Chef server 12.4.1, `users who are members of the server-admins group <https://docs.chef.io/ctl_chef_server.html#server-admins>`_ may use the ``user-create``, ``user-delete``, ``user-edit``, ``user-list``, and ``user-show`` arguements to manage user accounts on the Chef server via the ``knife user`` subcommand.

