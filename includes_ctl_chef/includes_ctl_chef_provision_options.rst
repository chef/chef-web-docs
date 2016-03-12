.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


This subcommand has the following options:

``-c CONFIG_FILE``, ``--config CONFIG_FILE``
   |chef_exe config|

``--cookbook COOKBOOK_PATH``
   |chef_exe cookbook_path| Default value: ``./provision``.

``-d``, ``--destroy``
   |chef_exe destroy_machine| Default value: ``false``.

``-D``, ``--debug``
   |chef_exe debug| Default value: ``false``.

``-h``, ``--help``
   |help subcommand|

``-n NODE_NAME``, ``--node-name NODE_NAME``
   |chef_exe node_name|

``-o OPT=VALUE``, ``--opt OPT=VALUE``
   |chef_exe options| Default value: ``{}``.

   .. note:: .. include:: ../../includes_notes/includes_notes_chef_exe_opt.rst

``-p POLICY_NAME``, ``--policy-name POLICY_NAME``
   |chef_exe policy_name|

``--[no-]policy``
   |no_policy| Default value: ``--policy``.

``-r RECIPE``, ``--recipe RECIPE``
   |chef_exe recipe|

``-s PATH``, ``--sync PATH``
   |chef_exe sync_path|

``-t REMOTE_HOST``, ``--target REMOTE_HOST``
   |chef_exe target|

``-v``, ``--version``
   |version chef|
