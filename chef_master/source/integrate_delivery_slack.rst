.. THIS PAGE IS IDENTICAL TO docs.chef.io/integrate_delivery_slack.html BY DESIGN
.. THIS PAGE IS LOCATED AT THE /delivery/ PATH.

=====================================================
Integrate Chef Automate with |slack|
=====================================================

.. include:: ../../includes_chef_automate/includes_chef_automate_mark.rst 

|automate| may be configured to allow projects to send |slack| notifications to users about changes submitted to that project's pipeline, such as:

* A change passed verification
* A change was approved by a teammate
* A comment was added to the change request
* A change was accepted
* A change was delivered
* A change failed at a specific stage in the pipeline

Integrating |automate| with |slack| requires a webhook to be created in |slack|, and then saving that webhook in |automate|. A webhook may be specified at two levels:

* By organization. A webhook that is specified at the organization level enables |slack| notifications for all projects that belong to that organization. 
* By project. A webhook that is specified at the project level enables |slack| notifications only for that project. 

.. note:: Notifications sent to |slack| by |automate| do not support retries. Therefore, notifications sent while |slack| is experiencing API issues, outages, or some other unplanned downtime may never be received by the channel. Undelivered notifications are not re-sent.

Create a Webhook
=====================================================
To create a webhook in |slack|:

#. `Create an incoming webhook <https://slack.com/apps/A0F7XDUAZ-incoming-webhooks>`__ in |slack| and be sure to use the team in |slack| to be associated with |automate|.
#. Select a team, and then click the **Configure** button.
#. Select **Add Configuration** (if that team already has at least one webhook) or **Install** to add a webhook.
#. Under **Post to Channel** select the channel in |slack| to which |automate| will send notifications.
#. Click **Add Incoming Webhooks Integration**. |slack| will create the new webhook, and then provide a location from which the URL for that webhook can be copied.
#. Copy the URL.


Add a Webhook to |automate|
=====================================================
To add a |slack| webhook for |automate|:

#. On the |automate| server, select **Organizations**.
#. Select an organization or a project.
#. Click **Edit** to open the details for that organization or project.
#. Pick a meaningful name for the webhook, and then paste the webhook URL.
#. Click **Send a Test**. If a test notification is successful, click **Save**.


Disable |slack| Notifications
=====================================================
|slack| notifications are enabled by default, but they may be disabled.

#. On the |automate| server, select **Organizations**.
#. Select an organization or a project.
#. Click **Edit** to open the details for that organization or project.
#. De-select the **Enabled** checkbox, and then click **Save**.

Delete |slack| Notifications
=====================================================
|slack| notifications are enabled by default, but they may be disabled.

#. On the |automate| server, select **Organizations**.
#. Select an organization or a project.
#. Click **Edit** to open the details for that organization or project.
#. Delete the URL for the |slack| webhook and click **Save** or click the trash can button.
