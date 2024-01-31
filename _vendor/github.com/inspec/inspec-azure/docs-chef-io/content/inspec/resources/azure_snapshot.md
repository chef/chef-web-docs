+++
title = "azure_snapshot Resource"
platform = "azure"
draft = false
gh_repo = "inspec-azure"

[menu.inspec]
title = "azure_snapshot"
identifier = "inspec/resources/azure/azure_snapshot Resource"
parent = "inspec/resources/azure"
+++

Use the `azure_snapshot` InSpec audit resource to test the properties and configuration of an Azure snapshot.

## Azure REST API Version, Endpoint, and HTTP Client Parameters

{{< readfile file="content/inspec/resources/reusable/md/inspec_azure_common_parameters.md" >}}

## Install

{{< readfile file="content/inspec/resources/reusable/md/inspec_azure_install.md" >}}

## Syntax

`resource_group` and `name` are required parameters.

```ruby
describe azure_snapshot(resource_group: 'RESOURCE_GROUP', name: 'SNAPSHOT_NAME') do
  it { should exist }
end
```

## Parameters

`resource_group` _(required)_
: Azure resource group where the targeted resource resides.

`name` _(required)_
: The name of the snapshot that is being created.

## Properties

`id`
: The id of the snapshot.

`name`
: The name of the snapshot.

`type`
: The type of the snapshot.

`location`
: The location of the snapshot.

`properties`
: The properties of the snapshot.

`sku`
: The sku of the snapshot.

For properties applicable to all resources, such as `type`, `name`, `id`, and `properties`, refer to [`azure_generic_resource`]({{< relref "azure_generic_resource.md#properties" >}}).

See the [Azure documentation](https://learn.microsoft.com/en-us/rest/api/compute/snapshots/get?tabs=HTTP) for other available properties.
Any attribute in the response may be accessed with the key names separated by dots (`.`). For example, `properties.<attribute>`.

## Examples

### Test if a snapshot is referenced with a valid name

```ruby
describe azure_snapshot(resource_group: 'RESOURCE_GROUP', name: 'SNAPSHOT_NAME') do
  it { should exist }
end
```

### Test if a snapshot is referenced with an invalid name

```ruby
describe azure_snapshot(resource_group: 'RESOURCE_GROUP', name: 'SNAPSHOT_NAME') do
  it { should_not exist }
end
```

### Test if a snapshot has the `Windows' operating system type

```ruby
describe azure_snapshot(resource_group: 'RESOURCE_GROUP', name: 'SNAPSHOT_NAME') do
  its('properties.osType') { should cmp 'Windows' }
end
```

### Test if the snapshot has a valid disk size

```ruby
describe azure_snapshot(resource_group: 'RESOURCE_GROUP', name: 'SNAPSHOT_NAME') do
  its('properties.diskSizeGB') { should cmp 127 }
end
```

## Matchers

{{< readfile file="content/inspec/reusable/md/inspec_matchers_link.md" >}}

This resource has the following special matchers.

### exists

Use `should exist` to test for a resource that should exist.

```ruby
describe azure_snapshot(resource_group: 'RESOURCE_GROUP', name: 'SNAPSHOT_NAME') do
  it { should exist }
end
```

Use `should_not exist` to test for a resource that should not exist.

```ruby
describe azure_snapshot(resource_group: 'RESOURCE_GROUP', name: 'SNAPSHOT_NAME') do
  it { should_not exist }
end
```

## Azure Permissions

{{% inspec-azure/azure_permissions_service_principal role="contributor" %}}
