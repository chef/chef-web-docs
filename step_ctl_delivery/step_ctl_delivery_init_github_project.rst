.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


To initialize a project using a |github| repository, run a command similar to:

.. code-block:: bash

   $ delivery init --github ORG_NAME -r REPO_NAME

where ``ORG_NAME`` is the name of the GitHub organization and ``REPO_NAME`` is the name of the repository in |github|. For example to initialize the ``seapower`` repository in |github| with the ``chef-cookbooks`` organization:

.. code-block:: bash

   $ delivery init --github chef-cookbooks -r seapower

and returns output similar to:

.. code-block:: bash

   Chef Delivery
   Loading configuration from /Users/albertatom/chef/delivery/organizations/sandbox/seapower
   Is /Users/albertatom/chef/delivery/organizations/sandbox/seapower a git repo?  yes
   Project seapower already exists.
   Creating and checking out add-delivery-config feature branch: done
   Generating build cookbook skeleton
   Using cached copy of build-cookbook generator "/Users/albertatom/.delivery/cache/generator-cookbooks/pcb"
   Build-cookbook generated: "chef" "generate" "cookbook" ".delivery/build-cookbook" "-g" "/Users/albertatom/.delivery/cache/generator-cookbooks/pcb"
   Adding and commiting build-cookbook: done
   Writing configuration to /Users/albertatom/chef/delivery/organizations/sandbox/seapower/.delivery/config.json
   New delivery configuration
   --------------------------
   {
     "version": "2",
     "build_cookbook": {
       "path": ".delivery/build-cookbook",
       "name": "build-cookbook"
     },
     "skip_phases": [],
     "build_nodes": {},
     "dependencies": []
   }
   Git add and commit delivery config: done
   Push add-delivery-config branch and create Pull Request
