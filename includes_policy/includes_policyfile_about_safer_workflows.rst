.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics. 


|policyfile| encourages safer workflows by making it easier to publish development versions of cookbooks to the |chef server| without the risk of mutating the production versions and without requiring a complicated versioning scheme to work around cookbook mutability issues. Roles are mutable and those changes are applied only to the nodes specified by the policy. |policyfile| does not require any changes to your normal workflows. Use the same repositories you are already using, the same cookbooks, and workflows. |policyfile| will prevent an updated cookbook or role from being applied immediately to all machines.
