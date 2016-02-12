================================================
Custom Resources
================================================

.. revealjs::

 .. revealjs:: Custom Resources
    :noheading:

    .. image:: ../../images/custom_resources.svg

 .. revealjs:: About Custom Resources

    .. include:: ../../includes_custom_resources/includes_custom_resources.rst

    .. note:: Read this scenario as a single-page topic at https://docs.chef.io/custom_resources.html.

 .. revealjs:: Scenario: Create a Resource that Manages a Website

    .. include:: ../../includes_custom_resources/includes_custom_resources_slide_website.rst

 .. revealjs:: Create a Cookbook

    .. include:: ../../includes_custom_resources/includes_custom_resources_slide_website_cookbook.rst

 .. revealjs:: Objectives
    :noheading:

    .. image:: ../../images/custom_resources_01.svg

 .. revealjs:: Objectives

    .. include:: ../../includes_custom_resources/includes_custom_resources_slide_website_objectives.rst

 .. revealjs:: What is needed?

    .. include:: ../../includes_custom_resources/includes_custom_resources_slide_website_objectives_requirements.rst

 .. revealjs:: Define Properties
    :noheading:

    .. image:: ../../images/custom_resources_02.svg

 .. revealjs:: Define Properties

    .. include:: ../../includes_custom_resources/includes_custom_resources_slide_website_properties.rst

 .. revealjs:: Define Properties (continued)

    .. include:: ../../includes_custom_resources/includes_custom_resources_slide_website_properties_add.rst

 .. revealjs:: Define Actions
    :noheading:

    .. image:: ../../images/custom_resources_03.svg

 .. revealjs:: Define Actions

    .. include:: ../../includes_custom_resources/includes_custom_resources_slide_website_actions.rst

 .. revealjs:: Define Resource
    :noheading:

    .. image:: ../../images/custom_resources_04.svg

 .. revealjs:: Define the Resource

    .. include:: ../../includes_custom_resources/includes_custom_resources_slide_website_resources.rst

 .. revealjs:: package

    .. include:: ../../includes_custom_resources/includes_custom_resources_slide_website_resources_package.rst

 .. revealjs:: template, httpd.service

    .. include:: ../../includes_custom_resources/includes_custom_resources_slide_website_resources_template_httpd_service.rst

 .. revealjs:: template, httpd.conf

    .. include:: ../../includes_custom_resources/includes_custom_resources_slide_website_resources_template_httpd_conf.rst

 .. revealjs:: directory

    .. include:: ../../includes_custom_resources/includes_custom_resources_slide_website_resources_directory.rst

 .. revealjs:: service

    .. include:: ../../includes_custom_resources/includes_custom_resources_slide_website_resources_service.rst

 .. revealjs:: Create Templates

    .. include:: ../../includes_custom_resources/includes_custom_resources_slide_website_templates.rst

 .. revealjs:: httpd.conf.erb

    .. include:: ../../includes_custom_resources/includes_custom_resources_slide_website_templates_httpd_conf_erb.rst

 .. revealjs:: Template Variables

    .. include:: ../../includes_custom_resources/includes_custom_resources_slide_website_templates_httpd_conf_erb_variables.rst

 .. revealjs:: httpd.service.erb

    .. include:: ../../includes_custom_resources/includes_custom_resources_slide_website_templates_httpd_service_erb.rst

 .. revealjs:: Final Resource (Part One)

    .. include:: ../../includes_custom_resources/includes_custom_resources_slide_website_final_resource_part1.rst

 .. revealjs:: Final Resource (Part Two)

    .. include:: ../../includes_custom_resources/includes_custom_resources_slide_website_final_resource_part2.rst

 .. revealjs:: Final Resource (Part Three)

    .. include:: ../../includes_custom_resources/includes_custom_resources_slide_website_final_resource_part3.rst

 .. revealjs:: Final Cookbook Directory

    .. include:: ../../includes_custom_resources/includes_custom_resources_slide_website_final_cookbook_directory.rst

 .. revealjs:: Recipe
    :noheading:

    .. image:: ../../images/custom_resources_05.svg

 .. revealjs:: Add the Resource to a Recipe

    .. include:: ../../includes_custom_resources/includes_custom_resources_slide_website_recipe.rst

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
..     Now run the recipe in this cookbook on a node that has |redhat enterprise linux| 7 or |centos| 7. |apache| |httpd| should be installed, configured, and started.
.. 
..  .. revealjs:: Add to Run-List, Run Chef
.. 
..     Now run the recipe in this cookbook on a node that has |redhat enterprise linux| 7 or |centos| 7. |apache| |httpd| should be installed, configured, and started.
.. 