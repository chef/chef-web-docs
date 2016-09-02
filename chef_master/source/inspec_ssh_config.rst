=====================================================
ssh_config
=====================================================

.. include:: ../../includes_inspec_resources/includes_inspec_resource_ssh_config.rst

Syntax
-----------------------------------------------------
.. include:: ../../includes_inspec_resources/includes_inspec_resource_ssh_config_syntax.rst

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

name
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_inspec_resources/includes_inspec_resource_ssh_config_matcher_name.rst

Examples
-----------------------------------------------------
.. include:: ../../includes_inspec_resources/includes_inspec_resource_generic_examples_intro.rst

**Test SSH configuration settings**

.. include:: ../../step_inspec/step_inspec_ssh_config_settings.rst

**Test which variables from the local environment are sent to the server**

.. include:: ../../step_inspec/step_inspec_ssh_config_owner_and_group.rst

**Test owner and group permissions**

.. include:: ../../step_inspec/step_inspec_ssh_config_owner_and_group.rst

**Test SSH configuration**

.. include:: ../../step_inspec/step_inspec_ssh_config_ssh.rst
