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

be_listening
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_inspec_resources/includes_inspec_resource_port_matcher_be_listening.rst

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
