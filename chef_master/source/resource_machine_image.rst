=====================================================
machine_image
=====================================================
`[edit on GitHub] <https://github.com/chef/chef-web-docs/blob/master/chef_master/source/resource_machine_image.rst>`__

.. tag resource_machine_image_summary

Use the **machine_image** resource to define a machine image. This image may then be used by the **machine** resource when building machines.

.. end_tag

.. warning:: .. tag notes_provisioning

             This functionality was available with Chef provisioning and was packaged in the Chef development kit.

             Chef Provisioning is no longer included with Chef DK, and will be officially end of life on August 31, 2019.  The source code of Chef Provisioning and the drivers have been moved into the chef-boneyard organization. Current users of Chef Provisioning should contact your Chef Customer Success Manager or Account Representative to review your options.

             .. end_tag

Syntax
=====================================================
.. tag resource_machine_image_syntax

The syntax for using the **machine_image** resource in a recipe is as follows:

.. code-block:: ruby

   machine_image 'name' do
     attribute 'value' # see properties section below
     ...
     action :action # see actions section below
   end

where

* ``machine_image`` tells the Chef Infra Client to use the ``Chef::Provider::MachineImage`` provider during the Chef Infra Client run
* ``name`` is the name of the resource block and also the name of the machine image
* ``attribute`` is zero (or more) of the properties that are available for this resource
* ``action`` identifies which steps the Chef Infra Client will take to bring the node into the desired state

.. end_tag

Actions
=====================================================
.. tag resource_machine_image_actions

This resource has the following actions:

``:archive``
   Use to archive a machine image.

``:create``
   Default. Use to create a machine image.

``:destroy``
   Use to destroy a machine image.

``:nothing``
   .. tag resources_common_actions_nothing

   This resource block does not act unless notified by another resource to take action. Once notified, this resource block either runs immediately or is queued up to run at the end of the Chef Infra Client run.

   .. end_tag

.. end_tag

Properties
=====================================================
.. tag resource_machine_image_attributes

This resource has the following properties:

``attributes``
   Use to specify a hash of attributes to be applied to the machine image.

``chef_environment``
   The name of the environment.

``complete``
   Use to specify if all of the attributes specified in ``attributes`` represent a complete specification for the machine image. When true, any attributes not specified in ``attributes`` will be reset to their default values.

``image_options``
   **Ruby Type:** Hash

   Use to specify options that are used with this machine image.

``name``
   The name of the machine image.

``raw_json``
   The machine image as JSON data. For example:

   .. code-block:: javascript

      {

      }

``recipe``
   Use to add a recipe to the run-list for the machine image. Each ``recipe`` adds a single recipe to the run-list. The order in which ``recipe`` defines the run-list is the order in which Chef will execute the run-list on the machine image.

``remove_recipe``
   Use to remove a recipe from the run-list for the machine image.

``remove_role``
   Use to remove a role from the run-list for the machine image.

``role``
   Use to add a role to the run-list for the machine image.

``run_list``
   Use to specify the run-list to be applied to the machine image. See `About Run Lists </run_lists.html>`__ for more information.

``tags``
   Use to specify the list of tags to be applied to the machine image. Any tag not specified in this list will be removed.

.. end_tag

Examples
=====================================================
The following examples demonstrate various approaches for using resources in recipes:

**Build a machine from a machine image**

.. tag resource_machine_image_add_apache_to_image

.. To add Apache to a machine image, and then build a machine:

.. code-block:: ruby

   machine_image 'web_image' do
     recipe 'apache2'
   end

   machine 'web_machine' do
    from_image 'web_image'
   end

.. end_tag
