================================================
Kitchen
================================================


.. revealjs::

 .. revealjs:: Kitchen Training

  .. include:: ../../includes_slides/includes_slides_kitchen_splash.rst

 .. revealjs:: About Kitchen

  .. include:: ../../includes_test_kitchen/includes_test_kitchen.rst

 .. revealjs:: Objectives

    * Follow a test-first/test-driven model to build a home page for a website
    * Understand |kitchen| components
    * Understand |kitchen| commands
    * Understand |kitchen| workflow
    * Create the apache cookbook
    * Define a test matrix
    * Create the |kitchen yml| file
    * Install |docker| to use with |kitchen|
    * Create a test |kitchen| instance
    * Apply policy
    * Run |kitchen|
    * Update for the motd cookbook
    * Understand test results

 .. revealjs:: Success?

    * Is there a target machine running with the same platform as a production machine?
    * Does the |chef client| have access to the cookbook?

 .. revealjs:: Kitchen Components

  .. include:: ../../includes_slides/includes_slides_kitchen_components.rst

 .. revealjs:: What does Kitchen Do?

  .. include:: ../../includes_slides/includes_slides_kitchen_commands.rst

 .. revealjs:: Kitchen Workflow

  .. include:: ../../includes_slides/includes_slides_kitchen_workflow.rst

 .. revealjs:: Move to the Proper Directory

  .. include:: ../../includes_slides/includes_slides_chef_repo_open_cookbooks.rst

 .. revealjs:: Generate the Apache Cookbook

  .. include:: ../../includes_slides/includes_slides_cookbook_apache_generate_cookbook.rst

 .. revealjs:: Move to the Apache Directory

  .. include:: ../../includes_slides/includes_slides_cookbook_apache_directory_open_apache.rst

 .. revealjs:: Add the Cookbook to a Git Repo

  .. include:: ../../includes_slides/includes_slides_github_commit_chef_repo_git_add.rst

 .. revealjs:: Commit the Cookbook to the Git Repo

  .. include:: ../../includes_slides/includes_slides_cookbook_apache_github_commit.rst

 .. revealjs:: Test Matrix - Two Platforms

  .. include:: ../../includes_slides/includes_slides_kitchen_yaml_matrix_two_platforms.rst

 .. revealjs:: Test Matrix - Two Platforms, One Recipe

  .. include:: ../../includes_slides/includes_slides_kitchen_yaml_matrix_one_recipe.rst

 .. revealjs:: Test Matrix - Two Platforms, Two Recipes

  .. include:: ../../includes_slides/includes_slides_kitchen_yaml_matrix_two_recipes.rst

 .. revealjs:: Test Matrix - Three Platforms, Two Recipes

  .. include:: ../../includes_slides/includes_slides_kitchen_yaml_matrix_three_platforms.rst

 .. revealjs:: .kitchen.yml

  .. include:: ../../includes_slides/includes_slides_kitchen_yaml.rst

 .. revealjs:: Create .kitchen.yml

  .. include:: ../../includes_slides/includes_slides_kitchen_yaml_create.rst

 .. revealjs:: .kitchen.yml - Driver

  .. include:: ../../includes_slides/includes_slides_kitchen_yaml_driver.rst

 .. revealjs:: .kitchen.yml - Provisioner

  .. include:: ../../includes_slides/includes_slides_kitchen_yaml_provisioner.rst

 .. revealjs:: .kitchen.yml - Platforms

  .. include:: ../../includes_slides/includes_slides_kitchen_yaml_platforms.rst

 .. revealjs:: .kitchen.yml - Suites

  .. include:: ../../includes_slides/includes_slides_kitchen_yaml_suites.rst

 .. revealjs:: .kitchen.yml - Example - Two Platforms

  .. include:: ../../includes_slides/includes_slides_kitchen_yaml_example_two_platforms.rst

 .. revealjs:: .kitchen.yml - Exmple - Two Suites

  .. include:: ../../includes_slides/includes_slides_kitchen_yaml_example_two_suites.rst

 .. revealjs:: .kitchen.yml - Exmple - Three Platforms, Two Suites

  .. include:: ../../includes_slides/includes_slides_kitchen_yaml_example_three_platforms.rst

 .. revealjs:: Update .kitchen.yml

  .. include:: ../../includes_slides/includes_slides_kitchen_yaml_update.rst

 .. revealjs:: About Docker

  .. include:: ../../includes_slides/includes_slides_kitchen_docker.rst

 .. revealjs:: Install Docker Image

  .. include:: ../../includes_slides/includes_slides_kitchen_docker_verify.rst

 .. revealjs:: Install kitchen-docker

  .. include:: ../../includes_slides/includes_slides_kitchen_docker_gem.rst

 .. revealjs:: Verify kitchen-docker is Installed

  .. include:: ../../includes_slides/includes_slides_kitchen_docker_verify_kitchen.rst

 .. revealjs:: Move to the Apache Cookbook Directory

  .. include:: ../../includes_slides/includes_slides_cookbook_apache_directory_open.rst

 .. revealjs:: List Test Kitchen Instances

  .. include:: ../../includes_slides/includes_slides_kitchen_list.rst

 .. revealjs:: Create the Kitchen Instance

  .. include:: ../../includes_slides/includes_slides_kitchen_create.rst

 .. revealjs:: Kitchen Created

  .. include:: ../../includes_slides/includes_slides_kitchen_diagram_01.rst

 .. revealjs:: Login to the Kitchen Instance

  .. include:: ../../includes_slides/includes_slides_kitchen_login.rst

 .. revealjs:: Kitchen Login

  .. include:: ../../includes_slides/includes_slides_kitchen_diagram_03.rst

 .. revealjs:: Kitchen Login

  .. include:: ../../includes_slides/includes_slides_kitchen_diagram_04.rst

 .. revealjs:: Kitchen Login

  .. include:: ../../includes_slides/includes_slides_kitchen_diagram_05.rst

 .. revealjs:: Apply Policy

  .. include:: ../../includes_slides/includes_slides_kitchen_lab_apply_policy.rst

 .. revealjs:: Exit Kitchen

  .. include:: ../../includes_slides/includes_slides_kitchen_exit.rst

 .. revealjs:: Move to the Apache Cookbook Directory (Again)

  .. include:: ../../includes_slides/includes_slides_cookbook_apache_directory_open.rst

 .. revealjs:: Apply the Policy

  .. include:: ../../includes_slides/includes_slides_kitchen_converge.rst

 .. revealjs:: Run the kitchen converge Command

  .. include:: ../../includes_slides/includes_slides_kitchen_diagram_06.rst

 .. revealjs:: Verify the Test

  .. include:: ../../includes_slides/includes_slides_kitchen_lab_status_check.rst

 .. revealjs:: Update Kitchen for the motd Cookbook

  .. include:: ../../includes_slides/includes_slides_cookbook_motd_kitchen.rst

 .. revealjs:: Recap

    * Follow a test-first/test-driven model to build a home page for a website
    * Understand |kitchen| components, commands, and workflow
    * Define a test matrix
    * Create the |kitchen yml| file
    * Install |docker| to use with |kitchen|
    * Create a cookbook and test it using |kitchen|
    * Understand how to add multiple platforms and suites
    * Understand how to use alternate drivers (instead of |docker|)
    * Understand how to remove the |kitchen| test instance

 .. revealjs:: Questions

   .. include:: ../../includes_slides/includes_slides_core_questions.rst

 .. revealjs:: Time to Hack

   .. include:: ../../includes_slides/includes_slides_core_hack.rst

 .. revealjs:: More Info About Kitchen

    For more information, see:

    * |url slides_docs_chef_io|
    * |url slides_docs_kitchen|
    * |url slides_kitchen|
