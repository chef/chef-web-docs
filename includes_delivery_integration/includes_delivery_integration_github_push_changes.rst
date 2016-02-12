.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


Next, you must create some commits in the repository. This is not a change submission, this is just a base of code from which to build. |chef delivery| cannot currently operate on a completely empty repository. (Below are steps for a cookbook):

.. code-block:: bash

   $ chef generate cookbook <deliv_proj>
   $ cd <deliv_proj>
   $ git init && git add . && git commit -m 'Initial Commit'
   $ git remote add origin <github_ssh_url>
   $ git push origin master

Next, you'll actually create a first pull request; customarily, this is the addition of a  ``.delivery/config.json`` file. The one shown below is a good starting point for a cookbook.

.. code-block:: bash

   $ git checkout -b add_delivery_config
   $ mkdir .delivery

Edit ``.delivery/config.json`` like so:

.. code-block:: javascript

   {
     "version": "2",
     "build_cookbook": {
       "git": "https://github.com/opscode-cookbooks/delivery-truck.git",
       "name": "delivery-truck",
       "branch": "master"
     },
     "skip_phases": [
       "smoke",
       "security",
       "quality"
     ]
   }

Next, push the code to |github|.

.. code-block:: bash

   $ git add . && git commit -m 'add delivery config'
   $ git push origin add_delivery_config

(The |chef delivery_cli| CLI can perform all of this for projects that use local repositories; one day, it'll do it for remote repositories as well.)

Finally, create a pull request from this change in the |github| webui.
