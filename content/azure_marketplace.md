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

- **Go to [Azure Marketplace](https://azure.microsoft.com/marketplace/) and search for this keyword `Chef Automate`**

![MarketPlacePage](/images/az_home.png)

- **Select on `Get it Now` button as show below**

![TestDrivePage](/images/az_getitnow.png)

- **Sign in to Microsoft account with a valid `Azure portal email` address**

![SignInPage](/images/az_signin.png)

- **It will prompt you to login page, enter password and select on sign in**

![PasswordPage](/images/ms_signin.png)

- **Select on continue as shown below**

![ContinuePage](/images/az_continue.png)

- **Select on create**

![CreateAutomatePage](/images/az_automate_create.png)

- **Provide the required details as shown below and select on Next**

    - **`Subscription`: Select the required subscription**
    - **`Resource group`: Create new or Select existing one**
    - **`Region`: Select the required region**

![SubscriptionPage](/images/az_automate_basics.png)

- **Fill the custom settings and select on Next**

    - **`Username`: <Anyname> Eg:`chefuser`**
    - **`SSH public key`: use your existing or new public key**
    - **`Size`: Select the size based on requirement Eg:`Standard D4s v3`**

![NextReviewPage](/images/az_automate_custom_settings.png)

- **Review it once and select on create to start deployment**

![ValidationPage](/images/az_automate_review.png)

- **Chef Automate deployment is in progress it tooks around `15 min` to complete deployment**

![DeployInProgressPage](/images/az_automate_progress.png)

- **Select on Go to resource group**

![DeployCompletePage](/images/az_automate_complete.png)

- **Open Chef Automate Virtual machine**

![OverviewPage](/images/az_automate_overview.png)

- **Copy the `Public IP` to ssh into VM

![DeployDescPage](/images/az_automate_essentials.png)

- **SSH into the Chef Automate VM as shown**

![SSHPage](/images/az_ssh.png)

- **Execute the below command to get the Chef Automate `URL` and `login credentials`**

```bash
sudo cat /root/automate-credentials.toml
```

Which returns something like:

```
TODO: Fill this codesample in
```

- **Open your favorite browser and Access the Chef Automate URL and select on Advanced and continue as shown below**

![automate_insecure_page](/images/automate_insecure_page.png)

- **Enter your username, Password and select on Sign In to Access Chef Automate WebUI**

![Automate Login Page](/images/automate_signin.png)

- **Fill the required details and select on Register**

![AutomateWelcomePage](/images/automate_welcome.png)

- **Congratulations: Here is the Chef Automate WebUI you can play around with CHEF**

![Automate Event Feed](/images/automate_event_feed_empty.png)
