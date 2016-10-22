================================================
Resources
================================================


.. revealjs::

 .. revealjs:: Resources - Overview

  .. include:: ../../includes_slides/includes_slides_resources_splash.rst

 .. revealjs:: About Resources

  .. include:: ../../includes_resources_common/includes_resources_common.rst

 .. revealjs:: Objectives

    * Understand resources types

 .. revealjs:: Resource Types

  Use Chef resources to manage a piece of the system:
  
  * package
  * template
  * service
  * directory
  * file
  * user
  * group
  * registry key
  * script
  
  and more!

 .. revealjs:: Resource Type - package

  .. include:: ../../includes_slides/includes_slides_resources_type_package.rst

 .. revealjs:: Resource Type - file

  A file that should be generated:
  
  .. code-block:: ruby
         
     file '/etc/motd' do
       content 'Property of Chef Software, Inc.'
     end

 .. revealjs:: Resource Type - service

  .. include:: ../../includes_slides/includes_slides_resources_type_service.rst

 .. revealjs:: Resource Type - cron

  A cron job that should be configured:
  
  .. code-block:: ruby
         
     cron 'restart webserver' do
       hour '2'
       minute '0'
       command 'service httpd restart'
     end

 .. revealjs:: Resource Type - user

  A user that should be managed:
  
  .. code-block:: ruby
         
     user 'nginx' do
       comment 'Nginx <nginx@example.com>'
       uid '500'
       gid '500'
       manage_home true
     end

 .. revealjs:: Resource Type - dsc_script

  A DSC configuration that should be run:
  
  .. code-block:: ruby
         
     dsc_script 'emacs' do
       code <<-EOH
         Environment 'texteditor'
           {
             Name = 'EDITOR'
             Value = 'c:\\emacs\\bin\\emacs.exe'
           }
       EOH
     end

 .. revealjs:: Resource Type – registry_key

  A registry key that should be created:
  
  .. code-block:: ruby
         
     registry_key 'HKEY_LOCAL_MACHINE\\SOFTWARE\\Microsoft\\...\\System' do
       values [{
         :name => 'EnableLUA',
         :type => :dword,
         :data => 0
       }]
       action :create
     end

 .. revealjs:: Recap

    * Understand resources types

 .. revealjs:: Questions

   .. include:: ../../includes_slides/includes_slides_core_questions.rst

 .. revealjs:: More Info About Resources

    For more information, see:

    * |url slides_docs_chef_io|
    * |url slides_docs_resources|


.. revealjs::

 .. revealjs:: Resources - Syntax

  .. include:: ../../includes_slides/includes_slides_resources_splash.rst

 .. revealjs:: About Resources

  .. include:: ../../includes_resources_common/includes_resources_common.rst

 .. revealjs:: Objectives

    * Understand the resource syntax
    * Understand how to declare resources in recipes

 .. revealjs:: Syntax - Resource Type

  A resource has a type:
  
  .. code-block:: ruby
  
     file

 .. revealjs:: Syntax - Resource Name

  A resource has a name:
  
  .. code-block:: ruby
  
     file 'hello.txt'

 .. revealjs:: Syntax - Resource Keywords

  A resource includes details between keywords ``do`` and ``end``:
  
  .. code-block:: ruby
         
     file 'hello.txt' do
       ...
     end

 .. revealjs:: Syntax - Resource Action

  A resource describes the state of something by declaring an action:
  
  .. code-block:: ruby
         
     file 'hello.txt' do
       action :create
     end

 .. revealjs:: Syntax - Resource Syntax In Plain English

  The file named ``hello.txt`` should be created:
  
  .. code-block:: ruby
         
     file 'hello.txt' do
       action :create
     end

 .. revealjs:: Syntax - Resource Attributes

  A resource includes additional details---attributes:
  
  .. code-block:: ruby
         
     file 'hello.txt' do
       action :create
       content 'Hello, world!'
       mode '0644'
       owner 'chef'
       group 'chef'
     end

 .. revealjs:: Syntax – Resource Attributes In Plain English

  The TYPE named NAME should be ACTION'd with ATTRIBUTES:
  
  .. code-block:: ruby
         
     file 'hello.txt' do
       action :create
       content 'Hello, world!'
       mode '0644'
       owner 'chef'
       group 'chef'
     end

 .. revealjs:: Syntax – Resource Attributes In Plain English

  A file named ``hello.txt`` should be created with content of ``Hello, world!``, permissions of ``0644``, owned by the ``chef`` user and ``chef`` group:
  
  .. code-block:: ruby
         
     file 'hello.txt' do
       action :create
       content 'Hello, world!'
       mode '0644'
       owner 'chef'
       group 'chef'
     end

 .. revealjs:: Recap

    * Understand the resource syntax
    * Understand how to declare resources in recipes

 .. revealjs:: Questions

   .. include:: ../../includes_slides/includes_slides_core_questions.rst

 .. revealjs:: More Info About Resources

    For more information, see:

    * |url slides_docs_chef_io|
    * |url slides_docs_resources|


.. revealjs::

 .. revealjs:: Resources - Test and Repair

  .. include:: ../../includes_slides/includes_slides_resources_splash.rst

 .. revealjs:: About Resources

  .. include:: ../../includes_resources_common/includes_resources_common.rst

 .. revealjs:: Objectives

    * Understand how resources test and repair the system

 .. revealjs:: Test and Repair

  Resources follow a test and repair model:
  
  * Is a resource currently in the desired state? (test)
  * If YES, do nothing
  * If NO, then bring the resource into the desired state (repair)

 .. revealjs:: Test and Repair

  .. image:: ../../images/test_and_repair_model_template_01.png

 .. revealjs:: Test and Repair

  .. image:: ../../images/test_and_repair_model_template_02.png

 .. revealjs:: Test and Repair

  .. image:: ../../images/test_and_repair_model_template_03.png

 .. revealjs:: Test and Repair

  .. image:: ../../images/test_and_repair_model_template_04.png

 .. revealjs:: Test and Repair

  .. image:: ../../images/test_and_repair_model_template_05.png

 .. revealjs:: Test and Repair

  .. image:: ../../images/test_and_repair_model_template_06.png

 .. revealjs:: Test and Repair

  .. image:: ../../images/test_and_repair_model_template_07.png

 .. revealjs:: Recap

    * Understand how resources test and repair the system

 .. revealjs:: Questions

   .. include:: ../../includes_slides/includes_slides_core_questions.rst

 .. revealjs:: More Info About Resources

    For more information, see:

    * |url slides_docs_chef_io|
    * |url slides_docs_resources|





