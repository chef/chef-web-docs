=====================================================
iptables
=====================================================

.. include:: ../../includes_inspec_resources/includes_inspec_resource_iptables.rst

Syntax
-----------------------------------------------------
.. include:: ../../includes_inspec_resources/includes_inspec_resource_iptables_syntax.rst

Matchers
-----------------------------------------------------
|inspec resource matcher|

have_rule
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_inspec_resources/includes_inspec_resource_iptables_matcher_have_rule.rst

Examples
-----------------------------------------------------
|inspec examples|

**Test if the IP table allows a packet through**

.. include:: ../../step_inspec/step_inspec_iptables_allows_packets.rst

**Test if the IP table allows a packet through, for a specific table and chain**

.. include:: ../../step_inspec/step_inspec_iptables_allows_packets_on_specific_table_and_chain.rst
