+++
title = "Integrate Chef Automate Workflow with Slack"
draft = false

aliases = "/integrate_delivery_slack.html"

[menu]
  [menu.docs]
    title = "Workflow w/Slack"
    identifier = "legacy/chef_automate_1/workflow/integrate_delivery_slack.md Workflow w/Slack"
    parent = "legacy/chef_automate_1/workflow"
    weight = 100
+++    

[\[edit on
GitHub\]](https://github.com/chef/chef-web-docs/blob/master/chef_master/source/integrate_delivery_slack.rst)

<meta name="robots" content="noindex">

{{% chef_automate_mark %}}

{{% EOL_a1 %}}

Chef Automate may be configured to allow projects to send Slack
notifications to users about changes submitted to that project's
pipeline, such as:

-   A change passed verification
-   A change was approved by a teammate
-   A comment was added to the change request
-   A change was accepted
-   A change was delivered
-   A change failed at a specific stage in the pipeline

Integrating Chef Automate with Slack requires a webhook to be created in
Slack, and then saving that webhook in Chef Automate. A webhook may be
specified at two levels:

-   By organization. A webhook that is specified at the organization
    level enables Slack notifications for all projects that belong to
    that organization.
-   By project. A webhook that is specified at the project level enables
    Slack notifications only for that project.

{{< info >}}

Notifications sent to Slack by Chef Automate do not support retries.
Therefore, notifications sent while Slack is experiencing API issues,
outages, or some other unplanned downtime may never be received by the
channel. Undelivered notifications are not re-sent.

{{< /info >}}

Create a Webhook
================

To create a webhook in Slack:

1.  [Create an incoming
    webhook](https://slack.com/apps/A0F7XDUAZ-incoming-webhooks) in
    Slack and be sure to use the team in Slack to be associated with
    Chef Automate.
2.  Select a team, and then click the **Configure** button.
3.  Select **Add Configuration** (if that team already has at least one
    webhook) or **Install** to add a webhook.
4.  Under **Post to Channel** select the channel in Slack to which Chef
    Automate will send notifications.
5.  Click **Add Incoming Webhooks Integration**. Slack will create the
    new webhook, and then provide a location from which the URL for that
    webhook can be copied.
6.  Copy the URL.

Add a Webhook to Chef Automate
==============================

To add a Slack webhook for Chef Automate:

1.  On the Chef Automate server, select **Organizations**.
2.  Select an organization or a project.
3.  Click **Edit** to open the details for that organization or project.
4.  Pick a meaningful name for the webhook, and then paste the webhook
    URL.
5.  Click **Send a Test**. If a test notification is successful, click
    **Save**.

Disable Slack Notifications
===========================

Slack notifications are enabled by default, but they may be disabled.

1.  On the Chef Automate server, select **Organizations**.
2.  Select an organization or a project.
3.  Click **Edit** to open the details for that organization or project.
4.  De-select the **Enabled** checkbox, and then click **Save**.

Delete Slack Notifications
==========================

Slack notifications are enabled by default, but they may be disabled.

1.  On the Chef Automate server, select **Organizations**.
2.  Select an organization or a project.
3.  Click **Edit** to open the details for that organization or project.
4.  Delete the URL for the Slack webhook and click **Save** or click the
    trash can button.
