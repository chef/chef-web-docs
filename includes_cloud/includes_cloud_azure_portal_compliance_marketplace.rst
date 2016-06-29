.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

|chef| provides a fully functional |chef compliance| image that can be launched from the |azure marketplace|.

#. Sign in to the |azure portal_preview| (|url azure_preview|). (The |azure marketplace| offering is only available via the preview portal.) Authenticate using your |azure| account credentials.

#. Click the **New** icon in the lower left corner of the portal.

#. Click **Compute**, then click **Azure Marketplace**.

#. In the search box enter **Chef Compliance**.

#. Select the **Chef Compliance** offering that is appropriate for your size.

   .. note::  |chef compliance| is available on the |azure marketplace| in 5, 25, 50, 100, 150, 200, and 250 licensed images.

#. Click **Create** and follow the steps to launch the |chef compliance| image, providing a host name, user name, password or |ssh| key, and any additional information required. You will also select your deployment model here.

   .. note:: If you are using the "Resource Manager" deployment model, you will need to create a **DNS Name** label for the instance. <https://azure.microsoft.com/en-us/documentation/articles/virtual-machines-create-fqdn-on-portal/>

#. Once the virtual machine is launched you will need to create an account. To do this, open an |ssh| connection to the host using the user name and password (or |ssh| key) provided when you launch the virtual machine.

   .. note:: In the following steps substitute ``<fqdn>`` for the fully qualified domain **DNS NAME** that you created.

#. Update the ``/etc/chef-marketplace/marketplace.rb`` file to include the ``api_fqdn`` of the machine.

   .. code-block:: bash

      $ echo 'api_fqdn "<fqdn>"' | sudo tee -a /etc/chef-marketplace/marketplace.rb

#. Update the ``/etc/chef-compliance/chef-compliance.rb`` file to include the ``fqdn`` of the machine.

   .. code-block:: bash

      $ echo 'fqdn "<fqdn>"' | sudo tee -a /etc/chef-compliance/chef-compliance.rb

#. Run the following command to update the hostname and reconfigure the software:

   .. code-block:: bash

      $ sudo chef-marketplace-ctl hostname <fqdn>
      $ sudo chef-compliance-ctl reconfigure

#. Now proceed to the web based setup wizard ``https://<fqdn>/#/setup``

#. Before you can run through the wizard you must provide the VM Name of the instance in order to ensure that only you are configuring the |chef compliance| instance.

#. Follow the prompts to sign up for a new account.
