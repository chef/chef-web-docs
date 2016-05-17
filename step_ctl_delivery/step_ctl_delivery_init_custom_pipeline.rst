.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


To initialize a project using a |github| repository, run a command similar to:

.. code-block:: bash

   $ delivery init --generator PATH_TO_COOKBOOK -c PATH_TO_CONFIG -f PIPELINE

where ``PATH_TO_COOKBOOK`` is path to the cookbook generator, ``PATH_TO_CONFIG`` is the path to a ``config.json`` file, and ``PIPELINE`` is the name of a pipeline in |delivery|. For example to initialize a pipeine using the ``bc-generator`` cookbook generator and the ``trunk`` pipeline:

.. code-block:: bash

   $ delivery init --generator https://github.com/albertatom/bc-generator.git -c /Users/albertatom/chef/delivery/.delivery/config.json -f trunk

returns output similar to:

.. code-block:: bash

   Chef Delivery
   Loading configuration from /Users/albertatom/chef/delivery/organizations/sandbox/seapower
   Is /Users/albertatom/chef/delivery/organizations/sandbox/seapower a git repo?  yes
   Creating delivery project: seapower  created
   adding remote delivery: ssh://albertatom@Chef@delivery.chef.co:8989/Chef/sandbox/seapower
   Remote 'delivery' added to git config!
   Checking for content on the git remote delivery: No upstream content
   Pushing local content to server:
   To ssh://albertatom@Chef@delivery.chef.co:8989/Chef/sandbox/seapower
   *   refs/heads/master:refs/heads/master [new branch]
   Branch master set up to track remote branch master from delivery.
   Done
   
   Creating trunk  pipeline for project: seapower:  created
   Creating and checking out add-delivery-config feature branch: done
   Generating build cookbook skeleton
   Downloading build-cookbook generator from "https://github.com/albertatom/bc-generator.git"
   Build-cookbook generated: "chef" "generate" "cookbook" ".delivery/build-cookbook" "-g" "/Users/albertatom/.delivery/cache/generator-cookbooks/bc-generator"
   Adding and commiting build-cookbook: done
   Copying configuration to /Users/albertatom/chef/delivery/organizations/sandbox/seapower/.delivery/config.json
   New delivery configuration
   --------------------------
   {
     "version": "2",
     "build_cookbook": {
       "path": ".delivery/build-cookbook",
       "name": "build-cookbook"
     },
     "skip_phases": [
       "smoke",
       "security",
       "syntax",
       "lint",
       "quality"
     ],
     "build_nodes": {},
     "delivery-truck": {
       "publish": {
         "chef_server": true
       }
     },
     "dependencies": []
   }
   
   Git add and commit delivery config: done
   Chef Delivery
   Loading configuration from /Users/albertatom/chef/delivery/organizations/sandbox/seapower
   Review for change add-delivery-config targeted for pipeline trunk
   Created new patchset
   https://delivery.chef.co/e/Chef/#/organizations/sandbox/projects/seapower/changes/9e5b6c36-8deb-4c5c-822c-52e2863b8bb6
     seapower git:(add-delivery-config)
