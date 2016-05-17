=====================================================
Release Notes: |chef client| 12.10
=====================================================

.. include:: ../../includes_chef/includes_chef.rst

What's New
=====================================================
The following items are new for |chef client| 12.10 and/or are changes from previous versions. The short version:

* **New layout property for mdadm resource** Use the ``layout`` property to set the |raid5| parity algorithm. Possible values: ``left-asymmetric`` (or ``la``), ``left-symmetric`` (or ``ls``), ``right-asymmetric`` (or ``ra``), or ``right-symmetric`` (or ``rs``).
* **New with_run_context for the Recipe DSL** Use ``with_run_context`` to run resource blocks as part of the root or parent run context.

with_run_context
-----------------------------------------------------
.. include:: ../../includes_dsl_recipe/includes_dsl_recipe_method_with_run_context.rst

Changelog
=====================================================
https://github.com/chef/chef/blob/master/CHANGELOG.md
