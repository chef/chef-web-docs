=====================================================
iptables
=====================================================

.. include:: ../../includes_inspec_resources/includes_inspec_resource_iptables.rst

Syntax
-----------------------------------------------------
.. include:: ../../includes_inspec_resources/includes_inspec_resource_iptables_syntax.rst

Matchers
-----------------------------------------------------
.. include:: ../../includes_inspec_resources/includes_inspec_resource_generic_matchers_intro.rst

be
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_inspec_resources/includes_inspec_resource_common_matcher_be.rst

cmp
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_inspec_resources/includes_inspec_resource_common_matcher_cmp.rst

**Compare single value to array**

.. include:: ../../includes_inspec_resources/includes_inspec_resource_common_matcher_cmp_value_vs_array.rst

**Compare strings and regular expressions**

.. include:: ../../includes_inspec_resources/includes_inspec_resource_common_matcher_cmp_string_vs_regex.rst

**Compare strings and numbers**

.. include:: ../../includes_inspec_resources/includes_inspec_resource_common_matcher_cmp_string_vs_number.rst

**Ignoring case sensitivity**

.. include:: ../../includes_inspec_resources/includes_inspec_resource_common_matcher_cmp_case_sensitive.rst

**Printing octals**

.. include:: ../../includes_inspec_resources/includes_inspec_resource_common_matcher_cmp_octals.rst

eq
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_inspec_resources/includes_inspec_resource_common_matcher_eq.rst

have_rule
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_inspec_resources/includes_inspec_resource_iptables_matcher_have_rule.rst

include
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_inspec_resources/includes_inspec_resource_common_matcher_include.rst

match
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_inspec_resources/includes_inspec_resource_common_matcher_match.rst

Examples
-----------------------------------------------------
.. include:: ../../includes_inspec_resources/includes_inspec_resource_generic_examples_intro.rst

**Test if the IP table allows a packet through**

.. include:: ../../step_inspec/step_inspec_iptables_allows_packets.rst

**Test if the IP table allows a packet through, for a specific table and chain**

.. include:: ../../step_inspec/step_inspec_iptables_allows_packets_on_specific_table_and_chain.rst
