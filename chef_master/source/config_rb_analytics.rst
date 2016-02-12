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


