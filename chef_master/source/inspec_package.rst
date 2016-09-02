=====================================================
package
=====================================================

.. include:: ../../includes_inspec_resources/includes_inspec_resource_package.rst

Syntax
-----------------------------------------------------
.. include:: ../../includes_inspec_resources/includes_inspec_resource_package_syntax.rst

Matchers
-----------------------------------------------------
.. include:: ../../includes_inspec_resources/includes_inspec_resource_generic_matchers_intro.rst

be
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_inspec_resources/includes_inspec_resource_common_matcher_be.rst

be_installed
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_inspec_resources/includes_inspec_resource_package_matcher_be_installed.rst

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

version
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_inspec_resources/includes_inspec_resource_package_matcher_version.rst

Examples
-----------------------------------------------------
.. include:: ../../includes_inspec_resources/includes_inspec_resource_generic_examples_intro.rst

**Test if nginx version 1.9.5 is installed**

.. include:: ../../step_inspec/step_inspec_package_nginx_version_installed.rst

**Test that a package is not installed**

.. include:: ../../step_inspec/step_inspec_package_not_installed.rst

**Test if telnet is installed**

.. include:: ../../step_inspec/step_inspec_package_telnet_installed.rst

**Test if ClamAV (an antivirus engine) is installed and running**

.. include:: ../../step_inspec/step_inspec_package_clamav_installed.rst

**Verify if Memcached is installed, enabled, and running** 

.. include:: ../../step_inspec/step_inspec_service_memcached.rst
