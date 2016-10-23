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

Keys
-----------------------------------------------------
.. include:: ../../includes_search/includes_search_key.rst

To search for the available fields for a particular object, use the ``show`` argument with any of the following knife subcommands: ``knife client``, ``knife data bag``, ``knife environment``, ``knife node``, or ``knife role``. For example: ``knife data bag show``.

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

This subcommand has the following options:

``-a ATTR``, ``--attribute ATTR``
   The attribute (or attributes) to show.

``-b ROW``, ``--start ROW``
   The row at which return results begin.

``-f FILTER``, ``--filter-result FILTER``
   Use to filter the search output based on the pattern that matches the specified ``FILTER``. Only attributes in the ``FILTER`` will be returned. For example: ``\"ServerName=name, Kernel=kernel.version\``.

   .. note:: .. include:: ../../includes_notes/includes_notes_filter_search_vs_partial_search.rst

``-i``, ``--id-only``
   Show only matching object IDs.

``INDEX``
   The name of the index to be queried: ``client``, ``environment``, ``node``, ``role``, or ``DATA_BAG_NAME``. Default index: ``node``.

``-l``, ``--long``
   Display all attributes in the output and show the output as JSON.

``-m``, ``--medium``
   Display normal attributes in the output and to show the output as JSON.

``-o SORT``, ``--sort SORT``
   The order in which search results are to be sorted.

``-q SEARCH_QUERY``, ``--query SEARCH_QUERY``
   Protect search queries that start with a hyphen (-). A ``-q`` query may be specified as an argument or an option, but not both.

``-r``, ``--run-list``
   Show only the run-list.

``-R INT``, ``--rows INT``
   The number of rows to be returned.

``SEARCH_QUERY``
   The search query used to identify a list of items on a Chef server. This option uses the same syntax as the ``search`` subcommand.

Examples
=====================================================
The following examples show how to use this knife subcommand:

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
