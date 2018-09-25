=====================================================
Chef Compliance for Microsoft Azure
=====================================================
`[edit on GitHub] <https://github.com/chef/chef-web-docs/blob/master/chef_master/source/azure_portal.rst>`__

.. tag cloud_azure_portal

Microsoft Azure is a cloud hosting platform from Microsoft that provides virtual machines and integrated services for you to use with your cloud and hybrid applications. Through the Azure Marketplace and the `Azure portal <https://portal.azure.com/>`_, virtual machines can be bootstrapped and ready to run Chef Automate, Chef Compliance and Chef client.

.. end_tag

Chef Compliance
=====================================================
Chef provides a fully functional Chef Compliance VM image that can be launched from the Azure Marketplace.

#. Sign in to the `Azure portal <https://portal.azure.com/>`_ and authenticate using your Microsoft Azure account credentials.

#. Click the **New** icon in the upper-left corner of the portal.

#. In the search box enter **Chef Compliance**.

#. Select the **Chef Compliance** offering that is appropriate for your size.

   .. note::  Chef Compliance is available on the Azure Marketplace in 5, 25, 50, 100, 150, 200, and 250 licensed images.

#. Click **Create** and follow the steps to launch the Chef Compliance image, providing credentials, VM size, and any additional information required.

#. Once your VM has been created, create a **DNS name label** for the instance by following these instructions:  https://azure.microsoft.com/en-us/documentation/articles/virtual-machines-create-fqdn-on-portal/

#. Once the virtual machine is launched you will need to create an account. To do this, open an SSH connection to the host using the user name and password (or SSH key) provided when you launch the virtual machine.

   .. note:: In the following steps substitute ``<fqdn>`` for the fully qualified domain **DNS NAME** that you created.

#. Update the ``/etc/chef-marketplace/marketplace.rb`` file to include the ``api_fqdn`` of the machine.

   .. code-block:: none

      $ echo 'api_fqdn "<fqdn>"' | sudo tee -a /etc/chef-marketplace/marketplace.rb

#. Update the ``/etc/chef-compliance/chef-compliance.rb`` file to include the ``fqdn`` of the machine.

   .. code-block:: none

      $ echo 'fqdn "<fqdn>"' | sudo tee -a /etc/chef-compliance/chef-compliance.rb

#. Run the following command to update the hostname and reconfigure the software:

   .. code-block:: bash

      $ sudo chef-marketplace-ctl hostname <fqdn>
      $ sudo chef-compliance-ctl reconfigure

#. Now proceed to the web based setup wizard ``https://<fqdn>/#/setup``.

   .. note:: Before you can run through the wizard you must provide the VM Name of the instance in order to ensure that only you are configuring the Chef Compliance instance.

#. Follow the prompts to sign up for a new account.
