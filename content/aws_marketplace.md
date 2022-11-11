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

Chef Automate is the center of the modern Chef platform, providing users with a single source of truth for infrastructure, security, and application automation. The comprehensive dashboard offers real-time views of your configuration management activity. Chef Automate comes bundled with the latest Chef Infra Server, providing the core tools you need to manage your enterprise infrastructure. Data collection is enabled by default, allowing your nodes to report activity in real time. This instance is free for 60 days, or you can bring your own license (BYOL).

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

    ![Enter required information and click next](/images/stack_details.png "Stack Details")

1. Give Chef Automate an additional five minutes for all the services to start running.

1. Configure stack options:

    - **Tags:** Create a tag that can be used to refer to your resources (for example, `Key: Name, Value: Chef-automate-stack`).
    - **Permission:** Create an IAM role with `AmazonEC2FullAccess` to enable resource creation using the cloud formation template. Once created, select the IAM role from the dropdown menu.
    - **Stack failure options:** AWS provides two option:

        - **Roll back all stack resources:** In case of failure, it should rollback all created resources (`Default: Roll back all stack resources`).
        - **Preserve successfully provisioned resources:** In case of failure, it will rollback only failed resources.

    ![Enter required information and click next](/images/configure_stack.png "Configure stack")

    - Advanced Options:

        - **Stack Policy:** It is the JSON document that defines the update actions that can be performed on designated resources (`Default: No stack policy`).
        - **Rollback Configuration:** The user can set the alarm to monitor things during stack creation or update. Users must provide a threshold time and area of their cloud watch alarm. This alarm would get triggered if the threshold breaches. Users can enter multiple alarms as well. For more information, refer to [CFN Rollback Triggers](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/using-cfn-rollback-triggers.html?icmpid=docs_cfn_console) documentation.

    - **Notification Options:** Create or attach an AWS Simple Notification Service (SNS), which would help them get all notifications about their stack creation process on their email.

    ![Enter SNS topic for notifications](/images/notification_options.png "Notification options")

    - **Stack Creation Options:** It has two options:

        1. **Timeout:** If specified and stack creation is not completed in that time, the stack rollback will happen.
        2. **Termination Protection:** You cannot delete the stack directly if enabled. You have to first update it to disabled to delete it.

    Select **Next** and create your Chef Automate deployment. This process can take several minutes.

    Give Chef Automate an additional five minutes for all the services to start running.

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

## AWS Deployment Security

Update the AWS Deployment **Security Group** to require source IP addresses for a secure SSH connection.

1. Select the **Instance Security** group in the **Resources** tab of your AWS Chef Automate deployment.
![ ](/images/aws_resources.png "Resources Page")

1. Select the **Security Group ID** for your Chef Automate deployment.
![Locate and copy your security group ID from the second column](/images/aws_security_group.png "Security Group")

1. Select **Edit inbound rules**.
![Select the Edit inbound rules button](/images/aws_inbound_rules_edit.png "Edit Inbound Rules")

1. Select **Add rule** and then **SSH** and enter the source IP.

1. Select **Save rules** to finish.
![Add your IP address range as a custom SSH rule](/images/aws_inbound_rule.png "Add Rule")
