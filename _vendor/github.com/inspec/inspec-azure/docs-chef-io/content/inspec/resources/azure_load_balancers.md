+++
title = "azure_load_balancers Resource"
platform = "azure"
draft = false
gh_repo = "inspec-azure"

[menu.inspec]
title = "azure_load_balancers"
identifier = "inspec/resources/azure/azure_load_balancers Resource"
parent = "inspec/resources/azure"
+++

Use the `azure_load_balancers` InSpec audit resource to test the properties and configuration of Azure Load Balancers.

## Azure REST API Version, Endpoint, and HTTP Client Parameters

{{< readfile file="content/inspec/resources/reusable/md/inspec_azure_common_parameters.md" >}}

## Install

{{< readfile file="content/inspec/resources/reusable/md/inspec_azure_install.md" >}}

## Syntax

An `azure_load_balancers` resource block returns all Azure Load Balancers, either within a resource group (if provided) or the entire subscription.

```ruby
describe azure_load_balancers do
  #...
end
```

Or

```ruby
describe azure_load_balancers(resource_group: 'RESOURCE_GROUP') do
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

`locations`
: A list of locations for all the resources being interrogated.

: **Field**: `location`

`names`
: A list of names of all the resources being interrogated.

: **Field**: `name`

`tags`
: A list of `tag:value` pairs defined on the resources being interrogated.

: **Field**: `tags`

`types`
: A list of the types of resources being interrogated.

: **Field**: `type`

`properties`
: A list of properties for all the resources being interrogated.

: **Field**: `properties`

`skus`
: A list of the SKUs of the resources being interrogated.

: **Field**: `sku`

{{< note >}}

{{< readfile file="content/inspec/reusable/md/inspec_filter_table.md" >}}

{{< /note>}}

## Examples

### Check Load balancers are present

````ruby
describe azure_load_balancers do
    it            { should exist }
    its('names')  { should include 'EXAMPLE_LB' }
end
````

### Filter the results to include only those with names match the specified string value

```ruby
describe azure_load_balancers.where{ name.eql?('PRODUCTION-LB') } do
  it { should exist }
end
```

### Filter the results to include only those with location match the specified string value

```ruby
describe azure_load_balancers.where{ location.eql?('EASTUS-2') } do
  it { should exist }
end
```

## Matchers

{{< readfile file="content/inspec/reusable/md/inspec_matchers_link.md" >}}

This resource has the following special matchers.

### exists

The control passes if the filter returns at least one result.

```ruby
# If we expect 'EXAMPLEGROUP' resource group to have Load Balancers.
describe azure_load_balancers(resource_group: 'EXAMPLEGROUP') do
  it { should exist }
end
```

### not_exists

Use `should_not` if you expect zero matches.

```ruby
# If we expect 'EMPTYEXAMPLEGROUP' resource group to not have Load Balancers.
describe azure_load_balancers(resource_group: 'EMPTYEXAMPLEGROUP') do
  it { should_not exist }
end
```

## Azure Permissions

{{% inspec-azure/azure_permissions_service_principal role="contributor" %}}
