.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


The ``use_inline_resources`` method should be considered a default method for any provider that defines a custom resource. It's the correct behavior. And it will soon become the default behavior in a future version of the chef-client. 

Because inline compile mode makes it impossible for embedded resources to notify resources in the parent resource collection, inline compile mode may cause issues with some provider implementations. In these cases, use a definition to work around inline compile mode. See `this example <https://docs.chef.io/essentials_cookbook_definitions.html#many-recipes-one-definition>`_ for how to use a definition in this situation.
