.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


An environment is defined using JSON or the Ruby DSL. chef-solo will look for environments in ``/var/chef/environments``, but this location can be modified by changing the setting for ``environment_path`` in solo.rb. For example, the following setting in solo.rb:

.. code-block:: ruby

   environment_path '/var/chef-solo/environments'

Environment data looks like the following in JSON:

.. code-block:: javascript

   {
     "name": "dev",
     "default_attributes": {
       "apache2": {
         "listen_ports": [
           "80",
           "443"
         ]
       }
     },
     "json_class": "Chef::Environment",
       "description": "",
       "cookbook_versions": {
       "couchdb": "= 11.0.0"
     },
     "chef_type": "environment"
     }

and like the following in the Ruby DSL:

.. code-block:: ruby

   name 'environment_name'
   description 'environment_description'
   cookbook OR cookbook_versions  'cookbook' OR 'cookbook' => 'cookbook_version'
   default_attributes 'node' => { 'attribute' => [ 'value', 'value', 'etc.' ] }
   override_attributes 'node' => { 'attribute' => [ 'value', 'value', 'etc.' ] }
