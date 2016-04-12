.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


If the ``config.json`` file may specify some or all of the publish options together as a single block:

.. code-block:: javascript

   "delivery-truck":{
     "publish": {
       "chef_server": "true"
       "github": "chef/chef-web-docs"
       "git": "ssh://git@stash:2222/<project-name>/<repo-name>"
       "supermarket": "https://supermarket.chef.io",
       "supermarket-custom-credentials": "true"
     }
   }

or:

.. code-block:: javascript

   "delivery-truck":{
     "publish": {
       "chef_server": "true"
       "supermarket": "https://supermarket.chef.io"
     }
   }
