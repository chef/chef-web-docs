.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


This argument has the following options:

``-e DATE``, ``--expiration-date DATE``
   |key expiration_date| If this option is not specified, the public key will not have an expiration date. For example: ``2013-12-24T21:00:00Z``.

``-f FILE``, ``--file FILE``
   |file public_key| If the ``--key-name`` and ``public-key`` options are not specified the |chef server| will generate a private key.

``-k NAME``, ``--key-name NAME``
   |name key_public| 

``-p FILE_NAME``, ``--public-key FILE_NAME``
   |path key_public| If this option is not specified, and only if ``--key-name`` is specified, the |chef server| will generate a public/private key pair.
