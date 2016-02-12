.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


Each node stores its private key locally. This private key is generated as part of the bootstrap process that initially installs the |chef client| on the node. The first time |chef client| runs on that node, it uses the |chef validator| to authenticate, but then on each subsequent run it uses the private key generated for that client by the |chef server|.
