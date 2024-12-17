+++
title = "Azure Test Drive"
draft = false

gh_repo = "chef-web-docs"

product = ["client", "workstation", "automate"]

[menu]
  [menu.infra]
    title = "Azure Test Drive"
    identifier = "chef_infra/integrations/azure/azure_testdrive"
    parent = "chef_infra/integrations/azure"
    weight = 10
+++

{{< readfile file="content/reusable/md/azure_marketplace.md" >}}

{{< readfile file="content/reusable/md/workstation.md" >}}

{{< readfile file="content/reusable/md/automate_ha_support.md" >}}

## Test Drive

A **Test Drive** is a ready-to-go environment that allows you to experience Chef Automate for free, without an Azure subscription (You will need a [Microsoft account](https://signup.live.com/). The Test Drive comes already provisioned---you don't need to download, set up, or configure it---instead, you can spend two hours evaluating the user experience, key features, and benefits of the product.

### Get Started

1. Navigate to Chef Automate on the [Azure Marketplace](https://azuremarketplace.microsoft.com/en-us/marketplace/apps/chef-software.chef-automate).
  {{< figure src="/images/az_home.png" alt="Azure Home Page" >}}

1. Select **Test Drive**.
  {{< figure src="/images/az_testdrive.png" alt="Test Drive" >}}

1. Sign in with your Microsoft account email address.
  {{< figure src="/images/az_signin.png" alt="Sign In" >}}

1. Enter your password and select **Sign In**.
  {{< figure src="/images/ms_pass.png" alt="Enter Password" >}}

1. Select **Continue** to accept the Microsoft information terms.
  {{< figure src="/images/az_test_continue.png" alt=" Agree to MS information use policy and select continue" >}}

### Deploy Automate

1. Chef Automate deploys automatically. It takes about 15 minutes to finish.
  {{< figure src="/images/az_test_progress.png" alt="Deploy In Progress" >}}

1. Once Chef Automate deploys, you have **2 hours** to explore.
  {{< figure src="/images/az_test_ready.png" alt="Chef Automate Deployed" >}}

### Connect

1. Within 5 minutes of the Chef Automate deployment, you will receive an email with your username, password, and the URL for your deployment.
  {{< figure src="/images/az_test_goto.png" alt="GoToTDPage" >}}

1. Open your browser and access the Chef Automate URL and select Advanced and continue as shown below
  {{< figure src="/images/automate_insecure_page.png" alt="insecure site warning" >}}

1. Enter your username, password from the email and select **Sign In** to Access Chef Automate
  {{< figure src="/images/automate_signin.png" alt="automate_signin" >}}

1. Enter your name and email address, accept the Chef license, and then select **Register**
  {{< figure src="/images/automate_welcome.png" alt="AutomateWelcomePage" >}}

1. Congratulations! You're ready to explore Chef Automate!
  {{< figure src="/images/automate_event_feed_empty.png" alt="automate_event_feed" >}}
