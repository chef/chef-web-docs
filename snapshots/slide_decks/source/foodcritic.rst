================================================
Foodcritic
================================================


.. revealjs::

 .. revealjs:: Foodcritic Training

    .. image:: ../../images/slides_splash_foodcritic.png

 .. revealjs:: About Foodcritic

    .. include:: ../../includes_foodcritic/includes_foodcritic.rst

 .. revealjs:: Objectives

    * Change a recipe
    * Run Foodcritic
    * See what happens

 .. revealjs:: Change a Recipe

    #. Open ``recipes/default.rb``.
    #. Add:
    
       .. code-block:: ruby
       
          package_name = 'httpd'
          
          package '#{package_name}'
          
          service 'httpd' do
            action :start
          end
          
          template '/var/www/html/index.html' do
            source 'index.html.erb'
          end
    
    #. Save the file.

 .. revealjs:: Run Foodcritic

    Run:
    
    .. code-block:: bash
    
       $ foodcritic .
    
    Returns:
    
    .. code-block:: none
    
       FC002: Avoid string interpolation where not required: ./recipes/default.rb:7

 .. revealjs:: What Happened?

    * What rules have been deprecated?
    * What does Foodcritic return on success?

 .. revealjs:: Recap

    * Check cookbooks for common problems
    * Ensure style and correctness
    * Follow best practices, avoid mistakes
    * Foodcritic is part of the Chef development kit

 .. revealjs:: Questions

   .. include:: ../../includes_slides/includes_slides_core_questions.rst

 .. revealjs:: Time to Hack

   .. include:: ../../includes_slides/includes_slides_core_hack.rst

 .. revealjs:: More Info About Foodcritic

    For more information, see:

    * |url slides_docs_chef_io|
    * |url slides_docs_foodcritic|
    * |url slides_foodcritic|
