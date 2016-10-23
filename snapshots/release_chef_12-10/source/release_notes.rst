=====================================================
Release Notes: chef-client 12.10
=====================================================

.. include:: ../../includes_chef/includes_chef.rst

What's New
=====================================================
The following items are new for chef-client 12.10 and/or are changes from previous versions. The short version:

* **New layout property for mdadm resource** Use the ``layout`` property to set the RAID5 parity algorithm. Possible values: ``left-asymmetric`` (or ``la``), ``left-symmetric`` (or ``ls``), ``right-asymmetric`` (or ``ra``), or ``right-symmetric`` (or ``rs``).
* **New with_run_context for the Recipe DSL** Use ``with_run_context`` to run resource blocks as part of the root or parent run context.
* **New Recipe DSL methods for declaring, deleting, editing, and finding resources** Use the ``declare_resource``, ``delete_resource``, ``edit_resource``, and ``find_resource`` methods to interact with resources in the resource collection. Use the ``delete_resource!``, ``edit_resource!``, or ``find_resource!`` methods to trigger an exception when the resource is not found in the collection.

with_run_context
-----------------------------------------------------
.. include:: ../../includes_dsl_recipe/includes_dsl_recipe_method_with_run_context.rst

declare_resource
-----------------------------------------------------
.. include:: ../../includes_dsl_recipe/includes_dsl_recipe_method_declare_resource.rst

delete_resource
-----------------------------------------------------
.. include:: ../../includes_dsl_recipe/includes_dsl_recipe_method_delete_resource.rst

delete_resource!
-----------------------------------------------------
.. include:: ../../includes_dsl_recipe/includes_dsl_recipe_method_delete_resource_bang.rst

edit_resource
-----------------------------------------------------
.. include:: ../../includes_dsl_recipe/includes_dsl_recipe_method_edit_resource.rst

edit_resource!
-----------------------------------------------------
.. include:: ../../includes_dsl_recipe/includes_dsl_recipe_method_edit_resource_bang.rst

find_resource
-----------------------------------------------------
.. include:: ../../includes_dsl_recipe/includes_dsl_recipe_method_find_resource.rst

find_resource!
-----------------------------------------------------
.. include:: ../../includes_dsl_recipe/includes_dsl_recipe_method_find_resource_bang.rst


Changelog
=====================================================
https://github.com/chef/chef/blob/master/CHANGELOG.md
