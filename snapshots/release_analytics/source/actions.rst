=====================================================
Chef Analytics Webui
=====================================================

.. include:: ../../includes_analytics/includes_analytics_legacy.rst 

.. include:: ../../includes_actions/includes_actions.rst

Chef Analytics tracks all of this data in real-time, which then helps you answer the following types of questions:

* Which object changed?
* What type of change was made?
* When was this change made?
* Who changed it?

For example, Chef Analytics can tell you things like:

* The date and time on which a specific user uploaded a cookbook from their local workstation to the Chef server
* The date and time at which a cookbook stopped working
* The changes that were made to the system immediately before that cookbook stopped working

This type of information can be used to quickly identify where in the overall system something changed, which in turn helps identify what went wrong, and then helps show your organization what the resolution should be.

Chef Analytics can also tell you things like:

* What happened just before one (or more) chef-client runs started failing?
* Which versions of SSH are on which machines?
* Is each system updated for the latest patch?
* When did the depsolver break? Which changes happened immediately prior?

Because Chef Analytics tracks all of this in real-time, your organization will be able to use Chef Analytics to react to events as they happen and to more quickly resolve issues that may arise.

The Chef Analytics web user interface is installed as part of :doc:`Chef analytics </install_analytics>`.

.. note:: .. include:: ../../includes_chef/includes_chef_subscriptions.rst

Architecture
=====================================================
.. include:: ../../includes_actions/includes_actions_architecture.rst

Data Tracking
-----------------------------------------------------
.. include:: ../../includes_actions/includes_actions_tracked_data.rst

User Interface
=====================================================
.. include:: ../../includes_analytics/includes_analytics_ui.rst

.. include:: ../../includes_analytics/includes_analytics_ui_diffs.rst

Enable Auto-Refresh
-----------------------------------------------------
.. include:: ../../step_actions_webui/step_actions_webui_enable_auto_refresh_mode.rst

Export Actions
-----------------------------------------------------
.. include:: ../../step_actions_webui/step_actions_webui_export_action_list.rst

Load More Actions
-----------------------------------------------------
.. include:: ../../step_actions_webui/step_actions_webui_load_more_actions.rst

Log In
-----------------------------------------------------
.. include:: ../../step_actions_webui/step_actions_webui_log_in.rst

Save Search Query
-----------------------------------------------------
.. include:: ../../step_actions_webui/step_actions_webui_save_search_query.rst

Search Actions
-----------------------------------------------------
.. include:: ../../step_actions_webui/step_actions_webui_search.rst

Switch Orgs
-----------------------------------------------------
.. include:: ../../step_actions_webui/step_actions_webui_switch_orgs.rst

View Action Details
-----------------------------------------------------
.. include:: ../../step_actions_webui/step_actions_webui_view_action_details.rst
