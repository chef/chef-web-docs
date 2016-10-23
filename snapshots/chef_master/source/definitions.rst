=====================================================
About Definitions
=====================================================

.. warning:: Starting with chef-client 12.5, it is recommended to :doc:`build custom resources </custom_resources>` instead of definitions. While the use of definitions is not deprecated---all existing definitions will continue to work---it is recommended to also migrate existing definitions to the new custom resource patterns. This topic introduces definitions as they once were (and still can be, if desired), but deprecates all but one example of using them in favor of showing how to migrate an existing definition to the new custom resource pattern.

A definition behaves like a compile-time macro that is reusable across recipes. A definition is typically created by wrapping arbitrary code around resources that are declared as if they were in a recipe. A definition is then used in one (or more) actual recipes as if the definition were a resource.

Though a definition looks like a resource, and at first glance seems like it could be used interchangeably, some important differences exist. A definition:

* Is not a resource or a custom resource
* Is processed while the resource collection is compiled (whereas resources are processed while a node is converged)
* Does not support common resource properties, such as ``notifies``, ``subscribes``, ``only_if``, and ``not_if``
* Is defined from within the ``/definitions`` directory of a cookbook
* Does not support why-run mode

Syntax (pre-12.5)
=====================================================
.. include:: ../../includes_definition/includes_definition_12-4_syntax.rst

Examples
=====================================================
The following examples show how to use cookbook definitions.

Many Recipes, One Definition
-----------------------------------------------------
.. warning:: With the improved custom resource pattern available starting with chef-client 12.5, the need to use definitions is greatly minimized. In every case when considering to use a definition, first evaluate whether that defintion is better represented as a custom resource.

.. include:: ../../includes_definition/includes_definition_scenario_many_recipes_one_definition.rst


Definition vs. Resource
=====================================================
.. include:: ../../includes_definition/includes_definition_example.rst

As a Definition
-----------------------------------------------------
.. include:: ../../includes_definition/includes_definition_example_as_definition.rst

As a Resource
-----------------------------------------------------
.. include:: ../../includes_definition/includes_definition_example_as_resource.rst

Use Common Properties
-----------------------------------------------------
.. include:: ../../includes_definition/includes_definition_example_as_resource_with_common_properties.rst

