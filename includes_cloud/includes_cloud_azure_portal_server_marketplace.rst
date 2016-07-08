.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

|chef| provides a fully functional |chef server| that can be launched from the |azure marketplace|. This server is preconfigured with |chef server|, the |chef manage|, |reporting|, and |chef analytics|. This configuration is free to use for deployments under 25 nodes, and can be licensed for deployments beyond 25 nodes. (See |url pricing| for more information about licensing more than 25 nodes.)

Before getting started, you will need a functioning workstation. Install the `Chef development kit <https://docs.chef.io/install_dk.html>`_ on that workstation.

   .. note:: The following steps assume that |chef| is installed on the workstation and that the ``knife ssl fetch`` subcommand is available. The ``knife ssl fetch`` subcommand was added to |chef| in the 11.16 release of the |chef client|, and then packaged as part of the |chef dk| starting with the 0.3 release.)

#. Sign in to the |azure portal_preview| (|url azure_preview|). (The |azure marketplace| offering is only available via the preview portal.) Authenticate using your |azure| account credentials.

#. Click the **New** icon in the lower left corner of the portal.

#. Click **Compute**, then click **Azure Marketplace**.

#. In the search box enter **Chef Server**.

#. Select the **Chef Server 12** offering that is appropriate for your size.

   .. note:: The |chef server| is available on the |azure marketplace| in 25, 50, 100, 150, 200, and 250 licensed images, as well as a "Bring Your Own License" image.

#. Click **Create** and follow the steps to launch the |chef server|, providing a host name, user name, password or |ssh| key, and any additional information required. You will also select your deployment model here.

#. Create a **DNS Name** label for the instance. <https://azure.microsoft.com/en-us/documentation/articles/virtual-machines-create-fqdn-on-portal/>

#. Once the instance is launched you will need to create an account to use with the |chef manage|. To do this, open an |ssh| connection to the host using the user name and password (or |ssh| key) provided when you launched the instance.

#. Wait for the |chef server| to complete initial configuration.  You'll want to tail the ``cloud-init`` logfile until it has finished. For example:

   .. code-block:: bash

      $ tailf /var/log/cloud-init-output.log

   will return something similar to:

   .. code-block:: none

	cloud-init v. 0.7.5 finished at Thu, 05 May 2016 21:41:21 +0000. Datasource DataSourceAzureNet [seed=/dev/sr0].  Up 740.33 seconds
      
#. After ``cloud-init`` has completed, configure the |chef server| with the DNS Name.

   .. note:: In the following steps substitute ``<fqdn>`` for the fully qualified domain **DNS NAME** that you created.

#. Remove the |nginx| configuration for the existing |chef analytics| configuration:

   .. code-block:: bash

      $ sudo rm /var/opt/opscode/nginx/etc/nginx.d/analytics.conf

#. Update the ``/etc/chef-marketplace/marketplace.rb`` file to include the ``api_fqdn`` of the machine:

   .. code-block:: none

      $ echo 'api_fqdn "<fqdn>"' | sudo tee -a /etc/chef-marketplace/marketplace.rb

#. Update the ``/etc/opscode-analytics/opscode-analytics.rb`` file to include the ``analytics_fqdn`` of the machine:

   .. code-block:: none

      $ echo 'analytics_fqdn "<fqdn>"' | sudo tee -a /etc/opscode-analytics/opscode-analytics.rb

#. Run the following command to update the hostname and reconfigure the software:

   .. code-block:: bash

      $ sudo chef-marketplace-ctl hostname <fqdn>

#. Run the following command to update reconfigure |chef analytics|:

   .. code-block:: bash

      $ sudo opscode-analytics-ctl reconfigure

#. Now proceed to the web based setup wizard ``https://<fqdn>/signup``.

#. Before you can run through the wizard you must provide the VM Name or DNS Label of the instance in order to ensure that only you are configuring the |chef server|.

#. Follow the links to sign up for a new account and download the starter kit.

#. Extract the starter kit zip file downloaded. Open a command prompt and change into the ``chef-repo`` directory extracted from the starter kit.

#. Run ``knife ssl fetch`` to retrieve the |ssl| keys for the |chef server|.

#. Run ``knife client list`` to test the connection to the |chef server|. The command should return ``<orgname>-validator``, where ``<orgname>`` is the name of the organization you previously created. You are now ready to add virtual machines to your |chef server|.
