.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

The process of migrating from an existing |chef server| installation to the |amazon ami| differs depending on which software version being used and the location in which it is deployed. In all scenarios, data is first migrated to the latest |chef server| schema, after which it is migrated to the |amazon ami|.

* Verify that the latest version of the |chef server| is installed by using the platform package manager: ``rpm -qa | grep chef-server-core`` and compare the result to the latest version available on the `downloads site <https://downloads.chef.io/>`__. If this is not the latest version, download the package, and then `upgrade <https://docs.chef.io/upgrade_server.html#from-chef-server-title-12>`__ to the latest version.
* Upgrade an |chef server oec| node to the latest version of the |chef server| by following the `upgrade instructions <https://docs.chef.io/upgrade_server.html#from-chef-server-oec>`__.
* Upgrade an |chef server osc| node to the latest version of the |chef server| by following the `upgrade instructions <https://docs.chef.io/upgrade_server.html#from-chef-server-osc>`__.

After verifying that your existing |chef server| installation is up to date, do the following to migrate to the |amazon ami| instance:

#. .. include:: ../../step_install/step_install_chef_server_backup.rst

#. Copy the resulting tarball to your |amazon ami| instance:

   .. code-block:: bash

      $ scp /tmp/chef-backup-2014-12-10-20-31-40.tgz ec2-user@<MARKETPLACE AMI IP ADDRESS>:/tmp/

#. Login to the |amazon ami| and ensure that it is running the latest version of the |chef server|:

   .. code-block:: bash

      $ chef-marketplace-ctl upgrade -y

#. .. include:: ../../step_install/step_install_chef_server_reconfigure.rst

#. Restore the backup:

   .. code-block:: bash

      $ chef-server-ctl restore /tmp/chef-backup-2014-12-10-20-31-40.tgz

#. Download your new starter kit:

   Login to the |chef manage| by navigating to ``https://<MARKETPLACE AMI IP ADDRESS>/getting_started`` and download the starter kit.

#. .. include:: ../../step_install/step_install_aws_chef_server_extract_starter_kit.rst
#. .. include:: ../../step_install/step_install_aws_chef_server_knife_ssl_fetch.rst
#. .. include:: ../../step_install/step_install_aws_chef_server_knife_client_list.rst

#. Update the ``/etc/chef/client.rb`` on all of your nodes to use the new public DNS.  For example:

   .. code-block:: none

      $ knife ssh name:* 'sudo sed -ie "s/chef_server_url.*/chef_server_url 'https://ec2-52-6-31-230.compute-1.amazonaws.com/organizations/your_org'/" /etc/chef/client.rb

   Replace ``ec2-52-6-31-230.compute-1.amazonaws.com`` with your new public DNS name and ``your_org`` with your organization name.
