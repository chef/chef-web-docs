================================================
Dependency Management Scenarios
================================================

.. revealjs::

 .. revealjs:: Scenario #1
    :data-transition: none

    Project A requires B and C. B and C depend on A.

    .. image:: ../../images/dpm_scenario-1_01.svg
       :height: 500px

 .. revealjs:: Scenario #1
    :data-transition: none

    A change to project A breaks tests in project B.

    .. image:: ../../images/dpm_scenario-1_02.svg
       :height: 500px

 .. revealjs:: Scenario #1
    :data-transition: none

    Project A is updated. Tests in project B pass.

    .. image:: ../../images/dpm_scenario-1_03.svg
       :height: 500px

 .. revealjs:: Scenario #1
    :data-transition: none

    Project A is promoted.

    .. image:: ../../images/dpm_scenario-1_04.svg
       :height: 500px

 .. revealjs:: Scenario #2
    :data-transition: none

    Project A requires B and C. B and C depend on A. X requires Y. Y depends on X.

    .. image:: ../../images/dpm_scenario-2_01.svg
       :height: 500px

 .. revealjs:: Scenario #2
    :data-transition: none

    A change to project A breaks tests in project B.

    .. image:: ../../images/dpm_scenario-2_02.svg
       :height: 500px

 .. revealjs:: Scenario #2
    :data-transition: none

    Project X is changed. Tests in project Y pass.

    .. image:: ../../images/dpm_scenario-2_03.svg
       :height: 500px

 .. revealjs:: Scenario #2
    :data-transition: none

    Project A is updated. Tests in project B pass. Project X is promoted.

    .. image:: ../../images/dpm_scenario-2_04.svg
       :height: 500px

 .. revealjs:: Scenario #3
    :data-transition: none

    Project A requires B and C. B depends on A and D. C depends on A and E. E depends on C.

    .. image:: ../../images/dpm_scenario-3_01.svg
       :height: 500px

 .. revealjs:: Scenario #3
    :data-transition: none

    A change to project A breaks tests in project B.

    .. image:: ../../images/dpm_scenario-3_02.svg
       :height: 500px

 .. revealjs:: Scenario #3
    :data-transition: none

    Project E is changed and all tests pass.

    .. image:: ../../images/dpm_scenario-3_03.svg
       :height: 500px

 .. revealjs:: Scenario #3
    :data-transition: none

    Project A is updated. Project E is promoted even though tests in project B still fail.

    .. image:: ../../images/dpm_scenario-3_04.svg
       :height: 500px

 .. revealjs:: Scenario #4
    :data-transition: none

    Project A depends on B and C. B and C depend on A. B depends on D.

    .. image:: ../../images/dpm_scenario-4_01.svg
       :height: 500px

 .. revealjs:: Scenario #4
    :data-transition: none

    A change to project A breaks tests in project B.

    .. image:: ../../images/dpm_scenario-4_02.svg
       :height: 500px

 .. revealjs:: Scenario #4
    :data-transition: none

    A change to project B breaks tests in project D.

    .. image:: ../../images/dpm_scenario-4_03.svg
       :height: 500px

 .. revealjs:: Scenario #4
    :data-transition: none

    Projects A, B, C, and D are blocked.

    .. image:: ../../images/dpm_scenario-4_04.svg
       :height: 500px

 .. revealjs:: Scenario #4
    :data-transition: none

    Project D is updated and all tests pass.

    .. image:: ../../images/dpm_scenario-4_05.svg
       :height: 500px

 .. revealjs:: Scenario #4
    :data-transition: none

    Projects A, B, C, and D are promoted.

    .. image:: ../../images/dpm_scenario-4_06.svg
       :height: 500px

 .. revealjs:: Scenario #5
    :data-transition: none

    Project A requires B and C. B and C depend on A. X and Y depend on each other.

    .. image:: ../../images/dpm_scenario-5_01.svg
       :height: 500px

 .. revealjs:: Scenario #5
    :data-transition: none

    A change to project A breaks tests in project B.

    .. image:: ../../images/dpm_scenario-5_02.svg
       :height: 500px

 .. revealjs:: Scenario #5
    :data-transition: none

    Project X is changed, tests for project Y fail.

    .. image:: ../../images/dpm_scenario-5_03.svg
       :height: 500px

 .. revealjs:: Scenario #5
    :data-transition: none

    Project B is updated and all tests pass.

    .. image:: ../../images/dpm_scenario-5_04.svg
       :height: 500px

 .. revealjs:: Scenario #5
    :data-transition: none

    Projects A and B promote. Projects X and Y remain blocked.

    .. image:: ../../images/dpm_scenario-5_05.svg
       :height: 500px

 .. revealjs:: Scenario #6
    :data-transition: none

    Project A requires B and C. B and C depend on A. F requires E, which requires C.

    .. image:: ../../images/dpm_scenario-6_01.svg
       :height: 500px

 .. revealjs:: Scenario #6
    :data-transition: none

    A change to project A breaks tests in projects B and C.

    .. image:: ../../images/dpm_scenario-6_02.svg
       :height: 500px

 .. revealjs:: Scenario #6
    :data-transition: none

    Project B is updated and all tests pass, but tests for project C fail.

    .. image:: ../../images/dpm_scenario-6_03.svg
       :height: 500px

 .. revealjs:: Scenario #6
    :data-transition: none

    Project F is updated, tests for project E fail.

    .. image:: ../../images/dpm_scenario-6_04.svg
       :height: 500px

 .. revealjs:: Scenario #6
    :data-transition: none

    Project C is updated and all tests for project C pass. Tests for project E still fail.

    .. image:: ../../images/dpm_scenario-6_05.svg
       :height: 500px

 .. revealjs:: Scenario #6
    :data-transition: none

    Project E is updated and all tests pass.

    .. image:: ../../images/dpm_scenario-6_06.svg
       :height: 500px

 .. revealjs:: Scenario #6
    :data-transition: none

    Projects A, B, C, E, and F promote. Project D never changed and does not promote.

    .. image:: ../../images/dpm_scenario-6_07.svg
       :height: 500px

 .. revealjs:: More Info About Dependency Management
    :data-transition: none

    For more information, see:

    * |url slides_docs_chef_io|
    * https://docs.chef.io/delivery_manage_dependencies.html




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