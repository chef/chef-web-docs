=====================================================
Reporting API
=====================================================

.. include:: ../../includes_api_reporting/includes_api_reporting.rst

.. note:: .. include:: ../../includes_chef/includes_chef_subscriptions.rst

Requirements
=====================================================
.. include:: ../../includes_api_chef_server/includes_api_chef_server_requirements.rst

Authentication Headers
=====================================================
.. include:: ../../includes_api_chef_server/includes_api_chef_server_headers.rst

Header Format
-----------------------------------------------------
.. include:: ../../includes_api_chef_server/includes_api_chef_server_headers_format.rst

Required Headers
-----------------------------------------------------
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
-----------------------------------------------------
.. include:: ../../includes_api_chef_server/includes_api_chef_server_headers_example.rst

Global Endpoints
=====================================================
.. include:: ../../includes_api_chef_server/includes_api_chef_server_endpoints_global.rst

/reports/status
-----------------------------------------------------
.. include:: ../../includes_api_reporting/includes_api_reporting_endpoint_reports_status.rst

GET
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_api_reporting/includes_api_reporting_endpoint_reports_status_get.rst








Organization Endpoints
=====================================================
.. include:: ../../includes_api_reporting/includes_api_reporting_endpoints.rst


/reports/nodes/NODE/runs
-----------------------------------------------------
.. include:: ../../includes_api_reporting/includes_api_reporting_endpoint_reports_node_runs.rst

GET
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_api_reporting/includes_api_reporting_endpoint_reports_node_runs_get.rst


/reports/nodes/NODE/runs/RUNID/RESID
-----------------------------------------------------
.. include:: ../../includes_api_reporting/includes_api_reporting_endpoint_reports_node_resid.rst

GET
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_api_reporting/includes_api_reporting_endpoint_reports_node_resid_get.rst



/reports/nodes/NODE/runs/RUNID
-----------------------------------------------------
.. include:: ../../includes_api_reporting/includes_api_reporting_endpoint_reports_node_runid.rst

GET
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_api_reporting/includes_api_reporting_endpoint_reports_node_runid_get.rst



/reports/org/runs
-----------------------------------------------------
.. include:: ../../includes_api_reporting/includes_api_reporting_endpoint_reports_org_runs.rst

GET
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_api_reporting/includes_api_reporting_endpoint_reports_org_runs_get.rst



/reports/runs/counts
-----------------------------------------------------
.. include:: ../../includes_api_reporting/includes_api_reporting_endpoint_reports_runs_counts.rst

GET
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_api_reporting/includes_api_reporting_endpoint_reports_runs_counts_get.rst



/reports/runs/durations
-----------------------------------------------------
.. include:: ../../includes_api_reporting/includes_api_reporting_endpoint_reports_runs_durations.rst

GET
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_api_reporting/includes_api_reporting_endpoint_reports_runs_durations_get.rst
