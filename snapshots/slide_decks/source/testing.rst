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

    .. tag test_kitchen

    Use `Kitchen <http://kitchen.ci>`_  to automatically test cookbook data across any combination of platforms and test suites:

    * Defined in a .kitchen.yml file
    * Uses a driver plugin architecture
    * Supports cookbook testing across many cloud providers and virtualization technologies
    * Supports all common testing frameworks that are used by the Ruby community
    * Uses a comprehensive set of base images provided by `Bento <https://github.com/chef/bento>`_

    .. end_tag

 .. revealjs:: Tool - Serverspec

    .. tag slides_serverspec

    .. There is no comparision topic in chef-docs from which we can single-source this content, though there should be!

    Use Serverspec to write tests that verify machines:

    * Natively defines many resource types: package, service, user, etc.
    * Works well with Kitchen
    * Is not dependent on Chef

    .. end_tag

 .. revealjs:: Tool - ChefSpec

    .. tag chefspec_1

    Use ChefSpec to simulate the convergence of resources on a node:

    * Runs the chef-client on a local machine
    * Uses chef-zero or chef-solo
    * Is an extension of RSpec, a behavior-driven development (BDD) framework for Ruby
    * Is the fastest way to test resources and recipes

    .. end_tag

 .. revealjs:: Tool - Foodcritic

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

 .. revealjs:: Questions

   .. tag slides_core_questions

   .. Use this slide every time the slide deck stops for Q/A sessions with attendees.

   .. image:: ../../images/slides_questions.png

   .. end_tag

 .. revealjs:: More Info About Testing Tools

    For more information, see:

    * :doc:`ChefSpec <chefspec>`
    * :doc:`Foodcritic <foodcritic>`
    * :doc:`Kitchen <kitchen>`
    * :doc:`Serverspec <serverspec>`
