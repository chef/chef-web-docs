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

Use the `azure_policy_definitions` InSpec audit resource to test the properties and configuration of multiple Azure Policy definitions.

## Azure REST API Version, Endpoint, and HTTP Client Parameters

{{< readfile file="content/inspec/resources/reusable/md/inspec_azure_common_parameters.md" >}}

## Install

{{< readfile file="content/inspec/resources/reusable/md/inspec_azure_install.md" >}}

## Syntax

An `azure_policy_definitions` resource block returns all policy definitions built-in (if `built_in_only: true`) or within a subscription.

```ruby
describe azure_policy_definitions do
  it { should exist }
end
```

Or

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
: A list of the unique resource IDs.

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

{{< note >}}

{{< readfile file="content/inspec/reusable/md/inspec_filter_table.md" >}}

{{< /note>}}

## Examples

### Check a specific Policy definition is present

```ruby
describe azure_policy_definitions do
  its('names')  { should include 'my-policy' }
end
```

### Filters the results to include only those Policy definitions which include the specified name

```ruby
describe azure_policy_definitions.where{ name.include?('my-policy') } do
  it { should exist }
end
```

### Filters the results to include only the custom Policy definitions

```ruby
describe azure_policy_definitions.where(policy_type: "Custom") do
  it { should exist }
  its('count') { should be 15 }
end
```

## Matchers

{{< readfile file="content/inspec/reusable/md/inspec_matchers_link.md" >}}

This resource has the following special matchers.

### exists

The control passes if the filter returns at least one result. Use `should_not` if you expect zero matches.

```ruby
describe azure_policy_definitions do
  it { should exist }
end
```

## Azure Permissions

{{% inspec-azure/azure_permissions_service_principal role="contributor" %}}
