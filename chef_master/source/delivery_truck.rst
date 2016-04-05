=====================================================
About the delivery-truck Cookbook
=====================================================

.. include:: ../../includes_delivery_cookbook/includes_delivery_cookbook_delivery_truck.rst

.. note:: The ``delivery-truck`` cookbook has a dependency on the ``delivery-sugar`` cookbook, which contains a set of helper methods and custom resources that may be used in build cookbook recipes. Using these helper methods and custom resources in a build cookbook is optional.


delivery-truck Recipes
=====================================================
The following recipes are available by default in the ``delivery-truck`` cookbook:

``default.rb``
   .. include:: ../../includes_delivery_cookbook/includes_delivery_cookbook_common_recipe_default.rst

``deploy.rb``
   .. include:: ../../includes_delivery_cookbook/includes_delivery_cookbook_common_recipe_deploy.rst

``functional.rb``
   .. include:: ../../includes_delivery_cookbook/includes_delivery_cookbook_common_recipe_functional.rst

``lint.rb``
   .. include:: ../../includes_delivery_cookbook/includes_delivery_cookbook_common_recipe_lint.rst

``provision.rb``
   .. include:: ../../includes_delivery_cookbook/includes_delivery_cookbook_common_recipe_provision.rst

``publish.rb``
   .. include:: ../../includes_delivery_cookbook/includes_delivery_cookbook_common_recipe_publish.rst

``quality.rb``
   .. include:: ../../includes_delivery_cookbook/includes_delivery_cookbook_common_recipe_quality.rst

``security.rb``
   .. include:: ../../includes_delivery_cookbook/includes_delivery_cookbook_common_recipe_security.rst

``smoke.rb``
   .. include:: ../../includes_delivery_cookbook/includes_delivery_cookbook_common_recipe_smoke.rst

``syntax.rb``
   .. include:: ../../includes_delivery_cookbook/includes_delivery_cookbook_common_recipe_syntax.rst

``unit.rb``
   .. include:: ../../includes_delivery_cookbook/includes_delivery_cookbook_common_recipe_unit.rst


Create Build Cookbook
=====================================================
.. include:: ../../includes_delivery_cookbook/includes_delivery_cookbook_setup.rst

.. note:: This section assumes that |delivery| is already configured, a project exists, a user may access that project and submit changes, and that all work is being done from that project's root directory.

Edit the |berksfile|
-----------------------------------------------------
.. include:: ../../includes_delivery_cookbook/includes_delivery_cookbook_setup_berksfile.rst

Edit |metadata rb|
-----------------------------------------------------
.. include:: ../../includes_delivery_cookbook/includes_delivery_cookbook_setup_metadata.rst

Add delivery-truck to Recipes
-----------------------------------------------------
.. include:: ../../includes_delivery_cookbook/includes_delivery_cookbook_setup_recipes.rst


Read the Tutorial
=====================================================
To learn more about how to set up a project pipeline for a single cookbook and simple application, follow the steps outlined in the `Build a continuous deployment pipeline with Chef Delivery <https://learn.chef.io/delivery/get-started/>`__ tutorial on https://learn.chef.io/tutorials/.






Project Applications
=====================================================

.. done

Project applications are a useful way to promote projects by using a set of attributes that are pinned to versions, and then using those attributes when deploying software to a stage in the |delivery| pipeline.

Project applications are defined in the ``pubish.rb`` recipe in a ``build-cookbook`` using the ``define_project_application`` helper method, and then in the ``deploy.rb`` recipe using the ``get_projet_application`` method. The publish phase happens at the end of the build stage. It is at this point where the project application version is pinned, uploaded to the |chef server| as a data bag item, and then used through the remaining stages.

.. note:: The ``define_project_application`` helper method is available from the ``delivery-sugar`` cookbook, which is a dependency of the ``delivery-truck`` cookbook. This helper is available when the ``publish.rb`` recipe has ``include_recipe 'delivery-truck::publish'`` defined.

To define a project application, do the following:

#. Open the ``publish.rb`` recipe in the ``build-cookbook`` and edit it to contain:

   .. code-block:: ruby

      define_project_application(
        <app_name>,
        <app_version>,
        [ 'attribute',
          'attribute',
          ... ]
      )

   where

   * ``<app_name>`` is the name of the project application
   * ``<app_version>`` is version number to which the project application is pinned
   * ``'attribute'`` is |ruby hash| of attributes associated with this version; each attribute is defined as a key-value pair: ``'key = value'``


#. Set up the ``build-cookbook`` to know about this application. Add the following to ``.delivery/build-cookbook/attributes/default.rb``:

   .. code-block:: ruby

      default['delivery']['project_apps'] = ['<app_name>', '<app_name>', ...]

   where ``<app_name>`` is a list of one (or more) applications this ``build-cookbook`` should be aware of.

   .. note:: If the ``/attributes/default.rb`` directory and/or file does not exist, create it.


#. Open the ``default.rb`` recipe in the ``build-cookbook`` and edit it to contain:

   .. code-block:: ruby

      { 'hash_of_attributes' } = get_project_application(<app_name>)

   where ``'hash_of_attributes'`` is a list of one (or more) attributes defined in the ``define_project_application`` block.

   .. note:: Do not pass ``'id'``, ``'version'``, or ``'name'`` as part of the ``'hash_of_attributes'`` as these are already defined in the ``define_project_application`` block, are pulled in automatically by the ``get_project_application`` helper method, and will overwrite any value specified in the |ruby hash|.




Example: Project Applications
-----------------------------------------------------


.. done

This example shows how to use project applications to deploy a package into a ``.deb`` file during the deploy phase. (This example assumes a |delivery| project exists with a properly configured ``build-cookbook``.)

#. Open the ``publish.rb`` recipe in the ``build-cookbook`` and edit to look like the following:

   .. code-block:: ruby

      include_recipe 'delivery-truck::publish'

      # Generate your artifact and document it's location on a download server.
      artifact_location = <generated_artifact_location>

      # It's recommended to generate a checksum from your package too.
      artifact_checksum = <package_checksum>

      # Version the artifact based on the current date.
      artifact_version = Time.now.strftime('%F_%H%M')

      # Name your application.
      name = "<app_name>"

      project_app_attributes = {
        'artifact_location' => artifact_location,
        'artifact_checksum' => artifact_checksum
      }

      define_project_application(
        name,
        artifact_version,
        project_app_attributes
      )

#. In the ``publish.rb`` recipe, update ``<generated_artifact_location>`` and ``<package_checksum>`` to be correct for this project.

#. Set up the ``build-cookbook`` to know about this application. Add the following to ``.delivery/build-cookbook/attributes/default.rb``:

   .. code-block:: ruby

      default['delivery']['project_apps'] = ["<app_name>"]

   where ``<app_name>`` is the same value as the name of the application in the ``publish.rb`` file.

   When the publish phase is run, an application is created, versioned by timestamp, and including all of the information needed to install that version of the application. The provisioning code in ``delivery-truck`` will automatically pin based on this version.

#. Configure the ``build-cookbook`` to know about the application. Add the following to ``.delivery/build-cookbook/attributes/default.rb``:

   .. code-block:: ruby

      default['delivery']['project_apps'] = ["<APPLICATION_NAME>"]

#. Configure the ``build-cookbook`` to know how to install the application. Add the following to ``.delivery/build-cookbook/deploy.rb``:

   .. code-block:: ruby

      app_attributes = get_project_application("<APPLICATION_NAME>")

      # Download your package.
      remote_file "/tmp/latest_package.deb" do
        source   app_attributes['artifact_location']
        checksum app_attributes['artifact_checksum']
        action :create
      end

      # Install it onto your build infrastructure.
      package app_attributes['name'] do
        source "/tmp/latest_package.deb"
        action :install
      end


Validate the Installation
=====================================================
The surest way to validate your |delivery| installation is by creating a cookbook and submitting it to |github|, which will kick off a pipeline and you can see how the process works.

.. include:: ../../includes_delivery/includes_delivery_build_cookbook_create.rst

.. include:: ../../includes_delivery/includes_delivery_projects_add_with_delivery_truck.rst