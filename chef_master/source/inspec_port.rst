=====================================================
port
=====================================================

.. include:: ../../includes_inspec_resources/includes_inspec_resource_port.rst

Syntax
-----------------------------------------------------
.. include:: ../../includes_inspec_resources/includes_inspec_resource_port_syntax.rst

Matchers
-----------------------------------------------------
|inspec resource matcher|

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
|inspec examples|

**Test port 80, listening with the TCP protocol**

.. include:: ../../step_inspec/step_inspec_port_listen_with_tcp.rst

**Test port 80, listening with TCP version IPv6 protocol**

.. include:: ../../step_inspec/step_inspec_port_listen_with_tcp_and_ipv6.rst

**Test that only secure ports accept requests**

.. include:: ../../step_inspec/step_inspec_port_listen_on_secure_ports.rst
