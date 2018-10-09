=====================================================
timezone resource
=====================================================
`[edit on GitHub] <https://github.com/chef/chef-web-docs/blob/master/chef_master/source/resource_timezone.rst>`__
 
 Use the **timezone** resource to change the system timezone.
 
 **New in Chef Client 14.6.**

 Syntax

=====================================================

The timezone resource has the following syntax:

 .. code-block:: ruby

   timezone 'name' do
    timezone      String # default value: 'name' unless specified
    action        Symbol # defaults to :set if not specified
  end

 where:

 * ``timezone`` is the resource.
 * ``name`` is the name given to the resource block.
 * ``action`` identifies which steps the chef-client will take to bring the node into the desired state.
 * ``timezone`` is the property available to this resource.

 Actions
=====================================================

 The timezone resource has the following actions:

 ``:set``
    Set the system timezone.

 ``:nothing``
   .. tag resources_common_actions_nothing

    Define this resource block to do nothing until notified by another resource to take action. When this resource is notified, this resource block is either run immediately or it is queued up to be run at the end of the Chef Client run.

    .. end_tag
 
 Properties
=====================================================

 The timezone resource has the following properties:

 ``timezone``
   **Ruby Type:** String | **Default Value:** ``'name'``

    The timezone value to set.


 Examples
==========================================

 **Set the timezone to UTC**
 .. code-block:: ruby

   timezone 'UTC'
  
**Set the timezone to UTC with a friendly resource name**
 .. code-block:: ruby

   timezone 'Set the hosts timezone to UTC' do
    timezone 'UTC'
  end
