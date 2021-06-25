+++
title = "Azure Marketplace"
draft = false

gh_repo = "chef-web-docs"

aliases = ["/azure_portal"]

product = ["client", "workstation", "automate"]

[menu]
  [menu.infra]
    title = "Azure Marketplace"
    identifier = "chef_infra/integrations/azure/azure_marketplace"
    parent = "chef_infra/integrations/azure"
    weight = 10
+++

{{% azure_marketplace %}}

{{% workstation %}}

{{% automate_ha_support %}}

## Marketplace Deployment

The **Marketplace Deployment** is a test-level Chef Automate environment. This deployment requires an Azure account or subscription. You can provision Chef Automate directly from Azure. This Chef Automate solution requires that you bring your own license (BYOL). New users may try this solution for up to 60 days. Contact us at amp@chef.io to obtain a license.

### Get Started

1. Navigate to Chef Automate on the [Azure Marketplace](https://azuremarketplace.microsoft.com/marketplace/apps/chef-software.chef-automate).


1. Select **Get it Now**.
  ![Get It Now](/images/az_getitnow.png)

1. Sign in to your Microsoft account with your Microsoft account email address.
  ![SignIn](/images/az_signin.png)

1. Enter your password and select **Sign In**.
  ![Enter Password](/images/ms_pass.png)

1. Select **Continue** to accept the Microsoft information terms.
  ![Continue](/images/az_continue.png)

### Create Automate

1. Select **Create** to create your Chef Automate instance.
  ![CreateAutomate](/images/az_automate_create.png)

1. Enter the project details and select **Next**:

    1. `Subscription`: Select the your subscription
    1. `Resource group`: Create new or select an existing one
    1. `Region`: Select the region for your instance

    ![SubscriptionPage](/images/az_automate_basics.png)

1. Enter your custom settings and select **Next: Review + create** to validate your configuration.

    1. `Username`: <NAME>.Example:`chefuser`
    1. `SSH public key`: Copy your existing public key or make a new key pair.
    1. `Size`: The vCPUs and memory for your instance. The recommended minimum is 4vCPUs and 16GB memory.Example:`Standard D4s v3`

    ![NextReviewPage](/images/az_automate_custom_settings.png)

1. Review your validated configuration and select **Create** to deploy Chef Automate.
  ![ValidationPage](/images/az_automate_review.png)

1. Chef Automate takes about 15 minutes to deploy.
  ![DeployInProgressPage](/images/az_automate_progress.png)

1. Once the Chef Automate deployment completes, select **Go to resource group**.
  ![DeployCompletePage](/images/az_automate_complete.png)

### Connect

1. On the _Resource group_ page for your installation, select the Chef Automate virtual machine (VM), which is named `RESOURCE-GROUP-ipg6-VM`.
  ![OverviewPage](/images/az_automate_overview.png)

1. Locate and copy the `Public IP` on the _Virtual machine_ page. You will use this to connect to your VM.
  ![DeployDescPage](/images/az_automate_essentials.png) -->

1. From the command line, connect to your VM:

    ```bash
    ssh -i chefkey.pem chefuser@13.92.241.41
    ```

  ![SSHPage](/images/az_ssh.png)`

1. Execute the below command to get the Chef Automate `URL` and `login credentials`

    ```bash
    sudo cat /root/automate-credentials.toml
    ```

    Which returns something like:

    ```
    url = "https://chef-automate-example.eastus.cloudapp.azure.com"
    username = "admin"
    password = "EXAMPLE1234567890abcdefghijklmno"
    ```

1. Open your favorite browser and Access the Chef Automate URL and Select **Advanced and continue as shown below**
  ![automate_insecure_page](/images/automate_insecure_page.png)

1. Enter your username, Password and Select **Sign In to Access Chef Automate WebUI**
  ![Automate Login Page](/images/automate_signin.png)

1. Fill the required details and Select **Register**
  ![AutomateWelcomePage](/images/automate_welcome.png)

1. Congratulations: Here is the Chef Automate WebUI you can play around with CHEF**
  ![Automate Event Feed](/images/automate_event_feed_empty.png)
