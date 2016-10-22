.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


This section shows some of the common structural elements that appear in a custom provider that is built in a way that leverages platform resources (such as **file**, **template**, or **package**). Remember:

* A custom provider tells the chef-client how to complete a task
* The structure of a custom provider will vary, depending on the complexity of the tasks required to complete an action
* At its platform, a custom provider is just Ruby code, which means that anything that can be done in Ruby can be done in a custom provider

The basic syntax for a custom provider that is built to leverage platform resources is as follows:

.. code-block:: ruby

   def whyrun_supported?
     true
   end

   use_inline_resources

   action :action_name do
     condition test
       resource 'resource_name' do
         Chef::Log.log_type 'log_message'
         # a Chef recipe
       end
     end
   end

   def test()
     # some Ruby code
   end

where:

* ``whyrun_supported?`` indicates whether a custom provider can be run in why-run mode
* ``use_inline_resources`` is used to tell the chef-client to execute ``action`` blocks as part of a self-contained chef-client run. Using this method ensures that the chef-client can notify parent custom resources after embedded resources have finished processing
* ``action`` is the code block that tells the chef-client what to do when the ``:action_name`` is used in a recipe
* ``condition`` is a Ruby condition statement (``if``, ``else``, ``elseif``, ``unless``, ``while``, ``until``, ``case``, or ``for``)
* ``test`` is used to test for idempotence; ``test`` can be defined inline (within the ``action`` block), defined as a method using a definition block elsewhere in the custom provider (shown as ``def test()``), or defined using any other pattern that is available in Ruby
* ``resource`` is a resource written as a recipe
* ``Chef::Log.log_type`` is used to tell the chef-client to create a log entry, where ``log_type`` is one of the following types: ``debug``, ``info``, ``warn``, ``error``, or ``fatal``

For example:

.. code-block:: ruby

   def whyrun_supported?
     true
   end

   use_inline_resources

   action :delete do
     if user_exists?(new_resource.user)
       cmdStr = 'rabbitmqctl delete_user #{new_resource.user}'
       execute cmdStr do
         Chef::Log.debug 'rabbitmq_user_delete: #{cmdStr}'
         Chef::Log.info "Deleting RabbitMQ user '#{new_resource.user}'."
         new_resource.updated_by_last_action(true)
       end
     end
   end

   def user_exists?(name)
     cmdStr = "rabbitmqctl -q list_users |grep '^#{name}\\b'"
     cmd = Mixlib::ShellOut.new(cmdStr)
     cmd.environment['HOME'] = ENV.fetch('HOME', '/root')
     cmd.run_command
     Chef::Log.debug 'rabbitmq_user_exists?: #{cmdStr}'
     Chef::Log.debug 'rabbitmq_user_exists?: #{cmd.stdout}'
     begin
       cmd.error!
       true
     rescue
       false
     end
   end
