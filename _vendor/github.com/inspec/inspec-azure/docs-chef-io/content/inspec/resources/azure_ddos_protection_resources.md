+++
title = "azure_ddos_protection_resources Resource"
platform = "azure"
draft = false
gh_repo = "inspec-azure"

[menu.inspec]
title = "azure_ddos_protection_resources"
identifier = "inspec/resources/azure/azure_ddos_protection_resources Resource"
parent = "inspec/resources/azure"
+++

Use the `azure_ddos_protection_resources` InSpec audit resource to test properties of DDoS protection plans in a resource group.

## Azure REST API Version, Endpoint, and HTTP Client Parameters

{{% inspec_azure_common_parameters %}}

## Installation

{{% inspec_azure_install %}}

## Syntax

An `azure_ddos_protection_resources` resource block returns all Azure bastion hosts, either within a Resource Group (if provided)

```ruby
describe azure_ddos_protection_resources(resource_group: 'RESOURCE_GROUP') do
   #....
end
```

## Parameters

`resource_group`
: Azure resource group that the targeted resource resides in.

## Properties

`names`
: A list of the unique resource names.

: **Field**: `name`

`ids`
: A list of DDoS protection plan IDs.

: **Field**: `id`

`virtual_networks`
: The list of virtual networks associated with the DDoS protection plan resource.

: **Field**: `virtual_networks`

`provisioning_states`
: The provisioning states of the DDoS protection plans.

: **Field**: `provisioning_state`

`types`
: The types of all the DDoS protection plans.

: **Field**: `type`

`resource_guids`
: The resource GUID property of the DDoS protection plan resource. It uniquely identifies the resource, even if the user changes its name or migrate the resource across subscriptions or resource groups.

: **Field**: `resource_guid`


{{% inspec_filter_table %}}

Also, refer to the [Azure documentation](https://docs.microsoft.com/en-us/rest/api/virtualnetwork/ddos-protection-plans/list) for all available properties.
Access any attribute in the response by separating the key names with a period (`.`).

## Examples

**Ensure that the DDoS protection plan resource is in successful state.**

```ruby
describe azure_ddos_protection_resources(resource_group: 'RESOURCE_GROUP') do
  its('provisioning_states') { should include('Succeeded') }
end
```

**Ensure that a DDoS protection plan resource is from a location.**

```ruby
describe azure_ddos_protection_resources(resource_group: 'RESOURCE_GROUP') do
  its('location') { should include `RESOURCE_LOCATION` }
end
```

**Test if any DDoS protection plan exists in the resource group.**

```ruby
describe azure_ddos_protection_resources(resource_group: 'RESOURCE_GROUP') do
  it { should exist }
end
```

## Matchers

This InSpec audit resource has the following special matchers. For a full list of available matchers, please visit our [Universal Matchers page](https://www.inspec.io/docs/reference/matchers/).

### exists

```ruby
# Should not exist if no bastion hots are in the resource group

describe azure_ddos_protection_resources(resource_group: 'RESOURCE_GROUP') do
  it { should_not exist }
end
```

## Azure Permissions

{{% azure_permissions_service_principal role="contributor" %}}
