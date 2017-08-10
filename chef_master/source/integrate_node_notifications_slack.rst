=====================================================
Send Node Notifications to Slack
=====================================================
`[edit on GitHub] <https://github.com/chef/chef-web-docs/blob/master/chef_master/source/integrate_node_notifications_slack.rst>`__

.. tag chef_automate_mark

.. image:: ../../images/chef_automate_full.png
   :width: 40px
   :height: 17px

.. end_tag

.. tag chef_automate_beta_disclaimer

.. important:: The new functionality described in this topic is currently in Beta. To enable it in the Chef Automate UI, make sure your cursor is not in any text box or field, and type ``beta``. A new ``Notifications`` menu item will appear under the **Nodes** tab in the UI.

.. end_tag

Chef Automate may be configured to notify a particular Slack channel or user when it detects certain issues with the nodes you are managing. Currently, those issues include:

* A Chef client run failure on any node in your fleet.
* A critical InSpec compliance scan failure on any node in your fleet.

Integrating Chef Automate with Slack requires a webhook to be created in Slack, and then saving that webhook in Chef Automate. Currently, any user of Chef Automate may create and manage notifications. Notifications sent to Slack by Chef Automate will respect any outbound proxy settings
that you may have configured in your `delivery.rb` file. For more information on the proxy settings in Chef Automate, see `Proxy Settings <https://docs.chef.io/config_rb_delivery.html#proxy-settings>`_. 

.. note:: Notifications sent to Slack by Chef Automate do not support retries; therefore, notifications sent while Slack is experiencing API issues, outages, or some other unplanned downtime may never be received by the channel. Undelivered notifications are not re-sent. Attempts to send notifications do generate log messages in your Chef Automate server.

Create a Webhook
=====================================================
To create a webhook in Slack:

#. Navigate to `Incoming Webhooks <https://slack.com/apps/A0F7XDUAZ-incoming-webhooks>`__ in Slack and select the team that you want to be associated with Chef Automate.
#. Select **Add Configuration**.
#. Under **Post to Channel**, select the channel in Slack where Chef Automate will send notifications.
#. Click **Add Incoming Webhooks Integration**. Slack will create the new webhook and then provide a webhook URL for you to copy.
#. Copy the URL and click **Save Settings** at the bottom of the page to create the Slack webhook.

Add a Webhook to Chef Automate
=====================================================
To add a Slack webhook for Chef Automate:

#. On the Chef Automate server, select **Notifications** under the **Nodes** tab.
#. Click **Create Notification** and select **Add Slack notification** from the drop-down menu.
#. Pick the event you want to be notified about. Currently, you can choose to be notified on any Chef client run failures or any InSpec compliance scan failures.
#. Pick a meaningful name for the webhook, and then paste the Slack webhook URL from the previous section.
#. Click **Send Test**. If a test notification is successful, click **Save**. If the test is unsuccessful, make sure the Slack webhook URL was copied correctly and then try sending a test notification again.

Edit Slack Notifications
=====================================================
To edit a Slack webhook for Chef Automate:

#. On the Chef Automate server, select **Notifications** under the **Nodes** tab.
#. Use the navigation bar at the bottom of the page if necessary to scroll through the list of all notifications.
#. Click the pencil icon to edit the webhook and change the appropriate fields.
#. Click **Save** to store your changes.

Delete Slack Notifications
=====================================================
To delete a Slack webhook for Chef Automate:

#. On the Chef Automate server, select **Notifications** under the **Nodes** tab.
#. Use the navigation bar at the bottom of the page if necessary to scroll through the list of all notifications.
#. Click the trashcan icon and confirm your intent to delete the notification.
