=====================================================
Release Notes: |chef analytics_title| 1.3
=====================================================

.. include:: ../../includes_analytics/includes_analytics.rst

What's New
=====================================================
The following items are new for |chef analytics| 1.3 and/or are changes from previous versions. The short version:

* **Bug Fix** Ability to scroll through the dropdown of organizations when they are longer than the page.
* **Database Partitioning and Management** Databse partitioning was added for easier management. This has consequences for upgrading so read below.

Database Partitioning and Management
-----------------------------------------------------

We've made it easier to manage your data by utilizing ``pg_partman`` supported partitioning in the database. It is enabled by default as of 1.3.0.

.. note:: There are additional upgrade steps and concerns for the 1.3.0 upgrade. Please see the notes below for a short summary and be sure to follow the :doc:`1.3.0 upgrade instructions </upgrade_analytics>` when upgrading.

The largest table, activities, will allow partitions. The benefit of using partitions is that when old data is dropped the disk space is easily reclaimed.

By default, partitions will be enabled and the data retention timeline for activities is set to a year. These values are configurable via :doc:`opscode-analytics.rb </config_rb_analytics>`.

Important Notes Before You Upgrade
+++++++++++++++++++++++++++++++++++++++++++++++++++++

It is recommended that you use paritions but if you do not wish to do so, you must disable them before running reconfigure during your upgrade process (otherwise you cannot revert paritions without data loss). To disable paritions, add the following to your opscode-analytics.rb:

.. code-block:: ruby

   features['partitioning'] = false

Additionally, you will lose the ability to purge node data post upgrade. Node data is no longer being saved as of 1.2.0, but there might be older data in need of downsizing.

If you have disk space concerns, please run this command before reconfiguring to 1.3.0:

.. code-block:: bash

   $ opscode-analytics-ctl purge-nodes

Be sure to follow the :doc:`1.3.0 upgrade instructions </upgrade_analytics>` when upgrading.

