+++
title = "azure_management_group Resource"
platform = "azure"
draft = false
gh_repo = "inspec-azure"

[menu.inspec]
title = "azure_management_group"
identifier = "inspec/resources/azure/azure_management_group Resource"
parent = "inspec/resources/azure"
+++

Use the `azure_management_group` InSpec audit resource to test properties of an Azure management group.

## Azure REST API Version, Endpoint, and HTTP Client Parameters

{{% inspec_azure_common_parameters %}}

## Installation

{{% inspec_azure_install %}}

## Syntax

An `azure_management_group` resource block identifies a management group by its `name` or the `resource_id`.
```ruby
describe azure_management_group(name: 'abcd-1234') do
  it { should exist }
end
```
```ruby
describe azure_management_group(resource_id: '/providers/Microsoft.Management/managementGroups/{groupId}') do
  it { should exist }
end
```

## Parameters

`name`
: Management group name. `20000000-0001-0000-0000-000000000000`.

`group_id`
: Alias for the `name` parameter.

`resource_id`
: The unique resource ID. `/providers/Microsoft.Management/managementGroups/{groupId}`.

`expand`
: Optional. The `expand: 'children'` includes children in the response. `expand: 'path'` includes the path from the root group to the current group.

`recurse`
: Optional. The `recurse: true` includes the entire hierarchy in the response. Note that `expand: 'children'` will be set if `recurse` is set to `true`.

`filter`
: Optional. A filter which allows the exclusion of subscriptions from results (i.e. `filter: 'children.childType ne Subscription'`).

Either one of the parameter sets can be provided for a valid query along with the optional parameters:
- `resource_id`
- `name`
- `group_id` 

## Properties

`tenant_id`
: The management group tenant id.

`parent_name`
: The management group parent name.

`parent_id`
: The management group parent resource id. `/providers/Microsoft.Management/managementGroups/{groupId}`.

`children_display_names`
: The list of management group children display names.

`children_ids`
: The list of management group children ids.

`children_names`
: The list of management group children names.

`children_types`
: The list of management group children types.

For properties applicable to all resources, such as `type`, `name`, `id`, `properties`, refer to [`azure_generic_resource`]({{< relref "azure_generic_resource.md#properties" >}}).

Also, refer to [Azure documentation](https://docs.microsoft.com/en-us/rest/api/resources/managementgroups/get#managementgroup) for other properties available. 
Any attribute in the response may be accessed with the key names separated by dots (`.`).

## Examples

**Test Tenant ID, Parent Name, Children Display Name.**

```ruby
describe azure_management_group(group_id: 'abc-1234', recurse: true, expand: 'children') do
  its('tenant_id') { should eq('00000000-0000-0000-0000-000000000000') }
  its('parent_name') { should eq('MyGroupsParentName') }
  its('children_display_names') { should include('I am a child of the group!') }
end
```
See [integration tests](../../test/integration/verify/controls/azurerm_management_group.rb) for more examples.

## Matchers

This InSpec audit resource has the following special matchers. For a full list of available matchers, please visit our [Universal Matchers page](https://docs.chef.io/inspec/matchers/).

### exists

```ruby
# If we expect a resource to always exist

describe azure_management_group(name: 'abcd-1234') do
  it { should exist }
end

# If we expect a resource to never exist

describe azure_management_group(name: 'abcd-1234') do
  it { should_not exist }
end
```

## Azure Permissions

{{% azure_permissions_service_principal role="contributor" %}}
