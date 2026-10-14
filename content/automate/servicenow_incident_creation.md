+++
title = "ServiceNow Incident App"

draft = false


[menu]
  [menu.automate]
    title = "Incident App"
    identifier = "automate/integrations/servicenow/servicenow_incident_creation.md Chef Automate Incident Creation"
    parent = "automate/integrations/servicenow"
    weight = 20
+++

The Chef Automate Incident Creation App for ServiceNow is a certified app available in the [ServiceNow](https://store.servicenow.com) store. The Incident App generates incidents in the ServiceNow Incident Management environment for configuration run or compliance check failures in Chef Automate. This helps you capture the failures in your automated infrastructure and improve your incident tracking and resolution.

The Incident App exposes the REST API endpoint for communication between Chef Automate and the ServiceNow instance. Chef Automate sends HTTPS JSON notifications to the Incident App in a ServiceNow instance to creates and update incident failures.

![Flow diagram showing Chef Automate sending HTTPS notifications to the Incident Creation application in a ServiceNow instance.](/images/automate/SNOW_Automate_diagram.png)

## Key Features of the Incident App

* Incident management for infrastructure and compliance automation
* Intelligent data management and event de-duplication
* Compliance-related integrations within ServiceNow

The Incident App generates a data stream of compliance events that you can leverage by using this data to other ServiceNow applications. For example, you can integrate the Chef Automate compliance scan data with Governance and Risk Compliance (GRC) or Security and Incident Management (SIEM) systems in ServiceNow. You can personalize the Chef Automate compliance data stream by prioritizing the scan results, which helps you enhance your risk dashboard with real-time and ranked compliance events instead of low-information and context-free standard data streams.

## User Requirements

* Your unique ServiceNow URL. It has the format: `https://ven12345.service-now.com`.
* Setting up the Incident App requires the `x_chef_incident.api` role to configure it. Your ServiceNow administrator can enable this for you.

### System Requirements

* A running [Chef Automate](https://www.chef.io/automate/) instance.
* Chef Automate has a valid SSL/TLS certificate from a trusted certificate authority (CA).
* A running [ServiceNow](https://www.servicenow.com/) instance. The supported ServiceNow versions are Xanadu, Yokohama, and Zurich.
* The ServiceNow instance is reachable on port 443.

## Install

Get the app from the [ServiceNow](https://store.servicenow.com) store and then install it to your account from the **Service Management** dashboard.

## Setup

You can setup automatic incident creation for:

* Chef Infra Client failures
* Chef InSpec scan failures

### Chef Infra Client Incidents

To set up automatic incident reporting for failed Chef Infra Client runs from Chef Automate:

1. Confirm that you have the `x_chef_incident.api` role.
1. Navigate to **Settings** > **Notifications**
1. Select **Create Notification**
1. Enter or select:
   * **Name**: A unique name for this notification.
   * **Webhook Type**: The product or process receiving the notification. Options: **Slack**, **Webhook**, and **ServiceNow**.
   * **Failure Type**: The Chef process for the notification. Select **Infra Client Run failures**.
   * **Webhook URL**: The API address that the notification uses. It has the format: `https://ven12345.service-now.com/api/x_chef_incident/client_run`.
   * **ServiceNow Username**: The name you use to sign in to ServiceNow.
   * **ServiceNow Password**: The password you use to sign in to ServiceNow.
1. Select **Test Connectivity**. A successful test displays **Notification test connected successfully**. An unsuccessful test displays a message with information about any connection or credential problems to help you fix the error.

   ![Create Notification dialog configured for ServiceNow and Infra Client run failures with webhook URL and credentials.](/images/automate/SNOW_CCR_Setup.png)

1. Select **Create Notification** to save this notification.

### Chef InSpec Scan Incidents

Follow these steps to report failed Chef InSpec scans from Chef Automate:

1. Navigate to **Settings** > **Notifications** > **Create Notification** button.
1. Enter or select:
   * **Name**: A unique name for this notification.
   * **Webhook Type**: The product or process receiving the notification. Select the **ServiceNow** option.
   * **Failure Type**: The Chef process for the notification. Select the **Inspec compliance scan failures** option.
   * **Webhook URL**: The API address that the notification uses. It has the format:`https://ven12345.service-now.com/api/x_chef_incident/inspec_scan`
   * **ServiceNow Username**: The name you use to sign in to ServiceNow.
   * **ServiceNow Password**: The password you use to sign in to ServiceNow.
1. Select **Test Connectivity**. A successful test displays **Notification test connected successfully**. An unsuccessful test displays a message with information about any connection or credential problems to help you fix the error.

   ![Create Notification dialog configured for ServiceNow and InSpec compliance scan failures with webhook URL and credentials.](/images/automate/SNOW_Scan_Setup.png)

1. Select **Create Notification** to save this notification.

## Properties

The Chef Automate Incident App has nine configurable **Application Properties**. You must have the `admin` or `x_chef_incident.admin` roles to change the default values in the **Application Properties**.

To change the Incident App properties:

1. Find **Chef Incidents** in ServiceNow
1. Select **Chef Incidents** > **Properties** from the navigation.
1. Enter your changes in the **Chef Incident Properties** form.
1. Select **Save**.

   ![Chef incident properties page in ServiceNow with association, assignment, impact, urgency, retention, and logging settings.](/images/automate/SNOW_config_page.png)

### Incident App Properties

`x_chef_incident.association`
: Used to associate a Chef Infra Client run record with an Incident record. Possible values: `cookbook` and `node`. Default: `cookbook`.

   Create an incident for `cookbook` creates a failed cookbook by setting the value to `cookbook`. This associates all failing Chef Infra Client runs with the corresponding incident. `cookbook` is the default value because the number of nodes exceeds the number of cookbooks in any system. The short description of the incident provides information about the failure:

   ![ServiceNow incident showing a failed Chef Infra Client run for a cookbook with short description and error details.](/images/automate/SNOW_Failed_Cookbook.png)

   The **Chef Infra Client runs** tab of the incident displays the associated client runs. Setting the value to `node` creates an incident for each failed node. All failing Chef Infra Client runs for a node associates with the corresponding incident. The short description of the incident provides information about the run failure for one node.

   ![ServiceNow incident activity and related records showing client run failure details for a node-associated incident.](/images/automate/SNOW_Failed_Node_CCR.png)

`x_chef_incident.scan_association`

: Associate a Chef InSpec scan record with an incident record. Possible values: `profile` and `node`. Default: `profile`.

   Create a Chef InSpec compliance scan incident by setting this value to `profile`. This associates all failed Chef InSpec scans with the corresponding incident. `profile` is the default value because the number of nodes exceeds the number of profiles. The short description of the incident provides information about the failure.

   ![Chef InSpec scan record in ServiceNow showing a compliance failure entry linked to an incident.](/images/automate/SNOW_Failed_Profile_Scan.png)

   The **Chef InSpec scans** tab of the incident displays the associated Chef InSpec scans. Setting the value to `node` creates an incident for each failed node. All Chef InSpec scans failing for a node associates with the corresponding incident. The short description of the incident indicates the failed node.

   ![ServiceNow incident showing InSpec scan-related activity and a table of associated failed scan records by node.](/images/automate/SNOW_Failed_Node_Scan.png)

`x_chef_incident.assigned_to`

: Assign a ServiceNow user ID to incidents. If the user is part of a group, then that group is also automatically assigned to the incident. Default: `none`.

`x_chef_incident.assignment_group`

: Assign a group to the incident instead of the individual user in the `x_chef_incident.assigned_to` property. Default: `blank`.

`x_chef_incident.impact`

: Set an incident impact value. Possible values: `1`, `2`, `3`. Default: `2`.

`x_chef_incident.urgency`

: Set an incident urgency value. Possible values: `1`, `2`, `3`. Default: `2`.

`x_chef_incident.retention_days`

: Define the number of days to retain Chef Infra Client run and Chef InSpec scan reports in ServiceNow. The ServiceNow app automatically updates the records associated with reports when they're closed, deleted, or removed. Default: `30`.

`x_chef_incident.logging.enabled`

: Set to `Yes` to enable logging and `No` to disable it. Once enabled, authorized users can view the logs at **Chef incidents** > **Logs** and **System logs** > **Application logs**. Default: `No`.

`x_chef_incident.logging.verbosity`

: Set the amount of information visible in logs. Possible values: `debug`, `warn`, `info`, and `error`. Default: `error`.

## Uninstall

To uninstall the Chef Automate Incident App:

1. Navigate to the **System Applications** > **Applications** in ServiceNow.
1. Open the **Downloads** tab and select the **Chef Automate Incident Creation**.
1. Navigate to **Related Links**.
1. Select **Uninstall**.
