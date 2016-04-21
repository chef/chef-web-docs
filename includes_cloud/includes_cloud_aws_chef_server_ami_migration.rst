.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

To migrate from an older |amazon ami| to the latest |amazon ami|, do the following:

#. `Launch <https://docs.chef.io/aws_marketplace.html#launch-the-ami>`__ the latest |chef server| |amazon ami|.

#. Login to the old |amazon ami| and ensure that it is running the latest version of the |chef server|:

   .. code-block:: bash

      $ chef-marketplace-ctl upgrade -y

#. .. include:: ../../step_install/step_install_chef_server_backup.rst

#. Copy the resulting tarball to your new |amazon ami| instance:

   .. code-block:: bash

      $ scp /tmp/chef-backup-2014-12-10-20-31-40.tgz ec2-user@<MARKETPLACE AMI IP ADDRESS>:/tmp/

#. Login to the new |amazon ami| and ensure that it is running the latest version of the |chef server|:

   .. code-block:: bash

      $ chef-marketplace-ctl upgrade -y

#. Backup the marketplace configuration file on the new |amazon ami|:

   .. code-block:: bash

      $ cp /etc/chef-marketplace/marketplace.rb /tmp/marketplace.rb

#. Restore the backup:

   .. code-block:: bash

      $ chef-server-ctl restore /tmp/chef-backup-2014-12-10-20-31-40.tgz

#. Restore the marketplace configuration file on the new |amazon ami| and configure the |chef server|:

   .. code-block:: bash

      $ cp /tmp/marketplace.rb /etc/chef-marketplace/marketplace.rb
      $ chef-marketplace-ctl reconfigure
      $ chef-server-ctl reconfigure
      $ chef-manage-ctl reconfigure

#. Download your new starter kit:

   Login to the |chef manage| by navigating to ``https://<MARKETPLACE AMI IP ADDRESS>/getting_started`` and download the starter kit.

#. .. include:: ../../step_install/step_install_aws_chef_server_extract_starter_kit.rst
#. .. include:: ../../step_install/step_install_aws_chef_server_knife_ssl_fetch.rst
#. .. include:: ../../step_install/step_install_aws_chef_server_knife_client_list.rst

#. Update the ``/etc/chef/client.rb`` on all of your nodes to use the new public DNS.  For example:

   .. code-block:: bash

      $ knife ssh name:* 'sudo sed -ie "s/chef_server_url.*/chef_server_url 'https://ec2-52-6-31-230.compute-1.amazonaws.com/organizations/your_org'/" /etc/chef/client.rb

   Replace ``ec2-52-6-31-230.compute-1.amazonaws.com`` with your new public DNS name and ``your_org`` with your organization name.
