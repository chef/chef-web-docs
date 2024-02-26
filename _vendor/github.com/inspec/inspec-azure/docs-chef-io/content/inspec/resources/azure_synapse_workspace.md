+++
title = "azure_synapse_workspace Resource"
platform = "azure"
draft = false
gh_repo = "inspec-azure"

[menu.inspec]
title = "azure_synapse_workspace"
identifier = "inspec/resources/azure/azure_synapse_workspace Resource"
parent = "inspec/resources/azure"
+++

Use the `azure_synapse_workspace` InSpec audit resource to test the properties related to an Azure Synapse workspace.

## Azure REST API Version, Endpoint, and HTTP Client Parameters

{{< readfile file="content/inspec/resources/reusable/md/inspec_azure_common_parameters.md" >}}

## Install

{{< readfile file="content/inspec/resources/reusable/md/inspec_azure_install.md" >}}

## Syntax

```ruby
describe azure_synapse_workspace(resource_group: 'RESOURCE_GROUP', name: 'SYNAPSE_WORKSPACE_NAME') do
  it                                      { should exist }
  its('type')                             { should eq 'Microsoft.SqlVirtualMachine/sqlVirtualMachineGroups' }
  its('location')                         { should eq 'eastus' }
end
```

```ruby
describe azure_synapse_workspace(resource_group: 'RESOURCE_GROUP', name: 'SYNAPSE_WORKSPACE_NAME') do
  it  { should exist }
end
```

## Parameters

`name` _(required)_
: Name of the Azure Synapse workspace to test.

`resource_group` _(required)_
: Azure resource group where the targeted resource resides.

## Properties

`id`
: Resource ID.

`name`
: Resource name.

`type`
: Resource type. `Microsoft.Synapse/workspaces`.

`location`
: The Geo-location where the resource lives.

`properties`
: The properties of the Synapse workspaces.

`properties.provisioningState`
: State of the resource.

For properties applicable to all resources, such as `type`, `name`, `id`, and `properties`, refer to [`azure_generic_resource`]({{< relref "azure_generic_resource.md#properties" >}}).

Also, refer to [Azure documentation](https://docs.microsoft.com/en-us/rest/api/synapse/workspaces/get) for other properties available.

## Examples

### Test that the Synapse workspaces are provisioned successfully

```ruby
describe azure_synapse_workspace(resource_group: 'RESOURCE_GROUP', name: 'SYNAPSE_WORKSPACE_NAME') do
  its('properties.provisioningState') { should eq 'Succeeded' }
end
```

## Matchers

{{< readfile file="content/inspec/reusable/md/inspec_matchers_link.md" >}}

This resource has the following special matchers.

### exists

```ruby
# If a Synapse workspace is found, it will exist.

describe azure_synapse_workspace(resource_group: 'RESOURCE_GROUP', name: 'SYNAPSE_WORKSPACE_NAME') do
  it { should exist }
end
```

### not_exists

```ruby
# If Synapse workspaces are not found, it will not exist.

describe azure_synapse_workspace(resource_group: 'RESOURCE_GROUP', name: 'SYNAPSE_WORKSPACE_NAME') do
  it { should_not exist }
end
```

## Azure Permissions

{{% inspec-azure/azure_permissions_service_principal role="reader" %}}
