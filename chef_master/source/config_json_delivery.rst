=========================================================
Configure a Project through config.json
=========================================================
`[edit on GitHub] <https://github.com/chef/chef-web-docs/blob/master/chef_master/source/config_json_delivery.rst>`__

.. meta::
    :robots: noindex

.. tag chef_automate_mark

.. image:: ../../images/a2_docs_banner.svg
   :target: https://automate.chef.io/docs

.. end_tag


.. tag EOL_a1

.. danger:: This documentation applies to a deprecated product </versions.html#deprecated-products-and-versions>`__. The new Chef Automate includes newer out-of-the-box compliance profiles, an improved compliance scanner with total cloud scanning functionality, better visualizations, role-based access control and many other features. The new Chef Automate is included as part of the Chef Automate license agreement and is `available via subscription <https://www.chef.io/pricing/>`_.

.. end_tag

The ``config.json`` file is located at the root of the ``.delivery`` folder that is located within a project managed by Workflow and configures that project to publish to a pipeline.

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
.. tag delivery_config_json_setting

The behavior of pipeline phases can be customized using the project's ``config.json`` file. Each ``config.json`` file has a set of required settings as well as optional settings that can be set, such as which build nodes to use for specific phases, whether to skip certain phases, and so on. The basic settings are defined below; however, additional settings, such as which linting rules to follow, can also be added. See the `delivery-truck readme <https://github.com/chef-cookbooks/delivery-truck/blob/master/README.md>`_ for examples on how to add custom settings.

.. end_tag

``build_cookbook``
   **Required**

   .. tag delivery_config_json_setting_build_cookbook

   The ``build_cookbook`` setting specifies the location of the ``build-cookbook`` used by this project. A ``build-cookbook`` may be fetched from five locations:

   * A local directory within the project
   * A git repository
   * A Chef Supermarket instance (public or private)
   * A Chef server
   * A Chef Automate server

   .. end_tag

``build_nodes``
   **Optional**

   .. tag delivery_config_json_setting_build_nodes

   The ``build_nodes`` setting specifies which build nodes to use for specific phases in the Chef Automate pipeline. The build node may be defined as well as queried via wildcard search.

   .. note:: This setting should only be used with build nodes that use the previous push job-based dispatch system. Use the ``job_dispatch`` setting when using the new ssh-based job dispatch system.

   .. end_tag

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

   .. tag delivery_config_json_setting_dependencies

   The ``dependencies`` setting specifies run-time dependencies on which the current project depends. These dependency associations affect how projects are promoted through the Union, Rehearsal, and Delivered stages. Dependencies may be defined in the following ways:

   * ``"project_name"``
   * ``"project_name:pipeline_name"``
   * ``"org_name/project_name"``
   * ``"org_name/project_name:pipeline_name"``

   If only a project name is provided, the master pipeline for that project is the dependency.

   .. end_tag

.. _job-dispatch-config-settings:

``job_dispatch``
   **Optional**

   The ``job_dispatch`` setting is needed to use the `improved SSH job dispatch system </runners.html>`__. If you use this setting, you must remove any ``build_nodes`` settings from your configuration file.

   * ``"version"``
     Set the value to "v2" if you wish to use runners and the new job dispatch system:

     .. code-block:: javascript

        {
           ...
           "job_dispatch": {
              "version": "v2"
           ...
        }

     .. note:: If you omit this setting or set it to "v1", the previous job dispatch system using Push Jobs 1.x will be used instead.

   * ``"filters"``
     Similar to the former Chef Push Jobs-based dispatch system, you can set a variety of filters. Filters control which runners can run a job for a Chef Automate project. You can set filters for the entire project as well as specific filters per phase. You can also specify a matrix of filters to a run phase job repeatedly on multiple platform configurations.

     The values you can filter on are ``os``, ``platform``, ``platform_family``, and ``platform_version``. If you omit a value, job dispatch will not filter on it.

     **Using a default filter**

     If you wish to use a default filter for the entire project, you need to set the
     "default" tag. For example, if you wanted your project phase jobs to be executed on
     only ubuntu and centos platforms, you could write:

     .. code-block:: javascript

       {
          ...
          "job_dispatch": {
             "version": "v2",
             "filters" : {
                "default" : {
                  "os" : ["linux"],
                  "platform" : ["ubuntu", "centos"]
                }
             }
          ...
       }

     **Using a phase filter**

     Phase filters are filters that can be set per phase. They override a default filter
     for that phase if a default is set. You can specify a phase filter without setting a
     default. For example, to run the project's deploy phase specifically on Fedora 6 based
     systems that overrides a default of Windows, you could write:

     .. code-block:: javascript

       {
          ...
          "job_dispatch": {
             "version": "v2",
             "filters" : {
                "default" : {
                  "os" : ["windows"]
                }
                "unit" : {
                  "platform_family" : ["fedora"],
                  "platform_version" : ["6"]
                }
             }
          ...
       }

     **Using a matrix phase filter**

     You can set up a matrix of sub-jobs to run a phase on multiple platform configurations.
     This is itself a phase filter, overriding the default filter but running
     the phase job repeatedly on multiple runners. Matrix filters are only for phase filters
     and not the default filter.

     For example, if you want to unit test your project across multiple versions of Ubuntu,
     you could write something like:

     .. code-block:: javascript

       {
          ...
          "job_dispatch": {
             "version": "v2",
             "filters" : {
                "unit" :
                [
                   {
                     "platform_family" : ["ubuntu"],
                     "platform_version" : ["12.04"]
                   },
                   {
                     "platform_family" : ["ubuntu"],
                     "platform_version" : ["14.04"]
                   },
                   {
                     "platform_family" : ["ubuntu"],
                     "platform_version" : ["16.04"]
                   }
                ]
             }
          ...
       }

``skip_phases``
   **Optional**

   .. tag delivery_config_json_setting_skip_phases

   The ``skip_phases`` setting specifies which phases are skipped by Chef Automate during the execution of a change through the pipeline. If a phase is defined as skipped, this applies to all stages in the pipeline.

   Currently, the ``functional.rb``, ``quality.rb``, ``security.rb``, and ``smoke.rb`` recipes are blank by default and should be set to skipped in the ``config.json`` file:

   .. code-block:: javascript

      "skip_phases": [
        "functional",
        "quality",
        "security",
        "smoke"
      ]

   .. end_tag

``version``
   **Required**

   .. tag delivery_config_json_setting_version

   The ``version`` setting specifies the version of the configuration that the Chef Automate server must user. The current default value is ``2``,

   .. end_tag

.. note:: .. tag delivery_cookbook_delivery_truck

          ``delivery-truck`` is a cookbook for Chef Automate that should be a dependency of every recipe in a ``build-cookbook``, which is effectively a project-specific wrapper cookbook for the ``delivery-truck`` cookbook. The ``delivery-truck`` cookbook defines a set of recipes that correspond to the phases and stages in the Chef Automate pipeline and help ensure good default ``build-cookbook`` behavior. Chef recommends including the ``delivery-truck`` cookbook in all recipes in a ``build-cookbook``.

          .. end_tag

Phase Settings
-----------------------------------------------------
The individual phases of Chef Automate may be configured, grouped under the ``delivery-truck`` configuration setting by phase.

publish
+++++++++++++++++++++++++++++++++++++++++++++++++++++
The ``publish`` phase configuration settings specify the location(s) to which cookbooks are published.

Chef Infra Server
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
.. tag delivery_config_json_setting_delivery_truck_publish_chef_server

If the ``config.json`` file specifies the following cookbooks are published to the Chef Infra Server that is part of this Chef Automate configuration:

.. code-block:: javascript

   "delivery-truck":{
     "publish": {
       "chef_server": "true"
     }
   }

.. end_tag

git
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
.. tag delivery_config_json_setting_delivery_truck_publish_git

If the ``config.json`` file specifies the following cookbooks are published to a git repository located on an open source git server:

.. code-block:: javascript

   "delivery-truck":{
     "publish": {
       "git": "ssh://git@stash:2222/<project-name>/<repo-name>"
     }
   }

This publishing option requires the ``git`` deploy key for that repository to be available from a data bag on the Chef Infra Server that is part of this Chef Automate configuration.

.. end_tag

GitHub
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
.. tag delivery_config_json_setting_delivery_truck_publish_github

If the ``config.json`` file specifies the following cookbooks are published to a GitHub repository:

.. code-block:: javascript

   "delivery-truck":{
     "publish": {
       "github": "chef/chef-web-docs"
     }
   }

where ``"chef/chef-web-docs"`` represents the organization/repository to which the ``build-cookbook`` belongs.

This publishing option requires the ``github`` deploy key for that repository to be available from a data bag on the Chef Infra Server that is part of this Chef Automate configuration.

.. end_tag

Supermarket
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
.. tag delivery_config_json_setting_delivery_truck_publish_supermarket

Publish cookbooks to the public Chef Supermarket:

If the ``config.json`` file specifies the following cookbooks are published to the public Chef Supermarket:

.. code-block:: javascript

   "delivery-truck":{
     "publish": {
       "supermarket": "https://supermarket.chef.io"
     }
   }

.. end_tag

.. tag delivery_config_json_setting_delivery_truck_publish_supermarket_private

Publish cookbooks to a private Chef Supermarket:

.. code-block:: javascript

   "delivery-truck":{
     "publish": {
       "supermarket": "https://private-supermarket.example.com"
     }
   }

.. end_tag

.. tag delivery_config_json_setting_delivery_truck_publish_supermarket_credentials

Publish cookbooks to Chef Supermarket, but with custom credentials:

.. code-block:: javascript

   "delivery-truck":{
     "publish": {
       "supermarket": "https://supermarket.chef.io",
       "supermarket-custom-credentials": "true"
     }
   }

This ``publish`` option requires the ``supermarket_user`` and ``supermarket_key`` credentials to be available from the
``delivery-secrets`` data bag on the Chef Infra Server that is part of this Chef Automate configuration. For more information on the ``delivery-secrets`` data bag,
see `Handling Secrets <https://github.com/chef-cookbooks/delivery-sugar#handling-secrets-alpha>`_ in the ``delivery-sugar`` cookbook README file.

.. end_tag

.. note:: To enable Chef Automate to upload cookbooks to a private Supermarket, you have to manually log into the Supermarket server with the ``delivery`` user, and when it prompts you to enable the user for Supermarket, enter ``yes``. Also, you must copy the Supermarket certificate file to ``/etc/delivery/supermarket.crt`` on the Chef Automate server.

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

.. tag delivery_config_example_build_cookbook_local

.. To specify a build-cookbook located in a local directory:

.. code-block:: javascript

   "build_cookbook": {
     "name": "build-cookbook",
     "path": ".delivery/build-cookbook"
   }

.. end_tag

**A git source**

.. tag delivery_config_example_build_cookbook_git

.. To specify a build-cookbook located at a git source:

.. code-block:: javascript

   "build_cookbook": {
      "name"  : "delivery-truck",
      "git"   : "https://github.com/chef-cookbooks/delivery-truck.git",
      "branch": "master"
   }

.. end_tag

**A public Supermarket (https://supermarket.chef.io)**

.. tag delivery_config_example_build_cookbook_supermarket_public

.. To specify a build-cookbook located in a public Supermarket:

.. code-block:: javascript

   "build_cookbook": {
      "name": "delivery-truck",
      "supermarket": "true"
   }

.. end_tag

**A private Supermarket**

.. tag delivery_config_example_build_cookbook_supermarket_private

.. To specify a build-cookbook located in a private Supermarket:

.. code-block:: javascript

   "build_cookbook": {
      "name": "delivery-truck",
      "supermarket": "true",
      "site": "https://private-supermarket.example.com"
   }

.. end_tag

**A Chef server**

.. tag delivery_config_example_build_cookbook_server

.. To specify a build-cookbook located on a Chef Infra Server:

.. code-block:: javascript

   "build_cookbook": {
      "name": "delivery-truck",
      "server": "true"
   }

.. end_tag

**A Chef Automate server**

.. tag delivery_config_example_build_cookbook_automate_server

.. To specify a build-cookbook located on a Chef Automate server:

.. code-block:: javascript

   "build_cookbook": {
      "name": "delivery-truck",
      "enterprise": "chef",
      "organization": "chef-cookbooks"
   }

.. end_tag

Build Nodes and Phases
-----------------------------------------------------
.. tag delivery_config_example_build_nodes_by_phase

The following example shows how to specify build nodes to be used for specific phases.

.. code-block:: javascript

   "build_nodes": {
     "provision": ["name:builder-*-2.delivery.chef.co AND platform_version:14.04"],
     "deploy": ["name:builder-*-2.delivery.chef.co AND platform_version:14.04"],
     "functional": ["name:builder* AND platform_version:14.04 NOT name:builder-*-2.delivery.chef.co"]
   }

.. end_tag

Run-time Dependencies
-----------------------------------------------------
.. tag delivery_config_example_dependencies_on_master

The following example shows a run-time dependency against the master branch of a project named ``BackendAPI``:

.. code-block:: javascript

   {
     "version": "2",
     "build_cookbook": {
       "name": "build-cookbook",
       "path": ".delivery/build-cookbook"
     },
     "skip_phases": [],
     "dependencies": ["BackendAPI"]
   }

.. end_tag

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
.. tag delivery_config_example_test_patterns

The following example shows how to configure Chef Automate to ignore and/or run certain Foodcritic rules, and to exclude running tests that are located in the specified cookbook directories:

.. code-block:: javascript

   {
     "version": "2",
     "build_cookbook": {
       "name": "delivery-truck",
       "git": "https://github.com/chef-cookbooks/delivery-truck.git"
     },
     "delivery-truck": {
       "lint": {
         "foodcritic": {
           "ignore_rules": ["FC009", "FC057", "FC058"],
           "only_rules": ["FC002"],
           "excludes": ["spec", "test"],
           "fail_tags": ["any"]
         }
       }
     }
   }

where:

* ``ignore_rules`` is set to ignore Foodcritic rules ``FC009``, ``FC057``, ``FC058``
* ``only_rules`` is set to run only Foodcritic rule ``FC002``; omit this setting to specify all rules not specified by ``ignore_rules``
* ``excludes`` prevents Foodcritic rules from running if they are present in a cookbook's ``/spec`` and/or ``/test`` directories
* ``fail_tags`` states which rules should cause the run to fail; omit this setting to specify ``correctness``

.. end_tag

Foodcritic, excludes
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. tag delivery_config_json_setting_delivery_truck_lint_foodcritic_excludes

If the ``config.json`` file specifies:

.. code-block:: javascript

   "delivery-truck": {
     "lint": {
       "foodcritic": {
         "ignore_rules": ["RULE", "RULE", ...],
         "only_rules": ["RULE", "RULE", ...],
         "excludes": ["spec", "test"]
       }
     }
   }

then Foodcritic rules are not run against tests that are located in the specified directories, in this case the ``/spec`` and ``/test`` directories.

.. end_tag

Foodcritic, ignore_rules
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. tag delivery_config_json_setting_delivery_truck_lint_foodcritic_ignore_rules

If the ``config.json`` file specifies:

.. code-block:: javascript

   "delivery-truck": {
     "lint": {
       "foodcritic": {
         "ignore_rules": ["FC009", "FC057", "FC058"],
         "excludes": ["DIRECTORY", "DIRECTORY", ...]
       }
     }
   }

then all Foodcritic rules except ``FC009``, ``FC057``, and ``FC058``  rules are run.

.. end_tag

Foodcritic, only_rules
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. tag delivery_config_json_setting_delivery_truck_lint_foodcritic_only_rules

If the ``config.json`` file specifies:

.. code-block:: javascript

   "delivery-truck": {
     "lint": {
       "foodcritic": {
         "only_rules": ["FC002"],
         "excludes": ["DIRECTORY", "DIRECTORY", ...]
       }
     }
   }

then only the ``FC002`` Foodcritic rules is run.

.. end_tag
