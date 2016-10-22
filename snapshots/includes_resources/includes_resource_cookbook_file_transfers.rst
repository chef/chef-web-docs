.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


During a chef-client run, the checksum for each local file is calculated and then compared against the checksum for the same file as it currently exists in the cookbook on the Chef server. A file is not transferred when the checksums match. Only files that require an update are transferred from the Chef server to a node.

