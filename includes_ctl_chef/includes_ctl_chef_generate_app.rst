.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


.. note:: This command is built around the idea that there should be a middle ground between the "one cookbook per repo" and the "all cookbooks in one repo" approaches.

Use the ``chef generate app`` subcommand to generate a cookbook structure that:

* Supports multiple cookbooks (as many as needed to support an "application")
* Supports a top-level instance of |kitchen| that can be used to test each cookbook in the appication
* Supports a single |policyfile rb|, which is an upcoming feature of the |chef dk| that defines a workflow around a set of cookbooks and related policy (such as roles, environments, and so on); for more information about |policyfile rb|, see the chef.lists discussions (search for "policyfile")

.. note:: Avoid using hyphens or other non-alphanumeric characters in cookbook names. Doing so can cause unexpected errors when trying to use those names in recipes. See :ref:`ruby_style_patterns_cookbook_naming` for more information.
