=====================================================
AWS Marketplace
=====================================================
`[edit on GitHub] <https://github.com/chef/chef-web-docs/blob/master/chef_master/source/aws_marketplace.rst>`__

Chef provides a fully licensed Amazon Machine Images (AMI) for the Chef server and Chef Compliance that can be launched from the `AWS Marketplace <https://aws.amazon.com/marketplace/seller-profile/ref=srh_res_product_vendor?ie=UTF8&id=e7b7691e-634a-4d35-b729-a8b576175e8c>`__. Billing is done through your Amazon Web Services (AWS) account on an hourly basis and is dynamically updated to reflect current node usage.

Chef Server AMI
=====================================================
Follow the steps in the sections below to install the Chef server in AWS Marketplace.

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

Install the Chef DK
-----------------------------------------------------
While the Amazon Machine Images (AMI) for Chef server is being provisioned, download and install the `Chef Development Kit <https://docs.chef.io/install_dk.html>`__.  The Chef management console has many features and is useful for viewing and creating policy to be applied to nodes, the Chef development kit installs a collection of tools---Test Kitchen, ChefSpec, chef, chef-vault, Foodcritic, and more---and libraries that are all packaged together, which makes it easier to manage the dependencies these tools may have on each other and the dependencies that Chef has on Ruby.

Configure the Chef Server
-----------------------------------------------------
After the instance has been provisioned and initial configuration has completed (usually 10 to 13 minutes) run through the setup wizard to create your user and register for a Chef support account. To complete the configuration, do the following:

#. Access the Chef server setup wizard.  Build the URL by prepending ``https://`` and appending ``/signup`` to the IP address or public hostname that was automatically assigned when the Amazon Machine Images (AMI) was launched.  For example, ``https://<fqdn>/signup``.

   .. note:: .. tag notes_chef_aws_ssl

             In order to use TLS/SSL for the Web UI and API the Amazon Machine Images (AMI) will automatically create and use a self-signed certificate. Modern web browsers typically warn about self-signed certificates during login. In this situation, ignore the warning and accept the certificate.

             .. end_tag

#. Run through the setup wizard. If you opt into creating a support account you should receive a confirmation email for a Hosted Chef account. Follow the link in the confirmation email to complete the support account creation.

Configure the workstation
-----------------------------------------------------
#. Log into Chef server webui and download the starter kit.  Build the URL by appending ``/getting_started`` to the to the fully qualified path of organization.  For example, ``http://<fqdn>/organizations/<your_org>/getting_started``.

#. .. tag install_aws_chef_server_extract_starter_kit

   Extract the ``chef-starter.zip`` file to a directory on the workstation. Open a command prompt and change into the chef-repo directory extracted from the starter kit. For example:

   .. code-block:: bash

      $ cd ~/Downloads
      $ unzip chef-starter.zip
      $ cd chef-repo

   .. end_tag

#. .. tag install_aws_chef_server_knife_ssl_fetch

   Run ``knife ssl fetch`` to add the Chef server SSL certificate as a trusted SSL certificate.

   .. end_tag

#. .. tag install_aws_chef_server_knife_client_list

   Run ``knife client list`` to test the connection to the Chef server. The command should return ``<orgname>-validator``, where ``<orgname>`` is the name of the organization that was created previously.

   .. end_tag

#. Add virtual machines to the Chef server.
#. Bootstrap nodes with the Chef server.

Troubleshooting
-----------------------------------------------------

Required ports
+++++++++++++++++++++++++++++++++++++++++++++++++++++
For a Chef server configuration that is launched from the AWS Marketplace, access to the instance on the following ports is required:

.. list-table::
   :widths: 60 420
   :header-rows: 1

   * - Port
     - Description
   * - 443
     - HTTPS for Chef management console
   * - 8443
     - HTTPS for Chef Analytics
   * - 22
     - SSH

Change the hostname
+++++++++++++++++++++++++++++++++++++++++++++++++++++
To update the hostname, do the following:

#. Run ``sudo -i`` to gain administrator privileges.

#. Run ``chef-marketplace-ctl hostname`` to view the current hostname.

#. Configure the ``api_fqdn`` in ``/etc/chef-marketplace/marketplace.rb``

   .. code-block:: none

      $ echo 'api_fqdn "<new.hostname.com>"' | sudo tee -a /etc/chef-marketplace/marketplace.rb

#. Run ``chef-server-ctl stop`` to stop Chef server.

#. Run ``chef-marketplace-ctl hostname <new.hostname.com>`` to update the hostname.

#. Run ``chef-server-ctl reconfigure`` to ensure Chef server has beeen correctly configured with the new hostname.

#. Run ``chef-server-ctl restart`` to restart Chef server

Change instance size
+++++++++++++++++++++++++++++++++++++++++++++++++++++
To edit the Amazon Machine Images (AMI) instance size, do the following:

#. Login using SSH to access the Chef server instance. Use the SSH key pair and the IP address or public hostname that was automatically assigned when the Amazon Machine Images (AMI) was launched. The default user is ``ec2-user``. For example:

   .. code-block:: bash

      $ ssh -i /path/to/ssh_key.pem ec2-user@<instance IP address>

#. .. This topic is hooked in globally to install topics for Chef server applications.

   Stop the Chef server:

   .. code-block:: bash

      $ sudo chef-server-ctl stop

#. Navigate to the Amazon Web Services (AWS) instance in the AWS Management Console.
#. From the **Actions** dropdown, select **Instance State**, and then **Stop**.
#. After the instance transitions to **Stopped**, edit the instance size. From the **Actions** dropdown, select **Instance Settings**, and then **Change Instance Type**.
#. From the dropdown, select the desired instance size, and then click **Apply**.
#. From the **Actions** dropdown, select **Instance State**, and then click **Start**.
#. After the instance has started it will have a **new public IP address and public DNS**.
#. Use SSH to log into the new instance. Use the SSH key pair and new IP address:

   .. code-block:: bash

      $ ssh -i /path/to/ssh_key.pem ec2-user@<instance IP address>

#. Update the API FQDN in ``/etc/opscode/chef-server.rb`` using the public DNS name.  For example:

   .. code-block:: none

      $ sudo sed -ie "s/api_fqdn.*/api_fqdn 'ec2-52-6-31-230.compute-1.amazonaws.com'/" /etc/opscode/chef-server.rb

   Replace ``ec2-52-6-31-230.compute-1.amazonaws.com`` with the public DNS name.

#. .. tag install_chef_server_reconfigure

   .. This topic is hooked in globally to install topics for Chef server applications.

   Reconfigure the Chef server and the Chef management console (standalone and frontend group members
     of a High Availabilty installation):

   .. code-block:: bash

      $ sudo chef-server-ctl reconfigure
      $ sudo chef-manage-ctl reconfigure

   .. end_tag

#. .. This topic is hooked in globally to install topics for Chef server applications.

   Reconfigure the Chef server:

   .. code-block:: bash

      $ sudo chef-manage-ctl reconfigure

#. Verify that you can login to Chef management console by navigating to ``https://<YOUR NEW PUBLIC DNS>/login``.

   .. note:: .. tag notes_chef_aws_ssl

             In order to use TLS/SSL for the Web UI and API the Amazon Machine Images (AMI) will automatically create and use a self-signed certificate. Modern web browsers typically warn about self-signed certificates during login. In this situation, ignore the warning and accept the certificate.

             .. end_tag

#. Open a command prompt and change into your ``chef-repo`` directory.
#. Open ``.chef/knife.rb`` in a text editor and modify the ``chef_server_url`` with your new public DNS. For example:

   .. code-block:: bash

      $ vim ~/chef-repo/.chef/knife.rb

   will open a ``knife.rb`` file similar to:

   .. code-block:: ruby

      current_dir = File.dirname(__FILE__)
      log_level                :info
      log_location             STDOUT
      node_name                'your_username'
      client_key               "#{current_dir}/your_username.pem"
      validation_client_name   'your_username-validator'
      validation_key           "#{current_dir}/your_username-validator.pem"
      chef_server_url          'https://<YOUR NEW PUBLIC DNS>/organizations/your_org'
      cookbook_path            ["#{current_dir}/../cookbooks"]

#. .. tag install_aws_chef_server_knife_ssl_fetch

   Run ``knife ssl fetch`` to add the Chef server SSL certificate as a trusted SSL certificate.

   .. end_tag

#. .. tag install_aws_chef_server_knife_client_list

   Run ``knife client list`` to test the connection to the Chef server. The command should return ``<orgname>-validator``, where ``<orgname>`` is the name of the organization that was created previously.

   .. end_tag

#. Update the ``/etc/chef/client.rb`` on all of your nodes to use the new public DNS.  For example:

   .. code-block:: bash

      $ knife ssh name:* 'sudo sed -ie "s/chef_server_url.*/chef_server_url 'https://ec2-52-6-31-230.compute-1.amazonaws.com/organizations/your_org'/"' /etc/chef/client.rb

   Replace ``ec2-52-6-31-230.compute-1.amazonaws.com`` with your new public DNS name and ``your_org`` with your organization name.

Upgrade the Chef Server
+++++++++++++++++++++++++++++++++++++++++++++++++++++
The Chef server Amazon Machine Images (AMI) can perform in-place upgrades of all of the pre-bundled software. This makes it easy to stay up-to-date with the latest version of the Chef server, the Chef management console, Reporting and Chef Marketplace, while not requiring data to be migrated to the latest published Amazon Machine Images (AMI).

There are four options: upgrade the Chef server, the Chef management console, and Reporting; upgrade Chef Analytics; upgrade Chef Marketplace; upgrade everything.

To upgrade, do one of the following:

* Upgrade the Chef server, the Chef management console and Reporting packages by using the following command:

  .. code-block:: bash

     $ sudo chef-marketplace-ctl upgrade -s

  .. note:: The Chef server will be unavailable while the software is updated.

* Upgrade the Chef Analytics package by using the following command:

  .. code-block:: bash

     $ sudo chef-marketplace-ctl upgrade -a

  .. note:: Chef Analytics will be unavailable while the software is updated.

* Upgrade the Chef Marketplace package by using the following command:

  .. code-block:: bash

     $ sudo chef-marketplace-ctl upgrade -m

* Upgrade all the installed packages by using the following command:

  .. code-block:: bash

     $ sudo chef-marketplace-ctl upgrade -y

Migrate to AWS
+++++++++++++++++++++++++++++++++++++++++++++++++++++
The process of migrating from an existing Chef server installation to the Amazon Machine Images (AMI) differs depending on which software version being used and the location in which it is deployed. In all scenarios, data is first migrated to the latest Chef server schema, after which it is migrated to the Amazon Machine Images (AMI).

* Verify that the latest version of the Chef server is installed by using the platform package manager: ``rpm -qa | grep chef-server-core`` and compare the result to the latest version available on the `downloads site <https://downloads.chef.io/>`__. If this is not the latest version, download the package, and then `upgrade <https://docs.chef.io/upgrade_server.html#from-chef-server-12>`__ to the latest version.
* Upgrade an Enterprise Chef node to the latest version of the Chef server by following the `upgrade instructions <https://docs.chef.io/upgrade_server.html#from-chef-server-oec>`__.
* Upgrade an Open Source Chef node to the latest version of the Chef server by following the `upgrade instructions <https://docs.chef.io/upgrade_server.html#from-chef-server-osc>`__.

After verifying that your existing Chef server installation is up to date, do the following to migrate to the Amazon Machine Images (AMI) instance:

#. .. tag install_chef_server_backup

   .. This topic is hooked in globally to install topics for Chef server applications.

   Backup the data on the Chef server:

   .. code-block:: bash

      $ sudo chef-server-ctl backup

   .. end_tag

#. Copy the resulting tarball to your Amazon Machine Images (AMI) instance:

   .. code-block:: bash

      $ scp /tmp/chef-backup-2014-12-10-20-31-40.tgz ec2-user@<MARKETPLACE AMI IP ADDRESS>:/tmp/

#. Login to the Amazon Machine Images (AMI) and ensure that it is running the latest version of the Chef server:

   .. code-block:: bash

      $ chef-marketplace-ctl upgrade -y

#. .. tag install_chef_server_reconfigure

   .. This topic is hooked in globally to install topics for Chef server applications.

   Reconfigure the Chef server and the Chef management console (standalone and frontend group members
     of a High Availabilty installation):

   .. code-block:: bash

      $ sudo chef-server-ctl reconfigure
      $ sudo chef-manage-ctl reconfigure

   .. end_tag

#. Restore the backup:

   .. code-block:: bash

      $ chef-server-ctl restore /tmp/chef-backup-2014-12-10-20-31-40.tgz

#. Download your new starter kit:

   Login to the Chef management console by navigating to ``https://<MARKETPLACE AMI IP ADDRESS>/getting_started`` and download the starter kit.

#. .. tag install_aws_chef_server_extract_starter_kit

   Extract the ``chef-starter.zip`` file to a directory on the workstation. Open a command prompt and change into the chef-repo directory extracted from the starter kit. For example:

   .. code-block:: bash

      $ cd ~/Downloads
      $ unzip chef-starter.zip
      $ cd chef-repo

   .. end_tag

#. .. tag install_aws_chef_server_knife_ssl_fetch

   Run ``knife ssl fetch`` to add the Chef server SSL certificate as a trusted SSL certificate.

   .. end_tag

#. .. tag install_aws_chef_server_knife_client_list

   Run ``knife client list`` to test the connection to the Chef server. The command should return ``<orgname>-validator``, where ``<orgname>`` is the name of the organization that was created previously.

   .. end_tag

#. Update the ``/etc/chef/client.rb`` on all of your nodes to use the new public DNS.  For example:

   .. code-block:: none

      $ knife ssh name:* 'sudo sed -ie "s/chef_server_url.*/chef_server_url 'https://ec2-52-6-31-230.compute-1.amazonaws.com/organizations/your_org'/" /etc/chef/client.rb

   Replace ``ec2-52-6-31-230.compute-1.amazonaws.com`` with your new public DNS name and ``your_org`` with your organization name.

Migrate to the latest AMI
+++++++++++++++++++++++++++++++++++++++++++++++++++++
To migrate from an older Amazon Machine Images (AMI) to the latest Amazon Machine Images (AMI), do the following:

#. `Launch <https://docs.chef.io/aws_marketplace.html#launch-the-ami>`__ the latest Chef server Amazon Machine Images (AMI).

#. Login to the old Amazon Machine Images (AMI) and ensure that it is running the latest version of the Chef server:

   .. code-block:: bash

      $ chef-marketplace-ctl upgrade -y

#. .. tag install_chef_server_backup

   .. This topic is hooked in globally to install topics for Chef server applications.

   Backup the data on the Chef server:

   .. code-block:: bash

      $ sudo chef-server-ctl backup

   .. end_tag

#. Copy the resulting tarball to your new Amazon Machine Images (AMI) instance:

   .. code-block:: bash

      $ scp /tmp/chef-backup-2014-12-10-20-31-40.tgz ec2-user@<MARKETPLACE AMI IP ADDRESS>:/tmp/

#. Login to the new Amazon Machine Images (AMI) and ensure that it is running the latest version of the Chef server:

   .. code-block:: bash

      $ chef-marketplace-ctl upgrade -y

#. Backup the marketplace configuration file on the new Amazon Machine Images (AMI):

   .. code-block:: bash

      $ cp /etc/chef-marketplace/marketplace.rb /tmp/marketplace.rb

#. Restore the backup:

   .. code-block:: bash

      $ chef-server-ctl restore /tmp/chef-backup-2014-12-10-20-31-40.tgz

#. Restore the marketplace configuration file on the new Amazon Machine Images (AMI) and configure the Chef server:

   .. code-block:: bash

      $ cp /tmp/marketplace.rb /etc/chef-marketplace/marketplace.rb
      $ chef-marketplace-ctl reconfigure
      $ chef-server-ctl reconfigure
      $ chef-manage-ctl reconfigure

#. Download your new starter kit:

   Login to the Chef management console by navigating to ``https://<MARKETPLACE AMI IP ADDRESS>/getting_started`` and download the starter kit.

#. .. tag install_aws_chef_server_extract_starter_kit

   Extract the ``chef-starter.zip`` file to a directory on the workstation. Open a command prompt and change into the chef-repo directory extracted from the starter kit. For example:

   .. code-block:: bash

      $ cd ~/Downloads
      $ unzip chef-starter.zip
      $ cd chef-repo

   .. end_tag

#. .. tag install_aws_chef_server_knife_ssl_fetch

   Run ``knife ssl fetch`` to add the Chef server SSL certificate as a trusted SSL certificate.

   .. end_tag

#. .. tag install_aws_chef_server_knife_client_list

   Run ``knife client list`` to test the connection to the Chef server. The command should return ``<orgname>-validator``, where ``<orgname>`` is the name of the organization that was created previously.

   .. end_tag

#. Update the ``/etc/chef/client.rb`` on all of your nodes to use the new public DNS.  For example:

   .. code-block:: none

      $ knife ssh name:* 'sudo sed -ie "s/chef_server_url.*/chef_server_url 'https://ec2-52-6-31-230.compute-1.amazonaws.com/organizations/your_org'/" /etc/chef/client.rb

   Replace ``ec2-52-6-31-230.compute-1.amazonaws.com`` with your new public DNS name and ``your_org`` with your organization name.

Chef Compliance AMI
=====================================================
Follow the steps in the sections below to install Chef Compliance in AWS Marketplace.

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

Configure Chef Compliance
-----------------------------------------------------
After the instance has been provisioned and initial configuration has completed (usually five to seven minutes) run through the setup wizard to create your user and register for a Chef support account. To complete the configuration, do the following:

#. Access the Chef Compliance setup wizard.  Build the URL by prepending ``https://`` and appending ``/#/setup`` to the IP address or public hostname that was automatically assigned when the Amazon Machine Images (AMI) was launched.  For example, ``https://<fqdn>/#/setup``.
#. Run through the setup wizard, and then log in to Chef Compliance webui ``https://<fqdn>``. If you opt into creating a support account you should receive a confirmation email for a Hosted Chef account. Follow the link in the confirmation email to complete the support account creation.

Troubleshooting
-----------------------------------------------------

Required ports
+++++++++++++++++++++++++++++++++++++++++++++++++++++
For a Chef Compliance instance that is launched from the AWS Marketplace, the following ports are configured automatically using the one-click installation:

.. list-table::
   :widths: 60 420
   :header-rows: 1

   * - Port
     - Description
   * - 443
     - HTTPS
   * - 22
     - SSH

If the Chef Compliance instance is launched in a way that does not use the one-click installation, these ports may need to be configured manually.

Change the hostname
+++++++++++++++++++++++++++++++++++++++++++++++++++++
To update the hostname, do the following:

#. Run ``sudo -i`` to gain administrator privileges.

#. Run ``chef-marketplace-ctl hostname`` to view the current hostname.

#. Configure the ``api_fqdn`` in ``/etc/chef-marketplace/marketplace.rb``

   .. code-block:: none

      $ echo 'api_fqdn "<new.hostname.com>"' | sudo tee -a /etc/chef-marketplace/marketplace.rb

#. Run ``chef-compliance-ctl stop && mv /etc/chef-compliance/chef-compliance.rb /etc/chef-compliance/chef-compliance.rb.bak`` to stop Chef Compliance and remove the configuration file.

#. Run ``chef-marketplace-ctl hostname <new.hostname.com>`` to update the hostname.

#. Run ``chef-compliance-ctl reconfigure`` to ensure Chef Compliance has beeen correctly configured with the new hostname.

#. Run ``chef-compliance-ctl restart`` to restart Chef Compliance

Change instance size
+++++++++++++++++++++++++++++++++++++++++++++++++++++
To edit the Amazon Machine Images (AMI) instance size, do the following:

#. Login using SSH to access the Chef Compliance instance. Use the SSH key pair and the IP address or public hostname that was automatically assigned when the Amazon Machine Images (AMI) was launched. The default user is ``ec2-user``. For example:

   .. code-block:: bash

      $ ssh -i /path/to/ssh_key.pem ec2-user@<instance IP address>

#. Stop the Chef Compliance server:

   .. code-block:: bash

      $ sudo chef-compliance-ctl stop

#. Navigate to the Amazon Web Services (AWS) instance in the AWS Management Console.
#. From the **Actions** dropdown, select **Instance State**, and then **Stop**.
#. After the instance transitions to **Stopped**, edit the instance size. From the **Actions** dropdown, select **Instance Settings**, and then **Change Instance Type**.
#. From the dropdown, select the desired instance size, and then click **Apply**.
#. From the **Actions** dropdown, select **Instance State**, and then click **Start**.
#. After the instance has started it will have a **new public IP address and public DNS**.
#. Use SSH to log into the new instance. Use the SSH key pair and new IP address:

   .. code-block:: bash

      $ ssh -i /path/to/ssh_key.pem ec2-user@<instance IP address>

#. Update the ``fqdn`` to use the public DNS name.

#. Reconfigure the Chef Compliance server:

   .. code-block:: bash

      $ sudo chef-compliance-ctl reconfigure

#. Verify that you can login to Chef Compliance server by navigating to ``https://fqdn``.

#. Update the public DNS entry: Replace ``ec2-52-6-31-230.compute-1.amazonaws.com`` with your new public DNS name and ``your_org`` with your organization name.

Upgrade Chef Compliance
+++++++++++++++++++++++++++++++++++++++++++++++++++++
The Chef Compliance Amazon Machine Images (AMI) can perform in-place upgrades of all of the pre-bundled software. This makes it easy to stay up-to-date with the latest versions of Chef Compliance and Chef Marketplace while not requiring data to be migrated to the latest published Amazon Machine Images (AMI).
There are 3 options: upgrade Chef Compliance; upgrade Chef Marketplace; upgrade everything.

To upgrade, do one of the following:

* Upgrade the Chef Compliance package by using the following command:

  .. code-block:: bash

     $ sudo chef-marketplace-ctl upgrade -c

  .. note:: Chef Compliance will be unavailable while the software is updated.

* Upgrade the Chef Marketplace package by using the following command:

  .. code-block:: bash

     $ sudo chef-marketplace-ctl upgrade -m

* Upgrade all the installed packages by using the following command:

  .. code-block:: bash

     $ sudo chef-marketplace-ctl upgrade -y

Migrate to AWS
+++++++++++++++++++++++++++++++++++++++++++++++++++++
To migrate an existing Chef Compliance installation to the Amazon Machine Images (AMI), do the following:

#. `Launch <https://docs.chef.io/aws_marketplace.html#chef-compliance-ami>`__ the latest Chef Compliance Amazon Machine Images (AMI).
#. Verify that the latest version of the Chef Compliance is installed by using the platform package manager: ``rpm -qa | grep chef-compliance`` and compare the result to the latest version available on the `downloads site <https://downloads.chef.io/>`__. If this is not the latest you can download and install the latest package from the downloads site or add the `chef repo <https://docs.chef.io/packages.html#package-repositories>`__ to your package manager. Follow the `upgrade instructions <https://docs.chef.io/upgrade_compliance.html>`__ for Chef Compliance to complete the upgrade.

#. Login using SSH to access the Chef Compliance instance. Use the SSH key pair and the IP address or public hostname that was automatically assigned when the Amazon Machine Images (AMI) was launched. The default user is ``ec2-user``. For example:

   .. code-block:: bash

      $ ssh -i /path/to/ssh_key.pem ec2-user@<instance IP address>

#. Update the software on the Chef Compliance Amazon Machine Images (AMI).  For example:

   .. code-block:: bash

      $ chef-marketplace-ctl upgrade -y

#. Copy the contents of the old instance to your new instance and restart the service. For example:

   .. code-block:: bash

      $ ssh -i /path/to/ssh_key.pem ec2-user@<instance IP address>
      $ chef-compliance-ctl stop
      $ rsync -avz -e "ssh -i /path/to/ssh_key.pem -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null" --progress /var/opt/chef-compliance ec2-user@<new instance IP address>:/var/opt/chef-compliance
      $ rsync -avz -e "ssh -i /path/to/ssh_key.pem -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null" --progress /etc/chef-compliance ec2-user@<new instance IP address>:/etc/chef-compliance
      $ chef-compliance-ctl reconfigure
      $ chef-compliance-ctl start

Migrate to the latest AMI
+++++++++++++++++++++++++++++++++++++++++++++++++++++
To migrate from an older Amazon Machine Images (AMI) to the latest Amazon Machine Images (AMI), do the following:

#. `Launch <https://docs.chef.io/aws_marketplace.html#chef-compliance-ami>`__ the latest Chef Compliance Amazon Machine Images (AMI).

#. Login using SSH to access the Chef Compliance instance and update the software. Use the SSH key pair and the IP address or public hostname that was automatically assigned when the Amazon Machine Images (AMI) was launched. The default user is ``ec2-user``. For example:

   .. code-block:: bash

      $ ssh -i /path/to/ssh_key.pem ec2-user@<instance IP address>
      $ chef-marketplace-clt upgrade -y

#. Repeat the previous step on the your old Chef Compliance instance.
#. Copy the contents of the old instance to your new instance and restart the service. For example:

   .. code-block:: bash

      $ ssh -i /path/to/ssh_key.pem ec2-user@<instance IP address>
      $ chef-compliance-ctl stop
      $ rsync -avz -e "ssh -i /path/to/ssh_key.pem -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null" --progress /var/opt/chef-compliance ec2-user@<new instance IP address>:/var/opt/chef-compliance
      $ rsync -avz -e "ssh -i /path/to/ssh_key.pem -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null" --progress /etc/chef-compliance ec2-user@<new instance IP address>:/etc/chef-compliance
      $ chef-compliance-ctl reconfigure
      $ chef-compliance-ctl start
