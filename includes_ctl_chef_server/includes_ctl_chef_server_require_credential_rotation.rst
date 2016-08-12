.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

The ``require-credential-rotation`` subcommand takes the Chef server offline and requires a complete service credential rotation before the Chef server(s) in your cluster can restart again. 
Run ``rotate-shared-secrets`` to create a new shared secret, salt, and generate the new service credentials. Then copy the secrets file to each Chef server and run ``sudo chef-server-ctl reconfigure`` on them to complete the rotation process.

.. note:: Credential rotation does not rotate the pivotal, user, or client keys, or remove any Chef server policy or cookbooks that have been uploaded.

*New in Chef server 12.7*