.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


The Provider DSL is a Ruby DSL that is used to help define a custom provider and to ensure that a custom provider takes the correct actions when it is called from a recipe. The Provider DSL is a small DSL with just a few methods that are specific to the chef-client. Because the Provider DSL is a Ruby DSL, anything that can be done using Ruby can also be done when defining a custom provider.
