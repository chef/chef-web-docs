=====================================================
High Availability
=====================================================

.. warning:: This topic is deprecated. For the latest information on high availability and how to set up a highly-available server cluster, see :doc:`install_server_ha`.

.. include:: ../../includes_server_ha/includes_server_ha.rst

For |chef server| 12, the following high availability configurations are supported:

* DRBD
* AWS

DRBD
=====================================================
.. include:: ../../includes_server_ha/includes_server_ha_drbd.rst

Graceful Transitions
-----------------------------------------------------
.. include:: ../../includes_server_ha/includes_server_ha_graceful_transitions.rst

Split Brains
-----------------------------------------------------
.. include:: ../../includes_server_ha/includes_server_ha_drbd_split_brain.rst

Custom Handlers
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_server_ha/includes_server_ha_drbd_handlers.rst

Assumptions
-----------------------------------------------------
.. include:: ../../includes_server_ha/includes_server_ha_drbd_assumptions.rst

Failure Scenarios
-----------------------------------------------------
.. include:: ../../includes_server_ha/includes_server_ha_drbd_scenario.rst

Scenarios 1 and 2
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_server_ha/includes_server_ha_drbd_scenario_1and2.rst

Scenario 3
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_server_ha/includes_server_ha_drbd_scenario_3.rst

Scenario 4
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_server_ha/includes_server_ha_drbd_scenario_4.rst

Scenario 5
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_server_ha/includes_server_ha_drbd_scenario_5.rst

AWS
=====================================================
.. include:: ../../includes_server_ha/includes_server_ha_aws.rst

View the topic :doc:`High Availability: AWS </install_server_ha_aws>` for more information about how to set up the |chef server| for high availability in |amazon aws|.

.. note:: .. include:: ../../includes_chef/includes_chef_subscriptions.rst

Check HA Status
=====================================================
.. include:: ../../includes_api_chef_server/includes_api_chef_server_endpoint_status.rst
