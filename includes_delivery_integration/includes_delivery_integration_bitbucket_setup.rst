.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


|bitbucket| integration with |chef delivery| has the following requirements:

#. Shell access with ``sudo`` permission to the |chef delivery| server
#. A |chef delivery| user account with ``admin`` role in the |chef delivery| enterprise used for this integration
#. The URL for the |bitbucket| instance
#. The username and password of a |bitbucket| user to use as the service account. This user must have full access (read/write) to the projects you wish to add to |chef delivery|
