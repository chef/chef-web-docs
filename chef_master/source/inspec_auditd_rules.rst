=====================================================
auditd_rules
=====================================================

.. include:: ../../includes_inspec_resources/includes_inspec_resource_auditd_rules.rst

Syntax
-----------------------------------------------------
.. include:: ../../includes_inspec_resources/includes_inspec_resource_auditd_rules_syntax.rst

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

include
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_inspec_resources/includes_inspec_resource_common_matcher_include.rst

match
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_inspec_resources/includes_inspec_resource_common_matcher_match.rst

Examples
-----------------------------------------------------
.. include:: ../../includes_inspec_resources/includes_inspec_resource_generic_examples_intro.rst

**Test if a rule contains a matching element that is identified by a regular expression**

.. include:: ../../step_inspec/step_inspec_auditd_rules_match_element.rst

**Query the audit daemon status**

.. include:: ../../step_inspec/step_inspec_auditd_rules_query_daemon_status.rst

**Query properties of rules targeting specific syscalls or files**

.. include:: ../../step_inspec/step_inspec_auditd_rules_query_rules_properties.rst
