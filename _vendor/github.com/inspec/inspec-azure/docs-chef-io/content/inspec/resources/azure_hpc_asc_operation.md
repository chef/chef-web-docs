+++
title = "azure_hpc_asc_operation Resource"
platform = "azure"
draft = false
gh_repo = "inspec-azure"

[menu.inspec]
title = "azure_hpc_asc_operation"
identifier = "inspec/resources/azure/azure_hpc_asc_operation Resource"
parent = "inspec/resources/azure"
+++

Use the `azure_hpc_asc_operation` InSpec audit resource to test the properties related to an Azure HPC ASC Operation.

## Azure REST API Version, Endpoint, and HTTP Client Parameters

{{< readfile file="content/inspec/resources/reusable/md/inspec_azure_common_parameters.md" >}}

## Install

{{< readfile file="content/inspec/resources/reusable/md/inspec_azure_install.md" >}}

## Syntax

`name`, `cache_name`, and `resource_group` are required parameters.

```ruby
describe azure_hpc_asc_operation(location: 'LOCATION', operation_id: 'OPERATION_ID') do
  it                                      { should exist }
  its('type')                             { should eq 'Microsoft.StorageCache/Cache/StorageTarget' }
  its('location')                         { should eq 'East US' }
end
```

```ruby
describe azure_hpc_asc_operation(location: 'LOCATION', operation_id: 'OPERATION_ID') do
  it  { should exist }
end
```

## Parameters

`location` _(required)_
: The name of the region used to look up the operation.

`operation_id` _(required)_
: The operation ID that uniquely identifies the asynchronous operation.

## Properties

`id`
: The operation ID.

`name`
: The operation name.

`startTime`
: The start time of the operation.

`status`
: The status of the operation.

`endTime`
: The end time of the operation.

For properties applicable to all resources, such as `type`, `name`, `id`, and `properties`, refer to [`azure_generic_resource`]({{< relref "azure_generic_resource.md#properties" >}}).

Also, refer to [Azure documentation](https://docs.microsoft.com/en-us/rest/api/storagecache/asc-operations/get#ascoperation) for other properties available.

## Examples

### Test that the HPC ASC operation is succeeded

```ruby
describe azure_hpc_asc_operation(location: 'LOCATION', operation_id: 'OPERATION_ID') do
  its('status') { should eq 'Succeeded' }
end
```

## Matchers

{{< readfile file="content/inspec/reusable/md/inspec_matchers_link.md" >}}

This resource has the following special matchers.

### exists

```ruby
# If an HPC ASC Operation is found, it will exist.

describe azure_hpc_asc_operation(location: 'LOCATION', operation_id: 'OPERATION_ID') do
  it { should exist }
end
```

### not_exists

```ruby
# If an HPC ASC Operation is not found, it will not exist.

describe azure_hpc_asc_operation(location: 'LOCATION', operation_id: 'OPERATION_ID') do
  it { should_not exist }
end
```

## Azure Permissions

{{% inspec-azure/azure_permissions_service_principal role="reader" %}}
