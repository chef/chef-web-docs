.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

The ``rotate-credentials`` subcommand generates new credential values for all credentials for a given service by incrementing 
the value and creating a new hash value. You can choose whether to copy the updated secrets file to each node in the cluster and reconfiguring or by running this subcommand for that specific service on all the nodes.

*New in Chef server 12.7*