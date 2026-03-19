+++
title = "ServiceNow Event Creation App"

draft = true


[menu]
  [menu.automate]
    title = "Event Creation App"
    identifier = "automate/integrations/servicenow/servicenow_event_creation.md Chef Automate Event Creation"
    parent = "automate/integrations/servicenow"
    weight = 20
+++

The [ServiceNow](https://store.servicenow.com) store provides the Chef Automate Event Creation App, a ServiceNow-certified app. The Event Creation App integrates Chef Automate with ServiceNow and lets you create events and alerts for failed Chef Infra client runs and compliance scans. This app captures failures in your automated infrastructure and improves event tracking and resolution.

The Event Creation App exposes the Representational State Transfer (REST) API endpoint for communication between Chef Automate and your ServiceNow instance. Chef Automate sends HTTPS JSON notifications to the Event Creation App in ServiceNow to create and update events.

## User requirements

- Your unique ServiceNow URL. It has the format: `https://ven12345.service-now.com`.
- Setting up the Event Creation App requires the `x_chef_event.api` role in configuring it. Your ServiceNow administrator can enable this for you.

## ServiceNow plug-in requirements

Install the `Event Management Core` plugin from the Service Management dashboard. Contact your ServiceNow administrator for more information.

## Install

Get the Event Creation App from the [ServiceNow](https://store.servicenow.com) store and then install it to your account from the **Service Management** dashboard.

{{< note >}}

 Refer [Event Creation App Roles]({{< relref "servicenow_reference/#event-creation-app-roles" >}}) section for information on event app roles.

{{< /note >}}

## Setup

You can set up automatic event creation and alerts for:

- Chef Infra client run alerts

  Includes the client run alerts grouped by message key. The message key uses either cookbook or node in the properties section.

- Chef InSpec scan alerts

  Includes Chef InSpec scan run alerts grouped by message key. The message key uses either profile or node in the properties section.

- Chef Infra client runs

  Includes the client run records associated with the event created.

- Chef InSpec scans

  Includes the Inspec scan records associated with the events.

- Scheduled jobs

  The scheduled jobs include a script that deletes client runs and Chef InSpec scans when clients remove associated events. Client event rules delete those events.

  ![ServiceNow Event Creation modules](/images/automate/sn_event_menus.png)

## Properties

The Event Creation App has three configurable **Application Properties**. You must have the `admin` or `x_chef_event.admin` roles to change the default values in the **Application Properties**. Refer [Event Creation App Properties]({{< relref "servicenow_reference/#event-creation-app-properties" >}}) section for information on event app properties.

To change the Event Creation App properties:

1. Find **Chef Events** in ServiceNow.
1. Select **Chef Events** > **Properties** from the navigation.
1. Enter your changes in the **Chef Events Properties** form.
1. Select **Save**.

   ![ServiceNow Event Creation Configuration Page](/images/automate/sn_event_properties.png)

### Chef Infra Client events

To set up automatic event reporting for failed Chef Infra Client runs from Chef Automate:

1. Confirm that you have the `x_chef_event.api` role.
1. Go to **Settings** > **Notifications**.
1. Select **Create Notification**.
1. Enter a **Name** for this notification.
1. Select a **Webhook Type**. Options: **Slack**, **Webhook**, and **ServiceNow**.
1. Select **Infra Client run failures** for **Failure Type**.
1. Enter the **Webhook URL** in this format: `https://ven12345.service-now.com/api/x_chef_event/client_run`.
1. Enter your **ServiceNow Username**.
1. Enter your **ServiceNow Password**.

1. Select **Test Notification**. If the test passes, ServiceNow displays **Notification test connected**. If the test fails, ServiceNow displays a message with connection or credential details to help you fix the error.

   ![Chef Automate Event Creation for Client Run Failures](/images/automate/sn_event_client_run_creation.png)

1. Select **Create Notification** to save this notification. A confirmation message, **Created notification "unique notification name specified"** appears.

### Chef InSpec scan events

Follow these steps to report failed Chef InSpec scans from Chef Automate:

1. Confirm that you have the `x_chef_event.api` role.
1. Go to **Settings** > **Notifications**.
1. Select **Create Notification**.
1. Enter a **Name** for this notification.
1. Select a **Webhook Type**. Options: **Slack**, **Webhook**, and **ServiceNow**.
1. Select **InSpec compliance scan failures** for **Failure Type**.
1. Enter the **Webhook URL** in this format: `https://ven12345.service-now.com/api/x_chef_event/inspec_scan`.
1. Enter your **ServiceNow Username**.
1. Enter your **ServiceNow Password**.

1. Select **Test Notification**. If the test passes, ServiceNow displays **Notification test connected**. If the test fails, ServiceNow displays a message with connection or credential details to help you fix the error.

   ![Chef Automate Notification for Chef InSpec Scan Failures](/images/automate/sn_event_compliance_scan_creation.png)

1. Select **Create Notification** to save this notification. A confirmation message, **Created notification "unique notification name specified"** appears.

## Uninstall

To uninstall the Event Creation App:

1. Go to **System Applications** > **Applications** in ServiceNow.
1. Open the **Downloads** tab and select the **Chef Automate Event Creation**.
1. Navigate to **Related Links**.
1. Select **Uninstall**.
