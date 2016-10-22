.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

An ``if`` statement can be used to specify part of a recipe to be used when certain conditions are met. ``else`` and ``elseif`` statements can be used to handle situations where either the initial condition is not met or when there are other possible conditions that can be met. Since this behavior is 100% Ruby, do this in a recipe the same way here as anywhere else.

For example, using an ``if`` statement with the ``platform`` node attribute:

.. code-block:: ruby

   if node['platform'] == 'ubuntu'
     # do ubuntu things
   end



.. future example: step_resource_ruby_block_reload_configuration
.. future example: step_resource_ruby_block_run_specific_blocks_on_specific_platforms
.. future example: step_resource_mount_mysql
.. future example: step_resource_package_install_sudo_configure_etc_sudoers
.. future example: step_resource_ruby_block_if_statement_use_with_platform
.. future example: step_resource_remote_file_transfer_remote_source_changes
.. future example: step_resource_remote_file_use_platform_family
.. future example: step_resource_scm_use_different_branches
.. future example: step_resource_service_stop_do_stuff_start


