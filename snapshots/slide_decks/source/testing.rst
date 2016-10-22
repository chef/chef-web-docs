================================================
Testing Overview
================================================


.. revealjs::

 .. revealjs:: Testing Overview

  .. image:: ../../images/slides_splash_testing.png

 .. revealjs:: About Test-Driven Development

    Non-automated testing scenarios:
    
    * Write policy
    * Apply policy
    * Verify policy
    
    This is not bad for a simple use case, but this quickly becomes untenable.

 .. revealjs:: Automated Testing

    * Speeds up feedback loops
    * Increases confidence in changes before running them in production

 .. revealjs:: Pedantries

    * Unit testing
    * Integration testing
    * Acceptance testing
    * Functional testing
    * Regression testing
    * Smoke testing
    * Load testing

 .. revealjs:: Objectives of Automated Testing

    * Did the chef-client run complete successfully?
    * Did the recipe put the node in the desired state?
    * Are the resources properly defined?
    * Does the code follow our style guide?

 .. revealjs:: Tools for Testing

    The Chef development kit includes tools for testing Chef:
    
    * Kitchen (which uses Serverspec)
    * ChefSpec
    
    And tools for improving the quality of recipes and cookbooks:
    
    * Foodcritic

 .. revealjs:: Tool - Kitchen

    .. include:: ../../includes_test_kitchen/includes_test_kitchen.rst

 .. revealjs:: Tool - Serverspec

    .. include:: ../../includes_slides/includes_slides_serverspec.rst

 .. revealjs:: Tool - ChefSpec

    .. include:: ../../includes_chefspec/includes_chefspec.rst

 .. revealjs:: Tool - Foodcritic

    .. include:: ../../includes_foodcritic/includes_foodcritic.rst

 .. revealjs:: Questions

   .. include:: ../../includes_slides/includes_slides_core_questions.rst

 .. revealjs:: More Info About Testing Tools

    For more information, see:

    * `ChefSpec <https://docs.chef.io/decks/chefspec.html>`__
    * `Foodcritic <https://docs.chef.io/decks/foodcritic.html>`__
    * `Kitchen <https://docs.chef.io/decks/kitchen.html>`__
    * `Serverspec <https://docs.chef.io/decks/serverspec.html>`__
