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

![MarketPlacePage](/images/Az-marketplace-images/MarketPlacePage.png)

- **Select on `Get it Now` button as show below**

![TestDrivePage](/images/Az-marketplace-images/TestDrivePage.png)

- **Sign in to Microsoft account with a valid `Azure portal email` address**

![SignInPage](/images/Az-marketplace-images/SignInPage.png)

- **It will prompt you to login page, enter password and select on sign in**

![PasswordPage](/images/Az-marketplace-images/PasswordPage.png)

- **Select on continue as shown below**

![ContinuePage](/images/Az-marketplace-images/ContinuePage.png)

- **Select on create**

![CreateAutomatePage](/images/Az-marketplace-images/CreateAutomatePage.png)

- **Provide the required details as shown below and select on Next**

    - **`Subscription`: Select the required subscription**
    - **`Resource group`: Create new or Select existing one**
    - **`Region`: Select the required region**

![SubscriptionPage](/images/Az-marketplace-images/SubscriptionPage.png)

- **Fill the custom settings and select on Next**

    - **`Username`: <Anyname> Eg:`chefuser`**
    - **`SSH public key`: use your existing or new public key**
    - **`Size`: Select the size based on requirement Eg:`Standard D4s v3`**

![NextReviewPage](Az-marketplace-images/NextReviewPage.png)

- **Review it once and select on create to start deployment**

![ValidationPage](Az-marketplace-images/ValidationPage.png)

- **Chef Automate deployment is in progress it tooks around `15 min` to complete deployment**

![DeployInProgressPage](/images/Az-marketplace-images/DeployInProgressPage.png)

- **Select on Go to resource group**

![DeployCompletePage](/images/Az-marketplace-images/DeployCompletePage.png)

- **Open Chef Automate Virtual machine**

![OverviewPage](/images/Az-marketplace-images/OverviewPage.png)

- **Copy the `Public IP` to ssh into VM

![DeployDescPage](/images/Az-marketplace-images/DeployDescPage.png)

- **SSH into the Chef Automate VM as shown**

![SSHPage](/images/Az-marketplace-images/SSHPage.png)

- **Execute the below command to get the Chef Automate `URL` and `login credentials`**

```bash
sudo cat /root/automate-credentials.toml
```

![AutomateCredPage](/images/Az-marketplace-images/AutomateCredPage.png)

- **Open your favorite browser and Access the Chef Automate URL and select on Advanced and continue as shown below**

![InSecurePage](/images/Az-marketplace-images/InSecurePage.png)

- **Enter your username, Password and select on Sign In to Access Chef Automate WebUI**

![AutomateLoginPage](/images/Az-marketplace-images/AutomateLoginPage.png)

- **Fill the required details and select on Register**

![AutomateWelcomePage](/images/Az-marketplace-images/AutomateWelcomePage.png)

- **Congratulations: Here is the Chef Automate WebUI you can play around with CHEF**

![AutomateEventPage](/images/Az-marketplace-images/AutomateEventPage.png)
