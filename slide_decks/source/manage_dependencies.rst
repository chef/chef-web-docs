================================================
Dependency Management Scenarios
================================================

.. revealjs::

 .. revealjs:: Scenario #1: Projects A, B, and C
    :data-transition: none

    .. image:: ../../images/dpm_scenario-1_01.svg

 .. revealjs:: Scenario #1: Change to A, B fails
    :data-transition: none

    .. image:: ../../images/dpm_scenario-1_02.svg

 .. revealjs:: Scenario #1: A is updated, B passes
    :data-transition: none

    .. image:: ../../images/dpm_scenario-1_03.svg

 .. revealjs:: Scenario #1: A is promoted
    :data-transition: none

    .. image:: ../../images/dpm_scenario-1_04.svg

 .. revealjs:: Scenario #2: Projects A, B, C, X, and Y
    :data-transition: none

    .. image:: ../../images/dpm_scenario-2_01.svg

 .. revealjs:: Scenario #2: Change to A, B fails
    :data-transition: none

    .. image:: ../../images/dpm_scenario-2_02.svg

 .. revealjs:: Scenario #2: Change to X, Y passes
    :data-transition: none

    .. image:: ../../images/dpm_scenario-2_03.svg

 .. revealjs:: Scenario #2: A is updated, X is promoted
    :data-transition: none

    .. image:: ../../images/dpm_scenario-2_04.svg

 .. revealjs:: Scenario #3: Projects A, B, C, D, and E
    :data-transition: none

    .. image:: ../../images/dpm_scenario-3_01.svg

 .. revealjs:: Scenario #3: Change to A, B fails
    :data-transition: none

    .. image:: ../../images/dpm_scenario-3_02.svg

 .. revealjs:: Scenario #3: Change to E, E passes
    :data-transition: none

    .. image:: ../../images/dpm_scenario-3_03.svg

 .. revealjs:: Scenario #3: A is updated, B fails, E is promoted
    :data-transition: none

    .. image:: ../../images/dpm_scenario-3_04.svg

 .. revealjs:: Scenario #4: Projects A, B, C, and D
    :data-transition: none

    .. image:: ../../images/dpm_scenario-4_01.svg

 .. revealjs:: Scenario #4: Change to A, B fails
    :data-transition: none

    .. image:: ../../images/dpm_scenario-4_02.svg

 .. revealjs:: Scenario #4: B is updated and passes, D fails
    :data-transition: none

    .. image:: ../../images/dpm_scenario-4_03.svg

 .. revealjs:: Scenario #4: A, B, C, and D are blocked
    :data-transition: none

    .. image:: ../../images/dpm_scenario-4_04.svg

 .. revealjs:: Scenario #4: D is updated and passes
    :data-transition: none

    .. image:: ../../images/dpm_scenario-4_05.svg

 .. revealjs:: Scenario #4: A, B, C, and D promote
    :data-transition: none

    .. image:: ../../images/dpm_scenario-4_06.svg

 .. revealjs:: Scenario #5: Projects A, B, C, X, and Y
    :data-transition: none

    .. image:: ../../images/dpm_scenario-5_01.svg

 .. revealjs:: Scenario #5: Change to A, B fails
    :data-transition: none

    .. image:: ../../images/dpm_scenario-5_02.svg

 .. revealjs:: Scenario #5: Change to X, Y fails
    :data-transition: none

    .. image:: ../../images/dpm_scenario-5_03.svg

 .. revealjs:: Scenario #5: B is updated and passes
    :data-transition: none

    .. image:: ../../images/dpm_scenario-5_04.svg

 .. revealjs:: Scenario #5: A and B promote, X and Y remain blocked
    :data-transition: none

    .. image:: ../../images/dpm_scenario-5_05.svg

 .. revealjs:: Scenario #6: Projects A, B, C, D, E, and F
    :data-transition: none

    .. image:: ../../images/dpm_scenario-6_01.svg

 .. revealjs:: Scenario #6: Change to A, B and C both fail
    :data-transition: none

    .. image:: ../../images/dpm_scenario-6_02.svg

 .. revealjs:: Scenario #6: B is updated and passes, C fails
    :data-transition: none

    .. image:: ../../images/dpm_scenario-6_03.svg

 .. revealjs:: Scenario #6: F is updated, E fails
    :data-transition: none

    .. image:: ../../images/dpm_scenario-6_04.svg

 .. revealjs:: Scenario #6: C is updated and passes, E fails
    :data-transition: none

    .. image:: ../../images/dpm_scenario-6_05.svg

 .. revealjs:: Scenario #6: E is updated and passes
    :data-transition: none

    .. image:: ../../images/dpm_scenario-6_06.svg

 .. revealjs:: Scenario #6: A, B, C, E, and F promote
    :data-transition: none

    .. image:: ../../images/dpm_scenario-6_07.svg

 .. revealjs:: More Info About Dependency Management
    :data-transition: none

    For more information, see:

    * |url slides_docs_chef_io|
    * TBD




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