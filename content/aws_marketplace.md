+++
title = "AWS Marketplace"
draft = false

gh_repo = "chef-web-docs"

aliases = ["/aws_marketplace.html", "/aws_ami.html"]

product = ["client", "workstation"]

[menu]
  [menu.infra]
    title = "AWS Marketplace"
    identifier = "chef_infra/setup/integrations/aws_marketplace.md AWS Marketplace"
    parent = "chef_infra/setup/integrations"
    weight = 10
+++

Chef Automate is an enterprise platform that allows developers, operations, and security engineers to collaborate on application and infrastructure changes with speed and at scale. Chef Automate provides actionable insights across data centers and cloud providers, wherever your nodes live.

Chef Automate is the center of the modern Chef platform, providing users with a single source of truth for infrastructure, security, and application automation. The comprehensive dashboard provides real-time views of your configuration management activity. Chef Automate comes bundled with the latest Chef Infra Server, providing the core tools you need to manage your enterprise infrastructure. Data collection is enabled by default, allowing your nodes to report activity in real-time. This instance is free for 60 days or you can bring your own license (BYOL).

Use this instance with Chef Workstation installed on your laptop or a separate AWS instance.

{{% workstation %}}

If you need to run Automate with a high availability (HA) topology, please contact [Chef Support](https://www.chef.io/support).

## Installation

Select the Chef Automate AWS Marketplace [CloudFormation template](https://aws.amazon.com/marketplace/pp/prodview-r26bs6uknftps?ref_=srh_res_product_title).

Every CloudFormation Stack deployment creates a new [Virtual Private Cloud](https://docs.aws.amazon.com/vpc/latest/userguide/what-is-amazon-vpc.html) (VPC).

{{< note >}}
AWS provides 5 VPCs per region. If you require more VPCs, please contact [AWS Support](https://aws.amazon.com/contact-us/).
{{< /note >}}

### Specify the Stack Details

1. Enter the following values for your deployment.

     - Stack Name: `Chef-Automate`
     - EC2RootVolumeSize: `Default: 40`
     - Instance Type:`Default: t2.xlarge`
     - KeyName: _Enter your existing keypair_
     - SecurityGroupCidrIp: `0.0.0.0/0`
     - SubnetCIDR: `10.0.0.0/24`
     - VpcCIDR: `10.0.0.0/16`

1. Select **Next** and create your Chef Automate deployment. This process can take several minutes.

1. Give Chef Automate an additional five minutes for all the services to start running.

![Select next to create stack](/images/StackDetails.png "Stack Details")

## Post-Installation

1. Navigate to the AWS deployment **output** tab and locate the Chef Automate URL, user name, and password. You will need these in the next steps.

![AWS Chef Automate deployment output tab contains your instance URL, user name, and password ](/images/OutputPage.png "Output Page")

- Open your browser and paste the Chef Automate URL, which will open an alert page.

- Select **Advanced** and continue.

![Select 'advanced' to bypass the warning that the page is not secure](/images/NotSecurePage.png "Not Secure Page").

- Enter your **Username** and **Password** and select **Sign In**.

![ ](/images/AutomateUI.png "Automate")

- Fill out the registration form and [Accept the Chef License](https://docs.chef.io/chef_license_accept/).

- Select **Register** to enter Chef Automate.

![ ](/images/WelcomePage.png "Welcome Page")

- Congratulations! You've started Chef Automate!

![ ](/images/DashboardsPage.png "Dashboards Page")

## Add Chef Servers

1. Add Chef-Server Details, select the Add Chef Infra Server Button.

  ![ ](/images/AddChefServer.png "Add Chef Server")

1. Enter the server name, FQDN, and IP address. Then select **Add Chef Infra Server** to create the server.

    - Name: Add Proper Name for the Sever.
    - FQDN: It would be the same as Automate FQDN.
    - IP Address: Public IP Address of the EC2-Instance.

  <img src="/images/ChefServerDetails.png" style="width: 30%" />

1. The Chef Infra Server will appear in the list of servers. Select the server and view information about it.

  ![ ](/images/AddChefServer01.png "Add Chef Server")

1. Select **Add Chef Organization**.

  ![ ](/images/AddOrgPage.png "Add Org Page")

1. Enter the following information:

    - Name: **demo**
    - Admin User: **admin**
    - Admin Key: _copy the key from starter kit_

1. Select **Add Chef Organization**.

  {{< figure src="/images/automate/add-chef-organization-popup-menu.png" width="500" alt="Add Chef Organization Form">}}

## AWS Deployment Security

Update the AWS Deployment **Security Group** to require source IP addresses for a secure SSH connection.

1. Select the **Instance Security** group in the **Resources** tab of your AWS Chef Automate deployment.

![ ](/images/ResourcesPage.png "Resources Page")

1. Select the **Security Group ID** for your Chef Automate deployment.

![ ](/images/SecurityGroup.png "Security Group")

1. Select **Edit inbound rules**.

![ ](/images/InBoundRules.png "Inbound Rules")

1. Select **Add rule** and then **SSH** and enter the source IP.

1. Select **Save rules** to finish.

![ ](/images/AddRule.png "Add Rule")
