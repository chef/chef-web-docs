.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


The Chef push jobs client is used to receive job messages from the Chef push jobs server and to verify the heartbeat status. The Chef push jobs client uses the same authorization / authentication model as the chef-client. The Chef push jobs client listens for heartbeat messages from the Chef push jobs server. If there is no heartbeat from the Chef push jobs server, the Chef push jobs client will finish its current job, but then stop accepting any new jobs until the heartbeat from the Chef push jobs server resumes.
