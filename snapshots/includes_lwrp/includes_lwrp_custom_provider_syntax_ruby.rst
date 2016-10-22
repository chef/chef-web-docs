.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


This section shows some of the common structural elements that appear in a custom provider that is built using custom Ruby code. Remember:

* A custom provider tells the chef-client how to complete a task
* The structure of a custom provider will vary, depending on the complexity of the tasks required to complete an action
* At its platform, a custom provider is just Ruby code, which means that anything that can be done in Ruby can be done in a custom provider

The basic syntax for a custom provider that is built using custom Ruby code is as follows:

.. code-block:: ruby

   use_inline_resources
   
   def whyrun_supported?
     true
   end
   
   action :action_name do
     if updates_required?
       converge_by('message') do
         # some Ruby code
       end
     end
   end
   
   ...
   
   def updates_required?()
     # some Ruby code
     true
   end

where:

* ``use_inline_resources`` allows the custom provider to notify and be notified during the chef-client run
* ``whyrun_supported?`` indicates that a custom provider can be run in why-run mode
* ``action`` is the code block that tells the chef-client what to do when the ``:action_name`` is used in a recipe
* ``converge_by()`` is used to provide a ``'message'`` to be logged when a resource is updated during the chef-client run or to disable the code block when the chef-client is run in why-run mode

Other commonly used methods (that are not shown in the previous example) are ``current_resource``, ``load_current_resource``, and ``new_resource``.

The following example shows a custom provider:

.. code-block:: ruby

   require 'chef/mixin/shell_out'
   include Chef::Mixin::ShellOut
   
   use_inline_resources
   
   def whyrun_supported?
     true
   end
   
   action :fix do
     if modes_differ?
       converge_by("fix #{new_resource.path} mode to #{new_resource.mode}, was #{current_resource.mode}") do
         Chef::Log.debug "updating #{new_resource.path} to #{new_resource.mode} via shell_out!"
         shell_out!("chown #{new_resource.mode} #{new_resource.path}")

       end
     end
   end

   def modes_differ?
     current_resource.mode != new_resource.mode
   end

   def load_current_resource
     @current_resource = Chef::Resource::MyResource.new(new_resource.name)
     current_resource.path(new_resource.path)
     current_resource.mode(File.stat(new_resource.path).mode)
     current_resource
   end

where:

* ``converge_by`` uses the ``shell_out!`` method; ``FileUtils.chown`` is probably a better approach in most situations
* ``load_current_resource`` creates a ``current_resource`` with the same name as ``new_resource``, sets the new resource paths to be the same as the current resource paths, and then inspects the system for properties of the current resource
