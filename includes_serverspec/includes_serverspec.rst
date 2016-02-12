.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


Use |serverspec| to build integration tests that make assertions about the state of a node:

* Runs the |chef client| in a virtual instance, often via |kitchen|
* Is an extension of |rspec|, a |bdd| framework for |ruby|
* Is a good way to test cookbooks and recipes. Because cookbooks and recipes are actually run, the errors that may be returned will be similar to the errors that would exist in a real production environment
