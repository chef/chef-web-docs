.. THIS PAGE IS LOCATED AT THE /release/analytics/ PATH.

=====================================================
|analytics rb|
=====================================================

.. include:: ../../includes_config/includes_config_rb_analytics.rst

.. note:: If the |analytics rb| file does not exist, create a file called ``opscode-analytics.rb`` and put it in the ``/etc/opscode-analytics/`` directory.

.. note:: .. include:: ../../includes_chef/includes_chef_subscriptions.rst

Example
==========================================================================
.. include:: ../../includes_config/includes_config_rb_analytics_example.rst

Settings
==========================================================================

.. include:: ../../includes_config/includes_config_rb_analytics_settings.rst

Optional Settings
=====================================================
The following settings are often used for performance tuning of |chef analytics| in larger installations.

.. note:: When changes are made to the |analytics rb| file the |chef analytics| must be reconfigured by running the ``opscode-analytics-ctl reconfigure`` command.

actions
-----------------------------------------------------
.. include:: ../../includes_analytics_tuning/includes_analytics_tuning_actions.rst

paritioning
----------------------------------------------------
The following setting is used to enable and disable partitioning on the |chef analytics| server:

``features['partitioning']``
   Set this to ``false`` before running an upgrade to 1.3.0 to disable database paritioning; however, we recommend that you leave paritioning on. This setting must be set at the time of the 1.3.0 migration to take effect. See the "Upgrade With Paritions Disabled (Not Recommended)" section of the :doc:`upgrade documentation </upgrade_analytics>` for details on how to upgrade without paritioning enabled.