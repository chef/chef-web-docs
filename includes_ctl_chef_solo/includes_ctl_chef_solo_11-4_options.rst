.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


This command has the following syntax:

.. code-block:: bash

   chef-solo OPTION VALUE OPTION VALUE ...

This command has the following options:

``-c CONFIG``, ``--config CONFIG``
   |config chef-client|

``-d``, ``--daemonize``
   |daemonize|

   |daemonize windows|

``-f``, ``--[no-]fork``
   |fork_chef|

``-F FORMAT``, ``--format FORMAT``
   .. include:: ../../includes_ctl_chef_client/includes_ctl_chef_client_options_format

``--force-formatter``
   |force_formatter|

``--force-logger``
   |force_logger|

``-g GROUP``, ``--group GROUP``
   |name group_process_owner|

``-h``, ``--help``
   |help subcommand|

``-i SECONDS``, ``--interval SECONDS``
   |interval| |chef_client intervals_11-16|

``-j PATH``, ``--json-attributes PATH``
   |json attributes|

   .. include:: ../../includes_node/includes_node_ctl_run_list.rst

   .. warning:: .. include:: ../../includes_node/includes_node_ctl_attribute.rst

``-l LEVEL``, ``--log_level LEVEL``
   |log_level|

``-L LOGLOCATION``, ``--logfile c``
   |log_location| This is recommended when starting any executable as a daemon.

``--[no-]color``
   |color| Default setting: ``--color``.

``-N NODE_NAME``, ``--node-name NODE_NAME``
   |name node|

``-o RUN_LIST_ITEM``, ``--override-runlist RUN_LIST_ITEM``
   |override_runlist|

``-r RECIPE_URL``, ``--recipe-url RECIPE_URL``
   |recipe_url|

``-s SECONDS``, ``--splay SECONDS``
   |splay| |chef_client intervals_11-16|

``-u USER``, ``--user USER``
   |user chef_client|

``-v``, ``--version``
   |version chef|

``-W``, ``--why-run``
   |whyrun_mode|









