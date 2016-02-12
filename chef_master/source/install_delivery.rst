=====================================================
Installing |chef delivery|
=====================================================

We currently support two install methods with ``delivery-cluster``:

* :doc:`Install using AWS <install_delivery_aws>`. This method of provisioning takes care of creating most of the resources you need for |chef delivery|, and setting them up
* :doc:`Install using SSH <install_delivery_ssh>`. This method is used in all environments other than |amazon aws| and assumes that you have created machines and have SSH access with passwordless |sudo cmd| on the boxes.

An important consideration in picking your install method/location is network access. If you will be integrating with any APIs make sure you can access them from the environment in which |chef delivery| is installed. Often times we set up a cluster only to find an internal API is not available. Consider things like |jenkins|, or your own internal deployment tool, etc.

About |chef delivery| 
=====================================================
|chef delivery| is written in |erlang| and has its own embedded source control manager (|git|). Cookbook changes are introduced to |chef delivery| and run through a pipeline consisting of a number of stages, each comprised of a number of phases implemented through recipes. The final stage is Delivered, where the validated change is delivered to the |chef server| to be provisioned to the infrastructure, or pushed to |supermarket| or |github|.

|chef delivery| uses |push jobs| as a job dispatcher to communicate with the build nodes through the |chef server|. Any number of build nodes may be used, but |company_name| recommends a minimum of three build nodes to take advantage of the parallel phases that |chef delivery| runs: Unit, Lint, and Syntax, which are all part of the Verify stage.

The build nodes use API callbacks to communicate the results of each phase run to the |chef delivery| server.

.. image:: ../../images/delivery_architecture.svg
   :width: 600px
   :align: center


