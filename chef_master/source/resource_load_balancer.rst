=====================================================
load_balancer
=====================================================
`[edit on GitHub] <https://github.com/chef/chef-web-docs/blob/master/chef_master/source/resource_load_balancer.rst>`__

.. warning:: .. tag EOL_provisioning

           This functionality was available with Chef Provisioning and was packaged in the ChefDK.

             Chef Provisioning is no longer included with Chef DK, and will be officially end of life on August 31, 2019.  The source code of Chef Provisioning and the drivers have been moved into the chef-boneyard organization. Current users of Chef Provisioning should contact your Chef Customer Success Manager or Account Representative to review your options.

             .. end_tag

.. tag resource_load_balancer_summary

Use the **load_balancer** resource to create or destroy a load balancer.

.. end_tag

Syntax
=====================================================
.. tag resource_load_balancer_syntax

The syntax for using the **load_balancer** resource in a recipe is as follows:

.. code-block:: ruby

   load_balancer 'name' do
     attribute 'value' # see properties section below
     ...
     action :action # see actions section below
   end

where

* ``load_balancer`` tells the Chef Infra Client to use the ``Chef::Provider::LoadBalancer`` provider during the Chef Infra Client run
* ``name`` is the name of the resource block
* ``attribute`` is zero (or more) of the properties that are available for this resource
* ``action`` identifies which steps the Chef Infra Client will take to bring the node into the desired state

.. end_tag

Actions
=====================================================
This resource has the following actions:

``:create``
   Default.

``:destroy``

``:nothing``
   .. tag resources_common_actions_nothing

   This resource block does not act unless notified by another resource to take action. Once notified, this resource block either runs immediately or is queued up to run at the end of the Chef Infra Client run.

   .. end_tag

Properties
=====================================================
.. tag resource_load_balancer_attributes

This resource has the following properties:

``driver``
   **Ruby Type:** Chef::Provisioning::Driver

   Use to specify the driver to be used for provisioning.

``load_balancer_options``
   ...

``machines``
   ...

``name``
   **Ruby Type:** String

   The name of the load balancer.

.. end_tag
