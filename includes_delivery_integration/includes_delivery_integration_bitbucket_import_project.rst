.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


You can repeat these steps for each |bitbucket| project to be added to |chef delivery|:

#. Create a local clone of the project **from Bitbucket** and ``cd`` into it.
#. Create a ``.delivery/cli.toml`` using ``delivery setup``:

   .. code-block:: bash

      $ delivery setup --ent=$DELIVERY_ENTERPRISE --org=$DELIVERY_ORG --user=$DELIVERY_USER_NAME --server=$DELIVERY_SERVER

#. Run ``delivery init`` to push the code to the empty project in |chef delivery| (as created above). After importing the code, this command will generate a ``.delivery/config.json`` file, create a build cookbook, and submit a change to |chef delivery| to initialize a pipeline for the project. Changes are opened in the |chef delivery| webui. At this point, a corresponding pull request is shown in |bitbucket|.
