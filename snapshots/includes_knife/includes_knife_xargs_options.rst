.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics. 


This subcommand has the following options:

``-0``
   |use null_character| Default: ``false``.

``--chef-repo-path PATH``
   The path to the chef-repo. This setting will override the default path to the chef-repo. Default: same value as specified by ``chef_repo_path`` in client.rb.

``--concurrency``
   The number of allowed concurrent connections. Default: ``10``.

``--[no-]diff``
   Show a diff when a file changes. Default: ``--diff``.

``--dry-run``
   Prevent changes from being uploaded to the Chef server. Default: ``false``.

``--[no-]force``
   Force the upload of files even if they haven't been changed. Default: ``--no-force``. 

``-I REPLACE_STRING``, ``--replace REPLACE_STRING``
   Define a string that is to be used to replace all occurrences of a file name. Default: ``nil``.

``-J REPLACE_STRING``, ``--replace-first REPLACE_STRING``
   Define a string that is to be used to replace the first occurrence of a file name. Default: ``nil``.

``--local``
   Build or execute a command line against a local file. Set to ``false`` to build or execute against a remote file. Default: ``false``.

``-n MAX_ARGS``, ``--max-args MAX_ARGS``
   The maximum number of arguments per command line. Default: ``nil``.

``-p [PATTERN...]``, ``--pattern [PATTERN...]``
   One (or more) patterns for a command line. If this option is not specified, a list of patterns may be expected on standard input. Default: ``nil``.

``--repo-mode MODE``
   The layout of the local chef-repo. Possible values: ``static``, ``everything``, or ``hosted_everything``. Use ``static`` for just roles, environments, cookbooks, and data bags. By default, ``everything`` and ``hosted_everything`` are dynamically selected depending on the server type. Default value: ``default``.

``-s LENGTH``, ``--max-chars LENGTH``
   The maximum size (in characters) for a command line. Default: ``nil``.

``-t``
   Run the print command on the command line. Default: ``nil``.



