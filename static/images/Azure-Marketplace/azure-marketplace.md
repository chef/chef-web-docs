# Overview

About Azure Marketplace

The Azure Marketplace image deploys Chef Automate and Chef Infrastructure Server on a shared instance that can be used with [Chef Workstation](https://docs.chef.io/workstation/) tools like `chef`, `knife`, `inspec` and `hab`. The Chef Automate stack provides the dashboard, data aggregation, and analytics layer for all Chef products.

In case you have a need of running automate in HA mode, please contact [Chef Support](https://www.chef.io/support).

please contact [Chef Support](https://www.chef.io/support).


# Test drive Deployment

- **Go to [Azure Marketplace](https://azure.microsoft.com/en-in/marketplace/) and search for this keyword `Chef Automate`** 

![MarketPlacePage](Az-marketplace-images/MarketPlacePage.png)

- **Click on `Get it Now` button as show below**

![TestDrivePage](Az-marketplace-images/TestDrivePage.png)

- **Sign in to Microsoft account with a valid `Azure portal email` address**

![SignInPage](Az-marketplace-images/SignInPage.png)

- **It will prompt you to login page, enter password and click on sign in**

![PasswordPage](Az-marketplace-images/PasswordPage.png)

- **Click on continue as shown below**

![ContinuePage](Az-marketplace-images/ContinuePage.png)

- **Click on create** 

![CreateAutomatePage](Az-marketplace-images/CreateAutomatePage.png)

- **Provide the required details as shown below and click on Next**

    - **`Subscription`: Select the required subscription**

    - **`Resource group`: Create new or Select existing one** 

    - **`Region`: Select the required region**

![SubscriptionPage](Az-marketplace-images/SubscriptionPage.png)

- **Fill the custom settings and click on Next**

    - **`Username`: <Anyname> Eg:`chefuser`**

    - **`SSH public key`: use your existing or new public key**

    - **`Size`: Select the size based on requirement Eg:`Standard D4s v3`**

![NextReviewPage](Az-marketplace-images/NextReviewPage.png)

- **Review it once and click on create to start deployment**

![ValidationPage](Az-marketplace-images/ValidationPage.png)

- **Chef Automate deployment is in progress it tooks around `15 min` to complete deployment**

![DeployInProgressPage](Az-marketplace-images/DeployInProgressPage.png)

- **Click on Go to resource group**

![DeployCompletePage](Az-marketplace-images/DeployCompletePage.png)

- **Open Chef Automate Virtual machine**

![OverviewPage](Az-marketplace-images/OverviewPage.png)

- **Copy the `Public IP` to ssh into VM

![DeployDescPage](Az-marketplace-images/DeployDescPage.png)

- **SSH into the Chef Automate VM as shown**

![SSHPage](Az-marketplace-images/SSHPage.png)

- **Execute the below command to get the Chef Automate `URL` and `login credentials`**

```bash
sudo cat /root/automate-credentials.toml
```

![AutomateCredPage](Az-marketplace-images/AutomateCredPage.png)

- **Open your favorite browser and Access the Chef Automate URL and click on Advanced and continue as shown below**

![InSecurePage](Az-marketplace-images/InSecurePage.png)

- **Enter your username, Password and click on Sign In to Access Chef Automate WebUI**

![AutomateLoginPage](Az-marketplace-images/AutomateLoginPage.png)

- **Fill the required details and click on Register**

![AutomateWelcomePage](Az-marketplace-images/AutomateWelcomePage.png)

- **Congratulations: Here is the Chef Automate WebUI you can play around with CHEF**

![AutomateEventPage](Az-marketplace-images/AutomateEventPage.png)
