=====================================================
load_balancer
=====================================================
`[edit on GitHub] <https://github.com/chef/chef-web-docs/blob/master/chef_master/source/resource_load_balancer.rst>`__

.. meta::
    :robots: noindex

.. warning:: .. tag EOL_provisioning

             This functionality was available with Chef Provisioning and was packaged in the ChefDK.

             Chef Provisioning was officially end-of-life on August 31, 2019 and is no longer included with ChefDK. The Chef Provisioning source code and drivers have been moved into the chef-boneyard organization. If you are a current user of Chef Provisioning, please contact your Chef Customer Success Manager or Account Representative to review your options.

             .. end_tag

Use the **load_balancer** resource to create or destroy a load balancer.



Syntax
=====================================================

The syntax for using the **load_balancer** resource in a recipe is as follows:

.. code-block:: ruby

   load_balancer 'name' do
     attribute 'value' # see properties section below
     ...
     action :action # see actions section below
   end

where

* ``load_balancer`` tells Chef Infra Client to use the ``Chef::Provider::LoadBalancer`` provider during a Chef Infra Client run
* ``name`` is the name of the resource block
* ``attribute`` is zero (or more) of the properties that are available for this resource
* ``action`` identifies which steps Chef Infra Client will take to bring the node into the desired state

Actions
=====================================================
This resource has the following actions:

``:create``
   Default.

``:destroy``

``:nothing``
   .. tag resources_common_actions_nothing

   This resource block does not act unless notified by another resource to take action. Once notified, this resource block either runs immediately or is queued up to run at the end of a Chef Infra Client run.

   .. end_tag

Properties
=====================================================
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


