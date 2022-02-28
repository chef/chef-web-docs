+++
title = "azure_data_factory Resource"
platform = "azure"
draft = false
gh_repo = "inspec-azure"

[menu.inspec]
title = "azure_data_factory"
identifier = "inspec/resources/azure/azure_data_factory Resource"
parent = "inspec/resources/azure"
+++

Use the `azure_data_factory` InSpec audit resource to test properties of an Azure data factory.

## Azure REST API Version, Endpoint, and HTTP Client Parameters

{{% inspec_azure_common_parameters %}}

## Installation

{{% inspec_azure_install %}}

## Syntax

`resource_group` and Data Factory `name` must be given as parameters.

```ruby
describe azure_data_factory(resource_group: resource_group, name: factory_name) do
  it { should exist }
  its('name') { should eq factory_name }
  its('type') { should eq 'Microsoft.DataFactory/factories' }
end
```

## Parameters

`resource_group`
: Azure resource group that the targeted resource resides in. `MyResourceGroup`.

`name`
: The factory name.

Both the parameter sets needs be provided for a valid query:
- `resource_group` and `name`

## Properties

`resource_group`
: Azure resource group that the targeted resource resides in. `MyResourceGroup`.

`name`
: Name of the Azure resource to test. `MyDf`.

`type`
: The resource type.

`provisioning_state`
: The Data Factory provisioning state.

`repo_configuration_type`
: The Git or VSTS repository configuration type.

`repo_configuration_project_name`
: The VSTS repository project name.

`repo_configuration_account_name`
: The Git or VSTS repository account name.

`repo_configuration_repository_name`
: The Git or VSTS repository name.

`repo_configuration_collaboration_branch`
: The Git or VSTS repository collaboration branch.

`repo_configuration_root_folder`
: The Git or VSTS repository root folder.

`repo_configuration_tenant_id`
: The VSTS tenant ID.

## Examples

**Test that a Data Factory exists.**

```ruby
describe azure_data_factory(resource_group: resource_group, name: 'DATA_FACTORY_NAME') do
  it { should exist }
end
```

**Test that a Data Factory does not exist.**

```ruby
describe azure_data_factory(resource_group: resource_group, name: 'DATA_FACTORY_NAME') do
  it { should_not exist }
end
```

**Test properties of a Data Factory.**

```ruby
describe azure_data_factory(resource_group: resource_group, name: 'df_name') do
  its('repo_configuration_type') { should include REPO_CONFIGURATION_TYPE }
  its('repo_configuration_project_name') { should include REPO_CONFIGURATION_PROJECT_NAME }
  its('repo_configuration_account_name') { should include REPO_CONFIGURATION_ACCOUNT_NAME }
  its('repo_configuration_repository_name') { should include REPO_CONFIGURATION_REPOSITORY_NAME }
  its('repo_configuration_collaboration_branch') { should include REPO_CONFIGURATION_COLLABORATION_BRANCH }
  its('repo_configuration_root_folder') { should include REPO_CONFIGURATION_ROOT_FOLDER }
  its('repo_configuration_tenant_id') { should include REPO_CONFIGURATION_TENANT_ID }
end
```

## Azure Permissions

{{% azure_permissions_service_principal role="contributor" %}}
