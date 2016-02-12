.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

An |ssl| certificate is a common part of every web application infrastructure. A certificate can be created by a |rake| task, modified (as needed), and then copied into a cookbook for use later. A cookbook uses a resource to identify which certificate to use and when to use it. |ssl| certificates are cached on the node and are updated (as needed) during a |chef client| run.

