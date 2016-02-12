.. THIS PAGE IS LOCATED AT THE /devkit/ PATH.

=====================================================
|serverspec|
=====================================================

.. include:: ../../includes_serverspec/includes_serverspec.rst

.. include:: ../../includes_serverspec/includes_serverspec_whatis.rst

Integration Tests
=====================================================
.. include:: ../../includes_rspec/includes_rspec.rst

|serverspec| is built on the |rspec_dsl|.

Syntax
-----------------------------------------------------
.. include:: ../../includes_rspec/includes_rspec_syntax.rst

context
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_rspec/includes_rspec_syntax_context.rst

let
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_rspec/includes_rspec_syntax_let.rst

Require |chef spec|
-----------------------------------------------------
.. include:: ../../includes_serverspec/includes_serverspec_syntax_require.rst


|dsl recipe| Methods
=====================================================
Use |serverspec| matchers within the ``control`` and ``control_group`` blocks for testing recipes.

control
-----------------------------------------------------
.. include:: ../../includes_analytics/includes_analytics_controls.rst

.. include:: ../../includes_dsl_recipe/includes_dsl_recipe_method_control.rst

.. include:: ../../includes_dsl_recipe/includes_dsl_recipe_method_control_syntax.rst

directory Matcher
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_dsl_recipe/includes_dsl_recipe_method_control_matcher_directory.rst

file Matcher
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_dsl_recipe/includes_dsl_recipe_method_control_matcher_file.rst

package Matcher
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_dsl_recipe/includes_dsl_recipe_method_control_matcher_package.rst

port Matcher
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_dsl_recipe/includes_dsl_recipe_method_control_matcher_port.rst

service Matcher
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_dsl_recipe/includes_dsl_recipe_method_control_matcher_service.rst

Examples
+++++++++++++++++++++++++++++++++++++++++++++++++++++

**A package is installed**

.. include:: ../../step_dsl_recipe/step_dsl_recipe_control_matcher_package_installed.rst

**A package version is installed**

.. include:: ../../step_dsl_recipe/step_dsl_recipe_control_matcher_package_installed_version.rst

**A package is not installed**

.. include:: ../../step_dsl_recipe/step_dsl_recipe_control_matcher_package_not_installed.rst

**A service is enabled**

.. include:: ../../step_dsl_recipe/step_dsl_recipe_control_matcher_service_enabled.rst

**A configuration file contains specific settings**

.. include:: ../../step_dsl_recipe/step_dsl_recipe_control_matcher_file_sshd_configuration.rst

**A file contains desired permissions and contents**

.. include:: ../../step_dsl_recipe/step_dsl_recipe_control_matcher_file_permissions.rst

**Test an attribute value**

.. include:: ../../step_dsl_recipe/step_dsl_recipe_control_use_attributes.rst

control_group
-----------------------------------------------------
.. include:: ../../includes_dsl_recipe/includes_dsl_recipe_method_control_group.rst

.. include:: ../../includes_dsl_recipe/includes_dsl_recipe_method_control_group_syntax.rst

Examples
+++++++++++++++++++++++++++++++++++++++++++++++++++++

**control_group block with multiple control blocks**

.. include:: ../../step_dsl_recipe/step_dsl_recipe_control_group_many_controls.rst

**Duplicate control_group names**

.. include:: ../../step_dsl_recipe/step_dsl_recipe_control_group_duplicate_names.rst

**Verify a package is installed**

.. include:: ../../step_dsl_recipe/step_dsl_recipe_control_group_simple_recipe.rst

For more information ...
=====================================================
For more information about |serverspec|:

* `Serverspec <http://serverspec.org>`_
* `RSpec Documentation <https://relishapp.com/rspec/rspec-core/docs/command-line>`_
