=====================================================
load_balancer
=====================================================
`[edit on GitHub] <https://github.com/chef/chef-web-docs/blob/master/chef_master/source/resource_load_balancer.rst>`__

.. warning:: .. tag notes_provisioning

             This functionality is available with Chef provisioning and is packaged in the Chef development kit. Chef provisioning is a framework that allows clusters to be managed by the chef-client and the Chef server in the same way nodes are managed: with recipes. Use Chef provisioning to describe, version, deploy, and manage clusters of any size and complexity using a common set of tools.

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

* ``load_balancer`` tells the chef-client to use the ``Chef::Provider::LoadBalancer`` provider during the chef-client run
* ``name`` is the name of the resource block
* ``attribute`` is zero (or more) of the properties that are available for this resource
* ``action`` identifies which steps the chef-client will take to bring the node into the desired state

.. end_tag

Actions
=====================================================
.. tag resource_load_balancer_actions

This resource has the following actions:

``:create``
   Default.

``:destroy``

``:nothing``
   .. tag resources_common_actions_nothing

   This resource block does not act unless notified by another resource to take action. Once notified, this resource block either runs immediately or is queued up to run at the end of the Chef Client run.

   .. end_tag

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
