+++
title = "azure_sql_virtual_machine_group_availability_listeners Resource"
platform = "azure"
draft = false
gh_repo = "inspec-azure"

[menu.inspec]
title = "azure_sql_virtual_machine_group_availability_listeners"
identifier = "inspec/resources/azure/azure_sql_virtual_machine_group_availability_listeners Resource"
parent = "inspec/resources/azure"
+++

Use the `azure_sql_virtual_machine_group_availability_listeners` InSpec audit resource to test properties related to all Azure SQL virtual machine group availability listeners.

## Azure REST API Version, Endpoint, and HTTP Client Parameters

{{% inspec_azure_common_parameters %}}

## Installation

{{% inspec_azure_install %}}

## Syntax

An `azure_sql_virtual_machine_group_availability_listeners` resource block returns all Azure SQL virtual machine group availability listeners.

```ruby
describe azure_sql_virtual_machine_group_availability_listeners(resource_group: 'RESOURCE_GROUP', sql_virtual_machine_group_name: 'SQL_VIRTUAL_MACHINE_GROUP_NAME') do
  #...
end
```

## Parameters

`resource_group` _(required)_

: Azure resource group that the targeted resource resides in.

`sql_virtual_machine_group_name` _(required)_

: Azure SQL virtual machine group name

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
: A list of Properties for all the SQL virtual machine group availability listeners.

: **Field**: `properties`

`provisioningStates`
: A list of provisioning states of the SQL virtual machine group availability listeners.

: **Field**: `provisioningState`

{{% inspec_filter_table %}}

## Examples

**Loop through SQL virtual machine group availability listeners by their names.**

```ruby
azure_sql_virtual_machine_group_availability_listeners(resource_group: 'RESOURCE_GROUP', sql_virtual_machine_group_name: 'SQL_VIRTUAL_MACHINE_GROUP_NAME').names.each do |name|
  describe azure_sql_virtual_machine_group_availability_listener(resource_group: 'RESOURCE_GROUP', sql_virtual_machine_group_name: 'SQL_VIRTUAL_MACHINE_GROUP_NAME', name: name) do
    it { should exist }
  end
end
```

**Test that there are SQL virtual machine group availability listeners that are successfully provisioned.**

```ruby
describe azure_sql_virtual_machine_group_availability_listeners(resource_group: 'RESOURCE_GROUP', sql_virtual_machine_group_name: 'SQL_VIRTUAL_MACHINE_GROUP_NAME').where(provisioningState: 'Succeeded') do
  it { should exist }
end
```

## Matchers

This InSpec audit resource has the following special matchers. For a full list of available matchers, please visit our [Universal Matchers page](https://www.inspec.io/docs/reference/matchers/).

### exists

```ruby
# Should not exist if no SQL virtual machine group availability listeners are present

describe azure_sql_virtual_machine_group_availability_listeners(resource_group: 'RESOURCE_GROUP', sql_virtual_machine_group_name: 'SQL_VIRTUAL_MACHINE_GROUP_NAME') do
  it { should_not exist }
end
# Should exist if the filter returns at least one SQL virtual machine group availability listeners

describe azure_sql_virtual_machine_group_availability_listeners(resource_group: 'RESOURCE_GROUP', sql_virtual_machine_group_name: 'SQL_VIRTUAL_MACHINE_GROUP_NAME') do
  it { should exist }
end
```

## Azure Permissions

{{% azure_permissions_service_principal role="reader" %}}
