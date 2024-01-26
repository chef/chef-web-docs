+++
title = "azure_sql_managed_instances Resource"
platform = "azure"
draft = false
gh_repo = "inspec-azure"

[menu.inspec]
title = "azure_sql_managed_instances"
identifier = "inspec/resources/azure/azure_sql_managed_instances Resource"
parent = "inspec/resources/azure"
+++

Use the `azure_sql_managed_instances` InSpec audit resource to test the properties related to all Azure SQL-managed instances within a project.

## Azure REST API Version, Endpoint, and HTTP Client Parameters

{{< readfile file="content/inspec/resources/reusable/md/inspec_azure_common_parameters.md" >}}

## Install

{{< readfile file="content/inspec/resources/reusable/md/inspec_azure_install.md" >}}

## Syntax

An `azure_sql_managed_instances` resource block returns all Azure SQL-managed instances within a project.

```ruby
describe azure_sql_managed_instances do
  #...
end
```

## Parameters

`resource_group` _(optional)_

: The Azure resource group where the targeted resource resides.

## Properties

`ids`
: A list of resource IDs.

: **Field**: `id`

`names`
: A list of resource names.

: **Field**: `name`

`types`
: A list of the resource types.

: **Field**: `type`

`properties`
: A list of properties for all the SQL-managed instances.

: **Field**: `properties`

`locations`
: A list of the locations.

: **Field**: `location`

`provisioningStates`
: A list of provisioning states of all the SQL-managed instances.

: **Field**: `provisioningState`

`minimalTlsVersions`
: A list of minimalTlsVersion for all the SQL-managed instances.

: **Field**: `minimalTlsVersion`

`sku_names`
: A list of names for the sku.

: **Field**: `sku_name`

`sku_tiers`
: A list of tiers for the sku.

: **Field**: `sku_tier`

{{< note >}}

{{< readfile file="content/inspec/reusable/md/inspec_filter_table.md" >}}

{{< /note>}}

## Examples

**Loop through SQL managed instances by their names.**

```ruby
azure_sql_managed_instances(resource_group: 'RESOURCE_GROUP').names.each do |name|
  describe azure_sql_managed_instance(resource_group: 'RESOURCE_GROUP', name: name) do
    it { should exist }
  end
end
```

### Test that there are SQL-managed instances that are successfully provisioned

```ruby
describe azure_sql_managed_instances.where(provisioningState: 'Succeeded') do
  it { should exist }
end
```

## Matchers

{{< readfile file="content/inspec/reusable/md/inspec_matchers_link.md" >}}

This resource has the following special matchers.

### exists

```ruby
# Should not exist if no SQL-Managed Instances are present.

describe azure_sql_managed_instances do
  it { should_not exist }
end
```

### not_exists

```ruby
# Should exist if the filter returns at least one SQL-Managed Instance.

describe azure_sql_managed_instances do
  it { should exist }
end
```

## Azure Permissions

{{% inspec-azure/azure_permissions_service_principal role="reader" %}}
