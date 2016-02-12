=====================================================
About Build Cookbooks
=====================================================

.. include:: ../../includes_delivery/includes_delivery_build_cookbook.rst

Build Cookbook Structure 
=====================================================
.. include:: ../../includes_delivery/includes_delivery_build_cookbook_structure.rst

The following table lists the per-phase files in a build cookbook.

.. list-table::
   :widths: 200 400
   :header-rows: 1

   * - Recipe and Phases
     - Description
   * - ``default.rb``

       All phases, all stages
     - .. include:: ../../includes_delivery/includes_delivery_build_cookbook_recipe_default.rst
   * - ``deploy.rb``

       Acceptance, Union, Rehearsal, Delivered
     - .. include:: ../../includes_delivery/includes_delivery_build_cookbook_recipe_deploy.rst
   * - ``functional.rb``              

       Acceptance, Union, Rehearsal, Delivered
     - .. include:: ../../includes_delivery/includes_delivery_build_cookbook_recipe_functional.rst
   * - ``lint.rb``

       Verify, Build
     - .. include:: ../../includes_delivery/includes_delivery_build_cookbook_recipe_lint.rst
   * - ``provision.rb``

       Acceptance, Union, Rehearsal, Delivered
     - .. include:: ../../includes_delivery/includes_delivery_build_cookbook_recipe_provision.rst
   * - ``publish.rb``

       Build
     - .. include:: ../../includes_delivery/includes_delivery_build_cookbook_recipe_publish.rst
   * - ``quality.rb``

       Build
     - .. include:: ../../includes_delivery/includes_delivery_build_cookbook_recipe_quality.rst
   * - ``security.rb``

       Build
     - .. include:: ../../includes_delivery/includes_delivery_build_cookbook_recipe_security.rst
   * - ``smoke.rb``

       Acceptance, Union, Rehearsal, Delivered
     - .. include:: ../../includes_delivery/includes_delivery_build_cookbook_recipe_smoke.rst
   * - ``syntax.rb``

       Verify, Build
     - .. include:: ../../includes_delivery/includes_delivery_build_cookbook_recipe_syntax.rst
   * - ``unit.rb``

       Verify, Build
     - .. include:: ../../includes_delivery/includes_delivery_build_cookbook_recipe_unit.rst


Create Build Cookbooks
=====================================================
.. include:: ../../includes_delivery/includes_delivery_build_cookbook_create.rst

Example
-----------------------------------------------------
.. include:: ../../includes_delivery/includes_delivery_build_cookbook_pcb_example.rst

Manage Secrets
-----------------------------------------------------
.. include:: ../../includes_delivery/includes_delivery_manage_secrets.rst

Create a Data Bag 
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_delivery/includes_delivery_manage_secrets_create.rst

Use a Data Bag 
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_delivery/includes_delivery_manage_secrets_use.rst


Set Up Projects
==================================================================
.. include:: ../../includes_delivery/includes_delivery_projects.rst

Use delivery-truck
-------------------------------------------------------------------
.. include:: ../../includes_delivery/includes_delivery_projects_add_with_delivery_truck.rst

Use the Web UI
-----------------------------------------------------
.. include:: ../../includes_delivery/includes_delivery_projects_add_with_webui.rst
