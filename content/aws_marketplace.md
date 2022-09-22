+++
title = "AWS Marketplace"
draft = false

gh_repo = "chef-web-docs"

aliases = ["/aws_marketplace.html", "/aws_ami.html"]

product = ["client", "workstation", "automate"]

[menu]
  [menu.infra]
    title = "AWS Marketplace"
    identifier = "chef_infra/integrations/aws_marketplace.md AWS Marketplace"
    parent = "chef_infra/integrations"
    weight = 10
+++

Chef Automate is an enterprise platform that allows developers, operations, and security engineers to collaborate on application and infrastructure changes with speed and at scale. Chef Automate provides actionable insights across data centers and cloud providers, wherever your nodes live.

Chef Automate is the center of the modern Chef platform, providing users with a single source of truth for infrastructure, security, and application automation. The comprehensive dashboard provides real-time views of your configuration management activity. Chef Automate comes bundled with the latest Chef Infra Server, providing the core tools you need to manage your enterprise infrastructure. Data collection is enabled by default, allowing your nodes to report activity in real-time. This instance is free for 60 days or you can bring your own license (BYOL).

Use this instance with Chef Workstation installed on your laptop or a separate AWS instance.

{{% workstation %}}

{{% automate_ha_support %}}

## Installation

Select [Chef Automate](https://aws.amazon.com/marketplace/pp/prodview-r26bs6uknftps?ref_=srh_res_product_title) in the AWS Marketplace.

The Chef Automate AWS deployment uses [CloudFormation](https://aws.amazon.com/cloudformation/). [Download the CloudFormation template](https://aws-ami-chef-automate-v2.s3.amazonaws.com/cloudformation_template.yaml) or use the [view the template in CloudFormation Designer](https://console.aws.amazon.com/cloudformation/designer/home?templateURL=https://s3.amazonaws.com/awsmp-fulfillment-cf-templates-prod/658820ac-955d-4f73-bbcd-ab19b598d852/ec282ef4e8434b46a9df737571e1e0ac.template)

Every CloudFormation Stack deployment creates a new [Virtual Private Cloud](https://docs.aws.amazon.com/vpc/latest/userguide/what-is-amazon-vpc.html) (VPC).

{{< note >}}
AWS provides 5 VPCs for each region. If you require more VPCs, please contact [AWS Support](https://aws.amazon.com/contact-us/).
{{< /note >}}

### Start Chef Automate with CloudFormation

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

1. Navigate to the AWS deployment **Outputs** tab and locate the Chef Automate URL, user name, and password. You will need these in the next steps.
![AWS Chef Automate deployment **Outputs** tab contains your instance URL, user name, and password ](/images/OutputPage.png "Output")

1. Open your browser and paste the Chef Automate URL, which will open an alert page.

1. Select **Advanced** and continue.
![Select 'advanced' to bypass the warning that the page is not secure](/images/NotSecurePage.png "Not Secure Page").

1. Enter your **Username** and **Password** and select **Sign In**.
![ ](/images/chef_automate_login.png "Chef Automate Login")

1. Fill out the registration form and [Accept the Chef License](https://docs.chef.io/chef_license_accept/).

1. Select **Register** to enter Chef Automate.
![ ](/images/WelcomePage.png "Welcome Page")

1. Congratulations! You've started Chef Automate!
![ ](/images/DashboardsPage.png "Dashboards Page")

## Add Chef Servers

1. Add Chef-Server Details, select the Add Chef Infra Server Button.
![ ](/images/chef_automate_add_server.png "Add Chef Server")

1. Enter the server name, FQDN, and IP address. Then select **Add Chef Infra Server** to create the server.

    - Name: Add Proper Name for the Sever.
    - FQDN: It would be the same as Automate FQDN.
    - IP Address: Public IP Address of the EC2-Instance.

    ![Add Chef Infra Server Form](/images/automate/add-chef-server-popup-menu.png)

1. The Chef Infra Server will appear in the list of servers. Select the server and view information about it.
![Select a server from the list](/images/chef_automate_single_server.png "Single Server View")

1. Select **Add Chef Organization**.
{{< figure src="/images/chef_automate_add_org_page.png" style="width: 30%;" >}}

1. Enter the following information:

    - Name: **demo**
    - Admin User: **admin**
    - Admin Key: _copy the key from starter kit_

1. Select **Add Chef Organization**.
![Select the Add Chef Organization button to complete this action](/images/OrgPageDetails.png)

## AWS EC2 Access

The AWS EC2 instance connect functionality can be used to access the EC2 machine. It is recommended to use the same instead of SSH to the EC2 machine.

1. Select the EC2 machine and select the connect option as shown below:

    ![Add Chef Infra Server Form](/images/automate/select-connect-option-in-ec2machine.png)

1. Select **Connect** button on the new screen shown below:

    ![Add Chef Infra Server Form](/images/automate/select-button-on-ec2machine.png)

The above action will launch a new tab for EC2 connect page, as shown below:

![Add Chef Infra Server Form](/images/automate/new-tab-of-ec2-machine.png)

Now, you are into the EC2 machine, where you can run necessary commands.

## FAQs

### Data Storage in machine

The chef automate deployment uses EBS volume, which is attached to an EC2 instance. This EBS volume is created as part of the cloud formation template. This storage is used to store data as part of automate.

Also, on this EC2, we have Postgres and OpenSearch Database running where customers’ data is stored. Instead of existing DBs, customers can also configure external databases (Postgres and OpenSearch)based on these configurations [guidelines of Automate](https://docs.chef.io/automate/managed_services/)

### Data encryption configuration

The current setup uses EBS for data storage. The current encryption configuration is set as disabled for EBS volumes. We are planning to update the encryption configuration to enable it.

### Monitoring

Click [here](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/monitoring_ec2.html) for the reference of EC2 monitoring guide.

### Backup

Step-wise instructions for data and Configuration backup for automate can be found [here](https://docs.chef.io/automate/backup/)

The command shown below gives you the data and configuration backup. Use the below command along with the details on the flag option.

```sh
chef-automate backup
```

Click [here](https://docs.chef.io/automate/cli_chef_automate/#chef-automate-backup) to know more on Chef Automate Backup.

### Secure Access to the Machine

We do not require credential-based access to EC2 machines; hence it is recommended to utilize EC2 Instance Connect functionality. Click [here](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/AccessingInstances.html) to refer to the guide of EC2 Instance Connect.

### AWS EC2 service limit

Refer to [EC2 service limit](https://docs.aws.amazon.com/general/latest/gr/ec2-service.html#limits_ec2) link.
