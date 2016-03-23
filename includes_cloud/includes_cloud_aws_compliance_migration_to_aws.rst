.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

To migrate an existing |chef compliance| installation to the |amazon ami|, do the following:

#. `Launch <https://docs.chef.io/aws_marketplace.html#chef-compliance-ami>`__ the latest |chef compliance| |amazon ami|.
#. Verify that the latest version of the |chef compliance| is installed by using the platform package manager: ``rpm -qa | grep chef-compliance`` and compare the result to the latest version available on the `downloads site <https://downloads.chef.io/>`__. If this is not the latest you can download and install the latest package from the downloads site or add the `chef repo <https://docs.chef.io/packages.html#package-repositories>`__ to your package manager. Follow the `upgrade instructions <https://docs.chef.io/upgrade_compliance.html>`__ for |chef compliance| to complete the upgrade.

#. Login using |ssh| to access the |chef compliance| instance. Use the |ssh| key pair and the IP address or public hostname that was automatically assigned when the |amazon ami| was launched. The default user is ``ec2-user``. For example:

   .. code-block:: bash

      $ ssh -i /path/to/ssh_key.pem ec2-user@<instance IP address>

#. Update the software on the |chef compliance| |amazon ami|.  For example:

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
