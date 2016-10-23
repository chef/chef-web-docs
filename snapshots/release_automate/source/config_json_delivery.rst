.. THIS PAGE IS IDENTICAL TO docs.chef.io/config_json_delivery.html BY DESIGN
.. THIS PAGE IS LOCATED AT THE /release/delivery/ PATH.

=========================================================
Configure a Project through config.json (Chef Automate)
=========================================================

.. include:: ../../includes_chef_automate/includes_chef_automate_mark.rst 

The ``config.json`` file is located at the root of the ``.delivery`` folder that is located within a project managed by Chef Automate and configures that project to publish to a Chef Automate pipeline.

Structure
=====================================================
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

Configuration Settings
-----------------------------------------------------
.. include:: ../../includes_delivery_config/includes_delivery_config_json_setting.rst

``build-cookbook``
   **Required**

   .. include:: ../../includes_delivery_config/includes_delivery_config_json_setting_build_cookbook.rst

``build_nodes``
   **Optional**

   .. include:: ../../includes_delivery_config/includes_delivery_config_json_setting_build_nodes.rst

``delivery-truck``
   **Optional**

   The ``delivery-truck`` setting specifies configurations for specific phases of the Chef Automate pipeline:
   
   .. code-block:: javascript
   
      "delivery-truck": {
        "lint": {
          "foodcritic": {
            "only_rules": ["FC002"]
          }
        }
        "publish": {
          "chef_server": "true"
          "github": "chef/chef-web-docs"
          "git": "ssh://git@stash:2222/<project-name>/<repo-name>"
          "supermarket": "https://supermarket.chef.io",
          "supermarket-custom-credentials": "true"
        }
        ...
        <more_phases>
        ...
      }

``dependencies``
   **Optional**

   .. include:: ../../includes_delivery_config/includes_delivery_config_json_setting_dependencies.rst

``skip_phases``
   **Optional**

   .. include:: ../../includes_delivery_config/includes_delivery_config_json_setting_skip_phases.rst

``version``
   **Required**

   .. include:: ../../includes_delivery_config/includes_delivery_config_json_setting_version.rst

.. note:: .. include:: ../../includes_delivery_cookbook/includes_delivery_cookbook_delivery_truck.rst

Phase Settings
-----------------------------------------------------
The individual phases of Chef Automate may be configured, grouped under the ``delivery-truck`` configuration setting by phase.

publish
+++++++++++++++++++++++++++++++++++++++++++++++++++++
The ``publish`` phase configuration settings specify the location(s) to which cookbooks are published.

Chef Server
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
.. include:: ../../includes_delivery_config/includes_delivery_config_json_setting_delivery_truck_publish_chef_server.rst

git
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
.. include:: ../../includes_delivery_config/includes_delivery_config_json_setting_delivery_truck_publish_git.rst

GitHub
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
.. include:: ../../includes_delivery_config/includes_delivery_config_json_setting_delivery_truck_publish_github.rst

Supermarket
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
.. include:: ../../includes_delivery_config/includes_delivery_config_json_setting_delivery_truck_publish_supermarket.rst

.. include:: ../../includes_delivery_config/includes_delivery_config_json_setting_delivery_truck_publish_supermarket_private.rst

.. include:: ../../includes_delivery_config/includes_delivery_config_json_setting_delivery_truck_publish_supermarket_credentials.rst

Multiple Locations
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
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

Examples
=====================================================
The following examples show different ways to specify settings and pipeline behaviors in the ``config.json`` file.

build-cookbook Locations
-----------------------------------------------------
The following examples show how to specify the location of the ``build-cookbook``.

**A local directory**

.. include:: ../../includes_delivery_config/includes_delivery_config_example_build_cookbook_local.rst

**A git source**

.. include:: ../../includes_delivery_config/includes_delivery_config_example_build_cookbook_git.rst

**A public Supermarket (https://supermarket.chef.io)**

.. include:: ../../includes_delivery_config/includes_delivery_config_example_build_cookbook_supermarket_public.rst

**A private Supermarket**

.. include:: ../../includes_delivery_config/includes_delivery_config_example_build_cookbook_supermarket_private.rst

**A Chef server**

.. include:: ../../includes_delivery_config/includes_delivery_config_example_build_cookbook_server.rst

**Multiple locations**

.. include:: ../../includes_delivery_config/includes_delivery_config_example_build_cookbook_server.rst

Build Nodes and Phases
-----------------------------------------------------
.. include:: ../../includes_delivery_config/includes_delivery_config_example_build_nodes_by_phase.rst

Run-time Dependencies
-----------------------------------------------------
.. include:: ../../includes_delivery_config/includes_delivery_config_example_dependencies_on_master.rst

Stages and Platforms
-----------------------------------------------------
The ``"build_nodes"`` section may also specify build nodes by stages and/or platform:

.. code-block:: javascript

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

.. code-block:: javascript

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

Test Patterns
-----------------------------------------------------
.. include:: ../../includes_delivery_config/includes_delivery_config_example_test_patterns.rst

Foodcritic, excludes
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_delivery_config/includes_delivery_config_json_setting_delivery_truck_lint_foodcritic_excludes.rst

Foodcritic, ignore_rules
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_delivery_config/includes_delivery_config_json_setting_delivery_truck_lint_foodcritic_ignore_rules.rst

Foodcritic, only_rules
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_delivery_config/includes_delivery_config_json_setting_delivery_truck_lint_foodcritic_only_rules.rst
