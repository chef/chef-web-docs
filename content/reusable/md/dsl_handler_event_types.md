The following table describes the events that may occur during a Chef
Infra Client run. Each of these events may be referenced in an `on`
method block by declaring it as the event type.

<table>
<colgroup>
<col style="width: 19%" />
<col style="width: 80%" />
</colgroup>
<thead>
<tr class="header">
<th>Event</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td><code>:run_start</code></td>
<td>The start of a Chef Infra Client run.</td>
</tr>
<tr>
<td><code>:run_started</code></td>
<td>The Chef Infra Client run has started.</td>
</tr>
<tr>
<td><code>:run_completed</code></td>
<td>The Chef Infra Client run has completed.</td>
</tr>
<tr>
<td><code>:run_failed</code></td>
<td>The Chef Infra Client run has failed.</td>
</tr>
<tr>
<td><code>:ohai_completed</code></td>
<td>The Ohai run has completed.</td>
</tr>
<tr>
<td><code>:skipping_registration</code></td>
<td>The Chef Infra Client is not registering with the Chef Infra Server because it already has a private key or because it does not need one.</td>
</tr>
<tr>
<td><code>:registration_start</code></td>
<td>The Chef Infra Client is attempting to create a private key with which to register to the Chef Infra Server.</td>
</tr>
<tr>
<td><code>:registration_completed</code></td>
<td>The Chef Infra Client created its private key successfully.</td>
</tr>
<tr>
<td><code>:registration_failed</code></td>
<td>The Chef Infra Client encountered an error and was unable to register with the Chef Infra Server.</td>
</tr>
<tr>
<td><code>:node_load_start</code></td>
<td>The Chef Infra Client is attempting to load node data from the Chef Infra Server.</td>
</tr>
<tr>
<td><code>:node_load_success</code></td>
<td>The Chef Infra Client successfully loaded node data from the policy builder.</td>
</tr>
<tr>
<td><code>:node_load_failed</code></td>
<td>The Chef Infra Client encountered an error and was unable to load node data from the Chef Infra Server.</td>
</tr>
<tr>
<td><code>:run_list_expand_failed</code></td>
<td>The Chef Infra Client failed to expand the run-list.</td>
</tr>
<tr>
<td><code>:node_load_completed</code></td>
<td>The Chef Infra Client successfully loaded node data from the Chef Infra Server. Default and override attributes for roles have been computed, but are not yet applied.</td>
</tr>
<tr>
<td><code>:policyfile_loaded</code></td>
<td>The policy file was loaded.</td>
</tr>
<tr>
<td><code>:cookbook_resolution_start</code></td>
<td>The Chef Infra Client is attempting to pull down the cookbook collection from the Chef Infra Server.</td>
</tr>
<tr>
<td><code>:cookbook_resolution_failed</code></td>
<td>The Chef Infra Client failed to pull down the cookbook collection from the Chef Infra Server.</td>
</tr>
<tr>
<td><code>:cookbook_resolution_complete</code></td>
<td>The Chef Infra Client successfully pulled down the cookbook collection from the Chef Infra Server.</td>
</tr>
<tr>
<td><code>:cookbook_clean_start</code></td>
<td>The Chef Infra Client is attempting to remove unneeded cookbooks.</td>
</tr>
<tr>
<td><code>:removed_cookbook_file</code></td>
<td>The Chef Infra Client removed a file from a cookbook.</td>
</tr>
<tr>
<td><code>:cookbook_clean_complete</code></td>
<td>The Chef Infra Client is done removing cookbooks and/or cookbook files.</td>
</tr>
<tr>
<td><code>:cookbook_sync_start</code></td>
<td>The Chef Infra Client is attempting to synchronize cookbooks.</td>
</tr>
<tr>
<td><code>:synchronized_cookbook</code></td>
<td>The Chef Infra Client is attempting to synchronize the named cookbook.</td>
</tr>
<tr>
<td><code>:updated_cookbook_file</code></td>
<td>The Chef Infra Client updated the named file in the named cookbook.</td>
</tr>
<tr>
<td><code>:cookbook_sync_failed</code></td>
<td>The Chef Infra Client was unable to synchronize cookbooks.</td>
</tr>
<tr>
<td><code>:cookbook_sync_complete</code></td>
<td>The Chef Infra Client is finished synchronizing cookbooks.</td>
</tr>
<tr>
<td><code>:cookbook_gem_start</code></td>
<td>The Chef Infra Client is collecting gems from the cookbooks.</td>
</tr>
<tr>
<td><code>:cookbook_gem_installing</code></td>
<td>The Chef Infra Client is installing a cookbook gem.</td>
</tr>
<tr>
<td><code>:cookbook_gem_using</code></td>
<td>The Chef Infra Client is using a cookbook gem.</td>
</tr>
<tr>
<td><code>:cookbook_gem_finished</code></td>
<td>The Chef Infra Client finished installing cookbook gems.</td>
</tr>
<tr>
<td><code>:cookbook_gem_failed</code></td>
<td>The Chef Infra Client failed to install cookbook gems.</td>
</tr>
<tr>
<td><code>:cookbook_compilation_start</code></td>
<td> The Chef Infra Client created the run_context and is starting cookbook compilation.</td>
</tr>
<tr>
<td><code>:library_load_start</code></td>
<td>The Chef Infra Client is loading library files.</td>
</tr>
<tr>
<td><code>:library_file_loaded</code></td>
<td>The Chef Infra Client successfully loaded the named library file.</td>
</tr>
<tr>
<td><code>:library_file_load_failed</code></td>
<td>The Chef Infra Client was unable to load the named library file.</td>
</tr>
<tr>
<td><code>:library_load_complete</code></td>
<td>The Chef Infra Client is finished loading library files.</td>
</tr>
<tr>
<td><code>:lwrp_load_start</code></td>
<td>The Chef Infra Client is loading custom resources.</td>
</tr>
<tr>
<td><code>:lwrp_file_loaded</code></td>
<td>The Chef Infra Client successfully loaded the named custom resource.</td>
</tr>
<tr>
<td><code>:lwrp_file_load_failed</code></td>
<td>The Chef Infra Client was unable to load the named custom resource.</td>
</tr>
<tr>
<td><code>:lwrp_load_complete</code></td>
<td>The Chef Infra Client is finished loading custom resources.</td>
</tr>
<tr>
<td><code>:ohai_plugin_load_start</code></td>
<td>Ohai has started loading plugins.</td>
</tr>
<tr>
<td><code>:ohai_plugin_file_loaded</code></td>
<td>Ohai has loaded a plugin.</td>
</tr>
<tr>
<td><code>:ohai_plugin_file_load_failed</code></td>
<td>Ohai failed to load a plugin.</td>
</tr>
<tr>
<td><code>:ohai_plugin_load_complete</code></td>
<td>Ohai has completed loading plugins.</td>
</tr>
<tr>
<td><code>:attribute_load_start</code></td>
<td>The Chef Infra Client is loading attribute files.</td>
</tr>
<tr>
<td><code>:attribute_file_loaded</code></td>
<td>The Chef Infra Client successfully loaded the named attribute file.</td>
</tr>
<tr>
<td><code>:attribute_file_load_failed</code></td>
<td>The Chef Infra Client was unable to load the named attribute file.</td>
</tr>
<tr>
<td><code>:attribute_load_complete</code></td>
<td>The Chef Infra Client is finished loading attribute files.</td>
</tr>
<tr>
<td><code>:definition_load_start</code></td>
<td>The Chef Infra Client is loading definitions.</td>
</tr>
<tr>
<td><code>:definition_file_loaded</code></td>
<td>The Chef Infra Client successfully loaded the named definition.</td>
</tr>
<tr>
<td><code>:definition_file_load_failed</code></td>
<td>The Chef Infra Client was unable to load the named definition.</td>
</tr>
<tr>
<td><code>:definition_load_complete</code></td>
<td>The Chef Infra Client is finished loading definitions.</td>
</tr>
<tr>
<td><code>:recipe_load_start</code></td>
<td>The Chef Infra Client is loading recipes.</td>
</tr>
<tr>
<td><code>:recipe_file_loaded</code></td>
<td>The Chef Infra Client successfully loaded the named recipe.</td>
</tr>
<tr>
<td><code>:recipe_file_load_failed</code></td>
<td>The Chef Infra Client was unable to load the named recipe.</td>
</tr>
<tr>
<td><code>:recipe_not_found</code></td>
<td>The Chef Infra Client was unable to find the named recipe.</td>
</tr>
<tr>
<td><code>:recipe_load_complete</code></td>
<td>The Chef Infra Client is finished loading recipes.</td>
</tr>
<tr>
<td><code>:cookbook_compilation_complete</code></td>
<td>The Chef Infra Client completed all cookbook compilation phases.</td>
</tr>
<tr>
<td><code>:converge_start</code></td>
<td>The Chef Infra Client run converge phase has started.</td>
</tr>
<tr>
<td><code>:action_collection_registration</code></td>
<td>Provides a reference to the action_collection before cookbooks are compiled.</td>
</tr>
<tr>
<td><code>:converge_complete</code></td>
<td>The Chef Infra Client run converge phase is complete.</td>
</tr>
<tr>
<td><code>:converge_failed</code></td>
<td>The Chef Infra Client run converge phase has failed.</td>
</tr>
<tr>
<td><code>:control_group_started</code></td>
<td>The named control group is being processed.</td>
</tr>
<tr>
<td><code>:control_example_success</code></td>
<td>The named control group has been processed.</td>
</tr>
<tr>
<td><code>:control_example_failure</code></td>
<td>The named control group's processing has failed.</td>
</tr>
<tr>
<td><code>:resource_action_start</code></td>
<td>A resource action is starting.</td>
</tr>
<tr>
<td><code>:resource_skipped</code></td>
<td>A resource action was skipped.</td>
</tr>
<tr>
<td><code>:resource_current_state_loaded</code></td>
<td>A resource's current state was loaded.</td>
</tr>
<tr>
<td><code>:resource_after_state_loaded</code></td>
<td>A resource's after state was loaded.</td>
</tr>
<tr>
<td><code>:resource_current_state_load_bypassed</code></td>
<td>A resource's current state was not loaded because the resource does not support why-run mode.</td>
</tr>
<tr>
<td><code>:resource_bypassed</code></td>
<td>A resource action was skipped because the resource does not support why-run mode.</td>
</tr>
<tr>
<td><code>:resource_update_applied</code></td>
<td>A change has been made to a resource. (This event occurs for each change made to a resource.)</td>
<tr>
<td><code>:resource_update_progress</code></td>
<td>A resource sent a progress notification to the user to indicate overall progress of a long running operation.</td>
</tr>
<tr>
<td><code>:resource_failed_retriable</code></td>
<td>A resource action has failed and will be retried.</td>
</tr>
<tr>
<td><code>:resource_failed</code></td>
<td>A resource action has failed and will not be retried.</td>
</tr>
<tr>
<td><code>:resource_updated</code></td>
<td>A resource requires modification.</td>
</tr>
<tr>
<td><code>:resource_up_to_date</code></td>
<td>A resource is already correct.</td>
</tr>
<tr>
<td><code>:resource_completed</code></td>
<td>All actions for the resource are complete.</td>
</tr>
<tr>
<td><code>:stream_opened</code></td>
<td>A stream has opened.</td>
</tr>
<tr>
<td><code>:stream_closed</code></td>
<td>A stream has closed.</td>
</tr>
<tr>
<td><code>:stream_output</code></td>
<td>A chunk of data from a single named stream.</td>
</tr>
<tr>
<td><code>:handlers_start</code></td>
<td>The handler processing phase of a Chef Infra Client run has started.</td>
</tr>
<tr>
<td><code>:handler_executed</code></td>
<td>The named handler was processed.</td>
</tr>
<tr>
<td><code>:handlers_completed</code></td>
<td>The handler processing phase of a Chef Infra Client run is complete.</td>
</tr>
<tr>
<td><code>:provider_requirement_failed</code></td>
<td>An assertion declared by a provider has failed.</td>
</tr>
<tr>
<td><code>:whyrun_assumption</code></td>
<td>An assertion declared by a provider has failed, but execution is allowed to continue because the Chef Infra Client is running in why-run mode.</td>
</tr>
<td><code>:deprecation</code></td>
<td>A deprecation message has been emitted.</td>
</tr>
<tr>
<td><code>:attribute_changed</code></td>
<td>Prints out all the attribute changes in cookbooks or sets a policy that override attributes should never be used.</td>
</tr>
</tbody>
</table>
