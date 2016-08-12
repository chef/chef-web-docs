.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

The ``rotate-shared-secrets`` subcommand creates a new shared secret and salt, in addition to generating new service credentials. It also resets 
the ``credential_version`` number for the services to 0. After you have run this subcommand, a new shared secret has been created, so you must copy the secrets file to 
each Chef server and run ``sudo chef-server-ctl reconfigure`` on them to complete the rotation process.

*New in Chef server 12.7*
