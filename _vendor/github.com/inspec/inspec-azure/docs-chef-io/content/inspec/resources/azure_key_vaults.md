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

Use the `azure_key_vaults` InSpec audit resource to test properties related to key vaults for a resource group or the entire subscription.

## Azure REST API Version, Endpoint, and HTTP Client Parameters

{{% inspec_azure_common_parameters %}}

## Installation

{{% inspec_azure_install %}}

## Syntax

An `azure_key_vaults` resource block returns all Azure key vaults, either within a Resource Group (if provided), or within an entire Subscription.
```ruby
describe azure_key_vaults do
  #...
end
```
or
```ruby
describe azure_key_vaults(resource_group: 'my-rg') do
  #...
end
```

## Parameters

`resource_group` _(optional)_

: The name of the resource group.

## Properties

`ids`
: A list of the unique resource ids.

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

{{% inspec_filter_table %}}

## Examples

**Loop through Key Vaults by Their Ids  .**

```ruby
azure_key_vaults.ids.each do |id|
  describe azure_key_vault(resource_id: id) do
    it { should exist }
  end
end  
```     
**Test that There are Key Vaults that Includes a Certain String in their Names (Client Side Filtering)   .**

```ruby
describe azure_key_vaults.where { name.include?('deployment') } do
  it { should exist }
end
```    
**Test that There are Key Vaults that Includes a Certain String in their Names (Server Side Filtering via Generic Resource - Recommended)   .**

```ruby
describe azure_generic_resources(resource_provider: 'Microsoft.KeyVault/vaults', substring_of_name: 'deployment') do
  it { should exist }
end
```

## Matchers

This InSpec audit resource has the following special matchers. For a full list of available matchers, please visit our [Universal Matchers page](https://www.inspec.io/docs/reference/matchers/).

### exists

```ruby
# Should not exist if no key vaults are in the resource group

describe azure_key_vaults(resource_group: 'MyResourceGroup') do
  it { should_not exist }
end

# Should exist if the filter returns at least one key vault

describe azure_key_vaults(resource_group: 'MyResourceGroup') do
  it { should exist }
end
```

## Azure Permissions

{{% azure_permissions_service_principal role="contributor" %}}
