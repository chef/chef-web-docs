.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics. 


The opaque identifier that is computed from the content of a cookbook is the only place where an opaque identifier is necessary. When working with |policyfile|, be sure to:

* Use the same names and version contraints as normal in the |policyfile rb| file
* Use the same references to cookbooks pulled from |supermarket|
* Use the same branch, tag, and revision patterns for cookbooks pulled from |git|
* Use the same paths for cookbooks pulled from disk

Extra metadata about the cookbook is stored and included in |api chef server| responses and in the |policylock| file, including the source of a cookbook (|supermarket|, |git|, local disk, etc.), as well as any upstream idenfiers, such as |git| revisions. For cookbooks that are loaded from the local disk that are in a |git| repo, the upstream URL, current revision ID, and the state of the repo are stored also. 

The opaque identifier is mostly behind the scenes and is only visible once published to the |chef server|. Cookbooks that are uploaded to the |chef server| may have extended version numbers such as ``1.0.0-dev``.
