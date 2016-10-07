.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


To configure |supermarket| to use |chef identity|, do the following:

#. Log on to the |chef server| via |ssh| and elevate to an admin-level user. If running a multi-node |chef server| cluster, log on to the node acting as the primary node in the cluster.
#. Update the ``/etc/opscode/chef-server.rb`` configuration file.

   .. include:: ../../step_config/step_config_ocid_application_hash_supermarket.rst

#. Reconfigure the |chef server|.

   .. code-block:: bash

      $ sudo chef-server-ctl reconfigure

#. |oauth| 2.0 data is located in ``/etc/opscode/oc-id-applications/supermarket.json``:

   .. code-block:: javascript

      {
        "name": "supermarket",
        "uid": "0bad0f2eb04e935718e081fb71asdfec3681c81acb9968a8e1e32451d08b",
        "secret": "17cf1141cc971a10ce307611beda7ffadstr4f1bc98d9f9ca76b9b127879",
        "redirect_uri": "https://supermarket.mycompany.com/auth/chef_oauth2/callback"
      }

   The ``uid`` and ``secret`` values will be needed later on during the setup process for |supermarket|.

.. note:: Add as many |chef identity| applications to the |chef server rb| configuration file as necessary. A |json| file is generated for each application added, which contains the authentication tokens for that application. The secrets are added to the |chef identity| database and are available to all nodes in the |chef server| front end group. The generated |json| files do not need to be copied anywhere.
