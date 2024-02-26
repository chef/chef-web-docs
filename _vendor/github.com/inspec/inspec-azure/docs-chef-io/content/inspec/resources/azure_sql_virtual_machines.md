+++
title = "azure_sql_virtual_machines Resource"
platform = "azure"
draft = false
gh_repo = "inspec-azure"

[menu.inspec]
title = "azure_sql_virtual_machines"
identifier = "inspec/resources/azure/azure_sql_virtual_machines Resource"
parent = "inspec/resources/azure"
+++

Use the `azure_sql_virtual_machines` InSpec audit resource to test the properties of all Azure SQL virtual machines.

## Azure REST API Version, Endpoint, and HTTP Client Parameters

{{< readfile file="content/inspec/resources/reusable/md/inspec_azure_common_parameters.md" >}}

## Install

{{< readfile file="content/inspec/resources/reusable/md/inspec_azure_install.md" >}}

## Syntax

An `azure_sql_virtual_machines` resource block returns all Azure SQL virtual machines.

```ruby
describe azure_sql_virtual_machines do
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
: A list of Properties for all the SQL virtual machines.

: **Field**: `properties`

`locations`
: A list of the Geo-locations.

: **Field**: `location`

`provisioningStates`
: A list of provisioning states of the SQL virtual machines.

: **Field**: `provisioningState`

{{< note >}}

{{< readfile file="content/inspec/reusable/md/inspec_filter_table.md" >}}

{{< /note>}}

## Examples

### Loop through SQL virtual machines by their names

```ruby
azure_sql_virtual_machines(resource_group: 'RESOURCE_GROUP').names.each do |name|
  describe azure_sql_virtual_machine(resource_group: 'RESOURCE_GROUP', name: name) do
    it { should exist }
  end
end
```

### Test that there are SQL virtual machines that are successfully provisioned

```ruby
describe azure_sql_virtual_machines(resource_group: 'RESOURCE_GROUP').where(provisioningState: 'Succeeded') do
  it { should exist }
end
```

## Matchers

{{< readfile file="content/inspec/reusable/md/inspec_matchers_link.md" >}}

This resource has the following special matchers.

### exists

```ruby
# Should not exist if no SQL virtual machines are present.

describe azure_sql_virtual_machines(resource_group: 'RESOURCE_GROUP') do
  it { should_not exist }
end
```

### not_exists

```ruby
# Should exist if the filter returns at least one SQL virtual machine.

describe azure_sql_virtual_machines(resource_group: 'RESOURCE_GROUP') do
  it { should exist }
end
```

## Azure Permissions

{{% inspec-azure/azure_permissions_service_principal role="reader" %}}
