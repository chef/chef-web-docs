.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


A role is defined using JSON or the Ruby DSL. chef-solo will look for roles in ``/var/chef/roles``, but this location can be modified by changing the setting for ``role_path`` in solo.rb. For example, the following setting in solo.rb:

.. code-block:: ruby

   role_path '/var/chef-solo/roles'

Role data looks like the following in JSON:

.. code-block:: javascript

   {
     "name": "test",
     "default_attributes": { },
     "override_attributes": { },
     "json_class": "Chef::Role",
     "description": "This is just a test role, no big deal.",
     "chef_type": "role",
     "run_list": [ "recipe[test]" ]
   }

and like the following in the Ruby DSL:

.. code-block:: ruby

   name 'test'
   description 'This is just a test role, no big deal.'
   run_list 'recipe[test]'

and finally, JSON data passed to chef-solo:

.. code-block:: ruby

   { 'run_list': 'role[test]' }
