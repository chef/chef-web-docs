=====================================================
port
=====================================================

.. include:: ../../includes_inspec_resources/includes_inspec_resource_port.rst

Syntax
-----------------------------------------------------
.. include:: ../../includes_inspec_resources/includes_inspec_resource_port_syntax.rst

Matchers
-----------------------------------------------------
.. include:: ../../includes_inspec_resources/includes_inspec_resource_generic_matchers_intro.rst

be
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_inspec_resources/includes_inspec_resource_common_matcher_be.rst

be_listening
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_inspec_resources/includes_inspec_resource_port_matcher_be_listening.rst

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

pid
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_inspec_resources/includes_inspec_resource_port_matcher_pid.rst

process
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_inspec_resources/includes_inspec_resource_port_matcher_process.rst

protocol
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_inspec_resources/includes_inspec_resource_port_matcher_protocol.rst

Examples
-----------------------------------------------------
.. include:: ../../includes_inspec_resources/includes_inspec_resource_generic_examples_intro.rst

**Test port 80, listening with the TCP protocol**

.. include:: ../../step_inspec/step_inspec_port_listen_with_tcp.rst

**Test port 80, on a specific address**

.. include:: ../../step_inspec/step_inspec_port_listen_test_port_80.rst

**Test port 80, listening with TCP version IPv6 protocol**

.. include:: ../../step_inspec/step_inspec_port_listen_with_tcp_and_ipv6.rst

**Test that only secure ports accept requests**

.. include:: ../../step_inspec/step_inspec_port_listen_on_secure_ports.rst

**Verify if Memcached is installed, enabled, and running** 

.. include:: ../../step_inspec/step_inspec_service_memcached.rst
