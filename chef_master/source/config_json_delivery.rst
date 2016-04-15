=====================================================
config.json (Chef Delivery)
=====================================================

.. include:: ../../includes_delivery_config/includes_delivery_config_json.rst

Structure
=====================================================
.. include:: ../../includes_delivery_config/includes_delivery_config_json_structure.rst

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

   .. include:: ../../includes_delivery_config/includes_delivery_config_json_setting_delivery_truck.rst

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
The individual phases of |delivery| may be configured, grouped under the ``delivery-truck`` configuration setting by phase.


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

Supermarket Credentials
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
.. include:: ../../includes_delivery_config/includes_delivery_config_json_setting_delivery_truck_publish_supermarket_credentials.rst

Multiple Locations
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
.. include:: ../../includes_delivery_config/includes_delivery_config_json_setting_delivery_truck_publish_all.rst




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
.. include:: ../../includes_delivery_config/includes_delivery_config_example_stages_platforms.rst


Test Patterns
-----------------------------------------------------
.. include:: ../../includes_delivery_config/includes_delivery_config_example_test_patterns.rst

|foodcritic|, excludes
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_delivery_config/includes_delivery_config_json_setting_delivery_truck_lint_foodcritic_excludes.rst

|foodcritic|, ignore_rules
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_delivery_config/includes_delivery_config_json_setting_delivery_truck_lint_foodcritic_ignore_rules.rst

|foodcritic|, only_rules
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_delivery_config/includes_delivery_config_json_setting_delivery_truck_lint_foodcritic_only_rules.rst



