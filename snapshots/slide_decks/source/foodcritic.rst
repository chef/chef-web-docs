================================================
Foodcritic
================================================

.. revealjs::

 .. revealjs:: Foodcritic Training

    .. image:: ../../images/slides_splash_foodcritic.png

 .. revealjs:: About Foodcritic

    .. tag foodcritic_1

    Use Foodcritic to check cookbooks for common problems:

    * Style
    * Correctness
    * Syntax
    * Best practices
    * Common mistakes
    * Deprecations

    Foodcritic looks for lint-like behavior and reports it!

    .. end_tag

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

   .. tag slides_core_questions

   .. Use this slide every time the slide deck stops for Q/A sessions with attendees.

   .. image:: ../../images/slides_questions.png

   .. end_tag

 .. revealjs:: Time to Hack

   .. tag slides_core_hack

   .. Use this slide every time the slide deck stops for Q/A sessions with attendees.

   .. image:: ../../images/slides_hack.png

   .. end_tag

 .. revealjs:: More Info About Foodcritic

    For more information, see:

    * |url slides_docs_chef_io|
    * |url slides_docs_foodcritic|
    * |url slides_foodcritic|
