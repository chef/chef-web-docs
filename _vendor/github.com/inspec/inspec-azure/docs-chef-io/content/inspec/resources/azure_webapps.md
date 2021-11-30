+++
title = "azure_webapps Resource"
platform = "azure"
draft = false
gh_repo = "inspec-azure"

[menu.inspec]
title = "azure_webapps"
identifier = "inspec/resources/azure/azure_webapps Resource"
parent = "inspec/resources/azure"
+++

Use the `azure_webapps` InSpec audit resource to test properties and configuration of multiple Azure web applications.

## Azure REST API Version, Endpoint, and HTTP Client Parameters

{{% inspec_azure_common_parameters %}}

## Installation

{{% inspec_azure_install %}}

## Syntax

An `azure_webapps` resource block returns all webapps, either within a Resource Group (if provided), or within an entire Subscription.
```ruby
describe azure_webapps do
  #...
end
```
or
```ruby
describe azure_webapps(resource_group: 'my-rg') do
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
: A list of names of all the resources being interrogated.

: **Field**: `name`

`tags`
: A list of `tag:value` pairs defined on the resources being interrogated.

: **Field**: `tags`

`properties`
: A list of properties for all the resources being interrogated.

: **Field**: `properties`

{{% inspec_filter_table %}}

## Examples

**Test that an Example Resource Group has the Named Web Application.**

```ruby
describe azure_webapps(resource_group: 'ExampleGroup') do
  its('names') { should include('my_web_app') }
end
```

## Matchers

This InSpec audit resource has the following special matchers. For a full list of available matchers, please visit our [Universal Matchers page](https://www.inspec.io/docs/reference/matchers/).

### exists

The control will pass if the filter returns at least one result. Use `should_not` if you expect zero matches.
```ruby
# If we expect 'ExampleGroup' Resource Group to have at least one web application
describe azure_webapps(resource_group: 'ExampleGroup') do
  it { should exist }
end

# If we expect 'EmptyExampleGroup' Resource Group to not have any web applications
describe azure_webapps(resource_group: 'EmptyExampleGroup') do
  it { should_not exist }
end
```

## Azure Permissions

{{% azure_permissions_service_principal role="contributor" %}}
