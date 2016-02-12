.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


A cookbook is the fundamental unit of configuration and policy distribution. Each cookbook defines a scenario, and includes some (or all) of the following:

* Attribute values that are set on nodes
* Definitions that allow the creation of reusable collections of resources
* File distributions
* Libraries that extend the |chef client| and/or provide helpers to |ruby| code
* Recipes that specify which resources to manage and the order in which those resources will be applied
* Custom resources and providers
* Templates
* Metadata about recipes (including dependencies), version constraints, supported platforms, and so on