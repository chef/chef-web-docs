.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

An attribute can be defined in an environment and then used to override the default settings on a node. When an environment is applied during a chef-client run, these attributes are compared to the attributes that are already present on the node. When the environment attributes take precedence over the default attributes, the chef-client will apply those new settings and values during the chef-client run on the node.

An environment attribute can only be set to be a default attribute or an override attribute. An environment attribute cannot be set to be a ``normal`` attribute. Use the ``default_attribute`` and ``override_attribute`` methods in the Ruby DSL file or the ``default_attributes`` and ``override_attributes`` hashes in a JSON data file.
