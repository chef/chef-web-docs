.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


The Chef push jobs server is used to send job messages to one (or more) managed nodes and also to manage the list of jobs that are available to be run against nodes.

A heartbeat message is used to let all of the nodes in an organization know that the Chef push jobs server is available. The Chef push jobs server listens for heartbeat messages from each Chef push jobs client. If there is no heartbeat from a Chef push jobs client, the Chef push jobs server will mark that node as unavailable for job messages until the heartbeat resumes.

