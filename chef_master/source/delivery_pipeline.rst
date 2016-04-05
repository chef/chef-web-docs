=====================================================
About Delivery Pipelines
=====================================================

Each project contains a configuration file in its source repository, located at ``.delivery/config.json``, that specifies the build cookbook to use for the project, and in turn, the build cookbook contains recipes that control what happens in the pipeline phases. The config file also allows customization of the behavior of |delivery| and the build cookbook.  You can create a config file (as well as a build cookbook) using the |delivery| CLI tool and the init subcommand: `delivery init` or `delivery init --local`.

When |delivery| executes a phase, it selects a build node to run the job. On the build node, the project's source is fetched and synchronized to the revision matching the head of the feature branch for the change. The build node reads the project's ``config.json`` file and uses this information to fetch the appropriate build cookbook. Finally, the build node runs a local |chef zero| run to execute the appropriate phase.

Configuration Settings
=====================================================
.. include:: ../../includes_delivery_config/includes_delivery_config_json_setting.rst

``version``
   **Required**

   .. include:: ../../includes_delivery_config/includes_delivery_config_json_setting_version.rst

``build-cookbook``
   **Required**

   .. include:: ../../includes_delivery_config/includes_delivery_config_json_setting_build_cookbook.rst

``build_nodes``
   **Optional**

   .. include:: ../../includes_delivery_config/includes_delivery_config_json_setting_build_nodes.rst

``skip_phases``
   **Optional**

   .. include:: ../../includes_delivery_config/includes_delivery_config_json_setting_skip_phases.rst

``dependencies``
   **Optional**

   .. include:: ../../includes_delivery_config/includes_delivery_config_json_setting_dependencies.rst


.. note:: .. include:: ../../includes_delivery_cookbook/includes_delivery_cookbook_delivery_truck.rst


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


Build Nodes and Phases
-----------------------------------------------------
.. include:: ../../includes_delivery_config/includes_delivery_config_example_build_nodes_by_phase.rst

.. _specifying_dependencies:

Run-time Dependencies
-----------------------------------------------------
.. include:: ../../includes_delivery_config/includes_delivery_config_example_dependencies_on_master.rst
