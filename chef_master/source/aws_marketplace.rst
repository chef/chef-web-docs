=====================================================
|amazon aws marketplace|
=====================================================

|company_name| provides a fully licensed |amazon ami| for the |chef server| and |chef compliance| that can be launched from the `AWS Marketplace <https://aws.amazon.com/marketplace/seller-profile/ref=srh_res_product_vendor?ie=UTF8&id=e7b7691e-634a-4d35-b729-a8b576175e8c>`__. Billing is done through your |amazon aws| account on an hourly basis and is dynamically updated to reflect current node usage.


|chef server_title| AMI
=====================================================
Follow the steps in the sections below to install the |chef server| in |amazon aws marketplace|.

Launch the AMI
-----------------------------------------------------

To get a fully-functional Amazon Machine Images (AMI) for Chef server, do the following:

#. Login to the `AWS Marketplace <https://aws.amazon.com/marketplace>`__ using your Amazon Web Services (AWS) account credentials
#. Navigate to the Chef server `product page <https://aws.amazon.com/marketplace/pp/B01AMIH01Q>`__ and accept the software terms
#. Navigate to the `IAM Role section in the AWS console <https://console.aws.amazon.com/iam/home#roles>`__
   
   Create a new role for your marketplace instance with the 'Amazon Ec2' service type and attach the 'AWSMarketplaceFullAccess' policy.

   .. note:: You can skip creating a role if you're launching from the IC Marketplace
   
#. Navigate back to the Chef server `product page <https://aws.amazon.com/marketplace/pp/B01AMIH01Q>`__ and continue to the launch wizard.
#. Click the 'Launch with Ec2 Console' button next to the desired region
   
   Configure the Amazon EC2 instance type, Amazon Virtual Private Cloud (VPC) settings, SSH key pair, IAM Role and assign `a public IP address <http://docs.aws.amazon.com/AWSEC2/latest/UserGuide/using-instance-addressing.html#concepts-public-addresses>`__.
   
   .. note:: You must assign the previously created IAM role or another role with full marketplace access unless you're launching from the IC Marketplace
   
   Optionally add additional storage or increase the root volume size.
   
   Configure security group to include the required ports for access.

   .. note:: Your security group should allow access from your workstation on ports 22, 443 and 8443

#. Launch Amazon Machine Images (AMI)


Install the |chef dk_title|
-----------------------------------------------------
.. include:: ../../includes_cloud/includes_cloud_aws_chef_server_install_dk.rst

Configure the |chef server_title|
-----------------------------------------------------
.. include:: ../../includes_cloud/includes_cloud_aws_chef_server_configure.rst

Configure the workstation
-----------------------------------------------------
.. include:: ../../includes_cloud/includes_cloud_aws_chef_workstation_configure.rst

Troubleshooting
-----------------------------------------------------

Required ports
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_server_firewalls_and_ports/includes_server_firewalls_and_ports_aws.rst

Change the hostname
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_cloud/includes_cloud_aws_chef_server_update_hostname.rst

Change instance size
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_cloud/includes_cloud_aws_chef_server_change_instance.rst

Upgrade the |chef server_title|
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_cloud/includes_cloud_aws_chef_server_upgrade_software.rst

Migrate to AWS
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_cloud/includes_cloud_aws_chef_server_migration_to_aws.rst

Migrate to the latest AMI
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_cloud/includes_cloud_aws_chef_server_ami_migration.rst


|chef compliance| AMI
=====================================================
Follow the steps in the sections below to install |chef compliance| in |amazon aws marketplace|.

Launch the AMI
-----------------------------------------------------

To get a fully-functional Amazon Machine Images (AMI) for Chef Compliance, do the following:

#. Login to the `AWS Marketplace <https://aws.amazon.com/marketplace>`__ using your Amazon Web Services (AWS) account credentials
#. Navigate to the Chef Compliance `product page <https://aws.amazon.com/marketplace/pp/B01B3NDVEO>`__ and accept the software terms
#. Navigate to the `IAM Role section in the AWS console <https://console.aws.amazon.com/iam/home#roles>`__

   Create a new role for your marketplace instance with the 'Amazon Ec2' service type and attach the 'AWSMarketplaceFullAccess' policy.

   .. note:: You can skip creating a role if you're launching from the IC Marketplace
   
#. Navigate back to the Chef Compliance `product page <https://aws.amazon.com/marketplace/pp/B01B3NDVEO>`__ and continue to the launch wizard.
#. Click the 'Launch with Ec2 Console' button next to the desired region
   
   Configure the Amazon EC2 instance type, Amazon Virtual Private Cloud (VPC) settings, SSH key pair, IAM Role and assign `a public IP address <http://docs.aws.amazon.com/AWSEC2/latest/UserGuide/using-instance-addressing.html#concepts-public-addresses>`__.
   
   .. note:: You must assign the previously created IAM role or another role with full marketplace access unless you're launching from the IC Marketplace
   
   Optionally add additional storage or increase the root volume size.
   
   Configure security group to include the required ports for access.

   .. note:: Your security group should allow access from your workstation on ports 22 and 443

#. Launch Amazon Machine Images (AMI)


Configure |chef compliance|
-----------------------------------------------------
.. include:: ../../includes_cloud/includes_cloud_aws_compliance_configure.rst

Troubleshooting
-----------------------------------------------------

Required ports
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_cloud/includes_cloud_aws_compliance_ports.rst

Change the hostname
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_cloud/includes_cloud_aws_compliance_update_hostname.rst

Change instance size
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_cloud/includes_cloud_aws_compliance_change_instance.rst

Upgrade |chef compliance|
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_cloud/includes_cloud_aws_compliance_upgrade_software.rst

Migrate to AWS
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_cloud/includes_cloud_aws_compliance_migration_to_aws.rst

Migrate to the latest AMI
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_cloud/includes_cloud_aws_compliance_ami_migration.rst
