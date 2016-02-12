.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

.. note:: These instructions assume that you will use |chef delivery| as your source code source of truth and your |chef delivery| is not integrated with GitHub.

This topic describes a manual setup for a Chef cookbook project with delivery-truck as your build cookbook.

The following example shows how to create a new cookbook, but then do all of the steps required by |chef delivery| manually. These commands should be run, mostly, from a |chef delivery| workstation.

#. Create a project in |chef delivery|: log into the |chef delivery| web user interface with administrator (**Admin**) credentials. If you need to find your credentials, go back to your provisioning node and use this command:

   .. code-block:: bash

      $ rake info:delivery_creds

#. Once logged into |chef delivery| from your workstation, select **Organizations** in drop-down menu at the upper right.
#. Click your organization, or create it if necessary.

   .. include:: ../../steps_provisioning/steps_add_new_project_default_only.rst

#. Create a working directory: 

   .. code-block:: bash

      $ mkdir ~/workspace
      $ cd ~/workspace

#. Clone a project with the ``delivery`` CLI:

   .. code-block:: bash

      $ delivery clone new-project --server=SERVER --ent=ENTERPRISE --org=ORGANIZATION --user=USERNAME

#. Move to the new project directory:

   .. code-block:: bash

      $ cd new-project

#. Create a cookbook:

   .. code-block:: bash

      $ chef generate cookbook NEW_COOKBOOK_NAME

   This uses the |chef dk| to generate a new cookbook, including a default recipe and default |chef spec| tests.

#. Move to the directory of the new cookbook:   

   .. code-block:: bash

      $ cd NEW_COOKBOOK_NAME

#. Create the initial commit on the "master" branch:

   .. code-block:: bash

      $ git add .
      $ git commit -m 'Initial Commit'

#. Push the master branch:

   .. code-block:: bash

      $ git push delivery master

#. Create a pipeline in |chef delivery|. First, log into the |chef delivery| web user interface with administrator credentials, use this command to find your credentials:

   .. code-block:: bash

      $ cat ~/delivery-cluster/.chef/delivery-cluster-data/ENTERPRISE.creds

   Then click **Organizations** in the left column, and select your organization and project.

   In the page header click the **Pipelines** tab and enter ``master`` for **New Pipeline Name** and accept ``master`` for **Pipeline Base**.

   Save the pipeline.

#. Initialize the cookbook for |chef delivery|. First, create a feature branch (``add-delivery-config`` in the example):

   .. code-block:: bash

      $ git checkout -b add_delivery_config

   and then create the configuration:

   .. code-block:: bash

      $ mkdir .delivery

#. Create config.json in the .delivery directory as follows: 

   .. code-block:: javascript

      {
        "version": "2",
        "build_cookbook": {
          "branch": "master",
          "name": "delivery-truck",
          "git": "https://github.com/opscode-cookbooks/delivery-truck.git"
        },
        "skip_phases": [
          "smoke",
          "security",
          "quality"
        ]
        "build_nodes": {},
        "delivery-truck": {
          "publish": {
            "chef_server": true
          }
        }     
      }

   This configures the cookbook to be built with ``delivery-truck``, which is the open source build cookbook for |chef delivery|. It also causes Delivery to skip the phases that are irrelevant to cookbook changes. And, it pushes your change (the new cookbook) to your delivery cluster Chef server. If your nodes have that cookbook in their run list, they will pick up the change when they next sync.

#. Add the config.json changes to the feature branch:

   .. code-block:: bash

      $ git add .delivery
      $ git commit -m 'Add delivery config'

#. Submit these changes for review:

   .. code-block:: bash

      $ delivery review

   This immediately kicks off the configured Delivery pipeline. You must manually **Approve** the change (use the button) after the **Verify** phase, and manually **Deliver** the change (use the button) after the **Build** phase. The final four phases, **Acceptance**, **Union**, **Rehearsal**, and **Delivered** happen automatically.
