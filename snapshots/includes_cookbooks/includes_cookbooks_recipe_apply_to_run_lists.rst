.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

A recipe must be assigned to a run-list using the appropriate name, as defined by the cookbook directory and namespace. For example, a cookbook directory has the following structure::

   cookbooks/
     apache2/
       recipes/
         default.rb
         mod_ssl.rb

There are two recipes: a default recipe (that has the same name as the cookbook) and a recipe named ``mod_ssl``. The syntax that applies a recipe to a run-list is similar to:

.. code-block:: ruby

   {
     'run_list': [
     'recipe[cookbook_name::default_recipe]',
     'recipe[cookbook_name::recipe_name]'
     ]
   }

where ``::default_recipe`` is implied (and does not need to be specified). On a node, these recipes can be assigned to a node's run-list similar to:

.. code-block:: ruby

   {
     'run_list': [
     'recipe[apache2]',
     'recipe[apache2::mod_ssl]'
     ]
   }
