.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


The ``/.chef/trusted_certs`` directory stores trusted SSL certificates used to access the Chef server:

* On each workstation, this directory is the location into which SSL certificates are placed after they are downloaded from the Chef server using the ``knife ssl fetch`` subcommand
* On every node, this directory is the location into which SSL certificates are placed when a node has been bootstrapped with the chef-client from a workstation
