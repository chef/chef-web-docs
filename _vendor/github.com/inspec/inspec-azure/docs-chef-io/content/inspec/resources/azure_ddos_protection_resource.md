+++
title = "azure_ddos_protection_resource Resource"
platform = "azure"
draft = false
gh_repo = "inspec-azure"

[menu.inspec]
title = "azure_ddos_protection_resource"
identifier = "inspec/resources/azure/azure_ddos_protection_resource Resource"
parent = "inspec/resources/azure"
+++

Use the `azure_ddos_protection_resource` InSpec audit resource to test properties of a DDoS protection plan resource.

## Azure REST API Version, Endpoint, and HTTP Client Parameters

{{% inspec_azure_common_parameters %}}

## Installation

{{% inspec_azure_install %}}

## Syntax

The `resource_group` and the DDoS protection plan resource `name`, or the `resource_id` are required parameters.

```ruby
describe azure_ddos_protection_resource(resource_group: 'RESOURCE_GROUP', name: 'DDOS_PROTECTION_PLAN_NAME') do
  it { should exist }
end
```

 ## Parameters

| Name                           | Description                                                  |
|--------------------------------|--------------------------------------------------------------|
| resource_group                 | Azure resource group that the targeted resource resides in.  |
| name                           | Name of the Azure DDoS Protection Plan resource to test.     |
| resource_id                    | The Azure DDoS Protection Plan resource ID to test.          |


The `resource_group` and the DDoS protection plan resource `name`, or the `resource_id` are required parameters.

## Properties

`name`
: Name of the Azure DDoS protection plan resource to test.

`type`
: The resource type.

`provisioning_state`
: The provisioning state of DDoS protection plan. Valid values: `Deleting`, `Failed`, `Succeeded`, `Updating`.

`virtual_networks`
: The list of virtual networks associated with the DDoS protection plan resource.

`resource_guid`
: The resource GUID property of the DDoS protection plan resource. It uniquely identifies the resource, even if the user changes its name or migrate the resource across subscriptions or resource groups.


Also, refer to the [Azure documentation](https://docs.microsoft.com/en-us/rest/api/virtualnetwork/ddos-protection-plans/get)
for other properties available.
Access any attribute in the response by separating the key names with a period (`.`).

## Examples

**Ensure that the DDoS protection plan resource has the correct type.**

```ruby
describe azure_ddos_protection_resource(resource_group: 'RESOURCE_GROUP', name: 'DDOS_PROTECTION_PLAN_NAME') do
  its('type') { should eq 'Microsoft.Network/ddosProtectionPlans' }
end
```

**Ensure that the DDoS protection plan resource is in successful state.**

```ruby
describe azure_ddos_protection_resource(resource_group: 'RESOURCE_GROUP', name: 'DDOS_PROTECTION_PLAN_NAME') do
  its('provisioning_state') { should eq 'Succeeded' }
end
```

**Ensure that the DDoS protection plan resource is from same location.**

```ruby
describe azure_ddos_protection_resource(resource_group: 'RESOURCE_GROUP', name: 'DDOS_PROTECTION_PLAN_NAME') do
  its('location') { should eq `RESOURCE_LOCATION` }
end
```

## Matchers

This InSpec audit resource has the following special matchers. For a full list of available matchers, please visit our [Universal Matchers page](/inspec/matchers/).

### exists

```ruby
# If a DDoS protection plan resource is found it will exist

describe azure_ddos_protection_resource(resource_group: 'RESOURCE_GROUP', name: 'DDOS_PROTECTION_PLAN_NAME') do
  it { should exist }
end

# DDoS protection plan resources that aren't found will not exist
describe azure_ddos_protection_resource(resource_group: 'RESOURCE_GROUP', name: 'DDOS_PROTECTION_PLAN_NAME') do
  it { should_not exist }
end
```

## Azure Permissions

{{% azure_permissions_service_principal role="contributor" %}}
