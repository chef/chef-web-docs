=====================================================
|reporting_title|
=====================================================

.. include:: ../../includes_reporting/includes_reporting.rst

.. note:: .. include:: ../../includes_chef/includes_chef_subscriptions.rst

Requirements
=====================================================
.. include:: ../../includes_system_requirements/includes_system_requirements_reporting.rst

|reporting| is configured as :doc:`a premium feature </install_reporting>` of the |chef server|.

The Reporting Run
=====================================================
.. include:: ../../includes_reporting/includes_reporting_run.rst

|chef manage_title|, Reports
=====================================================
.. include:: ../../includes_manage/includes_manage.rst

When |reporting| and |chef manage| are both added to the |chef server|, a user interface for |reporting| is also available.

.. image:: ../../images/step_manage_webui_reports.png

|knife_title| Reporting
=====================================================
.. include:: ../../includes_plugin_knife/includes_plugin_knife_reporting.rst

.. note:: Review the list of `common options <https://docs.chef.io/knife_common_options.html>`_ available to this (and all) |knife| subcommands and plugins.

Install the Plugin
-----------------------------------------------------
.. include:: ../../step_plugin_knife/step_plugin_knife_reporting_install_rubygem.rst

runs list
-----------------------------------------------------
.. include:: ../../includes_plugin_knife/includes_plugin_knife_reporting_runs_list.rst

Syntax
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_plugin_knife/includes_plugin_knife_reporting_runs_list_syntax.rst

Options
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_plugin_knife/includes_plugin_knife_reporting_runs_list_options.rst

Examples
+++++++++++++++++++++++++++++++++++++++++++++++++++++
**View all chef-client runs for an organization**

.. include:: ../../step_plugin_knife/step_plugin_knife_reporting_runs_list_by_organization.rst

**View all chef-client runs for a single node**

.. include:: ../../step_plugin_knife/step_plugin_knife_reporting_runs_list_by_node.rst

**View a specific chef-client run**

.. include:: ../../step_plugin_knife/step_plugin_knife_reporting_runs_list_by_run_id.rst

runs show
-----------------------------------------------------
.. include:: ../../includes_plugin_knife/includes_plugin_knife_reporting_runs_show.rst

Syntax
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_plugin_knife/includes_plugin_knife_reporting_runs_show_syntax.rst

Options
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_plugin_knife/includes_plugin_knife_reporting_runs_show_options.rst

Examples
+++++++++++++++++++++++++++++++++++++++++++++++++++++
**Show runs by run identifier**

.. include:: ../../step_plugin_knife/step_plugin_knife_reporting_runs_show_by_run_id.rst

state_attrs Method
=====================================================
.. include:: ../../includes_dsl_resource/includes_dsl_resource_method_state_attrs.rst

Configuration Settings
=====================================================
|reporting| relies on two settings in the |client rb| file:

.. list-table::
   :widths: 200 300
   :header-rows: 1

   * - Setting
     - Description
   * - ``enable_reporting``
     - |enable reporting| For example:

       .. code-block:: ruby

          enable_reporting true
   * - ``enable_reporting_url_fatals``
     - |enable reporting_url_fatals| For example:

       .. code-block:: ruby

          enable_reporting_url_fatals false



Reporting API
=====================================================
.. include:: ../../includes_api_reporting/includes_api_reporting.rst

Requirements
-----------------------------------------------------
.. include:: ../../includes_api_chef_server/includes_api_chef_server_requirements.rst

Authentication Headers
-----------------------------------------------------
.. include:: ../../includes_api_chef_server/includes_api_chef_server_headers.rst

Header Format
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_api_chef_server/includes_api_chef_server_headers_format.rst

Required Headers
+++++++++++++++++++++++++++++++++++++++++++++++++++++
The following authentication headers are required:

.. list-table::
   :widths: 130 400
   :header-rows: 1

   * - Feature
     - Description
   * - ``Accept``
     - .. include:: ../../includes_api_chef_server/includes_api_chef_server_headers_accept.rst
   * - ``Content-Type``
     - .. include:: ../../includes_api_chef_server/includes_api_chef_server_headers_content_type.rst
   * - ``Host``
     - .. include:: ../../includes_api_chef_server/includes_api_chef_server_headers_host.rst
   * - ``X-Chef-Version``
     - .. include:: ../../includes_api_chef_server/includes_api_chef_server_headers_x_chef_version.rst
   * - ``X-Ops-Authorization-N``
     - .. include:: ../../includes_api_chef_server/includes_api_chef_server_headers_x_ops_authorization.rst
   * - ``X-Ops-Content-Hash``
     - .. include:: ../../includes_api_chef_server/includes_api_chef_server_headers_x_ops_content_hash.rst
   * - ``X-Ops-Reporting-Protocol-Version``
     - .. include:: ../../includes_api_reporting/includes_api_reporting_headers_x_ops_reporting_protocol_version.rst
   * - ``X-Ops-Sign``
     - .. include:: ../../includes_api_chef_server/includes_api_chef_server_headers_x_ops_sign.rst
   * - ``X-Ops-Timestamp``
     - .. include:: ../../includes_api_chef_server/includes_api_chef_server_headers_x_ops_timestamp.rst
   * - ``X-Ops-UserId``
     - .. include:: ../../includes_api_chef_server/includes_api_chef_server_headers_x_ops_userid.rst

Example
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_api_chef_server/includes_api_chef_server_headers_example.rst

Global Endpoints
-----------------------------------------------------
.. include:: ../../includes_api_chef_server/includes_api_chef_server_endpoints_global.rst

/reports/status
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_api_reporting/includes_api_reporting_endpoint_reports_status.rst

GET
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
.. include:: ../../includes_api_reporting/includes_api_reporting_endpoint_reports_status_get.rst

Organization Endpoints
-----------------------------------------------------
.. include:: ../../includes_api_reporting/includes_api_reporting_endpoints.rst

/reports/nodes/NODE/runs
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_api_reporting/includes_api_reporting_endpoint_reports_node_runs.rst

GET
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
.. include:: ../../includes_api_reporting/includes_api_reporting_endpoint_reports_node_runs_get.rst

/reports/nodes/NODE/runs/RUNID/RESID
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_api_reporting/includes_api_reporting_endpoint_reports_node_resid.rst

GET
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
.. include:: ../../includes_api_reporting/includes_api_reporting_endpoint_reports_node_resid_get.rst

/reports/nodes/NODE/runs/RUNID
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_api_reporting/includes_api_reporting_endpoint_reports_node_runid.rst

GET
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
.. include:: ../../includes_api_reporting/includes_api_reporting_endpoint_reports_node_runid_get.rst

/reports/org/runs
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_api_reporting/includes_api_reporting_endpoint_reports_org_runs.rst

GET
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
.. include:: ../../includes_api_reporting/includes_api_reporting_endpoint_reports_org_runs_get.rst

/reports/runs/counts
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_api_reporting/includes_api_reporting_endpoint_reports_runs_counts.rst

GET
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
.. include:: ../../includes_api_reporting/includes_api_reporting_endpoint_reports_runs_counts_get.rst

/reports/runs/durations
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_api_reporting/includes_api_reporting_endpoint_reports_runs_durations.rst

GET
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
.. include:: ../../includes_api_reporting/includes_api_reporting_endpoint_reports_runs_durations_get.rst
