=====================================================
Release Notes: |chef analytics_title| 1.1.5
=====================================================

.. include:: ../../includes_analytics/includes_analytics.rst

What's New
=====================================================
The following items are new for |chef analytics| 1.1.5 and/or are changes from previous versions. The short version:

* **Notifications to Slack using incoming webhooks** Send |chef analytics| notifications to |slack| in real time based on rules and notifications in |chef analytics| that are configured to send to the incoming webhooks functionality in |slack|.
* **Splunk application for Chef server** Use the |chef splunk| to gather insights about nodes that are under management by |chef|.
* **Rules** Use rules to generate notifications based on the results of tests run during the |chef client| run.
* **Actions** Use |chef actions| to view changes made to each node object, the run history for all nodes, the history of every cookbook (and cookbook version), how and where policy settings---roles, environments, and data bags---are applied, and which users made which changes.
* **Reporting 1.2.2** |reporting| should be upgraded to version 1.2.2 for full funcationality with the |chef analytics| 1.1 release.
* **oc-id service** The |service ocid| service enables |oauth| 2.0 authentication to the |chef server| by |chef analytics|.
* **knife-analytics plugin** Use the |subcommand knife analytics| subcommand to view information about actions, alerts, notifications, and rules that are managed by |chef analytics|.
* **New settings for data retention** The number of months for which activities data is kept is configurable. (New in |chef analytics| 1.1.5.)

In addition, the following functionality is available in |chef client| 12.4.1 to support building audit controls and running the |chef client| in |chef client_audit|:

* **chef-client may be run in audit-mode** Use |chef client_audit| to run audit controls against a node.
* **control method added to Recipe DSL** Use the ``control`` method to define specific tests that match directories, files, packages, ports, and services. A ``control`` method must be contained within a ``control_group`` block.
* **control_group method added to Recipe DSL** Use the ``control_group`` method to group one (or more) ``control`` methods together.



|slack| Incoming Webhooks
-----------------------------------------------------
.. include:: ../../includes_analytics/includes_analytics_webhook_example_slack.rst

|chef splunk|
-----------------------------------------------------
.. include:: ../../includes_analytics/includes_analytics_splunk.rst

|rules_analytics_title|
-----------------------------------------------------
.. include:: ../../includes_analytics_rules/includes_analytics_rules.rst

.. note:: For more information about building rules for |chef analytics|, including the full rules syntax, see :doc:`Chef Analytics Rules </analytics_rules>`.

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


|chef actions_title|
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
The following settings are new for |chef analytics| version 1.1.5:

.. list-table::
   :widths: 200 300
   :header-rows: 1

   * - Setting
     - Description
   * - ``data_retention['month_interval_to_keep_activities']``
     - The number of months for which activities data is retained. Default value: ``3``.
   * - ``data_retention['keep_all_data']``
     - Use to specify if all events are kept. If this setting is ``true``, the ``month_interval_to_keep_activities`` value is ignored. Default value: ``false``.

|chef client|, |chef client_audit|
-----------------------------------------------------
.. include:: ../../includes_chef_client/includes_chef_client_audit_mode.rst

Use following option to run the |chef client| in |chef client_audit| mode:

``--audit-mode MODE``
   |audit_mode| Default value: ``disabled``.

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


|service ocid| Service 
-----------------------------------------------------
.. include:: ../../includes_server_services/includes_server_services_oc_id.rst

These settings are configured in the 
`chef-server.rb <https://docs.chef.io/config_rb_server_optional_settings.html#oc-id>`_ file.


|subcommand knife analytics|
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
