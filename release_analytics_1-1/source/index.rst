.. THIS PAGE IS LOCATED AT THE /release/analytics_1-1/ PATH.

=====================================================
About |chef analytics_title|
=====================================================

.. include:: ../../includes_chef/includes_chef_index.rst

.. include:: ../../includes_analytics/includes_analytics.rst

View the :doc:`release notes </release_notes>` for the current version of |chef analytics|.

Getting Started
=====================================================
The :doc:`Chef analytics platform </analytics>` provides real-time visibility into what is happening on the |chef server|, including :doc:`what's changing </dsl_recipe>`, :doc:`who made those changes </actions>`, and :doc:`when they occurred </reporting>`. Use the |splunk| application for |chef analytics| to :doc:`gather insights about nodes that are under management </analytics_splunk>` by |chef|. Individuals may be :doc:`notified of these changes in real-time </analytics_rules>`.

Use this visibility to verify compliance against internal controls.

If you are new to |chef|, familiarize yourself with the other core components: `the server, workstations, and nodes <https://docs.chef.io/chef_overview.html>`_. For more information about workstations, cookbooks, and nodes, see the documentation for the chef-client. For more information about the server, see documentation for the Chef server.

Install, Upgrade
=====================================================
The |chef server| can be installed on new hardware. Existing |chef server oec| and |chef server osc| configurations may be upgraded to |chef server| 12.

.. raw:: html

   &nbsp;&nbsp;&nbsp;   <a href="https://docs.chef.io/release/analytics_1-1/install_analytics.html#standalone-version-1-1">Install Analytics 1.1 as Standalone</a> </br>
   &nbsp;&nbsp;&nbsp;   <a href="https://docs.chef.io/release/analytics_1-1/upgrade_analytics.html">Upgrade from Analytics 1.0.4</a> </br>

Features
=====================================================
The following features are part of the |chef analytics| platform:

.. raw:: html

   &nbsp;&nbsp;&nbsp;   <a href="https://docs.chef.io/release/analytics_1-1/actions.html">Actions</a> </br>
   &nbsp;&nbsp;&nbsp;   <a href="https://docs.chef.io/release/analytics_1-1/analytics_rules.html">Rules</a> </br>
   &nbsp;&nbsp;&nbsp;   <a href="https://docs.chef.io/release/analytics_1-1/dsl_recipe.html">Control Groups and Controls (Recipe DSL Methods)</a> </br>
   &nbsp;&nbsp;&nbsp;   <a href="https://docs.chef.io/release/analytics_1-1/chef_client.html">chef-client, audit-mode</a> </br>
   &nbsp;&nbsp;&nbsp;   <a href="https://docs.chef.io/release/analytics_1-1/reporting.html">Reporting</a> </br>
   &nbsp;&nbsp;&nbsp;   <a href="https://docs.chef.io/release/analytics_1-1/analytics_splunk.html">Splunk App for Chef Server</a> </br>
   &nbsp;&nbsp;&nbsp;   <a href="https://docs.chef.io/release/analytics_1-1/analytics_webui_tasks.html">Web User Interface</a> </br>

Manage |chef analytics_title|
=====================================================
|chef analytics| can be managed in the following ways:

.. raw:: html

   &nbsp;&nbsp;&nbsp;   <a href="https://docs.chef.io/release/analytics_1-1/analytics_monitor.html">Monitor</a> </br>

Reference
=====================================================
This section contains links to topics about configuration files, command-line tools, and APIs that are used by the |chef analytics| platform.

.. raw:: html

   &nbsp;&nbsp;&nbsp;   <a href="https://docs.chef.io/release/analytics_1-1/api_analytics.html">Analytics API</a> </br>
   &nbsp;&nbsp;&nbsp;   <a href="https://docs.chef.io/release/analytics_1-1/plugin_knife_analytics.html">knife-analytics (Knife plugin)</a> </br>
   &nbsp;&nbsp;&nbsp;   <a href="https://docs.chef.io/release/analytics_1-1/config_rb_analytics.html">opscode-analytics.rb</a> </br>
   &nbsp;&nbsp;&nbsp;   <a href="https://docs.chef.io/release/analytics_1-1/ctl_analytics.html">opscode-analytics-ctl</a> </br> 
   &nbsp;&nbsp;&nbsp;   <a href="https://docs.chef.io/api_chef_server.html#authenticate-user">authenticate_user endpoint in Chef Server API</a> </br>
   &nbsp;&nbsp;&nbsp;   <a href="https://docs.chef.io/config_rb_server_optional_settings.html#rabbitmq">RabbitMQ settings in chef-server.rb</a> </br>   
   &nbsp;&nbsp;&nbsp;   <a href="https://docs.chef.io/config_rb_server_optional_settings.html#oc-id">OAuth 2.0 authentication to the Chef server</a> </br>    

.. Hide the TOC from this file.

.. toctree::
   :hidden:

   actions
   analytics
   analytics_monitor
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
