.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


After the |chef dk| is installed and the |amazon ami| for |chef server| has been provisioned, do the following:

#. Login using |ssh| to access the |chef server| instance. Use the |ssh| key pair and the IP address or public hostname that was automatically assigned when the |amazon ami| was launched. The default user is ``ec2-user``. For example:

   .. code-block:: bash

      $ ssh -i /path/to/ssh_key.pem ec2-user@<instance IP address>

   .. note:: It may take a few minutes after the instance is available for the |ssh| daemon to be ready to accept connections.

#. If you're using the |amazon ami| version 12.0.1-2 or earlier you'll need to fix ``cloud-init``, otherwise, move to the next step.

   .. code-block:: bash

      $ sudo sed -i '/^preserve_hostname/d' /etc/cloud/cloud.cfg
      $ sudo rm -rf /var/lib/cloud
      $ sudo /usr/bin/cloud-init -d init

#. Configure the |chef server| using the following command:

   .. code-block:: bash

      $ sudo chef-server-ctl marketplace-setup

#. The ``marketplace-setup`` command should output the username and URL required to login to the |chef manage|. Follow the supplied link and login.

   .. note:: .. include:: ../../includes_notes/includes_notes_chef_aws_ssl.rst

#. The ``marketplace-setup`` command should supply a link to the starter kit, which is a zip file that contains various configuration files for the workstation, including the user key required for authentication to the |chef server| and the validation key used to bootstrap nodes with the |chef server|. Follow the link that is provided and download the starter kit.

#. .. include:: ../../step_install/step_install_aws_chef_server_extract_starter_kit.rst
#. .. include:: ../../step_install/step_install_aws_chef_server_knife_ssl_fetch.rst
#. .. include:: ../../step_install/step_install_aws_chef_server_knife_client_list.rst
#. Add virtual machines to the |chef server|.
#. Bootstrap nodes with the |chef server|.
