=======================================================
About Chef Automate Pipelines
=======================================================
`[edit on GitHub] <https://github.com/chef/chef-web-docs/blob/master/chef_master/source/delivery_pipeline.rst>`__

.. meta::
    :robots: noindex
    
.. tag chef_automate_mark

.. image:: ../../images/a2_docs_banner.svg
   :target: https://automate.chef.io/docs

.. end_tag


.. tag EOL_a1

.. danger:: This documentation applies to a deprecated product </versions.html#deprecated-products-and-versions>`__. The new Chef Automate includes newer out-of-the-box compliance profiles, an improved compliance scanner with total cloud scanning functionality, better visualizations, role-based access control and many other features. The new Chef Automate is included as part of the Chef Automate license agreement and is `available via subscription <https://www.chef.io/pricing/>`_.

.. end_tag

Each project contains a configuration file in its source repository, located at ``.delivery/config.json``, that specifies the build cookbook to use for the project, and in turn, the build cookbook contains recipes that control what happens in the pipeline phases. The config file also allows customization of the behavior of Chef Automate and the build cookbook.  You can create a config file (as well as a build cookbook) using the Chef Automate CLI tool and the init subcommand: ``delivery init`` or ``delivery init --local``.

When Chef Automate executes a phase, it selects a build node or runner to run the job. On the build node/runner, the project's source is fetched and synchronized to the revision matching the head of the feature branch for the change. The build node/runner reads the project's ``config.json`` file and uses this information to fetch the appropriate build cookbook. Finally, the build node/runner runs a local chef-zero run to execute the appropriate phase.

If you are using Chef Automate to manage changes in Chef cookbooks, you can wrap, or use directly, ``delivery-truck``, a build cookbook for building and testing cookbooks. The ``delivery-truck`` and ``delivery-sugar`` cookbooks contain helpers that can be used for non-cookbook workflows as well.  You can wrap or modify the ``delivery-truck`` cookbook to suit your own needs.

Here is an example of a build cookbook recipe that runs JUnit tests with Maven. For example:

.. code-block:: ruby

   log "Running unit"

   repo = node['delivery_builder']['repo']

   execute "run my JUnit tests" do
     command "mvn test"
     cwd repo
   end

This code logs that the unit tests are running and runs JUnit tests against the current repo.

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

Because build cookbooks read the configuration file, use the configuration file to customize the build cookbook to suit the needs of a particular project. In this way, you can share some "standard" version of a build cookbook with others and then use extra data in the config file to tailor the cookbook as needed.

Configuration Settings
=======================================================
.. tag delivery_config_json_setting

The behavior of pipeline phases can be customized using the project's ``config.json`` file. Each ``config.json`` file has a set of required settings as well as optional settings that can be set, such as which build nodes to use for specific phases, whether to skip certain phases, and so on. The basic settings are defined below; however, additional settings, such as which linting rules to follow, can also be added. See the `delivery-truck readme <https://github.com/chef-cookbooks/delivery-truck/blob/master/README.md>`_ for examples on how to add custom settings.

.. end_tag

``version``
   **Required**

   .. tag delivery_config_json_setting_version

   The ``version`` setting specifies the version of the configuration that the Chef Automate server must user. The current default value is ``2``,

   .. end_tag

``build-cookbook``
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

.. note:: .. tag delivery_cookbook_delivery_truck

          ``delivery-truck`` is a cookbook for Chef Automate that should be a dependency of every recipe in a ``build-cookbook``, which is effectively a project-specific wrapper cookbook for the ``delivery-truck`` cookbook. The ``delivery-truck`` cookbook defines a set of recipes that correspond to the phases and stages in the Chef Automate pipeline and help ensure good default ``build-cookbook`` behavior. Chef recommends including the ``delivery-truck`` cookbook in all recipes in a ``build-cookbook``.

          .. end_tag

build-cookbook Locations
-------------------------------------------------------
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
-------------------------------------------------------
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
-------------------------------------------------------
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

Multiple Pipelines
-------------------------------------------------------
To set up a second pipeline, there is an assumption that the branch that will become the second pipeline exists in your local project.

#. Push that branch to the Chef Automate Server ``git push delivery $BRANCH_NAME``
#. Navigate to the project's page (``e/$ENT_NAME/#/organizations/$ORG_NAME/projects/$PROJECT_NAME``) in the Chef Automate web UI and click on the ``Pipelines`` tab.
#. Click on ``Add A New Pipeline`` on the top of the page.
#. Give the new pipeline a descriptive name and input the base branch.

To make a pipeline other than ``master`` the default for a single project, create a ``cli.toml`` file in the ``/.delivery`` directory in the root of the project that includes ``pipeline = "$BRANCH_NAME"``. Now, all delivery-cli commands that target a pipeline will target $BRANCH_NAME.

If you wish to target a pipeline that is NOT the defined default, add the ``--pipeline=$BRANCH_NAME`` flag to the delivery-cli command.

Example:

``delivery review --pipeline=$BRANCH_NAME``

The commands that take this flag are:

* ``delivery init``
* ``delivery review``
* ``delivery diff``
* ``delivery job``
* ``delivery setup``
