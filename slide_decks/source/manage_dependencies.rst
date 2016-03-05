================================================
Dependency Management Scenarios
================================================

.. revealjs::

 .. revealjs:: Scenario #1: Projects A, B, and C

    .. image:: ../../images/dpm_scenario-1_01.svg

 .. revealjs:: Scenario #1: Change to Project A, Project B fails

    .. image:: ../../images/dpm_scenario-1_02.svg

 .. revealjs:: Scenario #1: Project A is updated, Project B passes

    .. image:: ../../images/dpm_scenario-1_03.svg

 .. revealjs:: Scenario #1: Project A is promoted

    .. image:: ../../images/dpm_scenario-1_04.svg

 .. revealjs:: Scenario #2: Projects A, B, C, X, and Y

    .. image:: ../../images/dpm_scenario-2_01.svg

 .. revealjs:: Scenario #2: Change to Project A, Project B fails

    .. image:: ../../images/dpm_scenario-2_02.svg

 .. revealjs:: Scenario #2: Change to Project X, Project Y passes

    .. image:: ../../images/dpm_scenario-2_03.svg

 .. revealjs:: Scenario #2: Projects A is updated, Project X is promoted

    .. image:: ../../images/dpm_scenario-2_04.svg

 .. revealjs:: More Info About Resources

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