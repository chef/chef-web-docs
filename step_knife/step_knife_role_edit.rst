.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


To edit the data for a role named ``role1``, enter:

.. code-block:: bash

   $ knife role edit role1
   
Update the role data in |json|:

.. code-block:: javascript

   ## sample:
   {
      "name": "role1",
      "description": "This is the description for the role1 role.",
      "json_class": "Chef::Role",
      "default_attributes": {
      },
      "override_attributes": {
      },
      "chef_type": "role",
      "run_list": ["recipe[cookbook_name::recipe_name]",
                   "role[role_name]"
      ],
      "env_run_lists": {
      },
   }

When finished, save it.
