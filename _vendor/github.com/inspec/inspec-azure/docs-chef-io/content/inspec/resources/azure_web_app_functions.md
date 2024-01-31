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

Use the `azure_web_app_functions` InSpec audit resource to test the properties related to azure functions for a resource group or the entire subscription.

## Azure REST API Version, Endpoint, and HTTP Client Parameters

{{< readfile file="content/inspec/resources/reusable/md/inspec_azure_common_parameters.md" >}}

## Install

{{< readfile file="content/inspec/resources/reusable/md/inspec_azure_install.md" >}}

## Syntax

An `azure_web_app_functions` resource block returns all Azure functions within a resource group (if provided) or an entire subscription.

```ruby
describe azure_web_app_functions(resource_group: 'RESOURCE_GROUP', site_name: 'function-app-http') do
  #...
end
```

or

```ruby
describe azure_web_app_functions(resource_group: 'RESOURCE_GROUP', site_name: 'function-app-http') do
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
: A list of the unique resource IDs.

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

{{< note >}}

{{< readfile file="content/inspec/reusable/md/inspec_filter_table.md" >}}

{{< /note>}}

## Examples

### Loop through functions by their IDs

```ruby
azure_web_app_functions(resource_group: 'RESOURCE_GROUP', site_name: 'function-app-http').ids.each do |id|
  describe azure_web_app_function(resource_id: id) do
    it { should exist }
  end
end
```

### Test that there are functions that include a certain string in their names (Client Side Filtering)

```ruby
describe azure_web_app_functions(resource_group: 'RESOURCE_GROUP', site_name: 'function-app-http').where { name.include?('queue') } do
  it { should exist }
end
```

## Matchers

{{< readfile file="content/inspec/reusable/md/inspec_matchers_link.md" >}}

This resource has the following special matchers.

### exists

```ruby
# Should not exist if no functions are in the resource group.

describe azure_web_app_functions(resource_group: 'RESOURCE_GROUP', site_name: 'function-app-http') do
  it { should_not exist }
end
```

### not_exists

```ruby
# Should exist if the filter returns at least one key vault.

describe azure_web_app_functions(resource_group: 'RESOURCE_GROUP', site_name: 'function-app-http') do
  it { should exist }
end
```

## Azure Permissions

{{% inspec-azure/azure_permissions_service_principal role="contributor" %}}
