### Chef Infra Client Incidents

To set up automatic incident reporting for failed Chef Infra Client runs:

1. Confirm that you have the `x_chef_automate.api` role.
1. Navigate to **Settings** > **Notifications**
1. Select the **Create Notification** button.
1. Enter or select:
   * **Name**: A unique name for this notification.
   * **Webhook Type**: The product or proccess receiving the notification. Options: **Slack**, **Webhook**, and **ServiceNow**.
   * **Failure Type**: The Chef process for the notification. Options: **Infra Client Run failures** and **Inspec compliance scan failures**
   * **Webhook URL**: The API address that the notification uses.
   * **ServiceNow Username**: The name you use to sign in to ServiceNow.
   * **ServiceNow Password**: The password you use to sign in to ServiceNow.
1. Select **Test Connectivity**. A successful test displays **Notification test connected successfully**. An unsuccessful test displays a message with information about any connection or credential problems to help you fix the error.

   ![Chef Automate Notification for CCR Failures](/images/automate/SNOW_CCR_Setup.png)

1. Select **Create Notification** to save the configuration details for this notification.

### Chef InSpec Scan Incidents

Follow these steps to report the failed Chef InSpec scans on node managed by Chef Automate:

1. Confirm that you have the `x_chef_automate.api` role.
2. Navigate to **Settings** from the **Chef Automate** menu.
3. Select the **Notifications** link from **General Settings** section on the left.
4. Select the **Create Notification** button.
5. Enter the following information, which are mandatory:
   * **Name**: a unique name for the failed client run notification.
   * **Webhook Type**: ServiceNow notification type. Possible values are **Slack**, **Webhook**, and **ServiceNow**.
   * **Failure Type**: select **InSpec compliance scan failures**.
   * **Webhook URL**: ServiceNow Chef InSpec scan API address.
   * **Username** and **Password**: a ServiceNow user credentials with `x_chef_automate.api` role. When you select **Webhook** type as **ServiceNow**, the app displays the **Username** and **Password** fields.
6. Select the checkbox to send the compliance scan notification only when critical control failures occurs.
7. Select the **Test Connectivity** button. The application checks that the values specified are correct and the connectivity between Chef Automate and the application establishes.

   A successful test displays the **Notification test connected successfully for com** message for compliance scan failures. Else, an error message shows detailing the connectivity or credentials issues and helps you resolve the error.

   ![Chef Automate Notification for InSpec Scan Failures](/images/automate/SNOW_Scan_Setup.png)

8. Select **Create Notification**. The app saves the configuration for the Chef Automate InSpec scans notifications.
