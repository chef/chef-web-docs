=====================================================
About Search
=====================================================

.. include:: ../../includes_search/includes_search.rst

Many of the examples in this section use knife, but the search indexes and search query syntax can be used in many locations, including from within recipes and when using the Chef server API.

Search Indexes
=====================================================
.. include:: ../../includes_search/includes_search_index.rst

Using Knife
-----------------------------------------------------
.. include:: ../../includes_knife/includes_knife_search.rst

**Search by platform ID**

.. include:: ../../step_knife/step_knife_search_by_platform_ids.rst

**Search by instance type**

.. include:: ../../step_knife/step_knife_search_by_platform_instance_type.rst

**Search by recipe**

.. include:: ../../step_knife/step_knife_search_by_recipe.rst

**Search by cookbook, then recipe**

.. include:: ../../step_knife/step_knife_search_by_cookbook.rst

**Search by node**

.. include:: ../../step_knife/step_knife_search_by_node.rst

**Search by node and environment**

.. include:: ../../step_knife/step_knife_search_by_node_and_environment.rst

**Search for nested attributes**

.. include:: ../../step_knife/step_knife_search_by_nested_attribute.rst

**Search for multiple attributes**

.. include:: ../../step_knife/step_knife_search_by_query_for_many_attributes.rst

**Search for nested attributes using a search query**

.. include:: ../../step_knife/step_knife_search_by_query_for_nested_attribute.rst

**Use a test query**

.. include:: ../../step_knife/step_knife_search_test_query_for_ssh.rst

Query Syntax
=====================================================
.. include:: ../../includes_search/includes_search_query_syntax.rst

.. note:: Search queries may not contain newlines.

Filter Search Results
=====================================================
.. include:: ../../includes_dsl_recipe/includes_dsl_recipe_method_search_filter_result.rst

Keys
=====================================================
.. include:: ../../includes_search/includes_search_key.rst

Nested Fields
-----------------------------------------------------
.. include:: ../../includes_search/includes_search_key_nested.rst

Examples
-----------------------------------------------------
.. include:: ../../step_search/step_search_key_name.rst

.. include:: ../../step_search/step_search_key_wildcard_question_mark.rst

.. include:: ../../step_search/step_search_key_wildcard_asterisk.rst

.. include:: ../../step_search/step_search_key_nested_starting_with.rst

.. include:: ../../step_search/step_search_key_nested_range.rst

Patterns
=====================================================
.. include:: ../../includes_search/includes_search_pattern.rst

Exact Matching
-----------------------------------------------------
.. include:: ../../includes_search/includes_search_pattern_exact.rst

.. include:: ../../step_search/step_search_pattern_exact_key_and_item.rst

.. include:: ../../step_search/step_search_pattern_exact_key_and_item_string.rst

Wildcard Matching
-----------------------------------------------------
.. include:: ../../includes_search/includes_search_pattern_wildcard.rst

.. include:: ../../step_search/step_search_pattern_wildcard_any_node.rst

.. include:: ../../step_search/step_search_pattern_wildcard_node_contains.rst

Range Matching
-----------------------------------------------------
.. include:: ../../includes_search/includes_search_pattern_range.rst

.. include:: ../../step_search/step_search_pattern_range_in_between.rst

.. include:: ../../step_search/step_search_pattern_range_exclusive.rst

Fuzzy Matching
-----------------------------------------------------
.. include:: ../../includes_search/includes_search_pattern_fuzzy.rst

.. include:: ../../step_search/step_search_pattern_fuzzy.rst

Operators
=====================================================
.. include:: ../../includes_search/includes_search_boolean_operators.rst

.. include:: ../../includes_search/includes_search_boolean_operators_andnot.rst

AND
-----------------------------------------------------
.. include:: ../../step_search/step_search_boolean_and.rst

.. AND -id:foo
.. -----------------------------------------------------
.. .. include:: ../../step_search/step_search_boolean_andnot.rst

NOT
-----------------------------------------------------
.. include:: ../../step_search/step_search_boolean_not.rst

OR
-----------------------------------------------------
.. include:: ../../step_search/step_search_boolean_or.rst

Special Characters
=====================================================
.. include:: ../../includes_search/includes_search_special_characters.rst

Targets
=====================================================
.. include:: ../../includes_search/includes_search_targets.rst

Roles in Run-lists
-----------------------------------------------------
.. include:: ../../includes_search/includes_search_role.rst

.. include:: ../../step_search/step_search_target_role_top_level.rst

.. include:: ../../step_search/step_search_target_role_expanded.rst

Nodes
-----------------------------------------------------
.. include:: ../../includes_search/includes_search_node.rst

API Clients
-----------------------------------------------------
.. include:: ../../includes_chef/includes_chef_api_client.rst

.. include:: ../../includes_search/includes_search_client.rst

Environments
-----------------------------------------------------
.. include:: ../../includes_environment/includes_environment.rst

.. include:: ../../includes_search/includes_search_environment.rst

Data Bags
-----------------------------------------------------
.. include:: ../../includes_data_bag/includes_data_bag.rst

.. include:: ../../includes_search/includes_search_data_bag.rst

