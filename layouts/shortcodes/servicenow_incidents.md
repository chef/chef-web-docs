### Chef Infra Client Incidents

To set up automatically create ServiceNow incidents for failed Chef Infra Client runs:

1. Confirm that you have the `x_chef_automate.api` role.
1. Navigate to **Settings** > **Notifications**
1. Select the **Create Notification** button.
1. Enter or select:
   * **Name**: A unique name for this notification.
   * **Webhook Type**: The product or process receiving the notification. Options: **Slack**, **Webhook**, and **ServiceNow**.
   * **Failure Type**: The Chef process for the notification. Options: **Infra Client Run failures** and **Inspec compliance scan failures**
   * **Webhook URL**: The API address that the notification uses.
   * **ServiceNow Username**: The name you use to sign in to ServiceNow.
   * **ServiceNow Password**: The password you use to sign in to ServiceNow.
1. Select **Test Connectivity**. A successful test displays **Notification test connected successfully**. An unsuccessful test displays a message with information about any connection or credential problems to help you fix the error.

   ![Chef Automate Notification for CCR Failures](/images/automate/SNOW_CCR_Setup.png)

1. Select **Create Notification** to save.

### Chef InSpec Scan Incidents

To set up automatically create ServiceNow incidents for failed Chef InSpec scans:

1. Confirm that you have the `x_chef_automate.api` role.
1. Navigate to **Settings** > **Notifications**
1. Select the **Create Notification** button.
1. Enter or select:
   * **Name**: A unique name for this notification.
   * **Webhook Type**: The product or process receiving the notification. Options: **Slack**, **Webhook**, and **ServiceNow**.
   * **Failure Type**: The Chef process for the notification. Options: **Infra Client Run failures** and **Inspec compliance scan failures**
   * **Webhook URL**: The API address that the notification uses.
   * **ServiceNow Username**: The name you use to sign in to ServiceNow.
   * **ServiceNow Password**: The password you use to sign in to ServiceNow.
1. Select **Test Connectivity**. A successful test displays **Notification test connected successfully**. An unsuccessful test displays a message with information about any connection or credential problems to help you fix the error.

   ![Chef Automate Notification for InSpec Scan Failures](/images/automate/SNOW_Scan_Setup.png)

8. Select **Create Notification** to save.
