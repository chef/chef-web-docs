+++
title = "azure_policy_definitions Resource"
platform = "azure"
draft = false
gh_repo = "inspec-azure"

[menu.inspec]
title = "azure_policy_definitions"
identifier = "inspec/resources/azure/azure_policy_definitions Resource"
parent = "inspec/resources/azure"
+++

Use the `azure_policy_definitions` InSpec audit resource to test properties and configuration of multiple Azure policy definitions.

## Azure REST API Version, Endpoint, and HTTP Client Parameters

{{% inspec_azure_common_parameters %}}

## Installation

{{% inspec_azure_install %}}

## Syntax

An `azure_policy_definitions` resource block returns all policy definitions, either built-in (if `built_in_only: true`), or within a subscription.
```ruby
describe azure_policy_definitions do
  it { should exist }
end
```

or

```ruby
describe azure_policy_definitions(built_in_only: true) do
  it { should exist }
end
```

## Parameters

`built_in_only` _(optional)_

: Indicates whether the interrogated policy definitions are built-in only. Defaults to `false` if not supplied.

## Properties

`ids`
: A list of the unique resource ids.

: **Field**: `id`

`names`
: A list of names of all the resources being interrogated.

: **Field**: `name`

`policy_types`
: A list of policy types of all the resources.

: **Field**: `policy_type`

`modes`
: A list of modes of all the resources.

: **Field**: `mode`

`metadata_versions`
: A list of metadata versions of the resources.

: **Field**: `metadata_version`

`metadata_categories`
: A list of metadata categories of the resources.

: **Field**: `metadata_category`

`parameters`
: A list of parameters of the resources.

: **Field**: `parameters`

`policy_rules`
: A list of policy rules of the resources.

: **Field**: `policy_rule`

`properties`
: A list of properties for all the resources being interrogated.

: **Field**: `properties`

{{% inspec_filter_table %}}

## Examples

**Check a Specific Policy Definition is Present.**

```ruby
describe azure_policy_definitions do
  its('names')  { should include 'my-policy' }
end
```
**Filters the Results to Include Only Those Policy Definitions which Include the Given Name.**

```ruby
describe azure_policy_definitions.where{ name.include?('my-policy') } do
  it { should exist }
end
```
**Filters the Results to Include Only The Custom Policy Definitions.**

```ruby
describe azure_policy_definitions.where(policy_type: "Custom") do
  it { should exist }
  its('count') { should be 15 }
end
```    

## Matchers

This InSpec audit resource has the following special matchers. For a full list of available matchers, please visit our [Universal Matchers page](https://www.inspec.io/docs/reference/matchers/).

### exists

The control will pass if the filter returns at least one result. Use `should_not` if you expect zero matches.
```ruby
describe azure_policy_definitions do
  it { should exist }
end
```

## Azure Permissions

{{% azure_permissions_service_principal role="contributor" %}}
