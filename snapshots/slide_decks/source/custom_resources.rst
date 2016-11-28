================================================
Custom Resources
================================================

.. revealjs::

 .. revealjs:: Custom Resources
    :noheading:

    .. image:: ../../images/custom_resources.svg

 .. revealjs:: About Custom Resources

    .. tag custom_resources_27

    .. This file is hooked into a slide deck

    A custom resource:

    * Is a simple extension of Chef
    * Is implemented as part of a cookbook
    * Follows easy, repeatable syntax patterns
    * Effectively leverages resources that are built into Chef
    * Is reusable in the same way as resources that are built into Chef

    For example, Chef includes built-in resources to manage files, packages, templates, and services, but it does not include a resource that manages websites.

    .. end_tag

    .. note:: Read this scenario as a single-page topic at https://docs.chef.io/custom_resources.html.

 .. revealjs:: Scenario: Create a Resource that Manages a Website

    .. tag custom_resources_slide_website

    .. This file is hooked into a slide deck

    Create a resource that configures Apache httpd for Red Hat Enterprise Linux 7 and CentOS 7.

    This scenario covers the following:

    #. Defining a cookbook named ``website``
    #. Defining two properties
    #. Defining an action
    #. For the action, defining the steps to configure the system using resources that are built into Chef
    #. Creating two templates that support the custom resource
    #. Adding the resource to a recipe

    .. end_tag

 .. revealjs:: Create a Cookbook

    .. tag custom_resources_slide_website_cookbook

    .. This file is hooked into a slide deck

    This article assumes that a cookbook directory named ``website`` exists in a chef-repo with (at least) the following directories:

    .. code-block:: text

       /website
         /recipes
         /resources
         /templates

    You may use a cookbook that already exists or you may create a new cookbook.

    See :doc:`ctl_chef` for more information about how to use the ``chef`` command-line tool that is packaged with the Chef development kit to build the chef-repo, plus related cookbook sub-directories.

    .. end_tag

 .. revealjs:: Objectives
    :noheading:

    .. image:: ../../images/custom_resources_01.svg

 .. revealjs:: Objectives

    .. tag custom_resources_slide_website_objectives

    .. This file is hooked into a slide deck

    Define a custom resource!

    A custom resource typically contains:

    * A list of defined custom properties (property values are specified in recipes)
    * At least one action (actions tell the chef-client what to do)
    * For each action, use a collection of resources that are built into Chef to define the steps required to complete the action

    .. end_tag

 .. revealjs:: What is needed?

    .. tag custom_resources_slide_website_objectives_requirements

    .. This file is hooked into a slide deck

    This custom resource requires:

    * Two template files
    * Two properties
    * An action that defines all of the steps necessary to create the website

    .. end_tag

 .. revealjs:: Define Properties
    :noheading:

    .. image:: ../../images/custom_resources_02.svg

 .. revealjs:: Define Properties

    .. tag custom_resources_slide_website_properties

    .. This file is hooked into a slide deck

    Custom properties are defined in the resource. This custom resource needs two:

    * ``instance_name``
    * ``port``

    These properties are defined as variables in the ``httpd.conf.erb`` file. A **template** block in recipes will tell the chef-client how to apply these variables.

    .. end_tag

 .. revealjs:: Define Properties (continued)

    .. tag custom_resources_slide_website_properties_add

    .. This file is hooked into a slide deck

    In the custom resource, add the following custom properties:

    .. code-block:: ruby

       property :instance_name, String, name_property: true
       property :port, Fixnum, required: true

    where

    * ``String`` and ``Fixnum`` are Ruby types (all custom properties must have an assigned Ruby type)
    * ``name_property: true`` allows the value for this property to be equal to the ``'name'`` of the resource block

    The ``instance_name`` property is then used within the custom resource in many locations, including defining paths to configuration files, services, and virtual hosts.

    .. end_tag

 .. revealjs:: Define Actions
    :noheading:

    .. image:: ../../images/custom_resources_03.svg

 .. revealjs:: Define Actions

    .. tag custom_resources_slide_website_actions

    .. This file is hooked into a slide deck

    Each custom resource must have at least one action that is defined within an ``action`` block:

    .. code-block:: ruby

       action :create do
         # the steps that define the action
       end

    where ``:create`` is a value that may be assigned to the ``action`` property for when this resource is used in a recipe.

    For example, the ``action`` appears as a property when this custom resource is used in a recipe:

    .. code-block:: ruby

       custom_resource 'name' do
         # some properties
         action :create
       end

    .. end_tag

 .. revealjs:: Define Resource
    :noheading:

    .. image:: ../../images/custom_resources_04.svg

 .. revealjs:: Define the Resource

    .. tag custom_resources_slide_website_resources

    .. This file is hooked into a slide deck

    Use the **package**, **template** (two times), **directory**, and **service** resources to define the ``website`` resource. Remember: :doc:`order matters <recipe_order_matters>`!

    .. end_tag

 .. revealjs:: package

    .. tag custom_resources_slide_website_resources_package

    .. This file is hooked into a slide deck

    Use the **package** resource to install httpd:

    .. code-block:: ruby

       package 'httpd' do
         action :install
       end

    .. end_tag

 .. revealjs:: template, httpd.service

    .. tag custom_resources_slide_website_resources_template_httpd_service

    .. This file is hooked into a slide deck

    Use the **template** resource to create an ``httpd.service`` on the node based on the ``httpd.service.erb`` template located in the cookbook:

    .. code-block:: ruby

       template "/lib/systemd/system/httpd-#{instance_name}.service" do
         source 'httpd.service.erb'
         variables(
           :instance_name => instance_name
         )
         owner 'root'
         group 'root'
         mode '0644'
         action :create
       end

    where

    * ``source`` gets the ``httpd.service.erb`` template from this cookbook
    * ``variables`` assigns the ``instance_name`` property to a variable in the template

    .. end_tag

 .. revealjs:: template, httpd.conf

    .. tag custom_resources_slide_website_resources_template_httpd_conf

    .. This file is hooked into a slide deck

    Use the **template** resource to configure httpd on the node based on the ``httpd.conf.erb`` template located in the cookbook:

    .. code-block:: ruby

       template "/etc/httpd/conf/httpd-#{instance_name}.conf" do
         source 'httpd.conf.erb'
         variables(
           :instance_name => instance_name,
           :port => port
         )
         owner 'root'
         group 'root'
         mode '0644'
         action :create
       end

    where

    * ``source`` gets the ``httpd.conf.erb`` template from this cookbook
    * ``variables`` assigns the ``instance_name`` and ``port`` properties to variables in the template

    .. end_tag

 .. revealjs:: directory

    .. tag custom_resources_slide_website_resources_directory

    .. This file is hooked into a slide deck

    Use the **directory** resource to create the ``/var/www/vhosts`` directory on the node:

    .. code-block:: ruby

       directory "/var/www/vhosts/#{instance_name}" do
         recursive true
         owner 'root'
         group 'root'
         mode '0755'
         action :create
       end

    .. end_tag

 .. revealjs:: service

    .. tag custom_resources_slide_website_resources_service

    .. This file is hooked into a slide deck

    Use the **service** resource to enable, and then start the service:

    .. code-block:: ruby

       service "httpd-#{instance_name}" do
         action [:enable, :start]
       end

    .. end_tag

 .. revealjs:: Create Templates

    .. tag custom_resources_slide_website_templates

    .. This file is hooked into a slide deck

    The ``/templates`` directory must contain two templates:

    * ``httpd.conf.erb`` to configure Apache httpd
    * ``httpd.service.erb`` to tell systemd how to start and stop the website

    .. end_tag

 .. revealjs:: httpd.conf.erb

    .. tag custom_resources_slide_website_templates_httpd_conf_erb

    .. This file is hooked into a slide deck

    ``httpd.conf.erb`` stores information about the website and is typically located under the ``/etc/httpd``:

    .. code-block:: ruby

       ServerRoot "/etc/httpd"
       Listen <%= @port %>
       Include conf.modules.d/*.conf
       User apache
       Group apache
       <Directory />
         AllowOverride none
         Require all denied
       </Directory>
       DocumentRoot "/var/www/vhosts/<%= @instance_name %>"
       <IfModule mime_module> 
         TypesConfig /etc/mime.types
       </IfModule>

    Copy it as shown, add it under ``/templates/default``, and then name the file ``httpd.conf.erb``.

    .. end_tag

 .. revealjs:: Template Variables

    .. tag custom_resources_slide_website_templates_httpd_conf_erb_variables

    .. This file is hooked into a slide deck

    The ``httpd.conf.erb`` template has two variables:

    * ``<%= @instance_name %>``
    * ``<%= @port %>``

    They are:

    * Declared as properties of the custom resource
    * Defined as variables in a **template** resource block within the custom resource
    * Tunable from a recipe when using ``port`` and ``instance_name`` as properties in that recipe
    * ``instance_name`` defaults to the ``'name'`` of the custom resource if not specified as a property

    .. end_tag

 .. revealjs:: httpd.service.erb

    .. tag custom_resources_slide_website_templates_httpd_service_erb

    .. This file is hooked into a slide deck

    ``httpd.service.erb`` tells systemd how to start and stop the website:

    .. code-block:: none

       [Unit]
       Description=The Apache HTTP Server - instance <%= @instance_name %>
       After=network.target remote-fs.target nss-lookup.target

       [Service]
       Type=notify

       ExecStart=/usr/sbin/httpd -f /etc/httpd/conf/httpd-<%= @instance_name %>.conf -DFOREGROUND
       ExecReload=/usr/sbin/httpd -f /etc/httpd/conf/httpd-<%= @instance_name %>.conf -k graceful
       ExecStop=/bin/kill -WINCH ${MAINPID}

       KillSignal=SIGCONT
       PrivateTmp=true

       [Install]
       WantedBy=multi-user.target

    Copy it as shown, add it under ``/templates/default``, and then name it ``httpd.service.erb``.

    .. end_tag

 .. revealjs:: Final Resource (Part One)

    .. This file is hooked into a slide deck
    .. If changes are made to this file, also update includes_custom_resources_website_final_resource

    The finished custom resource should look exactly like this:

    .. code-block:: ruby

       property :instance_name, String, name_property: true
       property :port, Fixnum, required: true

       action :create do
         package 'httpd' do
           action :install
         end

         template "/lib/systemd/system/httpd-#{instance_name}.service" do
           source 'httpd.service.erb'
           variables(
             :instance_name => instance_name
           )
           owner 'root'
           group 'root'
           mode '0644'
           action :create
         end

       ... # continued on next slide

 .. revealjs:: Final Resource (Part Two)

    .. This file is hooked into a slide deck
    .. If changes are made to this file, also update includes_custom_resources_website_final_resource

    .. code-block:: ruby

       # continued from previous slide

         template "/etc/httpd/conf/httpd-#{instance_name}.conf" do
           source 'httpd.conf.erb'
           variables(
             :instance_name => instance_name,
             :port => port
           )
           owner 'root'
           group 'root'
           mode '0644'
           action :create
         end

       ... # continued on next slide

 .. revealjs:: Final Resource (Part Three)

    .. This file is hooked into a slide deck
    .. If changes are made to this file, also update includes_custom_resources_website_final_resource

    .. code-block:: ruby

       # continued from previous slide

         directory "/var/www/vhosts/#{instance_name}" do
           recursive true
           owner 'root'
           group 'root'
           mode '0755'
           action :create
         end

         service "httpd-#{instance_name}" do
           action [:enable, :start]
         end

       end

 .. revealjs:: Final Cookbook Directory

    .. tag custom_resources_slide_website_final_cookbook_directory

    .. This file is hooked into a slide deck

    When finished adding the templates and building the custom resource, the cookbook directory structure should look like this:

    .. code-block:: text

       /website
         metadata.rb
         /recipes
           default.rb
         README.md
         /resources
           httpd.rb
         /templates
           /default
             httpd.conf.erb
             httpd.service.erb

    .. end_tag

 .. revealjs:: Recipe
    :noheading:

    .. image:: ../../images/custom_resources_05.svg

 .. revealjs:: Add the Resource to a Recipe

    .. tag custom_resources_slide_website_recipe

    .. This file is hooked into a slide deck

    The custom resource name is inferred from the name of the cookbook (``website``), the name of the recipe (``httpd``), and is separated by an underscore(``_``): ``website_httpd``.

    .. code-block:: ruby

       website_httpd 'httpd_site' do
         port 81
         action :create
       end

    which does the following:

    * Installs Apache httpd
    * Assigns an instance name of ``httpd_site`` that uses port 81
    * Configures httpd and systemd from a template
    * Creates the virtual host for the website
    * Starts the website using systemd

    .. end_tag

 .. revealjs:: More Info About Resources

    For more information, see:

    * |url slides_docs_chef_io|
    * https://docs.chef.io/custom_resources.html

.. 
.. Notes for future sections:
.. 
.. 1) custom resource names (that don't join cookbook_recipe) by using provides
.. 2) proper location of the defaut.rb recipe (not in this cookbook!)
.. 3) Actual test scenarios for Kitchen and otherwise
..

.. 
..  .. revealjs:: Test
..     :noheading:
.. 
..     .. image:: ../../images/custom_resources_06.svg
.. 
..  .. revealjs:: Add to Run-List, Run Kitchen
.. 
..     Now run the recipe in this cookbook on a node that has Red Hat Enterprise Linux 7 or CentOS 7. Apache httpd should be installed, configured, and started.
.. 
..  .. revealjs:: Add to Run-List, Run Chef
.. 
..     Now run the recipe in this cookbook on a node that has Red Hat Enterprise Linux 7 or CentOS 7. Apache httpd should be installed, configured, and started.
.. 
