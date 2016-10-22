.. THIS PAGE DOCUMENTS chef-client version 11.14

=====================================================
knife search 
=====================================================

.. include:: ../../includes_search/includes_search.rst

.. include:: ../../includes_knife/includes_knife_search.rst

Syntax
=====================================================
.. include:: ../../includes_knife/includes_knife_search_syntax.rst

Query Syntax
-----------------------------------------------------
.. include:: ../../includes_search/includes_search_query_syntax.rst

About Keys
-----------------------------------------------------
.. include:: ../../includes_search/includes_search_key.rst

Nested Fields
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_search/includes_search_key_nested.rst

Examples
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../step_search/step_search_key_name.rst

.. include:: ../../step_search/step_search_key_wildcard_question_mark.rst

.. include:: ../../step_search/step_search_key_wildcard_asterisk.rst

.. include:: ../../step_search/step_search_key_nested_starting_with.rst

.. include:: ../../step_search/step_search_key_nested_range.rst

About Patterns
-----------------------------------------------------
.. include:: ../../includes_search/includes_search_pattern.rst

Exact Matching
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_search/includes_search_pattern_exact.rst

.. include:: ../../step_search/step_search_pattern_exact_key_and_item.rst

.. include:: ../../step_search/step_search_pattern_exact_key_and_item_string.rst

Wildcard Matching
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_search/includes_search_pattern_wildcard.rst

.. include:: ../../step_search/step_search_pattern_wildcard_any_node.rst

.. include:: ../../step_search/step_search_pattern_wildcard_node_contains.rst

Range Matching
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_search/includes_search_pattern_range.rst

.. include:: ../../step_search/step_search_pattern_range_in_between.rst

.. include:: ../../step_search/step_search_pattern_range_exclusive.rst

Fuzzy Matching
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_search/includes_search_pattern_fuzzy.rst

.. include:: ../../step_search/step_search_pattern_fuzzy.rst

About Operators
-----------------------------------------------------
.. include:: ../../includes_search/includes_search_boolean_operators.rst

.. include:: ../../includes_search/includes_search_boolean_operators_andnot.rst

AND
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../step_search/step_search_boolean_and.rst

NOT
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../step_search/step_search_boolean_not.rst

OR
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../step_search/step_search_boolean_or.rst

Special Characters
-----------------------------------------------------
.. include:: ../../includes_search/includes_search_special_characters.rst

Options
=====================================================
.. note:: .. include:: ../../includes_knife/includes_knife_common_see_common_options_link.rst

.. include:: ../../includes_knife/includes_knife_search_options_11-16.rst

Examples
=====================================================
The following examples show how to use this knife subcommand:

**Search by platform ID**

.. include:: ../../step_knife/step_knife_search_by_platform_ids.rst

**Search by instance type**

.. include:: ../../step_knife/step_knife_search_by_platform_instance_type.rst

**Search by recipe**

.. include:: ../../step_knife/step_knife_search_by_recipe.rst

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
