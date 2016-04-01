.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

Use the ``create`` argument to create a new cookbook directory on the local machine, including the following directories and files:

  * cookbook/attributes
  * cookbook/CHANGELOG.md
  * cookbook/definitions
  * cookbook/files/default
  * cookbook/libraries
  * cookbook/metadata.rb
  * cookbook/providers
  * cookbook/README.md (or .rdoc)
  * cookbook/recipes/default.rb
  * cookbook/resources
  * cookbook/templates/default

After the cookbook is created, it can be uploaded to the |chef server| using the ``knife upload`` argument.

.. note:: Avoid using hyphens or other non-alphanumeric characters in cookbook names. Doing so can cause unexpected errors when trying to use those names in recipes. See :ref:`ruby_style_patterns_cookbook_naming` for more information.
