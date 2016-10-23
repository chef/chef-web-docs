.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


If you are familiar with Capistrano, the following examples should help you know when to use the various callbacks that are available. If you are not familiar with Capistrano, then follow the semantic names of these callbacks to help you determine when to use each of the callbacks within a recipe that is built with the **deploy** resource.

The following example shows where callbacks fit in relation to the steps taken by the ``deploy`` process in Capistrano:

.. image:: ../../images/includes_resource_deploy_strategy_callbacks_example1.png

and the following example shows the same comparison, but with the ``deploy:migrations`` process:

.. image:: ../../images/includes_resource_deploy_strategy_callbacks_example2.png



