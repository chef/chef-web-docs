+++
title = "AWS Marketplace"
draft = false

gh_repo = "chef-web-docs"

aliases = ["/aws_marketplace.html"]

product = ["client", "workstation"]

[menu]
  [menu.infra]
    title = "AWS Marketplace"
    identifier = "chef_infra/setup/integrations/aws_marketplace.md AWS Marketplace"
    parent = "chef_infra/setup/integrations"
    weight = 10
+++

Chef Automate is an enterprise platform that allows developers, and operations, and security engineers to collaborate to deliver application and infrastructure changes at the speed and scale modern business requires. Chef Automate provides actionable insights across data centers and cloud providers where your nodes live.

Chef Automate is the center of the modern Chef platform, providing users with a single source of truth for infrastructure, security, and application automation. The comprehensive dashboard provides real-time views of your configuration management activity. Chef Automate comes bundled with the latest Chef Infra Server, providing the core tools you need to manage your enterprise infrastructure with Chef. Data collection is enabled by default, allowing your nodes to report activity in real-time. This instance is free for 60 days or you can bring your own license (BYOL).

Use this instance with Chef Workstation installed on your laptop or a separate AWS instance.

The AWS Marketplace image deploys Chef Automate and Chef Infrastructure Server on a shared instance that can be used with [Chef Workstation](https://docs.chef.io/workstation/) tools like `chef`, `knife`, `inspec` and `hab`. The Chef Automate stack provides the dashboard, data aggregation, and analytics layer for all Chef products.

In case you have a need of running automate in HA mode, please contact [Chef Support](https://www.chef.io/support).

Please select here<hyperlink> for Automate's AWS marketplace CloudFormation template. (will not be available till image is published)

# Installation

New VPC will be created for every Cloudformation Stack deployment

Note: By default AWS provides 5 VPC's per region. If you requires more VPC please contact [AWS Support](https://aws.amazon.com/contact-us/).

### Specify the Stack Details

1. Enter the following values for your deployment.

     - Stack Name: < Any name for your reference >  `Eg: Chef-Automate`
     - EC2RootVolumeSize: < Change to req. size >  `Default: 40`
     - Instance Type: < Select EC2 Instance type > `Default: t2.xlarge`
     - KeyName: < Select your existing keypair >
     - SecurityGroupCidrIp: `Eg: 0.0.0.0/0`  (Source IP to access the Automate application through internet)
     - SubnetCIDR: `Eg: 10.0.0.0/24`  (Range for Subnet CIDR)
     - VpcCIDR: `Eg: 10.0.0.0/16`  (Range for VPC CIDR)

1. Select **Next** and create your Chef Automate deployment. This process can take several minutes.
1. Give Chef Automate an additional five minutes for all of the services to start running.

![Select next to create stack](/images/StackDetails.png "Stack Details")

# Post Installation

1. Navigate to the AWS deployment "output" tab and locate the Chef Automate URL, user name, and password. You will need these in the next steps.

![AWS Chef Automate deployment output tab contains your instance URL, user name, and password ](/images/OutputPage.png "Output Page")

- Open your browser and paste the Chef Automate URL, which will open an alert page. Select **Advanced** and continue:

![Select 'advanced' to bypass the warning that the page is not secure](/images/NotSecurePage.png "Not Secure Page")

- Enter your **Username** and **Password** and select **Sign In**

![ ](/images/AutomateUI.png "Automate")

- Fill out the registration form and [Accept the Chef License](https://docs.chef.io/chef_license_accept/). Select **Register** to enter Chef Automate.

![ ](/images/WelcomePage.png "Welcome Page")

- Congratulations! You've sucessfully started Chef Automate!

![ ](/images/DashboardsPage.png "Dashboards Page")


## Add Chef Servers

1. Add Chef-Server Details, select the Add Chef Infra Server Button

  ![ ](/images/AddChefServer.png "Add Chef Server")

1. Please fill the details and select Add Chef Infra Server
  - Name : Add Proper Name for the Sever
  - FQDN : It would be same as Automate FQDN
  - IP Address : Public IP Address of the EC2-Instance

  ![ ](/images/ChefServerDetails.png "Chef Server Details")

1. After Adding the Chef-Server

  ![ ](/images/AddChefServer01.png "Add Chef Server")

1. Select the Add Chef Organization Button

  ![ ](/images/AddOrgPage.png "Add Org Page")

1. Add Organization Details
  - Name : demo (By-default demo Organization is created)
  - Admin User : admin (For demo Organization we have user admin)
  - Admin Key : copy the key from stater kit

1. after adding the details, select the Add Chef Organization

  ![ ](/images/OrgPageDetails.png "Org Page Details")

## Update Security Group to enable SSH connection

1. Select Instance Security group under Resources section in CloudFormation stack.

![ ](/images/RecourcesPage.png "Recources Page")

1. Select Security group ID as shown below.

![ ](/images/SecurityGroup.png "Security Group")

1. Select Edit inbound rules.

![ ](/images/InBoundRules.png "Inbound Rules")


1. Select Add rule and select SSH and provide source IP and save the rules.

Note:  To access SSH securely select required source IP's.

![ ](/images/AddRule.png "Add Rule")

