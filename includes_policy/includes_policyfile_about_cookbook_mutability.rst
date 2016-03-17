.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics. 


When running |chef| without |policyfile|, existing versions of cookbooks are mutable. This is convenient for many use cases, especially if users upload in-development cookbook revisions to the |chef server|. But this sometimes creates issues that are similar to role mutability by allowing those cookbook changes to be applied immediately to nodes that use that cookbook. Users account for this by rigorous testing processes to ensure that only fully integrated cookbooks are ever published. This process does enforce good development habits, but at the same time it shoudn't be a required part of a workflow that ends with publishing an in-development cookbook to the |chef server| for testing against real nodes.

|policyfile| solves this issue by using a cookbook publishing API for the |chef server| that does not provide cookbook mutability. Name collisions are prevented by storing cookbooks by name and an opaque identifier that is computed from the content of the cookbook itself.

For example, name/version collisions can occur when users temporarily fork an upstream cookbook. Even if the user contributes their change and the maintainer is responsive, there may be a period of time where the user needs their fork in order to make progress. This situation presents a versioning dilemma: if the user doesn't update their own version, they must overwrite the existing copy of that cookbook on the |chef server|, wheres if they do update the version number it might conflict with the version number of the future release of that upstream cookbook.
