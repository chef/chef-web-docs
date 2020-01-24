=====================================================
AWS Marketplace
=====================================================
`[edit on GitHub] <https://github.com/chef/chef-web-docs/blob/master/chef_master/source/aws_marketplace.rst>`__

Chef provides Amazon Machine Images (AMIs) for Chef Automate and Chef Infra Server that can be launched from the `AWS Marketplace <https://aws.amazon.com/marketplace/seller-profile/ref=srh_res_product_vendor?ie=UTF8&id=e7b7691e-634a-4d35-b729-a8b576175e8c>`__. Hourly metered billing and Bring Your Own License (BYOL) options are available.

Metered AMI
-----------------------------------------------------
The Chef Automate Amazon Machine Image (AMI) is preinstalled with Chef Automate and Chef Infra Server on a single instance. When using the metered billing AMI, an hourly aggregate of your Chef Automate usage is calculated and billed through your Amazon Web Services (AWS) account. Follow the steps in the sections below to use the Chef Automate metered billing AMI:

Accept software terms
+++++++++++++++++++++++++++++++++++++++++++++++++++++

.. tag accept_aws_marketplace_terms

#. Login to the `AWS Marketplace <https://aws.amazon.com/marketplace>`__ using your Amazon Web Services (AWS) account credentials.
#. Navigate to the Chef Automate `product page <https://aws.amazon.com/marketplace/pp/B01N813OWL>`__ and accept the software terms.

.. end_tag

Create S3 bucket and access role
+++++++++++++++++++++++++++++++++++++++++++++++++++++
If you wish to use Chef Automate's built-in S3 backup support, or if you want to bring your own license, complete the following steps:

#. Navigate to the `S3 Console <https://s3.console.aws.amazon.com/s3/home>`__ and create an S3 bucket in the region where you intend to launch the Chef Automate AMI.
#. Copy the S3 bucket ARN.
#. Navigate to the `IAM Role section in the AWS console <https://console.aws.amazon.com/iam/home#roles>`__.
#. Create an access policy for your bucket that allows listing, getting, putting, deleting and multi-part uploads to your bucket ARN. You can use the following example with your bucket ARN in the Resource arrays:

.. code-block:: json

   {
     "Statement": [
       {
         "Action": [
           "s3:ListBucket",
           "s3:GetBucketLocation",
           "s3:ListBucketMultipartUploads",
           "s3:ListBucketVersions"
         ],
         "Effect": "Allow",
         "Resource": [
           "arn:aws:s3:::yourbucket"
         ]
       },
       {
         "Action": [
           "s3:GetObject",
           "s3:PutObject",
           "s3:DeleteObject",
           "s3:AbortMultipartUpload",
           "s3:ListMultipartUploadParts"
         ],
         "Effect": "Allow",
         "Resource": [
           "arn:aws:s3:::yourbucket/*"
         ]
       }
     ],
     "Version": "2012-10-17"
   }

#. Create an IAM role for your instance.
#. Attach the S3 bucket access policy to the role.

Launch the Metered AMI
+++++++++++++++++++++++++++++++++++++++++++++++++++++
#. Navigate back to the Chef Automate `product page <https://aws.amazon.com/marketplace/pp/B01AMIH01Q>`__ and continue to the launch wizard.
#. Click the 'Launch with EC2 Console' button next to the desired region.
#. Configure the Amazon EC2 instance type, Amazon Virtual Private Cloud (VPC) settings, SSH key pair, IAM Role and assign `a public IP address <http://docs.aws.amazon.com/AWSEC2/latest/UserGuide/using-instance-addressing.html#concepts-public-addresses>`__.
#. Increase the root volume size to a minimum of 30GB. You might consider even larger if you have hundreds of nodes or need to maintain months of node visibility data.
#. Launch the Amazon Machine Image (AMI).
#. `Install Chef Workstation <aws_marketplace.html#install-chef-workstation>`__.

Bring Your Own License (BYOL) AMI
-----------------------------------------------------
The Chef Automate Amazon Machine Image (AMI) is preinstalled with Chef Automate and Chef Infra Server on a single instance. The BYOL image includes a 30 day trial license, but it can also be configured to use an existing Chef Automate license that you have procured from Chef.  Follow the steps in the sections below to use the Chef Automate metered billing AMI:

Accept software terms
+++++++++++++++++++++++++++++++++++++++++++++++++++++

.. tag accept_aws_marketplace_terms

#. Login to the `AWS Marketplace <https://aws.amazon.com/marketplace>`__ using your Amazon Web Services (AWS) account credentials.
#. Navigate to the Chef Automate `product page <https://aws.amazon.com/marketplace/pp/B01N813OWL>`__ and accept the software terms.

.. end_tag

Create S3 bucket and access role
+++++++++++++++++++++++++++++++++++++++++++++++++++++
If you wish to use Chef Automate's built-in S3 backup support, or if you want to bring your own license, complete the following steps:

#. Navigate to the `S3 Console <https://s3.console.aws.amazon.com/s3/home>`__ and create an S3 bucket in the region where you intend to launch the Chef Automate AMI.
#. Select your bucket in the console and upload your Chef Automate ``delivery.license`` file. Ensure that you've restricted access to the file, and that it is not publicly readable. If you do not have a license, skip this step.

   .. note:: Placing your license file in S3 is not a requirement for using the BYOL functionality, the instance just needs a fully-qualified URL to the license file. For the sake of these instructions we're using S3 to safely store the file and make it accessible to the Chef Automate instance.

#. Copy the S3 bucket ARN.
#. Navigate to the `IAM Role section in the AWS console <https://console.aws.amazon.com/iam/home#roles>`__.
#. Create an access policy for your bucket that allows listing, getting, putting, deleting and multi-part uploads to your bucket ARN. You can use the following example with your bucket ARN in the Resource arrays:

.. code-block:: json

   {
     "Statement": [
       {
         "Action": [
           "s3:ListBucket",
           "s3:GetBucketLocation",
           "s3:ListBucketMultipartUploads",
           "s3:ListBucketVersions"
         ],
         "Effect": "Allow",
         "Resource": [
           "arn:aws:s3:::yourbucket"
         ]
       },
       {
         "Action": [
           "s3:GetObject",
           "s3:PutObject",
           "s3:DeleteObject",
           "s3:AbortMultipartUpload",
           "s3:ListMultipartUploadParts"
         ],
         "Effect": "Allow",
         "Resource": [
           "arn:aws:s3:::yourbucket/*"
         ]
       }
     ],
     "Version": "2012-10-17"
   }

#. Create an IAM role for your instance.
#. Attach the S3 bucket access policy to the role.

Launch the BYOL AMI
+++++++++++++++++++++++++++++++++++++++++++++++++++++
#. Navigate back to the Chef Automate `product page <https://aws.amazon.com/marketplace/pp/B01AMIH01Q>`__ and continue to the launch wizard.
#. If you're using your own license, create and copy a pre-signed link with the AWS command line tools and save it. For example:

   .. code-block:: bash

      $ aws s3 presign yourbucket/delivery.license

#. Configure all fields in the CloudFormation template. Use the pre-signed license URL for the ``LicenseUrl`` field.
#. Associate the IAM role for backup access.
#. Run the CloudFormation template to create the Chef Automate instance.

Install Chef Workstation
-----------------------------------------------------
While the Amazon Machine Images (AMI) for Chef Automate is provisioning, download and install Chef Workstation. Chef Workstation is a collection of tools and libraries that are packaged together to make it easy to develop cookbooks and resources for a Chef / Chef Automate environment. You'll need this to interact with Chef Automate and Chef Infra Server from the command line.

Configure Chef Automate
-----------------------------------------------------
After the instance has been provisioned and initial configuration has completed (usually 10 to 13 minutes) finish configuring Chef Automate and Chef Infra Server.

#. Access the intial configuration page by loading ``/biscotti/setup`` route. Build the URL by prepending ``https://`` and appending ``/biscotti/setup`` to the IP address or public hostname that was automatically assigned to the instance when the Amazon Machine Images (AMI) was launched.  For example, ``https://<fqdn>/biscotti/setup``. If you used the BYOL image, the CloudFormation stack will have the setup URL in the ``Outputs`` section.

   .. note:: .. tag notes_chef_aws_ssl

             In order to use TLS/SSL for the Web UI and API, the Amazon Machine Images (AMI) will automatically create and use a self-signed certificate. Modern web browsers typically warn about self-signed certificates during login; however, in this case, you can ignore the warning and accept the certificate.

             .. end_tag

#. Use the AWS console or command line tools to determine the Instance ID of your Chef Automate instance. The instance ID is required for authorization to access the setup page.
#. Fill out the setup form and submit it.
#. Follow the link and log into the Chef Automate webui.

Configure the workstation
-----------------------------------------------------

#. Download and extract the ``starter_kit.zip`` file to a directory on the workstation. Open a command prompt and change into the ``chef-repo`` directory extracted from the starter kit. For example:

   .. code-block:: bash

      $ cd ~/Downloads
      $ unzip starter_kit.zip
      $ cd starter_kit/chef-repo

   

#. .. tag install_aws_chef_server_knife_client_list

   Run ``knife client list`` to test the connection to the Chef Infra Server. The command should return ``<orgname>-validator``, where ``<orgname>`` is the name of the organization that was created previously.

   .. end_tag

Configure backups
-----------------------------------------------------
Follow the Workflow `instructions <delivery_server_backup.html#s3-backups>`__ for configuring backups.

Troubleshooting
-----------------------------------------------------

Required ports
+++++++++++++++++++++++++++++++++++++++++++++++++++++
The following are recommended security group rules for Chef Automate from the AWS Marketplace:

.. list-table::
   :widths: 60 420
   :header-rows: 1

   * - Port
     - Description
   * - 443
     - HTTPS for Chef Automate webui
   * - 8989
     - Git access for the delivery-cli and workflow
   * - 22
     - SSH

.. _change-automate-hostname:

Change the hostname
+++++++++++++++++++++++++++++++++++++++++++++++++++++
To update the hostname, do the following:

#. Run ``sudo -i`` to gain administrator privileges.

#. Run ``chef-marketplace-ctl hostname`` to view the current hostname.

#. Configure the ``api_fqdn`` in ``/etc/chef-marketplace/marketplace.rb``

   .. code-block:: none

      $ echo 'api_fqdn "<new.fully.qualified.hostname.com>"' | sudo tee -a /etc/chef-marketplace/marketplace.rb

#. Run ``chef-marketplace-ctl reconfigure`` to update Chef Automate and Chef Infra Server configuration.

#. Run ``chef-server-ctl stop`` to stop Chef Infra Server.

#. Run ``automate-ctl stop`` to stop Chef Automate.

#. Run ``chef-marketplace-ctl hostname <new.fully.qualified.hostname.com>`` to update the hostname.

#. Run ``automate-ctl reconfigure`` to ensure Chef Automate has been correctly configured with the new hostname.

#. Run ``chef-server-ctl reconfigure`` to ensure Chef Infra Server has been correctly configured with the new hostname.

#. Run ``automate-ctl restart`` to restart Chef Automate

#. Run ``chef-server-ctl restart`` to restart Chef server

Change instance size
+++++++++++++++++++++++++++++++++++++++++++++++++++++
To edit the Amazon Machine Images (AMI) instance size, do the following:

#. Login using SSH to access the Chef Automate instance. Use the SSH key pair and the IP address or public hostname that was automatically assigned when the Amazon Machine Images (AMI) was launched. The default user is ``ec2-user``. For example:

   .. code-block:: bash

      $ ssh -i /path/to/ssh_key.pem ec2-user@<instance IP address>

#. Stop the Chef Infra Server services:

   .. code-block:: bash

      $ sudo chef-server-ctl stop

#. Stop then Chef Automate services:

   .. code-block:: bash

      $ sudo automate-ctl stop

#. Navigate to the Amazon Web Services (AWS) instance in the AWS Management Console.
#. From the **Actions** dropdown, select **Instance State**, and then **Stop**.
#. After the instance transitions to **Stopped**, edit the instance size. From the **Actions** dropdown, select **Instance Settings**, and then **Change Instance Type**.
#. From the dropdown, select the desired instance size, and then click **Apply**.
#. From the **Actions** dropdown, select **Instance State**, and then click **Start**.
#. After the instance has started it will have a **new public IP address and public DNS**.
#. Use SSH to log into the new instance. Use the SSH key pair and new IP address:

   .. code-block:: bash

      $ ssh -i /path/to/ssh_key.pem ec2-user@<instance IP address>

#. Follow the `instructions for changing the hostname </aws_marketplace.html#change-automate-hostname>`__

#. Verify that you can login to Chef Automate webui by navigating to ``https://<YOUR NEW PUBLIC DNS>/e/default``.

   .. note:: .. tag notes_chef_aws_ssl

             In order to use TLS/SSL for the Web UI and API, the Amazon Machine Images (AMI) will automatically create and use a self-signed certificate. Modern web browsers typically warn about self-signed certificates during login; however, in this case, you can ignore the warning and accept the certificate.

             .. end_tag

#. Open a command prompt and change into your ``chef-repo`` directory.
#. .. tag install_update_aws_knife_rb

   Open ``.chef/config.rb`` in a text editor and modify the ``chef_server_url`` with your new public DNS. For example:

   .. code-block:: bash

      $ vim ~/chef-repo/.chef/config.rb

   will open a ``config.rb`` file similar to:

   .. code-block:: ruby

      current_dir = ::File.dirname(__FILE__)
      log_level                :info
      log_location             $stdout
      node_name                'your_username'
      client_key               "#{current_dir}/your_username.pem"
      validation_client_name   'your_orgname-validator'
      validation_key           "#{current_dir}/your_orgname-validator.pem"
      chef_server_url          'https://<YOUR NEW PUBLIC DNS>/organizations/your_org'
      cookbook_path            ["#{current_dir}/../cookbooks"]

   .. end_tag

#. Open ``.chef/pivotal.rb`` in a text editor and modify the ``chef_server_url`` and ``chef_server_root`` with your new public DNS. For example:

   .. code-block:: bash

     vim ~/chef-repo/.chef/pivotal.rb

   will open a ``pivotal.rb`` file similar to:

   .. code-block:: ruby

      node_name        "pivotal"
      chef_server_url  "<YOUR NEW PUBLIC DNS>"
      chef_server_root "<YOUR NEW PUBLIC DNS>"
      client_key       ::File.join(::File.dirname(__FILE__), "pivotal.pem")

   

#. .. tag install_aws_chef_server_knife_ssl_fetch

   Run ``knife ssl fetch`` to add the Chef Infra Server SSL certificate as a trusted SSL certificate.

   .. end_tag

#. .. tag install_aws_chef_server_knife_client_list

   Run ``knife client list`` to test the connection to the Chef Infra Server. The command should return ``<orgname>-validator``, where ``<orgname>`` is the name of the organization that was created previously.

   .. end_tag

#. Update the ``/etc/chef/client.rb`` on all of your nodes to use the new public DNS.  For example:

   .. code-block:: bash

      $ knife ssh name:* 'sudo sed -ie "s/chef_server_url.*/chef_server_url 'https://ec2-52-6-31-230.compute-1.amazonaws.com/organizations/your_org'/"' /etc/chef/client.rb

   Replace ``ec2-52-6-31-230.compute-1.amazonaws.com`` with your new public DNS name and ``your_org`` with your organization name.

Upgrade Chef Automate
+++++++++++++++++++++++++++++++++++++++++++++++++++++
The Chef Automate Amazon Machine Images (AMI) can perform in-place upgrades of all of the pre-bundled software. This makes it easy to stay up-to-date with the latest version of Chef Automate, the Chef Infra Server and Chef Marketplace, while not requiring data to be migrated to the latest published Amazon Machine Images (AMI).

There are three options: upgrade Chef Automate, upgrade Chef Infra Server, upgrade Chef Marketplace; upgrade everything.

To upgrade, do one of the following:

* Upgrade the Chef Automate package by using the following command:

  .. code-block:: bash

     $ sudo chef-marketplace-ctl upgrade --automate

  .. note:: Chef Automate and Chef Infra Server services will be unavailable while the software is updated.

* Upgrade the Chef Infra Server package by using the following command:

  .. code-block:: bash

     $ sudo chef-marketplace-ctl upgrade --server

  .. note:: Chef Infra Server services will be unavailable while the software is updated.

* Upgrade the Chef Marketplace package by using the following command:

  .. code-block:: bash

     $ sudo chef-marketplace-ctl upgrade --marketplace

* Upgrade all the installed packages by using the following command:

  .. code-block:: bash

     $ sudo chef-marketplace-ctl upgrade -y

Migrate to Chef Automate on AWS
+++++++++++++++++++++++++++++++++++++++++++++++++++++
The process of migrating from an existing Chef Infra Server installation to the Amazon Machine Images (AMI) differs depending on which software version is being used and the location in which it is deployed. In all scenarios, data is first migrated to the latest Chef Infra Server schema, after which it is migrated to the Amazon Machine Images (AMI).

* Verify that the latest version of the Chef Infra Server is installed by using the platform package manager: ``rpm -qa | grep chef-server-core`` and compare the result to the latest version available on the `downloads site <https://downloads.chef.io/>`__. If this is not the latest version, download the package, and then `upgrade </upgrade_server.html#from-chef-server-12>`_ to the latest version.

After verifying that your existing Chef Infra Server installation is up to date, do the following to migrate to the Amazon Machine Images (AMI) instance:

#.
   Backup the data on the Chef Infra Server using ``knife ec backup``. This method will export all of your existing Chef Infra Server data as JSON. We'll then re-import the same data into a new Chef Automate cluster. We use the JSON based backup and restore procedure because the Chef Infra Server data on the Chef Automate Marketplace AMI is stored in shared databases so copying of binary files won't work.

   .. code-block:: bash

      $ mkdir -p /tmp/chef-backup
      $ /opt/opscode/embedded/bin/knife ec backup /tmp/chef-backup --with-user-sql --with-key-sql
      $ tar -czvf chef-backup.tgz -C /tmp/chef-backup

#. Copy the resulting tarball to your Amazon Machine Images (AMI) instance:

   .. code-block:: bash

      $ scp /tmp/chef-backup.tgz ec2-user@<MARKETPLACE AMI IP ADDRESS>:/tmp/

#. Login to the Amazon Machine Images (AMI) and ensure that it is running the latest version of the Chef Infra Server:

   .. code-block:: bash

      $ chef-marketplace-ctl upgrade -y

#. Reconfigure Chef Automate and the Chef Infra Server:

   .. code-block:: bash

      $ sudo automate-ctl reconfigure
      $ sudo chef-server-ctl reconfigure

#. Restore the backup:

   .. code-block:: bash

      $ mkdir -p /tmp/chef-backup
      $ mv /tmp/chef-backup.tgz /tmp/chef-backup
      $ cd /tmp/chef-backup
      $ tar -ztf chef-backup.tgz
      $ /opt/opscode/embedded/bin/knife ec restore /tmp/chef-backup --with-user-sql --with-key-sql

#. .. tag install_update_aws_knife_rb

   Open ``.chef/config.rb`` in a text editor and modify the ``chef_server_url`` with your new public DNS. For example:

   .. code-block:: bash

      $ vim ~/chef-repo/.chef/config.rb

   will open a ``config.rb`` file similar to:

   .. code-block:: ruby

      current_dir = ::File.dirname(__FILE__)
      log_level                :info
      log_location             $stdout
      node_name                'your_username'
      client_key               "#{current_dir}/your_username.pem"
      validation_client_name   'your_orgname-validator'
      validation_key           "#{current_dir}/your_orgname-validator.pem"
      chef_server_url          'https://<YOUR NEW PUBLIC DNS>/organizations/your_org'
      cookbook_path            ["#{current_dir}/../cookbooks"]

   .. end_tag

#. .. tag install_aws_chef_server_knife_ssl_fetch

   Run ``knife ssl fetch`` to add the Chef Infra Server SSL certificate as a trusted SSL certificate.

   .. end_tag

#. .. tag install_aws_chef_server_knife_client_list

   Run ``knife client list`` to test the connection to the Chef Infra Server. The command should return ``<orgname>-validator``, where ``<orgname>`` is the name of the organization that was created previously.

   .. end_tag

#. Update the ``/etc/chef/client.rb`` on all of your nodes to use the new public DNS.  For example:

   .. code-block:: none

      $ knife ssh name:* 'sudo sed -ie "s/chef_server_url.*/chef_server_url 'https://ec2-52-6-31-230.compute-1.amazonaws.com/organizations/your_org'/" /etc/chef/client.rb

   Replace ``ec2-52-6-31-230.compute-1.amazonaws.com`` with your new public DNS name and ``your_org`` with your organization name.
