.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


The |path trusted_certs| directory stores trusted |ssl| certificates used to access the |chef server|:

* On each workstation, this directory is the location into which |ssl| certificates are placed after they are downloaded from the |chef server| using the |subcommand knife ssl_fetch| command
* On every node, this directory is the location into which |ssl| certificates are placed when  node has been bootstrapped with the |chef client| from a workstation
