=================================
Using Delivery Truck
=================================

Delivery Truck is a cookbook you should include in your build cookbook recipes. It contains a set of recipes that correspond to each phase of your build cookbook's phase recipes that can be included to ensure good default build cookbook behavior, such as version pinning. Chef strongly recommends including the Delivery Truck recipes in each of your phase cookbooks.

Getting Started
=============================================

This guide assumes you have already initialized a new project in |chef delivery_short| and are working out of the project's root directory.

Setting Up Your Build Cookbook
------------------------------------------------------

You should pull Delivery Truck and its dependency, Delivery Sugar, into your build cookbook. Edit your build cookbook's |berksfile| in ``.delivery/build-cookbook/Berkfile`` to look something like this:

.. code-block:: ruby

   source "https://supermarket.chef.io"

   metadata

   cookbook 'delivery-truck', github: 'chef-cookbooks/delivery-truck'
   cookbook 'delivery-sugar', github: 'chef-cookbooks/delivery-sugar'

This will ensure the latest Delivery Truck code is pulled into your build cookbook every time you build. You also need to make your build cookbook depend on Delivery Truck to make it available internally. Append the following line to the end of your build cookbook's ``metadata.rb`` file in ``.delivery/build-cookbook/metadata.rb``:

.. code-block:: none

   depends 'delivery-truck'


Using Delivery Truck In Your Build Recipes
---------------------------------------------------

Now that you have Delivery Truck included into your build cookbook, it is recommended that you include the corresponding Delivery Truck phase recipe in every one of your build cookbook's phase recipes. For example, your build cookbook's recipe directory should look something like this:

.. code-block:: bash

   $ ls .delivery/build-cookbook/recipes/
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


With the exception of ``default.rb``, every one of those recipes corresponds to a phase in Delivery's pipeline process. We recommend that you include Delivery Truck's default behavior in each of those recipes as well as the default recipe. You can do that by going through each of the above recipes and adding an ``include_recipe`` entry for the corresponding Delivery Truck phase at the start of each relevant recipe. For example, your ``unit.rb`` recipe would look like:

.. code-block:: none

   include_recipe 'delivery-truck::unit'

   <other_cookbook_content>


It is recommended doing that for all phase cookbooks, but especially for ``provision.rb``, as that is the part of Delivery Truck that handles promotion logic for you (see below for additional details on how promotion works).

Promotion In Delivery Truck
==================================

Promotion allows you to pin the artifacts that make up your project's software to versions at various stages of your infrastructure, allowing newer software to flow into production as it travels from Acceptance to Delivered.

This, in tandem with the concept of :doc:`/delivery_manage_dependencies`, can allow for safe and controlled promotion of your software across a shared infrastructure.

The following are a few concepts that you should understand before learning about promotion.

.. note:: Currently, projects named the same across enterprises or orgs will not behave properly, so please avoid re-using project names currently.

Terminology
--------------------------------
The following terms are used in this topic:

**Infrastructure Node**
   An infrastructure node is a node on which your project's software is deployed. You can have infrastructure nodes for each stage (Acceptance, Union, Rehearsal, and Delivered). Each stage will have its own version of your project's software as it gets promoted through to Delivered. An infrastructure node's run list `contains the delivery-base recipe <https://github.com/chef-cookbooks/delivery-base>`__ and a project cookbook (defined below). At the end of the deploy phase for a given project, any node with a project cookbook related to that project and the delivery-base recipe in its run list will run the |chef client| if the node is in the environment corresponding to the current stage (Acceptance, Union, Rehearsal, and Delivered with each having their own corresponding Chef environment).

**Project Cookbook**
   A project cookbook is a cookbook that is used to deploy your project's software onto an infrastructure node. You can have one or many project cookbooks to control deploying your project's software. Every project cookbook's default recipe will be executed by Chef Client on your infrastructure nodes to deploy your software. Delivery Truck's provision recipe will parse your project's root for a ``metadata.rb`` and ``metadata.json`` file as well as directories
of the structure ``cookbooks/<project_cookbooks>`` that also contain a ``metadata.rb`` and ``metadata.json`` file to detect your project cookbooks.

**Project Application**
   If you have a binary, package, or other arbitrary information you wish to use to promote your project's software, a project application is what you want in |chef delivery_short|. This lets you store versioned attributes that can be promoted through your infrastructure nodes for each stage and can then be used to deploy your application at that version. You can use these versioned attributes in a project cookbook that will be executed on a build node, or in whatever way you want in the deploy recipe.



Example: A Single Project Cookbook
--------------------------------------------
Assume you have set up your build cookbook with Delivery Truck in the way described above for a project named ``my_project``. Also assume ``my_project`` is a simple software application you know how to deploy.

From your project's root directory, generate a simple project cookbook to deploy your application on a new git branch:

.. code-block:: bash

   delivery checkout my_new_project_branch
   chef generate cookbook my_project
   cp -R my_project/ .
   rm -rf my_project


This will generate a cookbook in the root of your project. It should have a ``metadata.rb`` file that looks something like this:

.. code-block:: bash

   name 'my_project'
   maintainer 'The Authors'
   maintainer_email 'you@example.com'
   license 'all_rights'
   description 'Installs/Configures my_project'
   long_description 'Installs/Configures my_project'
   version '0.1.0'

That version is what you will be changing as you make changes to your software. It will get promoted through your infrastructure nodes per the Acceptance, Union, Rehearsal, and Delivered stages.

Next, using Chef, add how your project is deployed to ``my_project/recipes/default.rb``. This is a normal Chef recipe so do whatever you would normally do to deploy your software through Chef.

Delivery Truck's promotion recipe you included in your build cookbook will handle the rest of the promotion work. Use the following commands to push your change:

.. code-block:: bash

   git add -A
   git commit -m "Let us deploy our app."
   delivery review

A change will open in your browser and you can approve it. If there are no errors, it will make it through the Acceptance stage. At this point, your project's software will be on your Acceptance infrastructure nodes, which was handled by Delivery Truck's provision recipe.

You can go to your Acceptance infrastructure nodes and see your app working there.

The next three stages in this example, Union , Rehearsal, and Delivered, have other enterprise-wide software that make up your company's deployed applications. If you click **Deliver** in the web UI, it will go into the Union phase. Again, Delivery Truck will handle updating Union to point at the version of your project cookbook from your change and run it on Union's infrastructure nodes to deploy the correct version of your project there. Assuming that all your tests passed, it will continue to deploy on Rehearsal's infrastructure nodes, and then eventually Delivered's infrastructure nodes (at which point your project will be live in production).

Now you make a change to your project and want to update it in production, so you make a new change, and remember to bump your project cookbook's ``metadata.rb`` version as shown in the edited code block below:

.. code-block:: bash

   delivery checkout master
   delivery checkout our_new_change
   <edit metadata.rb's version>
   <edit your project with a change>
   git add -A
   git commit -m "Updated our project's code to version 0.2.0."
   delivery review

This version of your project cookbook will get promoted in the same way as above, overwriting your old project cookbook, and thus your project's software, on each stage's infrastructure nodes until it is Delivered.

This simple example can be used if all you need is a single cookbook to deploy your project's software. The following two examples are useful if you want to use multiple cookbooks or deploy an application (such as a package or artifact) based on versioned attributes.

Multiple Project Cookbooks
---------------------------------
You may want more than just a single cookbook to deploy your project's software. Fortunately, using multiple project cookbooks works much in the same way as a single one. Simply put as many cookbooks as you like -- that follow a valid cookbook directory and file structure -- under a ``/cookbooks`` directory in the root of your project and commit them into your project. Each project cookbook must have a ``metadata.rb`` or ``metadata.json`` file in the cookbook's root directory or Delivery Truck will not find it. Each valid project cookbook's default recipe (``<your_cookbook_root_dir>/recipes/default.rb``) will be run on your infrastructure nodes for each stage.

It is recommended that you bump the metadata's version of each cookbook as you make changes, as this is what is actually used to pin your cookbook at each stage as it progresses through the pipeline, but all project cookbooks will be deployed through your stage's infrastructure regardless of whether you bump the metadata version, make changes, or do nothing to it.

Using Project Applications
---------------------------------
As described above, project applications are a useful way of promoting a set of attributes that can be pinned to a version and used to deploy your project's software at the correct version in a stage.

A common use case of project applications is promoting a binary, but it can be any arbitrary attributes that you wish to have pinned per version that you can in turn use to promote your software.

Project applications are defined in the ``.delivery/build-cookbook/publish.rb`` recipe of your build cookbook. The versioned attributes are then used in abvproject cookbook to deploy onto infrastructure nodes or in ``.delivery/build-cookbook/deploy.rb`` for you to use how you see fit (if you are not using infrastructure nodes). The publish phase happens at the end of the build stage, so that is where the version for your application is locked down and then used throughout the remaining stages. The following helper methods come from the ``delivery-sugar`` cookbook; as long as this cookbook is included in the recipe, these helper methods will be available.

Your project application is defined simply by passing a name, version, and Ruby hash of attributes you wish to version to the ``define_project_application`` helper in your publish build cookbook recipe:

.. code-block:: ruby

   define_project_application(
     <project_app_name_sting>,
     <project_app_version_string_or_integer>,
     <hash_of_app_attributes>
   )

Then, you must let your build cookbook know about your applications. Add a ``.delivery/build-cookbook/attributes/default.rb`` file if it doesn't already exist (you may have to add the attributes folder too) and add the following:

.. code-block:: ruby

   default['delivery']['project_apps'] = [<name_of_app_1>, <name_of_app_2> , ... ,<name_of_app_n>]

Lastly, in the default recipe of your project cookbook or in the deploy recipe of your build cookbook, all the application attributes at the proper version for your current stage can be retrieved by passing your project application's name to the ``get_project_application`` helper:

.. code-block:: ruby

   <hash_of_app_attributes> = get_project_application(
                               <project_app_name_string>
                              )

You can then use your project application's attribute to deploy your application in whatever way you see fit, confident that the contents of the hash are properly versioned for your stage.

Do not pass ``'id'``, ``'version'``, or ``'name'`` as attribute keys you pass into ``define_project_application``, or they will be overwritten by the first two arguments you pass in. They will be available in the result of ``get_project_application`` by default.


**Warning: If the ``get_project_application`` method is called from the ``provision.rb`` recipe, be sure that ``delivery-truck::provision`` is executed before ``get_project_application`` by putting it in a ``ruby_block`` or in a separate recipe that is called provision via ``include_recipe``. If the ``get_project_application`` method is called directly in ``provision.rb``:

.. code-block:: ruby

   include_recipe 'delivery-truck::provision'
   get_project_application(<project_app_name_string>)

you will get an error because the |chef client| will execute ``get_project_application`` at compile time before it has run ``include_recipe 'delivery-truck::provision'``.

It is recommended to either use ``get_project_application`` in ``deploy.rb``, a project cookbook, in a ``ruby_block`` or in a separate ``include_recipe`` that is executed after ``include_recipe 'delivery-truck::provision'``.

Example: Usage Of Project Applications
++++++++++++++++++++++++++++++++++++++++++++++++++

This example of uses project applications to deploy a package. Assume you are starting from a Delivery project with a properly configured build cookbook that has recipes set up to include Delivery Truck per phase as described above.

You want to deploy an application that you package into a ``.deb`` file in the deploy phase. Following what is outlined above, define a project application in your ``.delivery/build-cookbook/publish.rb`` file (you will have to fill in the details to get/generate your artifact):

.. code-block:: ruby

   include_recipe 'delivery-truck::publish'

   # Generate your artifact and document it's location on a download server.
   artifact_location = <your_generated_artifact_location>

   # It's recommended to generate a checksum from your package too.
   artifact_checksum = <checksum_based_on_your_package>

   # Version the artifact based on the current date.
   artifact_version = Time.now.strftime('%F_%H%M')

   # Name your application.
   name = "<your_app_name>"

   project_app_attributes = {
     'artifact_location' => artifact_location,
     'artifact_checksum' => artifact_checksum
   }

   define_project_application(
     name,
     artifact_version,
     project_app_attributes
   )

Now, when the publish phase is run, an application versioned by a timestamp will be created, with all the information needed to install that version of your application. Delivery Truck's provision code will automatically pin based on this version.

Next, set up the build cookbook to know about your application by adding the following to ``.delivery/build-cookbook/attributes/default.rb``:

.. code-block:: ruby

   default['delivery']['project_apps'] = ["<your_app_name>"]

Finally, handle installing your application in your build cookbook's deploy recipe in ``.delivery/build-cookbook/deploy.rb``:

.. code-block:: ruby

   app_attributes = get_project_application("<your_app_name>")

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
The surest way to validate your |chef delivery| installation is by creating a cookbook and submitting it to |github|, which will kick off a pipeline and you can see how the process works.

.. include:: ../../includes_delivery/includes_delivery_build_cookbook_create.rst

.. include:: ../../includes_delivery/includes_delivery_projects_add_with_delivery_truck.rst



That's it. You now have an application that builds in the publish phase (which is every
time you accept a change) and gets promoted with version pinning throughout
your infrastructure nodes per stage. This, coupled with the concept of :doc:`/delivery_manage_dependencies`, allows for safe promotion of an artifact.
