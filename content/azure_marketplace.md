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
{{< figure src="/images/az_home.png" alt="Azure Home Page" >}}

1. Select **Get it Now**.
{{< figure src="/images/az_getitnow.png" alt="Get It Now" >}}

1. Sign in to your Microsoft account with your Microsoft account email address.
  {{< figure src="/images/az_signin.png" alt="Sign In" >}}

1. Enter your password and select **Sign In**.
  {{< figure src="/images/ms_pass.png" alt="Enter Password" >}}

1. Select **Continue** to accept the Microsoft information terms.
  {{< figure src="/images/az_continue.png" alt="Continue" >}}

### Deploy Automate

1. Select **Create** to create your Chef Automate instance.
  {{< figure src="/images/az_automate_create.png" alt="Create Automate" >}}

1. Enter the project details and select **Next**:

    1. `Subscription`: Select the your subscription
    1. `Resource group`: Create new or select an existing one
    1. `Region`: Select the region for your instance

    {{< figure src="/images/az_automate_basics.png" alt="Subscription Page" >}}

1. Enter your custom settings and select **Next: Review + create** to validate your configuration.

    1. `Username`: <NAME>
    Example:`chefuser`
    1. `SSH public key`: Copy your existing public key or make a new key pair.
    1. `Size`: The vCPUs and memory for your instance. The recommended minimum is 4vCPUs and 16GB memory.Example:`Standard D4s v3`

    {{< figure src="/images/az_automate_custom_settings.png" alt=" Custom Settings" >}}

1. Review your validated configuration and select **Create** to deploy Chef Automate.
  {{< figure src="/images/az_automate_review.png" alt="Validation Page" >}}

1. Chef Automate takes about 15 minutes to deploy.
  {{< figure src="/images/az_automate_progress.png" alt="Deploy In Progress Page" >}}

1. Once the Chef Automate deployment completes, select **Go to resource group**.
  {{< figure src="/images/az_automate_complete.png" alt="Deploy Complete Page" >}}

### Connect

1. On the _Resource group_ page for your installation, select the Chef Automate virtual machine (VM), which is named `RESOURCE-GROUP-ipg6-VM`.
  {{< figure src="/images/az_automate_overview.png" alt="Overview Page" >}}

1. Locate and copy the `Public IP` on the _Virtual machine_ page. You will use this to connect to your VM.
  {{< figure src="/images/az_automate_essentials.png" alt="Deploy Description" >}}

1. From the command line, connect to your VM:

    ```bash
    ssh -i chefkey.pem chefuser@13.92.241.41
    ```

  {{< figure src="/images/az_ssh.png" alt="SSH into your instance with your Automate pem key" >}}

1. Get your Chef Automate URL and login credentials from the command line:

    ```bash
    sudo cat /root/automate-credentials.toml
    ```

    Which returns something like:

    ```toml
    url = "https://chef-automate-example.eastus.cloudapp.azure.com"
    username = "admin"
    password = "EXAMPLE1234567890abcdefghijklmno"
    ```

1. Open your favorite browser and Access the Chef Automate URL and Select **Advanced and continue as shown below**
  {{< figure src="/images/automate_insecure_page.png" alt="Insecure site warning" >}}

1. Enter your username, Password and Select **Sign In to Access Chef Automate WebUI**
  {{< figure src="/images/automate_signin.png" alt="Automate Sign In " >}}

1. Enter your name and email address, accept the Chef license, and then select **Register**
  {{< figure src="/images/automate_welcome.png" alt="Automate Welcome" >}}

1. Congratulations! You're ready to explore Chef Automate!
  {{< figure src="/images/automate_event_feed_empty.png" alt="Automate Event Feed" >}}
