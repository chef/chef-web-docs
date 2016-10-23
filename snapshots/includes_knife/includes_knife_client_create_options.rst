.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


This argument has the following options:

``-a``, ``--admin``
   Create a client as an admin client. This is required for any user to access Open Source Chef as an administrator.  This option only works when used with the open source Chef server and will have no effect when used with Enterprise Chef or Chef server 12.x.

``-f FILE``, ``--file FILE``
   Save a private key to the specified file name.

``-k``, ``--prevent-keygen``
   Create a user without a public key. This key may be managed later by using the ``knife user key`` subcommands.

   .. note:: .. include:: ../../includes_notes/includes_notes_knife_prevent_keygen.rst

``-p FILE``, ``--public-key FILE``
   The path to a file that contains the public key. This option may not be passed in the same command with ``--prevent-keygen``. When using Open Source Chef a default key is generated if this option is not passed in the command. For Chef server version 12.x, see the ``--prevent-keygen`` option.

``--validator``
   Create the client as the chef-validator. Default value: ``true``.

