.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

The following options can be run with all |knife| sub-commands and plug-ins:

``-c CONFIG_FILE``, ``--config CONFIG_FILE``
   |config| For example, when |knife| is run from a node that is configured to be managed by the |chef server|, this option is used to allow |knife| to use the same credentials as the |chef client| when communicating with the |chef server|.

``--chef-zero-port PORT``
   |port chef_zero|

``-d``, ``--disable-editing``
   |no_editor|

``--defaults``
   |defaults|

``-e EDITOR``, ``--editor EDITOR``
   |editor|

``-E ENVIRONMENT``, ``--environment ENVIRONMENT``
   |name environment| When this option is added to a command, the command will run only against the named environment.

``-F FORMAT``, ``--format FORMAT``
   |format|

``-h``, ``--help``
   |help subcommand|

``-k KEY``, ``--key KEY``
   |key|

``--[no-]color``
   |color|

``--print-after``
   |print_after|

``-s URL``, ``--server-url URL``
   |url chef_server|

``-u USER``, ``--user USER``
   |user knife|

``-v``, ``--version``
   |version chef|

``-V``, ``--verbose``
   |verbose|

``-y``, ``--yes``
   |yes|

``-z``, ``--local-mode``
   |local_mode|










