=====================================================
|chef| Style Guide
=====================================================

.. include:: ../../includes_ruby/includes_ruby.rst

|ruby| Basics
=====================================================
This section covers the basics of |ruby|.

Verify Syntax
-----------------------------------------------------
.. include:: ../../includes_ruby/includes_ruby_style_basics_check_syntax.rst

Comments
-----------------------------------------------------
.. include:: ../../includes_ruby/includes_ruby_style_basics_comment.rst

Local Variables
-----------------------------------------------------
.. include:: ../../includes_ruby/includes_ruby_style_basics_variable_local.rst

Math
-----------------------------------------------------
.. include:: ../../includes_ruby/includes_ruby_style_basics_math.rst

Strings
-----------------------------------------------------
.. include:: ../../includes_ruby/includes_ruby_style_basics_strings.rst

|ruby| in Strings
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_ruby/includes_ruby_style_basics_string_embed_ruby.rst

Escape Character
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_ruby/includes_ruby_style_basics_string_escape_character.rst

Interpolation
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_ruby/includes_ruby_style_basics_string_interpolation.rst

Truths
-----------------------------------------------------
.. include:: ../../includes_ruby/includes_ruby_style_basics_truths.rst

Untruths
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_ruby/includes_ruby_style_basics_untruths.rst

Convert Truths
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_ruby/includes_ruby_style_basics_convert_truths.rst

Arrays
-----------------------------------------------------
.. include:: ../../includes_ruby/includes_ruby_style_basics_array_lists.rst

.. whitespace arrays assumes you understand what Array#include? is
.. introduce `[ "foo", "bar", "baz" ].each do |thing|` first, then introduce `%w{foo bar baz}.each do |thing|`
.. or just use #first or #last, since they are sort of introduced already
.. %w{debian ubuntu}.first  # => "debian"

Whitespace Arrays
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_ruby/includes_ruby_style_basics_array_shortcut.rst

|ruby hash|
-----------------------------------------------------
.. include:: ../../includes_ruby/includes_ruby_style_basics_hash.rst

Regular Expressions
-----------------------------------------------------
.. include:: ../../includes_ruby/includes_ruby_style_basics_regular_expressions.rst

Statements
-----------------------------------------------------
.. include:: ../../includes_ruby/includes_ruby_style_basics_statement.rst

``if``
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_ruby/includes_ruby_style_basics_statement_if.rst

``case``
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_ruby/includes_ruby_style_basics_statement_case.rst

Call a Method
-----------------------------------------------------
.. include:: ../../includes_ruby/includes_ruby_style_basics_method_call.rst

Define a Method
-----------------------------------------------------
.. include:: ../../includes_ruby/includes_ruby_style_basics_method_define.rst

|ruby| Class
-----------------------------------------------------
.. include:: ../../includes_ruby/includes_ruby_style_basics_class_recipe.rst

Include a Class
-----------------------------------------------------
.. include:: ../../includes_ruby/includes_ruby_style_basics_class_include.rst

Include a Parameter
-----------------------------------------------------
.. include:: ../../includes_ruby/includes_ruby_style_basics_parameter_include.rst

Log Entries
-----------------------------------------------------
.. include:: ../../includes_ruby/includes_ruby_style_basics_chef_log.rst

The following examples show using ``Chef::Log`` entries in a recipe.

.. include:: ../../step_ruby/step_ruby_class_chef_log_fatal.rst

.. include:: ../../step_ruby/step_ruby_class_chef_log_multiple.rst

Patterns to Follow
=====================================================
This section covers best practices for cookbook and recipe authoring.

|git| Etiquette
-----------------------------------------------------
.. include:: ../../includes_ruby/includes_ruby_style_patterns_git_etiquette.rst

Cookbook Naming
-----------------------------------------------------
.. include:: ../../includes_ruby/includes_ruby_style_patterns_cookbook_naming.rst

Cookbook Versioning
-----------------------------------------------------
.. include:: ../../includes_ruby/includes_ruby_style_patterns_cookbook_versioning.rst

Cookbook Patterns
-----------------------------------------------------
.. include:: ../../includes_ruby/includes_ruby_style_patterns_cookbook_good_examples.rst

Naming
-----------------------------------------------------
.. include:: ../../includes_ruby/includes_ruby_style_patterns_system_and_component_naming.rst

Default Recipe
-----------------------------------------------------
.. include:: ../../includes_ruby/includes_ruby_style_patterns_default_recipe.rst

Parameter Order
-----------------------------------------------------
.. include:: ../../includes_ruby/includes_ruby_style_patterns_resource_parameter_order.rst

File Modes
-----------------------------------------------------
.. include:: ../../includes_ruby/includes_ruby_style_patterns_file_modes.rst

Specify Resource Action?
-----------------------------------------------------
.. include:: ../../includes_ruby/includes_ruby_style_patterns_always_specify_action.rst

Symbols or Strings?
-----------------------------------------------------
.. include:: ../../includes_ruby/includes_ruby_style_patterns_symbols_vs_strings.rst

String Quoting
-----------------------------------------------------
.. include:: ../../includes_ruby/includes_ruby_style_patterns_string_quoting.rst

Shelling Out
-----------------------------------------------------
.. include:: ../../includes_ruby/includes_ruby_style_patterns_shelling_out.rst

Constructs to Avoid
-----------------------------------------------------
.. include:: ../../includes_ruby/includes_ruby_style_patterns_constructs_to_avoid.rst

Recipes
-----------------------------------------------------
.. include:: ../../includes_ruby/includes_ruby_style_patterns_recipes.rst

Patterns to Avoid
=====================================================
This section covers things that should be avoided when authoring cookbooks and recipes.

``node.set``
-----------------------------------------------------
Use ``node.default`` (or maybe ``node.override``) instead of ``node.set`` because ``node.set`` is an alias for ``node.normal``. Normal data is persisted on the node object. Therefore, using ``node.set`` will persist data in the node object. If the code that uses ``node.set`` is later removed, if that data has already been set on the node, it will remain.

Normal and override attributes are cleared at the start of the |chef client| run, and are then rebuilt as part of the run based on the code in the cookbooks and recipes at that time.

``node.set`` (and ``node.normal``) should only be used to do something like generate a password for a database on the first |chef client| run, after which it's remembered (instead of persisted). Even this case should be avoided, as using a data bag is the recommended way to store this type of data.


Use the |chef dk_title|
=====================================================
This section covers best practices for cookbook and recipe authoring.

|foodcritic| Linting
-----------------------------------------------------
.. include:: ../../includes_ruby/includes_ruby_style_tools_foodcritic_linting.rst

More about |ruby|
=====================================================
.. include:: ../../includes_ruby/includes_ruby_style_more_info.rst

