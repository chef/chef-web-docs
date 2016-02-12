=====================================================
|juniper chef|
=====================================================

.. include:: ../../includes_juniper/includes_juniper.rst

.. image:: ../../images/overview_junos.png

.. include:: ../../includes_juniper/includes_juniper_junos.rst

For more information about |juniper chef|, including information about installing and configuring the |chef client| on a |junos| device, see the |juniper| |juniper chef| documentation at http://www.juniper.net/techpubs/en_US/release-independent/junos-chef/information-products/pathway-pages/index.html.

The netdev Custom Resources
-----------------------------------------------------
The ``netdev`` cookbook is used to install and configure network interfaces and Layer 2 switching.

The ``netdev`` cookbook contains the following custom resources: ``netdev_interface``, ``netdev_l2_interface``, ``netdev_lag``, and ``netdev_vlan``.

.. note:: These custom resources are part of the ``netdev`` cookbook (https://github.com/chef-cookbooks/netdev).

netdev_interface
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_lwrp/includes_lwrp_netdev_interface.rst

Actions
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
.. include:: ../../includes_lwrp/includes_lwrp_netdev_interface_actions.rst

Properties
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
.. include:: ../../includes_lwrp/includes_lwrp_netdev_interface_attributes.rst

Examples
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
.. include:: ../../step_lwrp/step_lwrp_netdev_interface.rst

netdev_l2_interface
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_lwrp/includes_lwrp_netdev_l2_interface.rst

Actions
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
.. include:: ../../includes_lwrp/includes_lwrp_netdev_l2_interface_actions.rst

Properties
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
.. include:: ../../includes_lwrp/includes_lwrp_netdev_l2_interface_attributes.rst

Examples
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
.. include:: ../../step_lwrp/step_lwrp_netdev_l2_interface.rst

netdev_lag
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_lwrp/includes_lwrp_netdev_lag.rst

.. note:: The number of supported aggregated Ethernet interfaces on a switch must be manually configured before this resource can be used to create LAGs. Use the `aggregated-devices <http://www.juniper.net/techpubs/en_US/junos13.2/topics/reference/configuration-statement/device-count-chassis-qfx-series.html>`_ command to configure the number of supported interfaces:
   
   .. code-block:: bash
   
      $ set chassis aggregated-devices ethernet device-count <count-value>

Actions
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
.. include:: ../../includes_lwrp/includes_lwrp_netdev_lag_actions.rst

Properties
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
.. include:: ../../includes_lwrp/includes_lwrp_netdev_lag_attributes.rst

Examples
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
.. include:: ../../step_lwrp/step_lwrp_netdev_lag.rst

netdev_vlan
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_lwrp/includes_lwrp_netdev_vlan.rst

Actions
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
.. include:: ../../includes_lwrp/includes_lwrp_netdev_vlan_actions.rst

Properties
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
.. include:: ../../includes_lwrp/includes_lwrp_netdev_vlan_attributes.rst

Examples
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
.. include:: ../../step_lwrp/step_lwrp_netdev_vlan.rst