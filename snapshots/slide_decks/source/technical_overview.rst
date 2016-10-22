.. THIS PAGE IS LOCATED AT THE /decks/ PATH.

================================================
Technical Overview
================================================

.. revealjs::

 .. revealjs:: Agenda

    * Overview
    * Chef software platform
    * Building blocks
    * Automation patterns

 .. revealjs:: Overview

    * Chef is an automation framework that enables infrastructure as code
    * Chef leverages reusable definitions to automate desired state
    * Chef is API driven
    * Chef supports Linux variants, UNIX variants, AIX, and Microsoft Windows, all as first class citizens

 .. revealjs:: Software Platform

   .. image:: ../../images/chef_overview_simple.png

 .. revealjs:: Building Blocks: Resources

   .. image:: ../../images/blocks_resources.svg

 .. revealjs:: Resources

   Declare the state of the system. For example:
   
   * A package is installed
   * A configuration file exists (and is managed by a template)
   * A service is running

 .. revealjs:: package

  .. include:: ../../includes_slides/includes_slides_resources_type_package.rst

 .. revealjs:: template

  .. include:: ../../includes_slides/includes_slides_resources_type_template.rst

 .. revealjs:: service

  .. include:: ../../includes_slides/includes_slides_resources_type_service.rst

 .. revealjs:: Building Blocks: Recipes

   .. image:: ../../images/blocks_recipes.svg

 .. revealjs:: Recipes

   * Are a collection of resources
   * Execute resources in the same order as in the recipe

 .. revealjs:: Order Matters

  .. include:: ../../includes_slides/includes_slides_recipes_order.rst

 .. revealjs:: Package Runs First

  .. include:: ../../includes_slides/includes_slides_recipes_order_package.rst

 .. revealjs:: Template Runs Second

  .. include:: ../../includes_slides/includes_slides_recipes_order_template.rst

 .. revealjs:: Service Runs Third

  .. include:: ../../includes_slides/includes_slides_recipes_order_service.rst

 .. revealjs:: Building Blocks: Cookbooks

   .. image:: ../../images/blocks_cookbooks.svg

 .. revealjs:: Cookbooks

   * Contain recipes
   * Define steps to address expected outcomes
   
   .. code-block:: none
          
      haproxy
         ├── CHANGELOG.md
         ├── CONTRIBUTING
         ├── definitions
         ├── files
         │   └── default
         ├── LICENSE
         ├── metadata.rb
         ├── README.md
         ├── recipes
         │   └── default.rb
         └── templates
             └── default
                 └── haproxy.cfg.erb

 .. revealjs:: Building Blocks: Roles

   .. image:: ../../images/blocks_roles.svg

 .. revealjs:: Roles

   .. image:: ../../images/blocks_roles_example.svg
   
   .. 
   .. the following is the legacy slide. the question is: does that mean anything if it's in the first overview someone sees? suggestion: make it more visual. the image is just a mockup attempt.
   .. 
   .. Define reusable roles:
   ..
   .. .. code-block:: javascript
   .. 
   ..    chef_type:           role
   ..    default_attributes:
   ..      my-app:
   ..        application:
   ..          package:     mysite-A.tar.gz
   ..          package_sum: 73e5cf3287e4d903d3828da5be1ab228ea33152447551b4e489e659268f643b2
   ..          package_url: http://demo-framework.s3.amazonaws.com/mysite-A.tar.gz
   ..    description:         Role for a myapp webserver
   ..    env_run_lists:
   ..    json_class:          Chef::Role
   ..    name:                myapp_A_webserver
   ..    override_attributes:
   ..    run_list:
   ..      recipe[my-app::application]
   ..      recipe[my-app::webserver]
   .. 
   .. 

 .. revealjs:: Building Blocks: Environments

   .. image:: ../../images/blocks_environments.svg

 .. revealjs:: Environments

   .. image:: ../../images/blocks_environments_example.svg
   
   
   
   .. 
   .. the following is the legacy slide. the question is: does that mean anything if it's in the first overview someone sees? suggestion: make it more visual. the image is just a mockup attempt.
   .. 
   .. Define reusable environments:
   .. 
   .. .. code-block:: javascript
   .. 
   ..    chef_type:           environment
   ..    cookbook_versions:
   ..      database: 2.2.0 
   ..    default_attributes:
   ..      myapp:
   ..        version: 1.2.3
   ..    description:         for development nodes
   ..    json_class:          Chef::Environment
   ..    name:                development
   ..    override_attribute
   .. 

 .. revealjs:: Building Blocks: Data Bags

   .. image:: ../../images/blocks_data_bags.svg

 .. revealjs:: Data Bags

   Define global variables that are accessible to all the things:
   
   .. code-block:: javascript
   
      deploy_key:
        cipher:         aes-256-cbc
        encrypted_data: lIpW3sqd69wXt7+MB+uGXr0GfcrEf6rOnHLMA7H00ZCb
                        qzEZSzCf2ahv67CtcfrDGvUoWS57Gp5/QoR4WBYKQQUp
                        a0aNhrzrXhT9eDKNpru7hpuEkOZPRNstx1121bdMZ9lh
                        . . . . . . . . . . . . . . 
        iv:             tpz6zFz9xkscoi36kRw4JQ==
        
        version:        1
      id:               jenkins_ssh_key

 .. revealjs:: Automation Patterns

   .. image:: ../../images/automation_patterns.png

 .. revealjs:: Questions

   .. include:: ../../includes_slides/includes_slides_core_questions.rst

