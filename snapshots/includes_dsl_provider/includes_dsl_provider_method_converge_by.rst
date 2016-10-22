.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


The ``converge_by`` method is a wrapper that is used to support why-run mode and must wrap any Ruby calls that updates system state.  All core Chef resources internally use ``converge_by`` and support why-run mode by default. To ensure that a custom provider is idempotent, ``converge_by`` blocks must be checked for idempotency.

The syntax of a ``converge_by`` block is:

.. code-block:: ruby

   converge_by('message')

where:

* ``converge_by()`` is added to an ``action`` block as a wrapper
* ``'message'`` is the message returned by the chef-client when the resource runs

Some examples:

.. code-block:: ruby

   unless Dir.exist?(new_resource.path)
     converge_by("Create directory #{ new_resource.path }") do
       FileUtils.mkdir new_resource.path
     end
   end

.. code-block:: ruby

   if should_create_user?
     converge_by("Create user #{ new_resource.user }") do
       shell_out!("adduser #{ new_resource.user }")
     end
   end

.. code-block:: ruby

   if should_update_stuff?
     description = 'create dir #{app_root} and change owner to #{new_resource.owner}'
     converge_by(description) do
       FileUtils.mkdir app_root, :mode => new_resource.app_home_mode
       FileUtils.chown new_resource.owner, new_resource.owner, app_root
     end
   end

where the last example shows using a variable (``description``) as the ``'message'`` in the ``converge_by`` block.

An example of the ``converge_by`` method exists in the provider for `directory <https://github.com/chef/chef/blob/master/lib/chef/provider/directory.rb>`_ resource, which is a core Chef resource:

.. code-block:: ruby

   def whyrun_supported?
     true
   end
   
   ...
   
   def action_create
     unless File.exist?(@new_resource.path)
       converge_by('create new directory #{@new_resource.path}') do 
         if @new_resource.recursive == true
           ::FileUtils.mkdir_p(@new_resource.path)
         else
           ::Dir.mkdir(@new_resource.path)
         end
         Chef::Log.info('#{@new_resource} created directory #{@new_resource.path}')
       end 
     end
     set_all_access_controls
     update_new_file_state
   end

.. note:: why-run mode is already enabled for platform resources. When platform resources are used as part of the ``action`` block in a custom provider, only the ``whyrun_supported?`` is required to allow the chef-client to run in why-run mode.
