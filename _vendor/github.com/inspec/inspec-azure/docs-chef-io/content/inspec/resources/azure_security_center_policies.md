+++
title = "azure_security_center_policies Resource"
platform = "azure"
draft = false
gh_repo = "inspec-azure"

[menu.inspec]
title = "azure_security_center_policies"
identifier = "inspec/resources/azure/azure_security_center_policies Resource"
parent = "inspec/resources/azure"
+++

Use the `azure_security_center_policies` InSpec audit resource to test properties and configuration of multiple Azure Polices.

## Azure REST API Version, Endpoint, and HTTP Client Parameters

{{% inspec_azure_common_parameters %}}

## Installation

{{% inspec_azure_install %}}

## Syntax

An `azure_subscriptions` resource block returns all security policies for a subscription.
```ruby
describe azure_security_center_policies do
  it { should exist }
end
```

## Parameters

This resource does not require any parameters.

## Properties

`ids`
: A list of the unique resource ids.

: **Field**: `id`

`policy_names`
: A list of names of all the resources being interrogated.

: **Field**: `name`

`properties`
: A list of properties for all the resources being interrogated.

: **Field**: `properties`

{{% inspec_filter_table %}}

## Examples

**Check If a Specific Policy is Present.**

```ruby
describe azure_security_center_policies do
  its('names')  { should include 'my-policy' }
end
```
**Filter the Results to Include Only Those Policies which Include a Given String in Their Names.**

```ruby
describe azure_security_center_policies.where{ name.include?('production') } do
  it { should exist }
end
```
**Filter the Results to Include Only Those Policies that the Log Collection is Enabled.**

```ruby
describe azure_security_center_policies.where{ properties[:logCollection] == 'On' } do
  it { should exist }
  its('count') { should eq 4 }
end
```    

## Matchers

This InSpec audit resource has the following special matchers. For a full list of available matchers, please visit our [Universal Matchers page](https://www.inspec.io/docs/reference/matchers/).

### exists

The control will pass if the filter returns at least one result. Use `should_not` if you expect zero matches.
```ruby
describe azure_security_center_policies do
  it { should exist }
end
```

## Azure Permissions

{{% azure_permissions_service_principal role="contributor" %}}
