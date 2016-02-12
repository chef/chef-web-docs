=====================================================
|chef analytics_title|
=====================================================

.. include:: ../../includes_analytics/includes_analytics.rst

.. note:: .. include:: ../../includes_chef/includes_chef_subscriptions.rst

|chef analytics_title| Components
=====================================================
The following diagram shows the relationships between the various elements of |chef analytics|, including how information is routed from various nodes to the |chef analytics| server (through the |chef server|) nodes, where reports about |chef client| run outcomes may be viewed, where rules are processed, and where |chef analytics| data may be viewed.

.. image:: ../../images/chef_analytics.svg
   :width: 600px
   :align: center


.. list-table::
   :widths: 60 420
   :header-rows: 1

   * - Feature
     - Description
   * - **Controls**
     - .. include:: ../../includes_analytics/includes_analytics_controls.rst
   * - **Audit Mode**
     - .. include:: ../../includes_chef_client/includes_chef_client_audit_mode.rst
   * - **Chef Actions**
     - .. include:: ../../includes_actions/includes_actions.rst
   * - **Reporting**
     - .. include:: ../../includes_reporting/includes_reporting.rst
   * - **Rules**
     - .. include:: ../../includes_analytics_rules/includes_analytics_rules.rst

The following sections discuss these elements (and their various components) in more detail.

Integrations
=====================================================
|chef analytics| can integrate with |hipchat|, |slack| and |splunk| as well as send notifications via email and trigger webhooks.

|hipchat|
-----------------------------------------------------
.. include:: ../../includes_analytics/includes_analytics_hipchat.rst

|slack|
-----------------------------------------------------
.. include:: ../../includes_analytics/includes_analytics_webhook_example_slack.rst

|chef splunk|
-----------------------------------------------------
.. include:: ../../includes_analytics/includes_analytics_splunk.rst

Email
-----------------------------------------------------
.. include:: ../../includes_analytics/includes_analytics_email_notifications.rst

Webhooks
-----------------------------------------------------
For an example of creating a notification that integrates with a remote service via webhooks, see the |slack| integration section (above).

Controls
=====================================================
.. include:: ../../includes_analytics/includes_analytics_controls.rst

|dsl recipe| Methods
-----------------------------------------------------
The following methods are built into the |dsl recipe| and may be used to configure tests that are run while the |chef client| is run in |chef client_audit|:

.. list-table::
   :widths: 60 420
   :header-rows: 1

   * - Method
     - Description
   * - ``control``
     - .. include:: ../../includes_chef_client/includes_chef_client_audit_mode.rst
   * - ``control_group``
     - .. include:: ../../includes_chef_client/includes_chef_client_audit_mode.rst

Audit Mode
=====================================================
.. include:: ../../includes_chef_client/includes_chef_client_audit_mode.rst

The Audit Run
-----------------------------------------------------
.. include:: ../../includes_chef_client/includes_chef_client_audit_mode_run.rst

|reporting_title|
=====================================================
.. include:: ../../includes_reporting/includes_reporting.rst

The Reporting Run
-----------------------------------------------------
.. include:: ../../includes_reporting/includes_reporting_run.rst

|rules_analytics_title|
=====================================================
.. include:: ../../includes_analytics_rules/includes_analytics_rules.rst

.. note:: For more information about |chef analytics| rules, see https://docs.chef.io/analytics_rules.html.

|chef analytics_title| Webui
=====================================================
.. include:: ../../includes_actions/includes_actions.rst

Architecture
-----------------------------------------------------
.. include:: ../../includes_actions/includes_actions_architecture.rst

Data Tracking
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_actions/includes_actions_tracked_data.rst

User Interface
-----------------------------------------------------
.. include:: ../../includes_analytics/includes_analytics_ui.rst

Reference Topics
=====================================================
See the following links for information about installing, monitoring, using command-line tools, and configuration file settings:

* :doc:`Install Chef Analytics </install_analytics>`
* :doc:`Monitor Chef Analytics </analytics_monitor>`
* :doc:`opscode-analytics-ctl </ctl_analytics>`
* :doc:`opscode-analytics.rb </config_rb_analytics>`
