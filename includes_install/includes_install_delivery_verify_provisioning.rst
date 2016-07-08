.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


To verify provisioning (from inside the ``delivery-cluster`` directory), do the following:

#. Run the following command:

   .. code-block:: bash

      $ rake info:list_core_services

#. Get the credentials and URL for the |chef server| with the following command:

   .. code-block:: bash

      $ rake info:delivery_creds

   It will return output similar to:

   .. code-block:: bash

      Chef Server
      Username: delivery
      Password: m90wul1YG6DafdytgervfuIkrBlz0Eg=
      Chef Server URL: https://URL_FOR_CHEF_SERVER
      
      Chef Automate Server
      Created enterprise: delivery-enterprise
      Admin username: admin
      Admin password: +Fy1p5zRsIase5yhtrefi+Evmqq2CCD9BAUQ=
      Builder Password: Tw4Z3456gytyiwy+8ar6YByu9waw45y/po=
      Web login: https://URL_FOR_DELIVERY_SERVER

#. Navigate to the |chef server| URL, and then use the credentials that were returned to log in.
#. Click on **Nodes**. and verify that the |delivery| server, build nodes, and other nodes are available.
#. Navigate to the **Web Login** for the |delivery| server, and then use the ``admin`` credentials that were returned to log in.
#. Run the following command:

   .. code-block:: bash

      $ knife node status

   All build nodes should report available.
