.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


|bitbucket| integration with |delivery| allows |bitbucket| to be used as the canonical |git| repository for projects while at the same time benefiting from |delivery| workflow and pipeline automation. When |bitbucket| integration is enabled for a project in |bitbucket|, you will be able to:

* Review pull requests and make code comments in the |bitbucket| webui
* Browse code (including in-flight changes in the |delivery| pipeline) using |bitbucket|
* Have the target branch (usually master) of a |bitbucket| project repository be managed by |delivery|. When a change is approved in |delivery|, it will perform the merge in |bitbucket|

|bitbucket| integration is designed for use with |bitbucket| 3.x and supports connecting a |delivery| enterprise with a single |bitbucket| server URL. |delivery| does not support |bitbucket| project repositories that are hosted at https://bitbucket.org at this time. |delivery| communicates with |bitbucket| using the |bitbucket| REST API and HTTP-based |git| protocol. |delivery| authenticates with |bitbucket| with a user account over HTTP basic authentication. It is recommended that the connection be protected using SSL.
