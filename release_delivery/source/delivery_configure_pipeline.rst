.. THIS PAGE IS LOCATED AT THE /delivery/ PATH.

=========================================
Configure a Delivery pipeline
=========================================

Each project contains a configuration file in its source repository, located at ``.delivery/config.json``, that specifies the build cookbook to use for the project, and in turn, the build cookbook contains recipes that control what happens in the pipeline phases. The config file also allows customization of the behavior of |chef delivery| and the build cookbook.  You can create a config file (as well as a build cookbook) using the |chef delivery_short| CLI tool and the init subcommand: `delivery init` or `delivery init --local`.

When |chef delivery_short| executes a phase, it selects a build node to run the job. On the build node, the project's source is fetched and synchronized to the revision matching the head of the feature branch for the change. The build node reads the project's ``config.json`` file and uses this information to fetch the appropriate build cookbook. Finally, the build node runs a local |chef zero| run to execute the appropriate phase.

Configuration Settings
==========================================

The behavior of pipeline phases can be customized using the project's ``config.json`` file. Each ``config.json`` file has a set of required settings as well as optional settings that can be set, such as which build nodes to use for specific phases, whether to skip certain phases, and so on. The basic settings are defined below; however, additional settings, such as which linting rules to follow, can also be added. See the `delivery-truck readme <https://github.com/chef-cookbooks/delivery-truck/blob/master/README.md>`_ for examples on how to add custom settings.

``version``
   **Required**. Name-value pair that specifies the version of the |chef delivery| configuration that your Delivery Server must use. The latest and default version when creating this file from the Delivery CLI is "2".

   .. note: The value must be specified as a string.

``build-cookbook``
   **Required**. Object specifying the name and location of the build cookbook that your |chef delivery_short| Server must use. Build cookbooks can be embedded in project source repositories, fetched from a |git| server, |chef server|, or a |supermarket| instance. See :ref:`specifying-build-cookbook` for more information and examples.

``build_nodes``
   **Optional**. Object specifying which build nodes to use for specific phases, such as default, unit, publish, provision, etc. Specific nodes can be defined as well as queried through a wildcard search. See :ref:`specifying-build-nodes` for more information and examples.

``skip_phases``
   **Optional**. Object specifying which phases can be skipped by |chef delivery| during the execution of a change through the pipeline. Phases are specified by name and when you specify a phase to skip, it will be skipped for all stages. You currently cannot skip an entire stage or skip a phase only for a specific stage.

``dependencies``
   **Optional**. Object specifying which project(s) the current project depends on. Dependencies can be defined in the following ways:

   * "project_name"
   * "project_name:pipeline_name"
   * "org_name/project_name"
   * "org_name/project_name:pipeline_name"

   If only the project name is provided, the master pipeline is used by default.

   See :ref:`specifying_dependencies` for more information and examples.

.. note:: If you are using |chef delivery_short| to manage changes in |chef| cookbooks, you can wrap, or use directly, ``delivery-truck``, a build cookbook for building and testing cookbooks. The ``delivery-truck`` and ``delivery-sugar`` cookbooks contain helpers that can be used for non-cookbook workflows as well. You can wrap or modify the ``delivery-truck`` cookbook to suit your own needs. See :doc:`/delivery_truck` for more information.

.. _specifying-build-cookbook:

Specifying a Build Cookbook
-------------------------------------------

As described above, the ``build_cookbook`` field in the config file is used to specify the build cookbook for the project. Build cookbooks can be fetched from four sources: a local directory within the project, a git repository, a supermarket instance (either public or private), or from a Delivery server.

**Local directory**

.. code-block:: javascript

   "build_cookbook": {
     "name": "build-cookbook",
     "path": ".delivery/build-cookbook"
   }


**Git source**

.. code-block:: javascript

   "build_cookbook": {
      "name"  : "delivery-truck",
      "git"   : "https://github.com/chef-cookbooks/delivery-truck.git",
      "branch": "master"
   }

**Public Supermarket (https://supermarket.chef.io)**

.. code-block:: javascript

   "build_cookbook": {
      "name": "delivery-truck",
      "supermarket": "true"
   }

**Private Supermarket**

.. code-block:: javascript

   "build_cookbook": {
      "name": "delivery-truck",
      "supermarket": "true",
      "site": "https://private-supermarket.example.com"
   }

**Chef Server**

.. code-block:: javascript

   "build_cookbook": {
      "name": "delivery-truck",
      "server": "true"
   }

.. _specifying-build-nodes:

Specifying Build Nodes
------------------------------------

You can specify which build nodes you would like to use for specific phases. This can be done through wildcard searches on attributes such as the builder node name as well as the platform.

.. code-block:: javascript

   "build_nodes": {
     "provision": ["name:builder-*-2.delivery.chef.co AND platform_version:14.04"],
     "deploy": ["name:builder-*-2.delivery.chef.co AND platform_version:14.04"],
     "functional": ["name:builder* AND platform_version:14.04 NOT name:builder-*-2.delivery.chef.co"]
   }

.. _specifying_dependencies:

Specifying Run-time Dependencies
---------------------------------------

|chef delivery_short| provides the ability to define and view run-time dependencies.  These dependency associations affect how pipeline promotion works through Union, Rehearsal, and Delivered both for projects with dependencies, as well as those without.

To declare a dependency in your project's configuration file, update it with the name(s) of project(s) that your source project depends on.

Here's an example specifying just the project name of a dependency:

.. code-block:: javascript

   {
     "version": "2",
     "build_cookbook": {
       "name": "<your build cookbook name>",
       "path": "<relative path from project root>"
     },
     "skip_phases": [],
     "dependencies": ["BackendAPI"]
   }

.. note:: Because only the project name was specified, the default pipeline, master, will be associated with the target project's pipeline.

The dependency will be reflected in the system once the `deliver` button is
pressed in the |chef delivery_short| Server UI and the change is promoted to Union.

For more information on dependencies, how they affect which projects get promoted through |chef delivery_short|, and how to handle dependency failures, see :doc:`/delivery_manage_dependencies`.
