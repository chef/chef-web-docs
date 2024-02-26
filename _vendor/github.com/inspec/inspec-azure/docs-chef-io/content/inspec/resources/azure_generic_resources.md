+++
title = "azure_generic_resources Resource"
platform = "azure"
draft = false
gh_repo = "inspec-azure"

[menu.inspec]
title = "azure_generic_resources"
identifier = "inspec/resources/azure/azure_generic_resources Resource"
parent = "inspec/resources/azure"
+++

Use the `azure_generic_resources` Inspec audit resource to test any valid Azure resources.

## Install

{{< readfile file="content/inspec/resources/reusable/md/inspec_azure_install.md" >}}

## Syntax

This resource will interrogate all resources in your subscription available through Azure Resource Manager when initiated without a parameter.

```ruby
describe azure_generic_resources do
  it { should exist }
end
```

## Parameters

The following parameters can be passed for targeting Azure resources. All of them are optional.

`resource_group`
: Azure resource group where the targeted resources have been created.

: **Example**: `MyResourceGroup`

`substring_of_resource_group`
: Substring of an Azure resource group name where the targeted resources have been created.

: **Example**: `RESOURCE_GROUP`

`name`
: Name of the Azure resources to test.

: **Example**: `VM_NAME`

`substring_of_name`
: Substring a name of the Azure resources to test.

: **Example**: `NAME`

`resource_provider`
: Azure resource provider of the resources to be tested.

: **Example**: `Microsoft.Compute/virtualMachines`

`tag_name<superscript>*</superscript>`
: Tag name defined on the Azure resources.

: **Example**: `name`

`tag_value`
: Tag value of the tag defined with the `tag_name`.

: **Example**: `external_linux`

`resource_uri`
: Azure REST API URI of the resources to be tested. This parameter should be used when resources do not reside in resource groups. It requires `add_subscription_id` parameter to be provided together.

: **Example**: `/providers/Microsoft.Authorization/policyDefinitions/`

`add_subscription_id`
: Indicates whether the `resource_uri` contains the subscription ID.

: **Example**: `true` or `false`

`filter_free_text`
: Filter expression for the endpoints supporting `$filter` parameter. For example, [Azure role assignments](https://docs.microsoft.com/en-us/azure/role-based-access-control/role-assignments-list-rest). This can only be used with the `resource_uri` parameter.

: **Example**: `"atScope()"`
<superscript>*</superscript> When resources are filtered by a tag name and value, the tags for each resource are not returned in the results.

Either one of the parameter sets can be provided for a valid query:

- `resource_group`
- `substring_of_resource_group`
- `name`
- `substring_of_name`
- `substring_of_resource_group` and `substring_of_name`
- `resource_provider`
- `resource_group` and `resource_provider`
- `substring_of_resource_group` and `resource_provider`
- `tag_name`
- `tag_name` and `tag_value`
- `add_subscription_id` and `resource_uri`
- `add_subscription_id`, `resource_uri` and `filter_free_text`

Different parameter combinations can be tried. If it is not supported, the InSpec resource or the Azure Rest API will raise an error.

It is advised to use these parameter sets to narrow down the targeted resources at the server side, Azure Rest API, for a more computing resource-efficient test.

## Properties

`ids`
: A list of the unique resource IDs.

: **Field**: `id`

`names`
: A list of the unique resource names within a resource group.

: **Field**: `name`

`tags`
: A list of `tag:value` pairs defined on the resources.

: **Field**: `tags`

`types`
: A list of resource types.

: **Field**: `type`

`locations`
: A list of locations where resources are created.

: **Field**: `location`

`created_times<superscript>**</superscript>`
: A list of created times of the resources.

: **Field**: `created_time`

`changed_times<superscript>**</superscript>`
: A list of changing times of the resources.

: **Field**: `changed_time`

`provisioning_states<superscript>**</superscript>`
: A list of provisioning states of the resources.

: **Field**: `provisioning_state`

{{< note >}}

{{< readfile file="content/inspec/reusable/md/inspec_filter_table.md" >}}

{{< /note>}}

<superscript>**</superscript> These properties are not available when `resource_uri` is used.

## Examples

### Test all virtual machines in your subscription

```ruby
describe azure_generic_resources(resource_provider: 'Microsoft.Compute/virtualMachines') do
  it { should exist }
  its('count') { should eq 43 }
end
```

### Test all resources regardless of their type and resource group with a common string in names (Server Side Filtering)

```ruby
azure_generic_resources(substring_of_name: 'project_a').ids.each do |id|
  describe azure_generic_resource(resource_id: id) do
    it { should exist }
    its('location') { should eq 'eastus' }
  end
end
```

### Test all resources regardless of their type and resource group with a common tag 'name:value' pair (Server Side Filtering)

```ruby
azure_generic_resources(tag_name: 'demo', tag_value: 'shutdown_at_10_pm').ids.each do |id|
  describe azure_generic_resource(resource_id: id) do
    it { should exist }
    its('location') { should eq 'eastus' }
  end
end
```

### Filters the results to only include those that match the given location (Client Side Filtering)

```ruby
describe azure_generic_resources.where(location: 'eastus') do
  it { should exist }
end
```

### Filters the results to only include those that created within last 24 hours (Client Side Filtering)

```ruby
describe azure_generic_resources.where{ created_time > Time.now - 86400 } do
  it { should exist }
end
```

### Test policy definitions

```ruby
describe azure_generic_resources(add_subscription_id: true, resource_uri: 'providers/Microsoft.Authorization/policyDefinitions') do
  it { should exist }
end
```

### Filter role assignments via 'filter_free_text'

```ruby
describe azure_generic_resources(add_subscription_id: true, resource_uri: "providers/Microsoft.Authorization/roleAssignments", filter_free_text: "atScope()+and+assignedTo('{abcd1234-abcd-1234}')") do
  it { should exist }
end
```

{{< note >}}

{{< readfile file="content/inspec/reusable/md/inspec_filter_table.md" >}}

{{< /note>}}

For more examples, please see the [integration tests](/test/integration/verify/controls/azure_generic_resources.rb).

## Matchers

{{< readfile file="content/inspec/reusable/md/inspec_matchers_link.md" >}}

This resource has the following special matchers.

### exist

```ruby
# Should not exist if there is no resource with a given resource group.

describe azure_generic_resources(resource_group: 'fake_group') do
  it { should_not exist }
end
```

### not_exists

```ruby
# Should exist if there is at least one resource.

describe azure_generic_resources(resource_group: 'RESOURCE_GROUP') do
  it { should exist }
end
```

## Azure Permissions

{{% inspec-azure/azure_permissions_service_principal role="contributor" %}}
