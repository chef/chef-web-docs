.. THIS PAGE IS IDENTICAL TO docs.chef.io/config_rb_analytics.html BY DESIGN
.. THIS PAGE IS LOCATED AT THE /release/analytics_1-3/ PATH.

.. include:: ../../chef_master/source/config_rb_analytics.rst

paritioning
----------------------------------------------------

``features['partitioning']``
   Set this to ``false`` before running an upgrade to 1.3.0 to disable database paritioning; however, we recommend that you leave paritioning on. This setting must be set at the time of the 1.3.0 migration to take effect. See the "Upgrade With Paritions Disabled (Not Recommended)" section of the :doc:`upgrade documentation </upgrade_analytics>` for details on how to upgrade without paritioning enabled.
