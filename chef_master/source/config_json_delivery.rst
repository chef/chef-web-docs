==========================================================================
config.json (Chef Delivery)
==========================================================================

The ``config.json`` file is located at the root of the ``.delivery`` folder that is located in a project managed by |chef delivery|. The structure of the ``config.json`` file is similar to:

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

The ``"build_nodes"`` section may also specify build nodes by stages and/or platform:

.. code-block:: json

   {
     ...
       "build_nodes": {
         "default"    : ["name:builder"],
         "unit"       : ["name:builder AND platform_family:platform"],
         "..."        : ["name:builder AND platform_family:platform"]
       }
     ...
   }

For example:

.. code-block:: json

   {
     ...
       "build_nodes": {
         "default"    : ["name:builder*.foo.com"],
         "unit"       : ["name:builder*.foo.com AND platform_family:debian"],
         "syntax"     : ["name:builder*.foo.com AND platform_family:rhel"],
         "publish"    : ["name:builder*.foo.com AND platform_family:debian", "name:builder*.foo.com AND platform_family:rhel"]
       }
     ...
   }

