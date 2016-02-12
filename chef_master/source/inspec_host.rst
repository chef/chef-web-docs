=====================================================
host
=====================================================

.. include:: ../../includes_inspec_resources/includes_inspec_resource_host.rst

Syntax
-----------------------------------------------------
.. include:: ../../includes_inspec_resources/includes_inspec_resource_host_syntax.rst

Matchers
-----------------------------------------------------
|inspec resource matcher|

be_reachable
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_inspec_resources/includes_inspec_resource_host_matcher_be_reachable.rst

be_resolvable
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_inspec_resources/includes_inspec_resource_host_matcher_be_resolvable.rst

ipaddress
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_inspec_resources/includes_inspec_resource_host_matcher_ipaddress.rst

Examples
-----------------------------------------------------
|inspec examples|

**Verify host name is reachable over a specific protocol and port number**

.. include:: ../../step_inspec/step_inspec_host_name_is_reachable.rst

**Verify that a specific IP address can be resolved**

.. include:: ../../step_inspec/step_inspec_host_ip_address_resolved.rst
