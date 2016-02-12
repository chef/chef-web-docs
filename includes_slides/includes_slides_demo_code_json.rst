.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


|json| code:

.. code-block:: javascript

   {
     some: json_data
   }

For example, node data:

.. code-block:: javascript

   {
     "name": "node_name",
     "chef_environment": "_default",
     "run_list": [
       "recipe[recipe_name]"
     ]
     "json_class": "Chef::Node",
     "chef_type": "node",
     "automatic": { ... },
     "normal": { "tags": [ ] },
     "default": { },
     "override": { } 
   }
