.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


This option is valid only with |api chef server|, version 1.0, which was released with |chef server| 12.1. If this option or the ``--user-key`` option are not passed in the command, the |chef server| will create a user with a public key named ``default`` and will return the private key. For the |chef server| versions earlier than 12.1, this option will not work; a public key is always generated unless ``--user-key`` is passed in the command.
