.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

To migrate an existing |chef compliance| |amazon ami| to the latest version, do the following:

#. Launch the latest |chef compliance| |amazon ami|.
#. Login using |ssh| to access the |chef compliance| instance. Use the |ssh| key pair and the IP address or public hostname that was automatically assigned when the |amazon ami| was launched. The default user is ``ec2-user``. For example:

   .. code-block:: bash

      $ ssh -i /path/to/ssh_key.pem ec2-user@<instance IP address>
      $ chef-marketplace-clt upgrade -y

#. Repeat the previous step on the your old |chef compliance| instance.
#. Copy the contents of the old instance to your new instance and restart the service.  For example:

   .. code-block:: bash

      $ ssh -i /path/to/ssh_key.pem ec2-user@<instance IP address>
      $ chef-compliance-ctl stop
      $ rsync -avz -e "ssh -i /path/to/ssh_key.pem -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null" --progress /var/opt/chef-compliance ec2-user@<new instance IP address>:/var/opt/chef-compliance
      $ rsync -avz -e "ssh -i /path/to/ssh_key.pem -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null" --progress /etc/chef-compliance ec2-user@<new instance IP address>:/etc/chef-compliance
      $ chef-compliance-ctl reconfigure
      $ chef-compliance-ctl start
