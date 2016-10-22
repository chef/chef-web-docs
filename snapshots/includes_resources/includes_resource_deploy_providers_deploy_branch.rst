.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


The **deploy_branch** resource functions identically to the **deploy_revision** resource, in terms of how the chef-client processes the resource during the chef-client run. It uses the same ``Deploy::Revision`` provider, the same set of actions and attributes, and is (outside of the name itself) identical to the **deploy_revision** resource. Using the **deploy_revision** resource is preferred; however, the **deploy_branch** resource exists for those situations where, semantically, it is preferable to refer to a resource as a "branch" instead of a "revision".
