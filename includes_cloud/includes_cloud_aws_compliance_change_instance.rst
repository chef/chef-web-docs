.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


To edit the |amazon ami| instance size, do the following:

#. Login using |ssh| to access the |chef compliance| instance. Use the |ssh| key pair and the IP address or public hostname that was automatically assigned when the |amazon ami| was launched. The default user is ``ec2-user``. For example:

   .. code-block:: bash

      $ ssh -i /path/to/ssh_key.pem ec2-user@<instance IP address>

#. Stop the |chef compliance| server:

   .. code-block:: bash 

      $ sudo chef-compliance-ctl stop

#. Navigate to the |amazon aws| instance in the |amazon aws console|.
#. From the **Actions** dropdown, select **Instance State**, and then **Stop**.
#. After the instance transitions to **Stopped**, edit the instance size. From the **Actions** dropdown, select **Instance Settings**, and then **Change Instance Type**.
#. From the dropdown, select the desired instance size, and then click **Apply**.
#. From the **Actions** dropdown, select **Instance State**, and then click **Start**.
#. After the instance has started it will have a **new public IP address and public DNS**.
#. Use |ssh| to log into the new instance. Use the |ssh| key pair and new IP address: 

   .. code-block:: bash

      $ ssh -i /path/to/ssh_key.pem ec2-user@<instance IP address>

#. Update the ``fqdn`` to use the public DNS name.

#. Reconfigure the |chef compliance| server:

   .. code-block:: bash 

      $ sudo chef-compliance-ctl reconfigure

#. Verify that you can login to |chef compliance| server by navigating to ``https://fqdn``.

#. Update the public DNS entry: Replace ``ec2-52-6-31-230.compute-1.amazonaws.com`` with your new public DNS name and ``your_org`` with your organization name.
