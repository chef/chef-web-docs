The following table describes the events that may occur during a Chef
Infra Client run. Each of these events may be referenced in an `on`
method block by declaring it as the event type.

`:run_start`

: The start of a Chef Infra Client run.

`:run_started`

: The Chef Infra Client run has started.

`:run_completed`

: The Chef Infra Client run has completed.

`:run_failed`

: The Chef Infra Client run has failed.

`:ohai_completed`

: The Ohai run has completed.

`:skipping_registration`

: The Chef Infra Client is not registering with the Chef Infra Server because it already has a private key or because it does not need one.

`:registration_start`

: The Chef Infra Client is attempting to create a private key with which to register to the Chef Infra Server.

`:registration_completed`

: The Chef Infra Client created its private key successfully.

`:registration_failed`

: The Chef Infra Client encountered an error and was unable to register with the Chef Infra Server.

`:node_load_start`

: The Chef Infra Client is attempting to load node data from the Chef Infra Server.

`:node_load_success`

: The Chef Infra Client successfully loaded node data from the policy builder.

`:node_load_failed`

: The Chef Infra Client encountered an error and was unable to load node data from the Chef Infra Server.

`:run_list_expand_failed`

: The Chef Infra Client failed to expand the run-list.

`:node_load_completed`

: The Chef Infra Client successfully loaded node data from the Chef Infra Server. Default and override attributes for roles have been computed, but are not yet applied.

`:policyfile_loaded`

: The policy file was loaded.

`:cookbook_resolution_start`

: The Chef Infra Client is attempting to pull down the cookbook collection from the Chef Infra Server.

`:cookbook_resolution_failed`

: The Chef Infra Client failed to pull down the cookbook collection from the Chef Infra Server.

`:cookbook_resolution_complete`

: The Chef Infra Client successfully pulled down the cookbook collection from the Chef Infra Server.

`:cookbook_clean_start`

: The Chef Infra Client is attempting to remove unneeded cookbooks.

`:removed_cookbook_file`

: The Chef Infra Client removed a file from a cookbook.

`:cookbook_clean_complete`

: The Chef Infra Client is done removing cookbooks and/or cookbook files.

`:cookbook_sync_start`

: The Chef Infra Client is attempting to synchronize cookbooks.

`:synchronized_cookbook`

: The Chef Infra Client is attempting to synchronize the named cookbook.

`:updated_cookbook_file`

: The Chef Infra Client updated the named file in the named cookbook.

`:cookbook_sync_failed`

: The Chef Infra Client was unable to synchronize cookbooks.

`:cookbook_sync_complete`

: The Chef Infra Client is finished synchronizing cookbooks.

`:cookbook_gem_start`

: The Chef Infra Client is collecting gems from the cookbooks.

`:cookbook_gem_installing`

: The Chef Infra Client is installing a cookbook gem.

`:cookbook_gem_using`

: The Chef Infra Client is using a cookbook gem.

`:cookbook_gem_finished`

: The Chef Infra Client finished installing cookbook gems.

`:cookbook_gem_failed`

: The Chef Infra Client failed to install cookbook gems.

`:cookbook_compilation_start`

: The Chef Infra Client created the run\_context and is starting cookbook compilation.

`:library_load_start`

: The Chef Infra Client is loading library files.

`:library_file_loaded`

: The Chef Infra Client successfully loaded the named library file.

`:library_file_load_failed`

: The Chef Infra Client was unable to load the named library file.

`:library_load_complete`

: The Chef Infra Client is finished loading library files.

`:lwrp_load_start`

: The Chef Infra Client is loading custom resources.

`:lwrp_file_loaded`

: The Chef Infra Client successfully loaded the named custom resource.

`:lwrp_file_load_failed`

: The Chef Infra Client was unable to load the named custom resource.

`:lwrp_load_complete`

: The Chef Infra Client is finished loading custom resources.

`:ohai_plugin_load_start`

: Ohai has started loading plugins.

`:ohai_plugin_file_loaded`

: Ohai has loaded a plugin.

`:ohai_plugin_file_load_failed`

: Ohai failed to load a plugin.

`:ohai_plugin_load_complete`

: Ohai has completed loading plugins.

`:attribute_load_start`

: The Chef Infra Client is loading attribute files.

`:attribute_file_loaded`

: The Chef Infra Client successfully loaded the named attribute file.

`:attribute_file_load_failed`

: The Chef Infra Client was unable to load the named attribute file.

`:attribute_load_complete`

: The Chef Infra Client is finished loading attribute files.

`:definition_load_start`

: The Chef Infra Client is loading definitions.

`:definition_file_loaded`

: The Chef Infra Client successfully loaded the named definition.

`:definition_file_load_failed`

: The Chef Infra Client was unable to load the named definition.

`:definition_load_complete`

: The Chef Infra Client is finished loading definitions.

`:recipe_load_start`

: The Chef Infra Client is loading recipes.

`:recipe_file_loaded`

: The Chef Infra Client successfully loaded the named recipe.

`:recipe_file_load_failed`

: The Chef Infra Client was unable to load the named recipe.

`:recipe_not_found`

: The Chef Infra Client was unable to find the named recipe.

`:recipe_load_complete`

: The Chef Infra Client is finished loading recipes.

`:cookbook_compilation_complete`

: The Chef Infra Client completed all cookbook compilation phases.

`:converge_start`

: The Chef Infra Client run converge phase has started.

`:action_collection_registration`

: Provides a reference to the action\_collection before cookbooks are compiled.

`:converge_complete`

: The Chef Infra Client run converge phase is complete.

`:converge_failed`

: The Chef Infra Client run converge phase has failed.

`:control_group_started`

: The named control group is being processed.

`:control_example_success`

: The named control group has been processed.

`:control_example_failure`

: The named control group's processing has failed.

`:resource_action_start`

: A resource action is starting.

`:resource_skipped`

: A resource action was skipped.

`:resource_current_state_loaded`

: A resource's current state was loaded.

`:resource_after_state_loaded`

: A resource's after state was loaded.

`:resource_current_state_load_bypassed`

: A resource's current state was not loaded because the resource does not support why-run mode.

`:resource_bypassed`

: A resource action was skipped because the resource does not support why-run mode.

`:resource_update_applied`

: A change has been made to a resource. (This event occurs for each change made to a resource.)

`:resource_update_progress`

: A resource sent a progress notification to the user to indicate overall progress of a long running operation.

`:resource_failed_retriable`

: A resource action has failed and will be retried.

`:resource_failed`

: A resource action has failed and will not be retried.

`:resource_updated`

: A resource requires modification.

`:resource_up_to_date`

: A resource is already correct.

`:resource_completed`

: All actions for the resource are complete.

`:stream_opened`

: A stream has opened.

`:stream_closed`

: A stream has closed.

`:stream_output`

: A chunk of data from a single named stream.

`:handlers_start`

: The handler processing phase of a Chef Infra Client run has started.

`:handler_executed`

: The named handler was processed.

`:handlers_completed`

: The handler processing phase of a Chef Infra Client run is complete.

`:provider_requirement_failed`

: An assertion declared by a provider has failed.

`:whyrun_assumption`

: An assertion declared by a provider has failed, but execution is allowed to continue because the Chef Infra Client is running in why-run mode.

`:deprecation`

: A deprecation message has been emitted.

`:attribute_changed`

: Prints out all the attribute changes in cookbooks or sets a policy that override attributes should never be used.
