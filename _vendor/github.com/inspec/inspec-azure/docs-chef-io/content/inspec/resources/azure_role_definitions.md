+++
title = "azure_role_definitions Resource"
platform = "azure"
draft = false
gh_repo = "inspec-azure"

[menu.inspec]
title = "azure_role_definitions"
identifier = "inspec/resources/azure/azure_role_definitions Resource"
parent = "inspec/resources/azure"
+++

Use the `azure_role_definitions` InSpec audit resource to test the properties and configuration of multiple Azure role definitions.

## Azure REST API Version, Endpoint, and HTTP Client Parameters

{{< readfile file="content/inspec/resources/reusable/md/inspec_azure_common_parameters.md" >}}

## Install

{{< readfile file="content/inspec/resources/reusable/md/inspec_azure_install.md" >}}

## Syntax

An `azure_role_definitions` resource block returns all role definitions within a subscription.

```ruby
describe azure_role_definitions do
  it { should exist }
end
```

## Parameters

This resource does not require any parameters.

## Properties

`ids`
: A list of the unique resource IDs.

: **Field**: `id`

`names`
: A list of names of all the resources being interrogated.

: **Field**: `name`

`role_names`
: A list of role names of all the role definitions being interrogated.

: **Field**: `role_name`

`types`
: A list of role type of all the role definitions being interrogated.

: **Field**: `type`

`properties`
: A list of properties for all the resources being interrogated.

: **Field**: `properties`

{{< note >}}

{{< readfile file="content/inspec/reusable/md/inspec_filter_table.md" >}}

{{< /note>}}

## Examples

### Check a specific role definition is present

```ruby
describe azure_role_definitions do
  its('names')  { should include 'my-role' }
end
```

### Filter the results to include only those role definitions that have the specified name

```ruby
describe azure_role_definitions.where{ name.include?('my-role') } do
  it { should exist }
end
```

### Filter the results to include only the built-in role definitions

```ruby
describe azure_role_definitions.where{ type == "BuiltInRole" } do
  it { should exist }
  its('count') { should be 15 }
end
```

### Filter the results to include only the role definitions that contain 'Kubernetes' in the role name

```ruby
describe azure_role_definitions.where{ role_name.include?('Kubernetes') } do
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
describe azure_role_definitions do
  it { should exist }
end
```

## Azure Permissions

{{% inspec-azure/azure_permissions_service_principal role="contributor" %}}
