+++
title = "azure_sql_virtual_machine_groups Resource"
platform = "azure"
draft = false
gh_repo = "inspec-azure"

[menu.inspec]
title = "azure_sql_virtual_machine_groups"
identifier = "inspec/resources/azure/azure_sql_virtual_machine_groups Resource"
parent = "inspec/resources/azure"
+++

Use the `azure_sql_virtual_machine_groups` InSpec audit resource to test the properties related to all Azure SQL virtual machine groups.

## Azure REST API Version, Endpoint, and HTTP Client Parameters

{{< readfile file="content/inspec/resources/reusable/md/inspec_azure_common_parameters.md" >}}

## Install

{{< readfile file="content/inspec/resources/reusable/md/inspec_azure_install.md" >}}

## Syntax

An `azure_sql_virtual_machine_groups` resource block returns all Azure SQL Virtual Machine groups.

```ruby
describe azure_sql_virtual_machine_groups do
  #...
end
```

## Parameters

`resource_group` _(optional)_

: Azure resource group where the targeted resource resides.

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
: A list of properties for all the SQL virtual machine groups.

: **Field**: `properties`

`locations`
: A list of the resource locations.

: **Field**: `location`

`provisioningStates`
: A list of provisioning states of the SQL virtual machine groups.

: **Field**: `provisioningState`

{{< note >}}

{{< readfile file="content/inspec/reusable/md/inspec_filter_table.md" >}}

{{< /note>}}

## Examples

### Loop through SQL virtual machine groups by their names

```ruby
azure_sql_virtual_machine_groups(resource_group: 'RESOURCE_GROUP').names.each do |name|
  describe azure_sql_virtual_machine_group(resource_group: 'RESOURCE_GROUP', name: name) do
    it { should exist }
  end
end
```

### Test that there are SQL virtual machine groups that are successfully provisioned

```ruby
describe azure_sql_virtual_machine_groups(resource_group: 'RESOURCE_GROUP').where(provisioningState: 'Succeeded') do
  it { should exist }
end
```

## Matchers

{{< readfile file="content/inspec/reusable/md/inspec_matchers_link.md" >}}

This resource has the following special matchers.

### exists

```ruby
# Should not exist if no SQL Virtual Machine Groups are present.

describe azure_sql_virtual_machine_groups(resource_group: 'RESOURCE_GROUP') do
  it { should_not exist }
end
```

### not_exists

```ruby
# Should exist if the filter returns at least one SQL Virtual Machine group.

describe azure_sql_virtual_machine_groups(resource_group: 'RESOURCE_GROUP') do
  it { should exist }
end
```

## Azure Permissions

{{% inspec-azure/azure_permissions_service_principal role="reader" %}}
