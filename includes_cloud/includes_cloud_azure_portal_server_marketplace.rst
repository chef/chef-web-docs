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

   .. note:: If you are using the "Resource Manager" deployment model, you will need to create a **DNS Name** label for the instance. Create a **DNS Name** label by selecting the **Public IP Address** setting of the virtual machine, and then add it under **Settings**, then  **Configuration**, and then **DNS Name**. Click **Save** in the top pane to apply the changes. Use the full |fqdn| when running the ``chef-marketplace-ctl hostname`` command.

#. Once the virtual machine is launched, you will need to create an account to use with the |chef manage|. To do this, open an |ssh| connection to the host using the user name and password (or |ssh| key) provided when you launch the virtual machine.

#. Once logged in, run the following commands:

   .. code-block:: bash
   
      $ sudo chef-marketplace-ctl hostname <fqdn>

   where ``fqdn`` is the fully qualified domain name of the machine.

   .. code-block:: bash

      $ sudo chef-server-ctl marketplace-setup

   the setup command will prompt you for the appropriate information needed to set up your chef server (e.g. username, password, organzation, etc.). You will also be prompted to accept the license agreement.

#. Accept the **License Agreement**.

#. The ``chef-server-ctl marketplace setup`` command should return success. Navigate in a web browser to the appropriate URL of the |chef server| outputted by the setup command.

#. The marketplace-setup command should supply a link to the starter kit, which is a zip file that contains various configuration files for the workstation, including the user key required for authentication to the |chef server| and the validation key used to bootstrap nodes with the |chef server|. Follow the link that is provided and download the starter kit.

#. Extract the starter kit zip file downloaded. Open a command prompt and change into the ``chef-repo`` directory extracted from the starter kit.

#. Run ``knife ssl fetch`` to retrieve the |ssl| keys for the |chef server|.

#. Run ``knife client list`` to test the connection to the |chef server|. The command should return ``<orgname>-validator``, where ``<orgname>`` is the name of the organization you previously created. You are now ready to add virtual machines to your |chef server|.
