.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


A definition is code that is reused across recipes, similar to a compile-time macro. A definition is created using arbitrary code wrapped around built-in chef-client resources---**file**, **execute**, **template**, and so on---by declaring those resources into the definition as if they were declared in a recipe. A definition is then used in one (or more) recipes as if it were a resource.

Though a definition behaves like a resource, some key differences exist. A definition:

* Is not a resource or a custom resource
* Is defined from within the ``/definitions`` directory of a cookbook
* Is loaded before resources during the chef-client run; this ensures the definition is available to all of the resources that may need it
* May not notify resources in the resource collection because a definition is loaded **before** the resource collection itself is created; however, a resource in a definition **may** notify a resource that exists within the same definition
* Automatically supports why-run mode, unlike custom resources

Use a defintion when repeating patterns exist across resources and/or when a simple, direct approach is desired. There is no limit to the number of resources that may be included in a definition: use as many built-in chef-client resources as necessary.
