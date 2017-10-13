=====================================================
Manage Reports
=====================================================
`[edit on GitHub] <https://github.com/chef/chef-web-docs/blob/master/chef_master/source/server_manage_reports.rst>`__

.. tag reporting_legacy

.. note:: This documentation is meant to support existing Chef customers using Reporting.

          Are you a new Chef customer, or looking to gain better insight into your fleet? Take advantage of `Chef Automate </chef_automate.html>`__. You'll get a graphical interface and query language that gives you insight into operational, compliance, and workflow events. You can `download Chef Automate here <https://downloads.chef.io/automate>`__.

.. end_tag

.. note:: This topic is about using the Chef management console to manage reports.

.. tag reporting_summary

Use Reporting to keep track of what happens during the execution of chef-client runs across all of the machines that are under management by Chef. Reports can be generated for the entire organization and they can be generated for specific nodes.

Reporting data is collected during the chef-client run and the results are posted to the Chef server at the end of the chef-client run at the same time the node object is uploaded to the Chef server.

.. end_tag

Configure Reports
=====================================================
Reports can be built based on environments, by report status, by date range, and by organization.

Filter by Environment
-----------------------------------------------------
To filter report histories by environment:

#. Open the Chef management console.
#. Click **Reports**.
#. Click **Run History**.
#. From the **Filter by environment** drop-down, select ``All Environments``, ``_default``, or any custom environment:

   .. image:: ../../images/step_manage_webui_reports_history_filter_by_environment.png

Filter by Status
-----------------------------------------------------
To filter report histories by chef-client run status:

#. Open the Chef management console.
#. Click **Reports**.
#. Click **Run History**.
#. From the **Filter by status** drop-down, select ``All``, ``Success``, ``Failure``, or ``Started``:

   .. image:: ../../images/step_manage_webui_reports_history_filter_by_status.png

Show Runs by Date Range
-----------------------------------------------------
To show a specific set of chef-client runs:

#. Open the Chef management console.
#. Click **Reports**.
#. Click **Dashboard**.
#. Select the range for which runs will be shown: all runs that occurred in the last 3 months, the last month, the last week, the last twenty-four hours, after a specific date, or between two specific dates:

   .. image:: ../../images/step_manage_webui_reports_dashboard_show_runs.png

Show Runs for Org
-----------------------------------------------------
To show a specific set of chef-client run histories:

#. Open the Chef management console.
#. Click **Reports**.
#. Click **Run History**.
#. Select the range for which run histories will be shown: all runs that occurred in the last 3 months, the last month, the last week, the last twenty-four hours, after a specific date, or between two specific dates.

View Reports
=====================================================
The following report types are available:

Dashboard
-----------------------------------------------------
To view the reports dashboard:

#. Open the Chef management console.
#. Click **Reports**.
#. Click **Dashboard**.

Error Log
-----------------------------------------------------
To view chef-client run error logs:

#. Open the Chef management console.
#. Click **Reports**.
#. Click **Run History**.
#. Select the range of chef-client runs to show, the correct environment, and correct status.
#. Select a chef-client run.
#. Select the **Error Log** tab:

   .. image:: ../../images/step_manage_webui_reports_history_view_error_log.png

History
-----------------------------------------------------
To report histories:

#. Open the Chef management console.
#. Click **Reports**.
#. Click **Run History**.

Run Counts
-----------------------------------------------------
To view chef-client runs still running:

#. Open the Chef management console.
#. Click **Reports**.
#. Click **Dashboard**.
#. The chef-client runs that are still running are shown under the **Run Counts** header:

   .. image:: ../../images/step_manage_webui_reports_dashboard_view_run_counts.png

   Select (or de-select) ``success``, ``failure``, and ``aborted`` to filter the view to only specific run outcomes:

   .. image:: ../../images/step_manage_webui_reports_dashboard_view_dashboard_common_outcomes.png

Run Details
-----------------------------------------------------
To view chef-client details:

#. Open the Chef management console.
#. Click **Reports**.
#. Click **Run History**.
#. Select the range of chef-client runs to show, the correct environment, and correct status.
#. Select a chef-client run.
#. Select the **Details** tab:

   .. image:: ../../images/step_manage_webui_reports_history_view_details.png

   where:

   .. list-table::
      :widths: 60 420
      :header-rows: 1

      * - Setting
        - Description
      * - ``Step``
        - The order in which resources were executed during the chef-client run.
      * - ``Type``
        - The type of resource. /resource.html#resources
      * - ``Name``
        - A string that describes the action taken. For example, a log entry or the name of the service that is enabled.
      * - ``Action``
        - The action taken by the resource type.
      * - ``Duration``
        - The amount of time required to complete the action.
      * - ``Diff``
        - The difference between the current state and the previous state. This setting is available for files managed by the **cookbook_file**, **file**, **remote_file**, and **template** resources.
      * - ``Parameters``
        - Opens the **Run Details** dialog box, which lists all of the parameters on the node that were changed during the chef-client run.

Run Durations
-----------------------------------------------------
To view chef-client runs with errors:

#. Open the Chef management console.
#. Click **Reports**.
#. Click **Dashboard**.
#. The chef-client runs with errors are shown under the **Run Durations** header:

   .. image:: ../../images/step_manage_webui_reports_dashboard_view_run_durations.png

   Hover over duration values to see the number of associated runs:

   .. image:: ../../images/step_manage_webui_reports_dashboard_view_run_durations_hover.png

   Select (or de-select) ``success``, ``failure``, and ``aborted`` to filter the view to only specific run outcomes:

   .. image:: ../../images/step_manage_webui_reports_dashboard_view_dashboard_common_outcomes.png

Run-specific Details
-----------------------------------------------------
To view chef-client run-specific details:

#. Open the Chef management console.
#. Click **Reports**.
#. Click **Run History**.
#. Select the range of chef-client runs to show, the correct environment, and correct status.
#. Select a chef-client run.
#. Select the **Details** tab.
#. For a specific step, from the **Parameters** column, click the view icon to open the **Run Details** dialog box:

   .. image:: ../../images/step_manage_webui_reports_history_view_details_run_details.png

   where:

   .. list-table::
      :widths: 60 420
      :header-rows: 1

      * - Setting
        - Description
      * - ``Parameters``
        - The parameters that were set by the resource during the chef-client run.
      * - ``Initial State``
        - The state of the parameter at the start of the chef-client run.
      * - ``Final State``
        - The state of the parameter at the end of the chef-client run.

Run-list
-----------------------------------------------------
To view chef-client run-list details:

#. Open the Chef management console.
#. Click **Reports**.
#. Click **Run History**.
#. Select the range of chef-client runs to show, the correct environment, and correct status.
#. Select a chef-client run.
#. Select the **Run List** tab:

   .. image:: ../../images/step_manage_webui_reports_history_view_run_list.png

Runs Summary
-----------------------------------------------------
To view the chef-client runs summary:

#. Open the Chef management console.
#. Click **Reports**.
#. Click **Dashboard**.
#. The chef-client runs summaries are shown under the **Runs Summary** header:

   .. image:: ../../images/step_manage_webui_reports_dashboard_view_run_summary.png
