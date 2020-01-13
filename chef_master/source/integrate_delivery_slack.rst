.. THIS PAGE IS IDENTICAL TO docs.chef.io/integrate_delivery_slack.html BY DESIGN
.. THIS PAGE IS LOCATED AT THE /delivery/ PATH.

=====================================================
Integrate Chef Automate Workflow with Slack
=====================================================
`[edit on GitHub] <https://github.com/chef/chef-web-docs/blob/master/chef_master/source/integrate_delivery_slack.rst>`__

.. meta:: 
    :robots: noindex 

.. tag chef_automate_mark

.. image:: ../../images/a2_docs_banner.svg
   :target: https://automate.chef.io/docs

.. end_tag


.. tag EOL_a1

.. danger:: This documentation applies to a deprecated product </versions.html#deprecated-products-and-versions>`__. The new Chef Automate includes newer out-of-the-box compliance profiles, an improved compliance scanner with total cloud scanning functionality, better visualizations, role-based access control and many other features. The new Chef Automate is included as part of the Chef Automate license agreement and is `available via subscription <https://www.chef.io/pricing/>`_.

.. end_tag

Chef Automate may be configured to allow projects to send Slack notifications to users about changes submitted to that project's pipeline, such as:

* A change passed verification
* A change was approved by a teammate
* A comment was added to the change request
* A change was accepted
* A change was delivered
* A change failed at a specific stage in the pipeline

Integrating Chef Automate with Slack requires a webhook to be created in Slack, and then saving that webhook in Chef Automate. A webhook may be specified at two levels:

* By organization. A webhook that is specified at the organization level enables Slack notifications for all projects that belong to that organization.
* By project. A webhook that is specified at the project level enables Slack notifications only for that project.

.. note:: Notifications sent to Slack by Chef Automate do not support retries. Therefore, notifications sent while Slack is experiencing API issues, outages, or some other unplanned downtime may never be received by the channel. Undelivered notifications are not re-sent.

Create a Webhook
=====================================================
To create a webhook in Slack:

#. `Create an incoming webhook <https://slack.com/apps/A0F7XDUAZ-incoming-webhooks>`__ in Slack and be sure to use the team in Slack to be associated with Chef Automate.
#. Select a team, and then click the **Configure** button.
#. Select **Add Configuration** (if that team already has at least one webhook) or **Install** to add a webhook.
#. Under **Post to Channel** select the channel in Slack to which Chef Automate will send notifications.
#. Click **Add Incoming Webhooks Integration**. Slack will create the new webhook, and then provide a location from which the URL for that webhook can be copied.
#. Copy the URL.

Add a Webhook to Chef Automate
=====================================================
To add a Slack webhook for Chef Automate:

#. On the Chef Automate server, select **Organizations**.
#. Select an organization or a project.
#. Click **Edit** to open the details for that organization or project.
#. Pick a meaningful name for the webhook, and then paste the webhook URL.
#. Click **Send a Test**. If a test notification is successful, click **Save**.

Disable Slack Notifications
=====================================================
Slack notifications are enabled by default, but they may be disabled.

#. On the Chef Automate server, select **Organizations**.
#. Select an organization or a project.
#. Click **Edit** to open the details for that organization or project.
#. De-select the **Enabled** checkbox, and then click **Save**.

Delete Slack Notifications
=====================================================
Slack notifications are enabled by default, but they may be disabled.

#. On the Chef Automate server, select **Organizations**.
#. Select an organization or a project.
#. Click **Edit** to open the details for that organization or project.
#. Delete the URL for the Slack webhook and click **Save** or click the trash can button.
