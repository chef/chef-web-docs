+++
title = "azure_data_factory_linked_services Resource"
platform = "azure"
draft = false
gh_repo = "inspec-azure"

[menu.inspec]
title = "azure_data_factory_linked_services"
identifier = "inspec/resources/azure/azure_data_factory_linked_services Resource"
parent = "inspec/resources/azure"
+++

Use the `azure_data_factory_linked_services` InSpec audit resource to test the properties related to linked services for a resource group or the entire subscription.

## Azure REST API Version, Endpoint, and HTTP Client Parameters

{{% inspec_azure_common_parameters %}}

## Installation

{{% inspec_azure_install %}}

## Syntax

An `azure_data_factory_linked_services` resource block returns all Azure Linked Services, either within a Resource Group (if provided), or within an entire Subscription.

```ruby
describe (resource_group: `RESOURCE_GROUP`, factory_name: 'FACTORY_NAME') do
  #...
end
```

`resource_group` and `factory_name` are required parameters.

## Parameters

`resource_group`
: Azure resource group that the targeted resource resides in.

`factory_name`
: Azure factory name for which linked services are retrived.

## Properties

`names`
: A list of the unique resource names.

: **Field**: `name`

`ids`
: A list of Linked Services IDs.

: **Field**: `id`

`properties`
: A list of properties for the resource.

: **Field**: `properties`

`provisioning_states`
: The linked services provisioning state.

: **Field**: `provisioning_state`

`linked_service_types`
: The type of linked service resource.

: **Field**: `linked_service_type`

`type_properties`
: The linked service type of properties.

: **Field**: `type_properties`

<superscript>*</superscript> For information on how to use filter criteria on plural resources, refer to [FilterTable usage](https://github.com/inspec/inspec/blob/master/dev-docs/filtertable-usage.md).

## Examples

**Test if any linked services exist in the resource group.**

```ruby
describe azure_data_factory_linked_services(resource_group: `RESOURCE_GROUP`, factory_name: 'FACTORY_NAME') do
  it { should exist }
  its('names') { should include "factory_name" }
end
```

**Test that there aren't any Linked Services in a resource group.**

```ruby
**Should not exist if no Linked Services are in the resource group.**

describe azure_data_factory_linked_services(resource_group: `RESOURCE_GROUP`, factory_name: 'FACTORY_NAME') do
  it { should_not exist }
end
```

**Filter Linked Services in a resource group by properties.**

```ruby
describe azure_data_factory_linked_services(resource_group: `RESOURCE_GROUP`, factory_name: 'FACTORY_NAME') do
  its('names') { should include linked_service_name1 }
  its('types') { should include 'Microsoft.DataFactory/factories/linkedservices' }
  its('linked_service_types') { should include('MySql') }
end
```

## Azure Permissions

{{% azure_permissions_service_principal role="contributor" %}}
