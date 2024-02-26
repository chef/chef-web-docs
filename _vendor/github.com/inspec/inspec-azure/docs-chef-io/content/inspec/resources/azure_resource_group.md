+++
title = "azure_resource_group Resource"
platform = "azure"
draft = false
gh_repo = "inspec-azure"

[menu.inspec]
title = "azure_resource_group"
identifier = "inspec/resources/azure/azure_resource_group Resource"
parent = "inspec/resources/azure"
+++

Use the `azure_resource_group` InSpec audit resource to test the properties and configuration of an Azure resource group.

## Azure REST API Version, Endpoint, and HTTP Client Parameters

{{< readfile file="content/inspec/resources/reusable/md/inspec_azure_common_parameters.md" >}}

## Install

{{< readfile file="content/inspec/resources/reusable/md/inspec_azure_install.md" >}}

## Syntax

`name` or the `resource_id` are required parameters.

```ruby
describe azure_resource_group(name: 'RESOURCE_GROUP') do
  it { should exist }
end
```

```ruby
describe azure_resource_group(resource_id: '/subscriptions/{subscriptionId}/resourcegroups/{resourceGroupName}') do
  it { should exist }
end
```

## Parameters

`name`
: Name of the resource group.

`resource_id`
: The unique resource ID.

Either one of the parameter sets can be provided for a valid query:

- `resource_id`
- `name`

## Properties

`properties.provisioningState`
: The provisioning state. `Succeeded`.

For properties applicable to all resources, such as `type`, `name`, `id`, `location`, and `properties`, refer to [`azure_generic_resource`]({{< relref "azure_generic_resource.md#properties" >}}).

Also, refer to [Azure documentation](https://docs.microsoft.com/en-us/rest/api/policy/policy-definitions/get) for other properties available. Any attribute in the response may be accessed with the key names separated by dots (`.`). For example, `properties.<attribute>`.

## Examples

### Test a resource group location

```ruby
describe azure_resource_group(name: 'RESOURCE_GROUP') do
  its('location') { should cmp 'eastus' }
end
```

### Test a resource group provisioning state

```ruby
describe azure_resource_group(name: 'RESOURCE_GROUP') do
  its('properties.provisioningState') { should cmp 'Succeeded' }
end
```

### Test a resource group tags

```ruby
describe azure_resource_group(name: 'RESOURCE_GROUP') do
  its('tags') { should include(:owner) }
  its('tags') { should include(owner: 'InSpec') }
end
```

## Matchers

{{< readfile file="content/inspec/reusable/md/inspec_matchers_link.md" >}}

This resource has the following special matchers.

### exists

```ruby
# If we expect a resource group to always exist.

describe azure_resource_group(name: 'RESOURCE_GROUP') do
  it { should exist }
end
```

### not_exists

```ruby
# If we expect a resource group to never exist.

describe azure_resource_group(name: 'RESOURCE_GROUP') do
  it { should_not exist }
end
```

## Azure Permissions

{{% inspec-azure/azure_permissions_service_principal role="contributor" %}}
