.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


The structure of the ``config.json`` file is similar to:

.. code-block:: json

   {
     "version": "2",
     "build_cookbook": {
       "name": "build-cookbook",
       "path": ".delivery/build-cookbook"
     },
     "build_nodes": {
       "default"    : ["name:name_of_builder"]
     },
     "skip_phases": [
       "quality",
       "security"
     ],
     "delivery-truck":{
       "publish": {
         "github": "chef/chef-web-docs"
       }
     }
   }
