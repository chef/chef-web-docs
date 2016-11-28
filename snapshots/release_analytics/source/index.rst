

=====================================================
About Chef Analytics 
=====================================================

.. tag analytics_legacy

.. note:: This topic is meant to support existing customers using Analytics. The visibility capabilities of Chef Automate replace the features and functionality of Chef Analytics and we encourage customers to adopt Chef Automate going forward.

.. end_tag

.. tag chef_index

Chef is a systems and cloud infrastructure automation framework that makes it easy to deploy servers and applications to any physical, virtual, or cloud location, no matter the size of the infrastructure. Each organization is comprised of one (or more) workstations, a single server, and every node that will be configured and maintained by the chef-client. Cookbooks (and recipes) are used to tell the chef-client how each node in your organization should be configured. The chef-client (which is installed on every node) does the actual configuration.

.. end_tag

.. tag analytics_summary

The Chef Analytics platform is a feature of Chef that provides real-time visibility into what is happening on the Chef server, including what's changing, who made those changes, and when they occurred. Individuals may be notified of these changes in real-time. Use this visibility to verify compliance against internal controls.

.. end_tag

View the :doc:`release notes </release_notes>` for all versions of Chef Analytics.

Getting Started
=====================================================
The :doc:`Chef analytics platform </analytics>` provides real-time visibility into what is happening on the Chef server, including :doc:`what's changing </dsl_recipe>`, :doc:`who made those changes </actions>`, and :doc:`when they occurred </reporting>`. Use the Splunk application for Chef Analytics to :doc:`gather insights about nodes that are under management </analytics_splunk>` by Chef. Individuals may be :doc:`notified of these changes in real-time </analytics_rules>`.

Use this visibility to verify compliance against internal controls.

If you are new to Chef, familiarize yourself with the other core components: the server, workstations, and nodes . For more information about workstations, cookbooks, and nodes, see the documentation for the chef-client. For more information about the server, see documentation for the Chef server.

Install, Upgrade
=====================================================
The Chef server can be installed on new hardware. Existing Enterprise Chef and Open Source Chef configurations may be upgraded to Chef server 12.

:doc:`install_analytics`
:doc:`upgrade_analytics`

Features
=====================================================
The following features are part of the Chef Analytics platform:

:doc:`actions`
:doc:`analytics_rules`
:doc:`analytics_nodes_view`
:doc:`dsl_recipe`
:doc:`chef_client`
:doc:`reporting`
:doc:`analytics_splunk`
:doc:`analytics_webui_tasks`

Manage Chef Analytics
=====================================================
Chef Analytics can be managed in the following ways:

:doc:`analytics_monitor`

Reference
=====================================================
This section contains links to topics about configuration files, command-line tools, and APIs that are used by the Chef Analytics platform.

:doc:`api_analytics`
:doc:`plugin_knife_analytics`
:doc:`config_rb_analytics`
:doc:`ctl_analytics`

.. Hide the TOC from this file.

.. toctree::
   :hidden:

   actions
   analytics
   analytics_monitor
   analytics_nodes_view
   analytics_rules
   analytics_splunk
   analytics_webui_tasks
   api_analytics
   chef_client
   config_rb_analytics
   ctl_analytics
   dsl_recipe
   install_analytics
   install_reporting
   install_server_pre
   plugin_knife_analytics
   release_notes
   reporting
   upgrade_analytics
