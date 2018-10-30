=====================================================
machine_execute
=====================================================
`[edit on GitHub] <https://github.com/chef/chef-web-docs/blob/master/chef_master/source/resource_machine_execute.rst>`__

.. tag resource_machine_execute_summary

Use the **machine_execute** resource to run a command on a remote machine in much the same way the **execute** resource is used to run a command on a local machine.

.. end_tag

.. warning:: .. tag notes_provisioning

             This functionality is available with Chef provisioning and is packaged in the Chef development kit. Chef provisioning is a framework that allows clusters to be managed by the chef-client and the Chef server in the same way nodes are managed: with recipes. Use Chef provisioning to describe, version, deploy, and manage clusters of any size and complexity using a common set of tools.

             .. end_tag

Syntax
=====================================================
.. tag resource_machine_execute_syntax

The syntax for using the **machine_execute** resource in a recipe is as follows:

.. code-block:: ruby

   machine_execute 'name' do
     attribute 'value' # see properties section below
     ...
     action :action # see actions section below
   end

where

* ``machine_execute`` tells the chef-client to use the ``Chef::Provider::MachineExecute`` provider during the chef-client run
* ``name`` is the name of the resource block; when the ``command`` property is not specified as part of a recipe, ``name`` is also the command to be run
* ``attribute`` is zero (or more) of the properties that are available for this resource
* ``action`` identifies which steps the chef-client will take to bring the node into the desired state

.. end_tag

Actions
=====================================================
.. tag resource_machine_execute_actions

This resource has the following actions:

``:nothing``
   .. tag resources_common_actions_nothing

   Define this resource block to do nothing until notified by another resource to take action. When this resource is notified, this resource block is either run immediately or it is queued up to be run at the end of the Chef Client run.

   .. end_tag

``:run``
   Default. Use to run a machine.

.. end_tag

Properties
=====================================================
.. tag resource_machine_execute_attributes

This resource has the following properties:

``chef_server``
   **Ruby Type:** Hash

   The URL for the Chef server.

``command``
   **Ruby Type:** String

   The name of the command to be executed. Default value: the ``name`` of the resource block. See "Syntax" section above for more information.

``driver``
   **Ruby Type:** Chef::Provisioning::Driver

   Use to specify the driver to be used for provisioning.

``live_stream``
   **Ruby Type:** true, false | **Default Value:** ``false``

``machine``
   **Ruby Type:** String

   Use to specify the machine type.

.. end_tag
