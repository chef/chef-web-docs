=====================================================
About the delivery-truck Cookbook
=====================================================

``delivery-truck`` is a cookbook for |chef delivery| that should be a dependency of every recipe in a build cookbook. The ``delivery-truck`` cookbook defines a set of recipes that correspond to the phases and stages in the |chef delivery| pipeline and help ensure good default build cookbook behavior. |company_name| recommends including the ``delivery-truck`` cookbook in all recipes in a build cookbook.

.. note:: The ``delivery-truck`` cookbook has a dependency on the ``delivery-sugar`` cookbook, which contains a set of helper methods and custom resources that may be used in build cookbook recipes. Using these helper methods and custom resources in a build cookbook is optional.

This topic assumes that |chef delivery| is already configured, a project exists, and that all work is being done from that project's root directory.



Set up a Build Cookbook
=====================================================
Pull the ``delivery-truck`` and ``delivery-sugar`` cookbooks into a build cookbook. This requires editing the build cookbook's |berksfile|, and then updating the |metadata rb| file.

Edit the |berksfile|
-----------------------------------------------------
The build cookbook's |berksfile| is located at ``.delivery/build-cookbook/Berkfile``. Update it to include:

.. code-block:: ruby

   source "https://supermarket.chef.io"

   metadata

   cookbook 'delivery-truck', github: 'chef-cookbooks/delivery-truck'
   cookbook 'delivery-sugar', github: 'chef-cookbooks/delivery-sugar'

This will ensure that the latest versions of the ``delivery-truck`` and ``delivery-sugar`` cookbooks are pulled into the build cookbook every time a change is sent to the |chef delivery| project pipeline.

Edit |metadata rb|
-----------------------------------------------------
The build cookbook's |metadata rb| is located at ``.delivery/build-cookbook/metadata.rb``. Update it to include:

.. code-block:: none

   depends 'delivery-truck'

This will ensure that the build cookbook has a dependency on the ``delivery-truck`` cookbook.


Add delivery-truck to Recipes
=====================================================
The ``delivery-truck`` cookbook includes the following recipes:

* ``default.rb``
* ``deploy.rb``
* ``functional.rb``
* ``lint.rb``
* ``provision.rb``
* ``publish.rb``
* ``quality.rb``
* ``security.rb``
* ``smoke.rb``
* ``syntax.rb``
* ``unit.rb``

where:

* The ``default.rb`` file is executed by the |chef client|
* The ``provision.rb`` file discovers all ``metadata.rb`` and/or ``metadata.json`` files that are located in the project's root directory, plus any cookbook directory located under ``cookbooks/<project_cookbooks>``
* The remaining recipes correspond to specific phases that exist in the |chef delivery| pipeline

A build cookbook defines the same phases. For example, a build cookbook's recipe directory should contain an identical list of recipes. For example, run:

.. code-block:: bash

   $ ls .delivery/build-cookbook/recipes/

the list of recipes should be:

.. code-block:: bash

   default.rb
   deploy.rb
   functional.rb
   lint.rb
   provision.rb
   publish.rb
   quality.rb
   security.rb
   smoke.rb
   syntax.rb
   unit.rb

Each recipe corresponds to a specific phase in the |chef delivery| pipeline. The recipes in the build cookbook should include the same-named recipe in the ``delivery-truck`` cookbook. For example, to include the ``lint.rb`` recipe from the ``delivery-truck`` cookbook, update the ``lint.rb`` recipe in the build cookbook to add the following:

.. code-block:: ruby

   include_recipe 'delivery-truck::lint'

and then add to the ``unit.rb`` recipe:

.. code-block:: none

   include_recipe 'delivery-truck::unit'

and so on for all of the recipes. This ensures that all of the default behavior for all of the phases for the entire pipeline is available to this build cookbook.


Read the Tutorial
=====================================================
To learn more about how to set up a project pipeline for a single cookbook and simple application, follow the steps outlined in the `Build a continuous deployment pipeline with Chef Delivery <https://learn.chef.io/delivery/get-started/>`__ tutorial on https://learn.chef.io/tutorials/.
