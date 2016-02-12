.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


To edit the |amazon ami| instance size, do the following:

#. Login using |ssh| to access the |chef server| instance. Use the |ssh| key pair and the IP address or public hostname that was automatically assigned when the |amazon ami| was launched. The default user is ``ec2-user``. For example:

   .. code-block:: bash

      $ ssh -i /path/to/ssh_key.pem ec2-user@<instance IP address>

#. .. include:: ../../step_install/step_install_chef_server_stop.rst

#. Navigate to the |amazon aws| instance in the |amazon aws console|.
#. From the **Actions** dropdown, select **Instance State**, and then **Stop**.
#. After the instance transitions to **Stopped**, edit the instance size. From the **Actions** dropdown, select **Instance Settings**, and then **Change Instance Type**.
#. From the dropdown, select the desired instance size, and then click **Apply**.
#. From the **Actions** dropdown, select **Instance State**, and then click **Start**.
#. After the instance has started it will have a **new public IP address and public DNS**.
#. Use |ssh| to log into the new instance. Use the |ssh| key pair and new IP address: 

   .. code-block:: bash

      $ ssh -i /path/to/ssh_key.pem ec2-user@<instance IP address>

#. Update the API |fqdn| in ``/etc/opscode/chef-server.rb`` using the public DNS name.  For example:

   .. code-block:: bash

      $ sudo sed -ie "s/api_fqdn.*/api_fqdn 'ec2-52-6-31-230.compute-1.amazonaws.com'/" /etc/opscode/chef-server.rb

   Replace ``ec2-52-6-31-230.compute-1.amazonaws.com`` with the public DNS name.

#. .. include:: ../../step_install/step_install_chef_server_reconfigure.rst
#. .. include:: ../../step_install/step_install_chef_manage_reconfigure.rst

#. Verify that you can login to |chef manage| by navigating to ``https://<YOUR NEW PUBLIC DNS>/login``.

   .. note:: .. include:: ../../includes_notes/includes_notes_chef_aws_ssl.rst

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
      client_key               '#{current_dir}/your_username.pem'
      validation_client_name   'your_username-validator'
      validation_key           '#{current_dir}/your_username-validator.pem'
      chef_server_url          'https://<YOUR NEW PUBLIC DNS>/organizations/your_org'
      cookbook_path            ['#{current_dir}/../cookbooks']

#. .. include:: ../../step_install/step_install_aws_chef_server_knife_ssl_fetch.rst
#. .. include:: ../../step_install/step_install_aws_chef_server_knife_client_list.rst
#. .. include:: ../../step_install/step_install_aws_chef_server_update_to_public_dns.rst
