.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


The Ohai DSL is a Ruby DSL that is used to define an Ohai plugin and to ensure that Ohai collects the right data at the start of every chef-client run. The Ohai DSL is a small DSL with a single method that is specific to Ohai plugins. Because the Ohai DSL is a Ruby DSL, anything that can be done using Ruby can also be done when defining an Ohai plugin.
