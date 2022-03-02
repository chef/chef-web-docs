+++
title = "azure_web_app_functions Resource"
platform = "azure"
draft = false
gh_repo = "inspec-azure"

[menu.inspec]
title = "azure_web_app_functions"
identifier = "inspec/resources/azure/azure_web_app_functions Resource"
parent = "inspec/resources/azure"
+++

Use the `azure_web_app_functions` InSpec audit resource to test properties related to azure functions for a resource group or the entire subscription.

## Azure REST API Version, Endpoint, and HTTP Client Parameters

{{% inspec_azure_common_parameters %}}

## Installation

{{% inspec_azure_install %}}

## Syntax

An `azure_web_app_functions` resource block returns all Azure functions, either within a Resource Group (if provided), or within an entire Subscription.

```ruby
describe azure_web_app_functions(resource_group: 'my-rg', site_name: 'function-app-http') do
  #...
end
```

or

```ruby
describe azure_web_app_functions(resource_group: 'my-rg', site_name: 'function-app-http') do
  #...
end
```

## Parameters

`resource_group`

: The name of the resource group.

`site_name`

: The name of the function App.

## Properties

`ids`
: A list of the unique resource ids.

: **Field**: `id`

`names`
: A list of all the key vault names.

: **Field**: `name`

`types`
: A list of types of all the functions.

: **Field**: `type`

`locations`
: A list of locations for all the functions.

: **Field**: `location`

`properties`
: A list of properties for all the functions.

: **Field**: `properties`

{{% inspec_filter_table %}}

## Examples

**Loop through functions by their IDs.**

```ruby
azure_web_app_functions(resource_group: 'my-rg', site_name: 'function-app-http').ids.each do |id|
  describe azure_web_app_function(resource_id: id) do
    it { should exist }
  end
end
```

**Test that there are functions that includes a certain string in their names (Client Side Filtering).**

```ruby
describe azure_web_app_functions(resource_group: 'my-rg', site_name: 'function-app-http').where { name.include?('queue') } do
  it { should exist }
end
```

## Matchers

This InSpec audit resource has the following special matchers. For a full list of available matchers, please visit our [Universal Matchers page](https://www.inspec.io/docs/reference/matchers/).

### exists

```ruby
# Should not exist if no functions are in the resource group

describe azure_web_app_functions(resource_group: 'MyResourceGroup', site_name: 'function-app-http') do
  it { should_not exist }
end

# Should exist if the filter returns at least one key vault

describe azure_web_app_functions(resource_group: 'MyResourceGroup', site_name: 'function-app-http') do
  it { should exist }
end
```

## Azure Permissions

{{% azure_permissions_service_principal role="contributor" %}}
