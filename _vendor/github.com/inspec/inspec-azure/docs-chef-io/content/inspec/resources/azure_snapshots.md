+++
title = "azure_snapshots Resource"
platform = "azure"
draft = false
gh_repo = "inspec-azure"

[menu.inspec]
title = "azure_snapshots"
identifier = "inspec/resources/azure/azure_snapshots Resource"
parent = "inspec/resources/azure"
+++

Use the `azure_snapshots` InSpec audit resource to test the properties and configurations of multiple Azure snapshots.

## Azure REST API Version, Endpoint, and HTTP Client Parameters

{{< readfile file="content/inspec/resources/reusable/md/inspec_azure_common_parameters.md" >}}

## Install

{{< readfile file="content/inspec/resources/reusable/md/inspec_azure_install.md" >}}

## Syntax

```ruby
describe azure_snapshots do
  it { should exist }
end
```

## Parameters

No required parameters.

## Properties

`ids`
: The id of the snapshot.

: **Field**: `id`

`names`
: The name of the snapshot.

: **Field**: `name`

`types`
: The type of the snapshot.

: **Field**: `type`

`locations`
: The location of the snapshot.

: **Field**: `location`

`properties`
: The properties of the snapshot.

: **Field**: `properties`

`skus`
: The sku of the snapshot.

: **Field**: `sku`

{{< note >}}

{{< readfile file="content/inspec/reusable/md/inspec_filter_table.md" >}}

{{< /note>}}

See the [Azure documentation](https://learn.microsoft.com/en-us/rest/api/compute/snapshots/list-by-resource-group?tabs=HTTP) for other available properties.

## Examples

### Test if a snapshot has a valid type

```ruby
describe azure_snapshots do
  its('types') { should cmp 'Microsoft.Compute/snapshots' }
end
```

## Matchers

{{< readfile file="content/inspec/reusable/md/inspec_matchers_link.md" >}}

This resource has the following special matchers.

### exists

The control passes if the filter returns at least one result. Use `should_not` if you expect zero matches.

Use `should exist` to test that a resource exists.

```ruby
describe azure_snapshots do
  it { should exist }
end
```

Use `should_not exist` to test that resources do not exist.

```ruby
describe azure_snapshots do
  it { should_not exist }
end
```

## Azure Permissions

{{% inspec-azure/azure_permissions_service_principal role="contributor" %}}
