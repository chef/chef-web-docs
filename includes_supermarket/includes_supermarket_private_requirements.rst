.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


A private |supermarket| has the following requirements:

* An operational |chef server| (version 12.0 or higher) to act as the |oauth| 2.0 provider
* A user account on the |chef server| with ``admins`` priviliges
* A key for the user account on the |chef server|
* An x86_64 compatible |linux| host with at least 1 GB memory
* Sufficient disk space to meet project cookbook storage capacity or credentials to store cookbooks in an |amazon s3| bucket
