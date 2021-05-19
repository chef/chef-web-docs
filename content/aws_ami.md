# Overview

The AWS Marketplace image deploys Chef Automate and Chef Infrastructure Server on a shared instance that can be used with [Chef Workstation](https://docs.chef.io/workstation/) tools like `chef`, `knife`, `inspec` and `hab`. The Chef Automate stack provides the dashboard, data aggregation, and analytics layer for all Chef products.

In case you have a need of running automate in HA mode, please contact [Chef Support](https://www.chef.io/support).

Please click here<hyperlink> for Automate's AWS marketplace Cloud formation template. (will not be available till image is published)

# Installation

**New VPC will be created for every Cloudformation Stack deployment** 

Note: By default AWS provides 5 VPC's per region. If you requires more VPC please contact [AWS Support](https://aws.amazon.com/contact-us/).

### Specify the Stack Details

- **Fill the below required parameter values at the time of deployment.**

     - Stack Name: < Any name for your reference >  `Eg: Chef-Automate`

     - EC2RootVolumeSize: < Change to req. size >  `Default: 40` 

     - Instance Type: < Select EC2 Instance type > `Default: t2.xlarge`

     - KeyName: < Select your existing keypair >

     - SecurityGroupCidrIp: `Eg: 0.0.0.0/0`  (Source IP to access the Automate application through internet)

     - SubnetCIDR: `Eg: 10.0.0.0/24`  (Range for Subnet CIDR)

     - VpcCIDR: `Eg: 10.0.0.0/16`  (Range for VPC CIDR)

- **Click on Next and review once and then create stack**

![image01](Images/StackDetails.png)

- **Wait for few minutes to complete the Stack creation**

![image02](Images/EventPage.png)

# Post Installation

- **Go to Stack Outputs Section where you found Chef Automate URL and login credentials to access the WebUI**

**Note:** After Successful Stack creation wait for 5 minutes so that all the automate services come to running state.

![image03](Images/OutputPage.png)

- **Open your favorite browser and Access the Chef Automate URL and click on Advanced and continue as shown below**

![image04](Images/NotSecurePage.png)

- **Enter your username, Password and click on Sign In to Access Chef Automate WebUI**

**Note:**  your login credentials will be displayed on Outputs Section in cloudformation as shown above

![image05](Images/AutomateUI.png)

- **Fill the required details and click on Register**

![image06](Images/WelcomePage.png)

- **Congratulations: Here is the Chef Automate WebUI you can play around with CHEF**

![image07](Images/DashboardsPage.png)

- Add Chef-Server Details, Click On the **Add Chef Infra Server** Button 
  ![1.AddChefServer.png](Images/AddChefServer.png)
  
  Please fill the details and Click On **Add Chef Infra Server**
  - Name : Add Proper Name for the Sever
  - FQDN : It would be same as Automate FQDN
  - IP Address : Public IP Address of the EC2-Instance
  ![2.ChefServerDetails.png](Images/ChefServerDetails.png)  
  
  After Adding the Chef-Server
  ![3.AddChefServer01.png](Images/AddChefServer01.png)
  
  Click on the **Add Chef Organization** Button 
  ![4.AddOrgPage.png](Images/AddOrgPage.png)
  
  Add Organization Details
  - Name : demo (By-default **demo** Organization is created)
  - Admin User : admin (For **demo** Organization we have user **admin**)
  - Admin Key : copy the key from stater kit 
  
  after adding the details click on the **Add Chef Organization** 
  ![5..OrgPageDetails.png](Images/OrgPageDetails.png)
  
  
### Update Security Group to enable SSH connection

- **Click on Instance Security group under Resources section in cloud formation stack.**

![image08](Images/RecourcesPage.png)

- **Click on Security group ID as shown below.**

![image09](Images/SecurityGroup.png)

- **Click on Edit inbound rules.**

![image10](Images/InBoundRules.png)

- **Click on Add rule and select SSH and provide source IP and save the rules.**

**Note:**  To access SSH securely select required source IP's. 

![image11](Images/AddRule.png)
