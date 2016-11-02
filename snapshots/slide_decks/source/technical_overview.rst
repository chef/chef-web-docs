

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

  .. tag slides_resources_type_package

  A package to be installed:

  .. code-block:: ruby

     package 'haproxy' do
      action :install
     end

  .. end_tag

 .. revealjs:: template

  .. tag slides_resources_type_template

  A file to be generated from a template:

  .. code-block:: ruby

     template '/etc/haproxy/haproxy.cfg' do
       source 'haproxy.cfg.erb'
       owner 'root'
       group 'root'
       mode '0644'
       notifies :restart, 'service[haproxy]'
     end

  .. end_tag

 .. revealjs:: service

  .. tag slides_resources_type_service

  A service that should be started:

  .. code-block:: ruby

     service 'haproxy' do
       supports :restart => :true
       action [:enable, :start]
     end

  .. end_tag

 .. revealjs:: Building Blocks: Recipes

   .. image:: ../../images/blocks_recipes.svg

 .. revealjs:: Recipes

   * Are a collection of resources
   * Execute resources in the same order as in the recipe

 .. revealjs:: Order Matters

  .. tag slides_recipes_order

  .. code-block:: ruby

     package 'haproxy' do
      action :install
     end

     template '/etc/haproxy/haproxy.cfg' do
       source 'haproxy.cfg.erb'
       owner 'root'
       group 'root'
       mode '0644'
       notifies :restart, 'service[haproxy]'
     end

     service 'haproxy' do
       supports :restart => :true
       action [:start, :enable]
     end

  .. end_tag

 .. revealjs:: Package Runs First

  .. tag slides_recipes_order_package

  .. code-block:: ruby

     package 'haproxy' do
       action :install
     end

  .. code-block:: ruby

     template '/etc/haproxy/haproxy.cfg' do
       source 'haproxy.cfg.erb'
       owner 'root'
       group 'root'
       mode '0644'
       notifies :restart, 'service[haproxy]'
     end

     service 'haproxy' do
       supports :restart => :true
       action [:start, :enable]
     end

  .. end_tag

 .. revealjs:: Template Runs Second

  .. tag slides_recipes_order_template

  .. code-block:: ruby

     package 'haproxy' do
       action :install
     end

  .. code-block:: ruby

     template '/etc/haproxy/haproxy.cfg' do
       source 'haproxy.cfg.erb'
       owner 'root'
       group 'root'
       mode '0644'
       notifies :restart, 'service[haproxy]'
     end

  .. code-block:: ruby

     service 'haproxy' do
       supports :restart => :true
       action [:start, :enable]
     end

  .. end_tag

 .. revealjs:: Service Runs Third

  .. tag slides_recipes_order_service

  .. code-block:: ruby

     package 'haproxy' do
       action :install
     end

     template '/etc/haproxy/haproxy.cfg' do
       source 'haproxy.cfg.erb'
       owner 'root'
       group 'root'
       mode '0644'
       notifies :restart, 'service[haproxy]'
     end

  .. code-block:: ruby

     service 'haproxy' do
       supports :restart => :true
       action [:start, :enable]
     end

  .. end_tag

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

   .. tag slides_core_questions

   .. Use this slide every time the slide deck stops for Q/A sessions with attendees.

   .. image:: ../../images/slides_questions.png

   .. end_tag

