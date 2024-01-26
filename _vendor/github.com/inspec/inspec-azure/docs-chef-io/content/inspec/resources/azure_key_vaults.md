+++
title = "azure_key_vaults Resource"
platform = "azure"
draft = false
gh_repo = "inspec-azure"

[menu.inspec]
title = "azure_key_vaults"
identifier = "inspec/resources/azure/azure_key_vaults Resource"
parent = "inspec/resources/azure"
+++

Use the `azure_key_vaults` InSpec audit resource to test the properties related to key vaults for a resource group or the entire subscription.

## Azure REST API Version, Endpoint, and HTTP Client Parameters

{{< readfile file="content/inspec/resources/reusable/md/inspec_azure_common_parameters.md" >}}

## Install

{{< readfile file="content/inspec/resources/reusable/md/inspec_azure_install.md" >}}

## Syntax

An `azure_key_vaults` resource block returns all Azure key vaults, either within a resource group (if provided) or the entire subscription.

```ruby
describe azure_key_vaults do
  #...
end
```

Or

```ruby
describe azure_key_vaults(resource_group: 'RESOURCE_GROUP') do
  #...
end
```

## Parameters

`resource_group` _(optional)_

: The name of the resource group.

## Properties

`ids`
: A list of the unique resource IDs.

: **Field**: `id`

`names`
: A list of all the key vault names.

: **Field**: `name`

`tags`
: A list of `tag:value` pairs defined on the resources.

: **Field**: `tags`

`types`
: A list of types of all the key vaults.

: **Field**: `type`

`locations`
: A list of locations for all the key vaults.

: **Field**: `location`

`properties`
: A list of properties for all the key vaults.

: **Field**: `properties`

{{< note >}}

{{< readfile file="content/inspec/reusable/md/inspec_filter_table.md" >}}

{{< /note>}}

## Examples

### Loop through key vaults by their IDs

```ruby
azure_key_vaults.ids.each do |id|
  describe azure_key_vault(resource_id: id) do
    it { should exist }
  end
end
```

### Test to ensure there are key vaults that include a certain string in their names (Client Side Filtering)

```ruby
describe azure_key_vaults.where { name.include?('deployment') } do
  it { should exist }
end
```

### Test to ensure there are key vaults that include a certain string in their names (Server Side Filtering via Generic Resource - Recommended)

```ruby
describe azure_generic_resources(resource_provider: 'Microsoft.KeyVault/vaults', substring_of_name: 'deployment') do
  it { should exist }
end
```

## Matchers

{{< readfile file="content/inspec/reusable/md/inspec_matchers_link.md" >}}

This resource has the following special matchers.

### not_exists

```ruby
# Should not exist if no key vaults are in the resource group.

describe azure_key_vaults(resource_group: 'RESOURCE_GROUP') do
  it { should_not exist }
end
```

### exists

```ruby
# Should exist if the filter returns at least one key vault.

describe azure_key_vaults(resource_group: 'RESOURCE_GROUP') do
  it { should exist }
end
```

## Azure Permissions

{{% inspec-azure/azure_permissions_service_principal role="contributor" %}}
