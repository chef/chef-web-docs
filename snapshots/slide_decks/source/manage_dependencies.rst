================================================
Dependency Management Scenarios
================================================

.. revealjs::

 .. revealjs:: Scenario #1
    :data-transition: none

    A is required by B and C. B and C depend on A.

    .. image:: ../../images/dpm_scenario-1_01.svg
       :height: 700px

 .. revealjs:: Scenario #1
    :data-transition: none

    A change to A breaks tests in B.

    .. image:: ../../images/dpm_scenario-1_02.svg
       :height: 700px

 .. revealjs:: Scenario #1
    :data-transition: none

    A is updated. Tests in B pass.

    .. image:: ../../images/dpm_scenario-1_03.svg
       :height: 700px

 .. revealjs:: Scenario #1
    :data-transition: none

    A is promoted.

    .. image:: ../../images/dpm_scenario-1_04.svg
       :height: 700px

 .. revealjs:: Scenario #2
    :data-transition: none

    A is required by B and C. B and C depend on A. X is required by Y. Y depends on X.

    .. image:: ../../images/dpm_scenario-2_01.svg
       :height: 700px

 .. revealjs:: Scenario #2
    :data-transition: none

    A change to A breaks tests in B.

    .. image:: ../../images/dpm_scenario-2_02.svg
       :height: 700px

 .. revealjs:: Scenario #2
    :data-transition: none

    X is changed. Tests in Y pass.

    .. image:: ../../images/dpm_scenario-2_03.svg
       :height: 700px

 .. revealjs:: Scenario #2
    :data-transition: none

    A is updated. Tests in B pass. X is promoted.

    .. image:: ../../images/dpm_scenario-2_04.svg
       :height: 700px

 .. revealjs:: Scenario #3
    :data-transition: none

    A is required by B and C. B depends on A, is required by D. C depends on A, is required by E.

    .. image:: ../../images/dpm_scenario-3_01.svg
       :height: 700px

 .. revealjs:: Scenario #3
    :data-transition: none

    A change to A breaks tests in B.

    .. image:: ../../images/dpm_scenario-3_02.svg
       :height: 700px

 .. revealjs:: Scenario #3
    :data-transition: none

    E is changed and all tests pass.

    .. image:: ../../images/dpm_scenario-3_03.svg
       :height: 700px

 .. revealjs:: Scenario #3
    :data-transition: none

    A is updated. E is promoted even though tests in B still fail.

    .. image:: ../../images/dpm_scenario-3_04.svg
       :height: 700px

 .. revealjs:: Scenario #4
    :data-transition: none

    A is required by B and C. B and C depend on A. B is required by D.

    .. image:: ../../images/dpm_scenario-4_01.svg
       :height: 700px

 .. revealjs:: Scenario #4
    :data-transition: none

    A change to A breaks tests in B.

    .. image:: ../../images/dpm_scenario-4_02.svg
       :height: 700px

 .. revealjs:: Scenario #4
    :data-transition: none

    A change to B breaks tests in D.

    .. image:: ../../images/dpm_scenario-4_03.svg
       :height: 700px

 .. revealjs:: Scenario #4
    :data-transition: none

    A, B, C, and D are blocked.

    .. image:: ../../images/dpm_scenario-4_04.svg
       :height: 700px

 .. revealjs:: Scenario #4
    :data-transition: none

    D is updated and all tests pass.

    .. image:: ../../images/dpm_scenario-4_05.svg
       :height: 700px

 .. revealjs:: Scenario #4
    :data-transition: none

    A, B, C, and D are promoted.

    .. image:: ../../images/dpm_scenario-4_06.svg
       :height: 700px

 .. revealjs:: Scenario #5
    :data-transition: none

    A is required by B and C. B and C depend on A. X is required by Y. Y depends on X.

    .. image:: ../../images/dpm_scenario-5_01.svg
       :height: 700px

 .. revealjs:: Scenario #5
    :data-transition: none

    A change to A breaks tests in B.

    .. image:: ../../images/dpm_scenario-5_02.svg
       :height: 700px

 .. revealjs:: Scenario #5
    :data-transition: none

    X is changed, tests for Y fail.

    .. image:: ../../images/dpm_scenario-5_03.svg
       :height: 700px

 .. revealjs:: Scenario #5
    :data-transition: none

    B is updated and all tests pass.

    .. image:: ../../images/dpm_scenario-5_04.svg
       :height: 700px

 .. revealjs:: Scenario #5
    :data-transition: none

    A and B promote. X and Y remain blocked.

    .. image:: ../../images/dpm_scenario-5_05.svg
       :height: 700px

 .. revealjs:: Scenario #6
    :data-transition: none

    A is required by B and C. B and C depend on A. E depends on C, is required by F. F depends on E.

    .. image:: ../../images/dpm_scenario-6_01.svg
       :height: 700px

 .. revealjs:: Scenario #6
    :data-transition: none

    Changes to A break tests in B and C.

    .. image:: ../../images/dpm_scenario-6_02.svg
       :height: 700px

 .. revealjs:: Scenario #6
    :data-transition: none

    B is updated and all tests pass. Tests for C still fail.

    .. image:: ../../images/dpm_scenario-6_03.svg
       :height: 700px

 .. revealjs:: Scenario #6
    :data-transition: none

    E is updated, tests for F fail.

    .. image:: ../../images/dpm_scenario-6_04.svg
       :height: 700px

 .. revealjs:: Scenario #6
    :data-transition: none

    C is updated and all tests pass. Tests for F still fail.

    .. image:: ../../images/dpm_scenario-6_05.svg
       :height: 700px

 .. revealjs:: Scenario #6
    :data-transition: none

    E is updated and all tests pass.

    .. image:: ../../images/dpm_scenario-6_06.svg
       :height: 700px

 .. revealjs:: Scenario #6
    :data-transition: none

    A, B, C, E, and F promote. D never changed and does not promote.

    .. image:: ../../images/dpm_scenario-6_07.svg
       :height: 700px

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
..     Now run the recipe in this cookbook on a node that has Red Hat Enterprise Linux 7 or CentOS 7. Apache httpd should be installed, configured, and started.
..
..  .. revealjs:: Add to Run-List, Run Chef
..
..     Now run the recipe in this cookbook on a node that has Red Hat Enterprise Linux 7 or CentOS 7. Apache httpd should be installed, configured, and started.
..
