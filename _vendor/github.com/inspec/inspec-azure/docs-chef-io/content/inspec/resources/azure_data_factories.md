+++
title = "azure_data_factories Resource"
platform = "azure"
draft = false
gh_repo = "inspec-azure"

[menu.inspec]
title = "azure_data_factories"
identifier = "inspec/resources/azure/azure_data_factories Resource"
parent = "inspec/resources/azure"
+++

Use the `azure_data_factories` InSpec audit resource to test properties related to data factories for a resource group or the entire subscription.

## Azure REST API Version, Endpoint, and HTTP Client Parameters

{{% inspec_azure_common_parameters %}}

## Installation

{{% inspec_azure_install %}}

## Syntax

An `azure_data_factories` resource block returns all Azure data factories, either within a Resource Group (if provided), or within an entire Subscription.

```ruby
describe azure_data_factories do
  #...
end
```

or

```ruby
describe azure_data_factories(resource_group: 'my-rg') do
  #...
end
```

## Parameters

`resource_group`
: Azure resource group that the targeted resource resides in. `MyResourceGroup`.

## Properties

`names`
: A list of the unique resource names.

: **Field**: `name`

`ids`
: A list of data factory IDs .

: **Field**: `id`

`tags`
: A list of `tag:value` pairs for the resource.

: **Field**: `tag`

`provisioning_states`
: The Data Factory provisioning state.

: **Field**: `provisioning_state`

`types`
: The resource type.

: **Field**: `type`

`repo_configuration_types`
: The Git or VSTS repository configuration types.

: **Field**: `repo type`

`repo_configuration_project_names`
: The VSTS repository project names.

: **Field**: `project_name`

`repo_configuration_account_names`
: The Git or VSTS repository account names.

: **Field**: `account_name`

`repo_configuration_repository_names`
: The Git or VSTS repository names.

: **Field**: `repository_name`

`repo_configuration_collaboration_branches`
: The Git or VSTS repository collaboration branches.

: **Field**: `collaboration_branch`

`repo_configuration_root_folders`
: The Git or VSTS repository root folders.

: **Field**: `root_folder`

`repo_configuration_tenant_ids`
: The VSTS tenant IDs.

: **Field**: `tenant_id`

{{% inspec_filter_table %}}

## Examples

**Test if any Data Factories exist in the resource group.**

```ruby
describe azure_data_factories(resource_group: 'RESOURCE_GROUP') do
  it { should exist }
  its('names') { should include "factory_name" }
end
```
**Test that there aren't any Data Factories in a resource group.**

```ruby
**Should not exist if no Data Factory are in the resource group.**

describe azure_data_factories(resource_group: 'RESOURCE_GROUP') do
  it { should_not exist }
end
```

**Filter Data Factories in a resource group by properties.**

```ruby
describe azure_data_factories(resource_group: 'RESOURCE_GROUP') do
  its('repo_configuration_type') { should include CONFIGURATION_TYPE }
  its('repo_configuration_project_name') { should include PROJECT_NAME }
  its('repo_configuration_account_name') { should include ACCOUNT_NAME }
  its('repo_configuration_repository_name') { should include REPOSITORY_NAME }
  its('repo_configuration_collaboration_branch') { should include COLLABORATION_BRANCH }
  its('repo_configuration_root_folder') { should include ROOT_FOLDER }
end
```

## Azure Permissions

{{% azure_permissions_service_principal role="contributor" %}}
