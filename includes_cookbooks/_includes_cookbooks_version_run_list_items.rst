.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.
.. This approach to applying version constraints is not recommended. Use cookbook_versions for environments instead. This topic kept in the chef-docs repo for reference. This file should never be hooked into a live, published page.

A version constraint can be specified for recipe items that are part of a run-list. Use ``@`` (at sign) to indicate a version constraint. Only the "equal to" constraint can be used to specify a version constraint in a run-list. For example:

.. code-block:: ruby

   {'run_list':['recipe[nginx@1.2.3]']}
