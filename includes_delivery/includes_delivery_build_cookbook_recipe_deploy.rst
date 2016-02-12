.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


The purpose of the deploy phase is to deploy the artifacts published at the end of the Build stage onto a selected set of nodes. The specifics of deployment are project specific. If the project is a |chef| cookbook or an application deployed via a cookbook, you can use |push jobs| to trigger a |chef client| run or rely on a daemonized |chef client| setup for an asynchronous deployment.
