=====================================================
machine_execute
=====================================================
`[edit on GitHub] <https://github.com/chef/chef-web-docs/blob/master/chef_master/source/resource_machine_execute.rst>`__

.. meta::
    :robots: noindex

Use the **machine_execute** resource to run a command on a remote machine in much the same way the **execute** resource is used to run a command on a local machine.



.. warning:: .. tag EOL_provisioning

             This functionality was available with Chef Provisioning and was packaged in the ChefDK.

             Chef Provisioning was officially end-of-life on August 31, 2019 and is no longer included with ChefDK. The Chef Provisioning source code and drivers have been moved into the chef-boneyard organization. If you are a current user of Chef Provisioning, please contact your Chef Customer Success Manager or Account Representative to review your options.

             .. end_tag

Syntax
=====================================================

The syntax for using the **machine_execute** resource in a recipe is as follows:

.. code-block:: ruby

   machine_execute 'name' do
     attribute 'value' # see properties section below
     ...
     action :action # see actions section below
   end

where

* ``machine_execute`` tells Chef Infra Client to use the ``Chef::Provider::MachineExecute`` provider during a Chef Infra Client run
* ``name`` is the name of the resource block; when the ``command`` property is not specified as part of a recipe, ``name`` is also the command to be run
* ``attribute`` is zero (or more) of the properties that are available for this resource
* ``action`` identifies which steps Chef Infra Client will take to bring the node into the desired state

Actions
=====================================================
This resource has the following actions:

``:nothing``
   .. tag resources_common_actions_nothing

   This resource block does not act unless notified by another resource to take action. Once notified, this resource block either runs immediately or is queued up to run at the end of a Chef Infra Client run.

   .. end_tag

``:run``
   Default. Use to run a machine.

Properties
=====================================================
This resource has the following properties:

``chef_server``
   **Ruby Type:** Hash

   The URL for the Chef Infra Server.

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


