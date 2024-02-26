+++
title = "azure_db_migration_service Resource"
platform = "azure"
draft = false
gh_repo = "inspec-azure"

[menu.inspec]
title = "azure_db_migration_service"
identifier = "inspec/resources/azure/azure_db_migration_service Resource"
parent = "inspec/resources/azure"
+++

Use the `azure_db_migration_service` InSpec audit resource to test the properties related to a Azure DB Migration Service.

## Azure REST API Version, Endpoint, and HTTP Client Parameters

{{< readfile file="content/inspec/resources/reusable/md/inspec_azure_common_parameters.md" >}}

## Install

{{< readfile file="content/inspec/resources/reusable/md/inspec_azure_install.md" >}}

## Syntax

`resource_group` and `service_name` are required parameter.

```ruby
describe azure_db_migration_service(resource_group: 'RESOURCE_GROUP', service_name: 'SERVICE_NAME') do
  it                                      { should exist }
  its('name')                             { should cmp 'inspec-cloud-pack-test' }
  its('type')                             { should cmp 'Microsoft.DataMigration/services' }
  its('sku.name')                         { should cmp 'Basic_1vCore' }
  its('sku.size')                         { should cmp '1 vCore' }
  its('location')                         { should cmp 'southcentralus' }
end
```

```ruby
describe azure_db_migration_service(resource_group: 'RESOURCE_GROUP', service_name: 'SERVICE_NAME') do
  it { should exist }
end
```

## Parameters

`resource_group`
: Azure resource group where the targeted resource resides.

`service_name`
: Name of the Azure DB Migration service to test.

The parameter set should be provided for a valid query: `resource_group` and `service_name`.

## Properties

`id`
: Resource ID.

`name`
: DB Migration Service Name.

`location`
: DB Migration Service Location.

`type`
: Resource type.

`kind`
: The resource kind.

`etag`
: HTTP strong entity tag value. Ignored if submitted.

`sku.name`
: The unique name of the SKU, such as 'P3'.

`sku.size`
: The size of the SKU, used when the name alone does not denote a service size or when a SKU has multiple performance classes within a family. For example, 'A1' for virtual machines.

`sku.tier`
: The tier of the SKU, such as 'Free', 'Basic', 'Standard', or 'Premium'.

`tags`
: Resource tags.

`properties.provisioningState`
: The resource's provisioning state.

`properties.virtualSubnetId`
: The ID of the `Microsoft.Network/virtualNetworks/subnets` resource to which the service should be joined.

`properties.virtualNicId`
: The ID of the Azure Network Interface.

For properties applicable to all resources, such as `type`, `name`, `id`, and `properties`, refer to [`azure_generic_resource`]({{< relref "azure_generic_resource.md#properties" >}}).

Also, refer to [Azure documentation](https://docs.microsoft.com/en-us/rest/api/datamigration/services/get) for other properties available.
Any attribute in the response may be accessed with the key names separated by dots (`.`).

## Examples

```ruby
describe azure_db_migration_service(resource_group: 'RESOURCE_GROUP', service_name: 'NAME') do
  its('properties.provisioningState') { should eq 'Succeeded' }
end
```

```ruby
describe azure_db_migration_service(resource_group: 'RESOURCE_GROUP', service_name: 'NAME') do
  its('sku.name') { should 'Standard_1vCores' }
end
```

## Matchers

This InSpec audit resource has the following special matchers. For a full list of available matchers, please visit our [Universal Matchers page](/inspec/matchers/).

### exists

```ruby
# If a azure_db_migration_service is found, it will exist.

describe azure_db_migration_service(resource_group: 'RESOURCE_GROUP', service_name: 'NAME') do
  it { should exist }
end
```

### not_exists

```ruby
# azure_db_migration_services that aren't found, will not exist.

describe azure_db_migration_service(resource_group: 'RESOURCE_GROUP', service_name: 'NAME') do
  it { should_not exist }
end
```

## Azure Permissions

{{% inspec-azure/azure_permissions_service_principal role="contributor" %}}
