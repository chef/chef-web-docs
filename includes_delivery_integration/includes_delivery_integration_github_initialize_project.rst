After associating the appropriate GitHub and Chef Automate user accounts, you can setup and initialize your |github| repo to be managed by |automate|.

#. Create a local clone of a GitHub repo and ``cd`` into it.
#. Create a ``.delivery/cli.toml`` using ``delivery setup``:

   .. code-block:: bash

      $ delivery setup --ent=$DELIVERY_ENTERPRISE --org=$DELIVERY_ORG --user=$DELIVERY_USER_NAME --server=$DELIVERY_SERVER

#. Run ``delivery init``to generate a ``.delivery/config.json`` file, create a build cookbook, and submit a change to |delivery| to initialize a pipeline for the project. Changes are opened in the |delivery| web UI. At this point, a corresponding pull request is shown in |github|.

   .. include:: ../../step_ctl_delivery/step_ctl_delivery_init_github_project.rst

#. Push the code to |github|.

   .. code-block:: bash

      $ git push origin add_delivery_config

#. Finally, create a pull request from this change in the |github| webui.