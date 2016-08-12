.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

The ``rotate-all-credentials`` subcommand generates new credential values for all service credentials by incrementing the credential version number and creating a new hash value. You can choose whether to copy the updated secrets file to each node in the cluster and reconfiguring or by running this subcommand on all the nodes.

*New in Chef server 12.7*