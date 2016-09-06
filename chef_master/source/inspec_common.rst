=====================================================
Common Functionality (InSpec)
=====================================================

Each |inspec resource| (including custom resources) share a set of common matchers and helpers to target specific OS-level behaviors.

.. _inspec_common_matchers:

Common Matchers
=====================================================
.. include:: ../../includes_inspec_resources/includes_inspec_resource_common_matcher.rst

be
-----------------------------------------------------
.. include:: ../../includes_inspec_resources/includes_inspec_resource_common_matcher_be.rst

cmp
-----------------------------------------------------
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
-----------------------------------------------------
.. include:: ../../includes_inspec_resources/includes_inspec_resource_common_matcher_eq.rst

include
-----------------------------------------------------
.. include:: ../../includes_inspec_resources/includes_inspec_resource_common_matcher_include.rst

match
-----------------------------------------------------
.. include:: ../../includes_inspec_resources/includes_inspec_resource_common_matcher_match.rst


.. _inspec_common_os_family_helpers:

Platform Helpers and Symbols
=====================================================
More granular platform-specific tests may be built using helpers and symbols that are based on the ``os`` |inspec resource|.

os[:family] Symbols
-----------------------------------------------------
.. include:: ../../includes_inspec_resources/includes_inspec_resource_os_symbols.rst

os.family? Helpers
-----------------------------------------------------
.. include:: ../../includes_inspec_resources/includes_inspec_resource_os_helpers.rst

Examples
-----------------------------------------------------

**Test users on multiple platforms**

.. include:: ../../step_inspec/step_inspec_user_multiple_platforms.rst

