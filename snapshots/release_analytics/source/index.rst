.. THIS PAGE IS LOCATED AT THE /release/analytics/ PATH.

=====================================================
About Chef Analytics 
=====================================================

.. include:: ../../includes_analytics/includes_analytics_legacy.rst 

.. include:: ../../includes_chef/includes_chef_index.rst

.. include:: ../../includes_analytics/includes_analytics.rst

View the :doc:`release notes </release_notes>` for all versions of Chef Analytics.

Getting Started
=====================================================
The :doc:`Chef analytics platform </analytics>` provides real-time visibility into what is happening on the Chef server, including :doc:`what's changing </dsl_recipe>`, :doc:`who made those changes </actions>`, and :doc:`when they occurred </reporting>`. Use the Splunk application for Chef Analytics to :doc:`gather insights about nodes that are under management </analytics_splunk>` by Chef. Individuals may be :doc:`notified of these changes in real-time </analytics_rules>`.

Use this visibility to verify compliance against internal controls.

If you are new to Chef, familiarize yourself with the other core components: `the server, workstations, and nodes <https://docs.chef.io/chef_overview.html>`_. For more information about workstations, cookbooks, and nodes, see the documentation for the chef-client. For more information about the server, see documentation for the Chef server.

Install, Upgrade
=====================================================
The Chef server can be installed on new hardware. Existing Enterprise Chef and Open Source Chef configurations may be upgraded to Chef server 12.

.. raw:: html

   &nbsp;&nbsp;&nbsp;   <a href="https://docs.chef.io/release/analytics/install_analytics.html#standalone-version-1-1">Install Analytics as Standalone</a> </br>
   &nbsp;&nbsp;&nbsp;   <a href="https://docs.chef.io/release/analytics/upgrade_analytics.html">Upgrade Analytics</a> </br>

Features
=====================================================
The following features are part of the Chef Analytics platform:

.. raw:: html

   &nbsp;&nbsp;&nbsp;   <a href="https://docs.chef.io/release/analytics/actions.html">Actions</a> </br>
   &nbsp;&nbsp;&nbsp;   <a href="https://docs.chef.io/release/analytics/analytics_rules.html">Rules</a> </br>
   &nbsp;&nbsp;&nbsp;   <a href="https://docs.chef.io/release/analytics/analytics_nodes_view.html">Nodes View</a> </br>
   &nbsp;&nbsp;&nbsp;   <a href="https://docs.chef.io/release/analytics/dsl_recipe.html">Control Groups and Controls (Recipe DSL Methods)</a> </br>
   &nbsp;&nbsp;&nbsp;   <a href="https://docs.chef.io/release/analytics/chef_client.html">chef-client, audit-mode</a> </br>
   &nbsp;&nbsp;&nbsp;   <a href="https://docs.chef.io/release/analytics/reporting.html">Reporting</a> </br>
   &nbsp;&nbsp;&nbsp;   <a href="https://docs.chef.io/release/analytics/analytics_splunk.html">Splunk App for Chef Server</a> </br>
   &nbsp;&nbsp;&nbsp;   <a href="https://docs.chef.io/release/analytics/analytics_webui_tasks.html">Web User Interface</a> </br>

Manage Chef Analytics
=====================================================
Chef Analytics can be managed in the following ways:

.. raw:: html

   &nbsp;&nbsp;&nbsp;   <a href="https://docs.chef.io/release/analytics/analytics_monitor.html">Monitor</a> </br>

Reference
=====================================================
This section contains links to topics about configuration files, command-line tools, and APIs that are used by the Chef Analytics platform.

.. raw:: html

   &nbsp;&nbsp;&nbsp;   <a href="https://docs.chef.io/release/analytics/api_analytics.html">Analytics API</a> </br>
   &nbsp;&nbsp;&nbsp;   <a href="https://docs.chef.io/release/analytics/plugin_knife_analytics.html">knife-analytics (Knife plugin)</a> </br>
   &nbsp;&nbsp;&nbsp;   <a href="https://docs.chef.io/release/analytics/config_rb_analytics.html">opscode-analytics.rb</a> </br>
   &nbsp;&nbsp;&nbsp;   <a href="https://docs.chef.io/release/analytics/ctl_analytics.html">opscode-analytics-ctl</a> </br> 
   &nbsp;&nbsp;&nbsp;   <a href="https://docs.chef.io/api_chef_server.html#authenticate-user">authenticate_user endpoint in Chef Server API</a> </br>
   &nbsp;&nbsp;&nbsp;   <a href="https://docs.chef.io/config_rb_server_optional_settings.html#rabbitmq">RabbitMQ settings in chef-server.rb</a> </br>   
   &nbsp;&nbsp;&nbsp;   <a href="https://docs.chef.io/config_rb_server_optional_settings.html#oc-id">OAuth 2.0 authentication to the Chef server</a> </br>    

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
