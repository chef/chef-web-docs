================================================
Cookbooks
================================================


.. revealjs::

 .. revealjs:: Cookbook Training

    .. image:: ../../images/slides_splash_cookbooks.png

 .. revealjs:: About Cookbooks

    .. include:: ../../includes_cookbooks/includes_cookbooks.rst

 .. revealjs:: Objectives

    * Understand why we abstract data from policy
    * Policy defines the desired state of the system, whereas data defines the details that might change
    * Understand which resources to use to apply policy and manage data

	For example:

    * Apache Tomcat should be installed (policy); version 6 (data)
    * A file should exit (policy); the contents of that file (data)

 .. revealjs:: Which Resource to Use?

    * **cookbook_file**
    * **file**
    * **remote_file**
    * **template**

 .. revealjs:: cookbook_file

    Use the **cookbook_file** resource for a file that is stored a cookbook's ``/files`` directory:
    
    .. code-block:: none
    
       motd
          ├── Berksfile
          ├── README.md
          ├── chefignore
          ├── files
          │   └── default
          │       └── motd
          ├── metadata.rb
          ├── recipes
          └── default.rb

 .. revealjs:: file

    Use the **file** resource to define the contents of a file inline within the recipe:
    
    .. code-block:: ruby
           
       file '/etc/motd' do
         content 'Property of COMPANY NAME'
         action :create
         mode '0644'
         owner 'root'
         group 'root'
       end

 .. revealjs:: remote_file

    Use the **remote_file** resource when a file is stored at a remote location, such as on the web:
    
    .. code-block:: ruby
           
       file '/etc/motd' do
         url 'http://some.where.com/motd'
         action :create
         mode '0644'
         owner 'root'
         group 'root'
       end

 .. revealjs:: template

    Use the **template** resource when a template is stored a cookbook's ``/templates`` directory:
    
    .. code-block:: none
           
       motd
          ├── Berksfile
          ├── README.md
          ├── chefignore
          ├── metadata.rb
          ├── recipes
          │   └── default.rb
          └── templates
              └── default
                  └── motd.erb
    
    This template is then rendered to create a file:
    
    .. code-block:: ruby
           
       Property of <%= @company_name %>

 .. revealjs:: Recap - Which Resource to Use?

    * **cookbook_file** – a static file, located within the cookbook
    * **file** – content managed within the resource in the recipe
    * **remote_file** – a static file, obtained from a URL
    * **template** – dynamic content based on an Embedded Ruby (ERB) template

 .. revealjs:: Cookbooks

    * Is a package for Chef policies
    * Typically maps 1:1 to a piece of software or functionality
    * Distribution unit
    * Versioned
    * Re-usable

 .. revealjs:: Message of the day

    State is policy that describes the resource. For example, create the ``motd`` file if it does not already exist:
    
    .. code-block:: ruby
           
       file '/etc/motd' do
         content 'Property of COMPANY NAME'
         action :create
         mode '0644'
         owner 'root'
         group 'root'
       end

 .. revealjs:: Message of the day

    Content is data that may change independent of policy changes. For example, adding content and setting permissions:
    
    .. code-block:: ruby
           
       file '/etc/motd' do
         content 'Property of COMPANY NAME'
         action :create
         mode '0644'
         owner 'root'
         group 'root'
       end

 .. revealjs:: Questions

    .. include:: ../../includes_slides/includes_slides_core_questions.rst
