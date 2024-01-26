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

Use the `azure_security_center_policies` InSpec audit resource to test the properties and configuration of multiple Azure Policies.

## Azure REST API Version, Endpoint, and HTTP Client Parameters

{{< readfile file="content/inspec/resources/reusable/md/inspec_azure_common_parameters.md" >}}

## Install

{{< readfile file="content/inspec/resources/reusable/md/inspec_azure_install.md" >}}

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
: A list of the unique resource IDs.

: **Field**: `id`

`policy_names`
: A list of names of all the resources being interrogated.

: **Field**: `name`

`properties`
: A list of properties for all the resources being interrogated.

: **Field**: `properties`

{{< note >}}

{{< readfile file="content/inspec/reusable/md/inspec_filter_table.md" >}}

{{< /note>}}

## Examples

### Check if a specific policy is present

```ruby
describe azure_security_center_policies do
  its('names')  { should include 'my-policy' }
end
```

### Filter the results to include only those policies that have a specified string in their names

```ruby
describe azure_security_center_policies.where{ name.include?('production') } do
  it { should exist }
end
```

### Filter the results to include only those policies that the log collection is enabled

```ruby
describe azure_security_center_policies.where{ properties[:logCollection] == 'On' } do
  it { should exist }
  its('count') { should eq 4 }
end
```

## Matchers

{{< readfile file="content/inspec/reusable/md/inspec_matchers_link.md" >}}

This resource has the following special matchers.

### exists

The control passes if the filter returns at least one result. Use `should_not` if you expect zero matches.

```ruby
describe azure_security_center_policies do
  it { should exist }
end
```

## Azure Permissions

{{% inspec-azure/azure_permissions_service_principal role="contributor" %}}
