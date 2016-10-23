=====================================================
Release Notes: Chef Analytics
=====================================================

.. include:: ../../includes_analytics/includes_analytics_legacy.rst 

.. include:: ../../includes_analytics/includes_analytics.rst

What's New (1.4)
=====================================================
The following items are new for Chef Analytics 1.4 and/or are changes from previous versions:

* **Chef MLSA** Starting with Chef Analytics 1.4.0, the `Chef MLSA <https://docs.chef.io/chef_license.html>`__ must be accepted when reconfiguring the product. If the Chef MLSA has not already been accepted, the reconfigure process will prompt for a ``yes`` to accept it. Or run ``opscode-analytics-ctl reconfigure --accept-license`` to automatically accept the license.

What's New (1.3)
=====================================================
The following items are new for Chef Analytics 1.3 and/or are changes from previous versions. The short version:

* **Bug Fix** Ability to scroll through the dropdown of organizations when they are longer than the page.
* **Database Partitioning and Management** Databse partitioning was added for easier management. This has consequences for upgrading so read below.

Database Partitioning and Management
-----------------------------------------------------
We've made it easier to manage your data by utilizing ``pg_partman`` supported partitioning in the database. It is enabled by default as of 1.3.0.

.. note:: There are additional upgrade steps and concerns for the 1.3.0 upgrade. Please see the notes below for a short summary and be sure to follow the :doc:`1.3.0 upgrade instructions </upgrade_analytics>` when upgrading.

The largest table, activities, will allow partitions. The benefit of using partitions is that when old data is dropped the disk space is easily reclaimed.

By default, partitions will be enabled and the data retention timeline for activities is set to a year. These values are configurable via :doc:`opscode-analytics.rb </config_rb_analytics>`.

Important Notes Before You Upgrade
-----------------------------------------------------
It is recommended that you use paritions but if you do not wish to do so, you must disable them before running reconfigure during your upgrade process (otherwise you cannot revert paritions without data loss). To disable paritions, add the following to your opscode-analytics.rb:

.. code-block:: ruby

   features['partitioning'] = false

Additionally, you will lose the ability to purge node data post upgrade. Node data is no longer being saved as of 1.2.0, but there might be older data in need of downsizing.

If you have disk space concerns, please run this command before reconfiguring to 1.3.0:

.. code-block:: bash

   $ opscode-analytics-ctl purge-nodes

Be sure to follow the :doc:`1.3.0 upgrade instructions </upgrade_analytics>` when upgrading.




What's New (1.2)
=====================================================
The following items are new for Chef Analytics 1.2 and/or are changes from previous versions. The short version:

* **Nodes view** The new **Nodes** view allows you to filter nodes by status: all nodes, nodes that failed to converge, nodes that are missing, and nodes that converged successfully.
* **RabbitMQ queue tuning** New settings in the Chef server version 12.3 configuration file that support the management of RabbitMQ queues to allow the size and behavior of the queue needed by Chef Analytics to be configured, including settings for the queue length monitor and for tuning the rabbitmq-management plugin.
* **Purge node information** Chef Analytics stores Ohai data for every chef-client run. Use the ``purge-nodes`` command in ``opscode-analytics-ctl`` to manage this volume of data.

Nodes View
-----------------------------------------------------
.. include:: ../../includes_analytics/includes_analytics_nodes_view.rst

RabbitMQ Queues
-----------------------------------------------------
.. warning:: Tuning the RabbitMQ queue settings requires Chef server, version 12.3. These settings `must be configured in the chef-server.rb file <https://docs.chef.io/config_rb_server_optional_settings.html#rabbitmq>`__.

.. include:: ../../includes_server_tuning/includes_server_tuning_rabbitmq_analytics_queue.rst

.. include:: ../../includes_server_tuning/includes_server_tuning_rabbitmq_analytics_queue_settings.rst

Purge Node Information
-----------------------------------------------------
.. include:: ../../includes_ctl_analytics/includes_ctl_analytics_purge_nodes.rst


What's New (1.1.5)
=====================================================
The following items are new for Chef Analytics 1.1.5 and/or are changes from previous versions. The short version:

* **Notifications to Slack using incoming webhooks** Send Chef Analytics notifications to Slack in real time based on rules and notifications in Chef Analytics that are configured to send to the incoming webhooks functionality in Slack.
* **Splunk application for Chef server** Use the Chef App for Splunk to gather insights about nodes that are under management by Chef.
* **Rules** Use rules to generate notifications based on the results of tests run during the chef-client run.
* **Actions** Use Chef actions to view changes made to each node object, the run history for all nodes, the history of every cookbook (and cookbook version), how and where policy settings---roles, environments, and data bags---are applied, and which users made which changes.
* **Reporting 1.2.2** Reporting should be upgraded to version 1.2.2 for full funcationality with the Chef Analytics 1.1 release.
* **oc-id service** The **oc-id** service enables OAuth 2.0 authentication to the Chef server by Chef Analytics.
* **knife-analytics plugin** Use the ``knife analytics`` subcommand to view information about actions, alerts, notifications, and rules that are managed by Chef Analytics.
* **New settings for data retention** The number of months for which activities data is kept is configurable. (New in Chef Analytics 1.1.5.)

In addition, the following functionality is available in chef-client 12.4.1 to support building audit controls and running the chef-client in audit-mode:

* **chef-client may be run in audit-mode** Use audit-mode to run audit controls against a node.
* **control method added to Recipe DSL** Use the ``control`` method to define specific tests that match directories, files, packages, ports, and services. A ``control`` method must be contained within a ``control_group`` block.
* **control_group method added to Recipe DSL** Use the ``control_group`` method to group one (or more) ``control`` methods together.



Slack Incoming Webhooks
-----------------------------------------------------
.. include:: ../../includes_analytics/includes_analytics_webhook_example_slack.rst

Chef App for Splunk
-----------------------------------------------------
.. include:: ../../includes_analytics/includes_analytics_splunk.rst

Rules
-----------------------------------------------------
.. include:: ../../includes_analytics_rules/includes_analytics_rules.rst

.. note:: For more information about building rules for Chef Analytics, including the full rules syntax, see :doc:`Chef Analytics Rules </analytics_rules>`.

Rule Syntax
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_analytics_rules/includes_analytics_rules_syntax.rst

Message Types
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_analytics_rules/includes_analytics_rules_syntax_message_types.rst

Examples
+++++++++++++++++++++++++++++++++++++++++++++++++++++

**Raise audit failure**

.. include:: ../../step_analytics_rules/step_analytics_rules_raise_audit.rst

**Use regular expressions**

.. include:: ../../step_analytics_rules/step_analytics_rules_regular_expression.rst

**Verify resource updates**

.. include:: ../../step_analytics_rules/step_analytics_rules_verify_resource_updates.rst

**Verify run-lists**

.. include:: ../../step_analytics_rules/step_analytics_rules_verify_run_lists.rst


Chef Actions
-----------------------------------------------------
.. include:: ../../includes_actions/includes_actions.rst

Architecture
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_actions/includes_actions_architecture.rst

**Data Tracking**

.. include:: ../../includes_actions/includes_actions_tracked_data.rst

User Interface
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_analytics/includes_analytics_ui.rst

.. include:: ../../includes_analytics/includes_analytics_ui_diffs.rst

New settings for data retention
-----------------------------------------------------
The following settings are new for Chef Analytics version 1.1.5:

.. list-table::
   :widths: 200 300
   :header-rows: 1

   * - Setting
     - Description
   * - ``data_retention['month_interval_to_keep_activities']``
     - The number of months for which activities data is retained. Default value: ``3``.
   * - ``data_retention['keep_all_data']``
     - Use to specify if all events are kept. If this setting is ``true``, the ``month_interval_to_keep_activities`` value is ignored. Default value: ``false``.

chef-client, audit-mode
-----------------------------------------------------
.. include:: ../../includes_chef_client/includes_chef_client_audit_mode.rst

Use following option to run the chef-client in audit-mode mode:

``--audit-mode MODE``
   Enable audit-mode. Set to ``audit-only`` to skip the converge phase of the chef-client run and only perform audits. Possible values: ``audit-only``, ``disabled``, and ``enabled``. Default value: ``disabled``.

The Audit Run
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_chef_client/includes_chef_client_audit_mode_run.rst

control
-----------------------------------------------------
.. include:: ../../includes_analytics/includes_analytics_controls.rst

.. include:: ../../includes_dsl_recipe/includes_dsl_recipe_method_control.rst

.. include:: ../../includes_dsl_recipe/includes_dsl_recipe_method_control_syntax.rst

directory Matcher
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_dsl_recipe/includes_dsl_recipe_method_control_matcher_directory.rst

file Matcher
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_dsl_recipe/includes_dsl_recipe_method_control_matcher_file.rst

package Matcher
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_dsl_recipe/includes_dsl_recipe_method_control_matcher_package.rst

port Matcher
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_dsl_recipe/includes_dsl_recipe_method_control_matcher_port.rst

service Matcher
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_dsl_recipe/includes_dsl_recipe_method_control_matcher_service.rst

Examples
+++++++++++++++++++++++++++++++++++++++++++++++++++++

**A package is installed**

.. include:: ../../step_dsl_recipe/step_dsl_recipe_control_matcher_package_installed.rst

**A package version is installed**

.. include:: ../../step_dsl_recipe/step_dsl_recipe_control_matcher_package_installed_version.rst

**A package is not installed**

.. include:: ../../step_dsl_recipe/step_dsl_recipe_control_matcher_package_not_installed.rst

**A service is enabled**

.. include:: ../../step_dsl_recipe/step_dsl_recipe_control_matcher_service_enabled.rst

**A configuration file contains specific settings**

.. include:: ../../step_dsl_recipe/step_dsl_recipe_control_matcher_file_sshd_configuration.rst

**A file contains desired permissions and contents**

.. include:: ../../step_dsl_recipe/step_dsl_recipe_control_matcher_file_permissions.rst

control_group
-----------------------------------------------------
.. include:: ../../includes_dsl_recipe/includes_dsl_recipe_method_control_group.rst

.. include:: ../../includes_dsl_recipe/includes_dsl_recipe_method_control_group_syntax.rst

Examples
+++++++++++++++++++++++++++++++++++++++++++++++++++++

**control_group block with multiple control blocks**

.. include:: ../../step_dsl_recipe/step_dsl_recipe_control_group_many_controls.rst

**Duplicate control_group names**

.. include:: ../../step_dsl_recipe/step_dsl_recipe_control_group_duplicate_names.rst


**oc-id** Service 
-----------------------------------------------------
.. include:: ../../includes_server_services/includes_server_services_oc_id.rst

These settings are configured in the 
`chef-server.rb <https://docs.chef.io/config_rb_server_optional_settings.html#oc-id>`_ file.


knife analytics
-----------------------------------------------------
.. include:: ../../includes_plugin_knife/includes_plugin_knife_analytics.rst

action list
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_plugin_knife/includes_plugin_knife_analytics_action_list.rst

**Syntax**

.. include:: ../../includes_plugin_knife/includes_plugin_knife_analytics_action_list_syntax.rst

**Options**

.. include:: ../../includes_plugin_knife/includes_plugin_knife_analytics_action_list_options.rst

action show
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_plugin_knife/includes_plugin_knife_analytics_action_show.rst

**Syntax**

.. include:: ../../includes_plugin_knife/includes_plugin_knife_analytics_action_show_syntax.rst

**Options**

.. include:: ../../includes_plugin_knife/includes_plugin_knife_analytics_action_show_options.rst

alert list
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_plugin_knife/includes_plugin_knife_analytics_alert_list.rst

**Syntax**

.. include:: ../../includes_plugin_knife/includes_plugin_knife_analytics_alert_list_syntax.rst

**Options**

.. include:: ../../includes_plugin_knife/includes_plugin_knife_analytics_alert_list_options.rst

alert show
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_plugin_knife/includes_plugin_knife_analytics_alert_show.rst

**Syntax**

.. include:: ../../includes_plugin_knife/includes_plugin_knife_analytics_alert_show_syntax.rst

**Options**

.. include:: ../../includes_plugin_knife/includes_plugin_knife_analytics_alert_show_options.rst

notification list
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_plugin_knife/includes_plugin_knife_analytics_notification_list.rst

**Syntax**

.. include:: ../../includes_plugin_knife/includes_plugin_knife_analytics_notification_list_syntax.rst

**Options**

.. include:: ../../includes_plugin_knife/includes_plugin_knife_analytics_notification_list_options.rst

notification show
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_plugin_knife/includes_plugin_knife_analytics_notification_show.rst

**Syntax**

.. include:: ../../includes_plugin_knife/includes_plugin_knife_analytics_notification_show_syntax.rst

**Options**

.. include:: ../../includes_plugin_knife/includes_plugin_knife_analytics_notification_show_options.rst

rule list
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_plugin_knife/includes_plugin_knife_analytics_rule_list.rst

**Syntax**

.. include:: ../../includes_plugin_knife/includes_plugin_knife_analytics_rule_list_syntax.rst

**Options**

.. include:: ../../includes_plugin_knife/includes_plugin_knife_analytics_rule_list_options.rst

rule show
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_plugin_knife/includes_plugin_knife_analytics_rule_show.rst

**Syntax**

.. include:: ../../includes_plugin_knife/includes_plugin_knife_analytics_rule_show_syntax.rst

**Options**

.. include:: ../../includes_plugin_knife/includes_plugin_knife_analytics_rule_show_options.rst
