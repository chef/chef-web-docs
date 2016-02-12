.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics. 

Migrating from the open source |chef server| to hosted |chef server oec| can be done in a few simple steps. Two custom |knife| plugins can be installed to help with the export of data from the open source |chef server| and the import of that data to the hosted |chef server oec| server. Keep using the same repository or start a new one. Once the hosted |chef server oec| server is ready to go, nodes can be registered with hosted |chef server oec|, bootstrapped, and then be configured and managed by the |chef client|.

