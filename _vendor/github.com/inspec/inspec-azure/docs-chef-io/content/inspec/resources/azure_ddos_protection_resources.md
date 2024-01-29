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

Use the `azure_ddos_protection_resources` InSpec audit resource to test the properties of DDoS protection plans in a resource group.

## Azure REST API Version, Endpoint, and HTTP Client Parameters

{{< readfile file="content/inspec/resources/reusable/md/inspec_azure_common_parameters.md" >}}

## Install

{{< readfile file="content/inspec/resources/reusable/md/inspec_azure_install.md" >}}

## Syntax

An `azure_ddos_protection_resources` resource block returns all Azure bastion hosts, within a resource group (if provided).

```ruby
describe azure_ddos_protection_resources(resource_group: 'RESOURCE_GROUP') do
   #....
end
```

## Parameters

`resource_group`
: Azure resource group where the targeted resource resides.

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
: The resource GUID property of the DDoS protection plan resource. It uniquely identifies the resource, even if the user changes its name or migrates the resource across subscriptions or resource groups.

: **Field**: `resource_guid`

{{< note >}}

{{< readfile file="content/inspec/reusable/md/inspec_filter_table.md" >}}

{{< /note>}}

Also, refer to the [Azure documentation](https://docs.microsoft.com/en-us/rest/api/virtualnetwork/ddos-protection-plans/list) for all available properties. Access any attribute in the response by separating the key names with a period (`.`).

## Examples

### Test to ensure that the DDoS protection plan resource is in a successful state

```ruby
describe azure_ddos_protection_resources(resource_group: 'RESOURCE_GROUP') do
  its('provisioning_states') { should include('Succeeded') }
end
```

### Test to ensure that a DDoS protection plan resource is from a location

```ruby
describe azure_ddos_protection_resources(resource_group: 'RESOURCE_GROUP') do
  its('location') { should include `RESOURCE_LOCATION` }
end
```

### Test if any DDoS protection plan exists in the resource group

```ruby
describe azure_ddos_protection_resources(resource_group: 'RESOURCE_GROUP') do
  it { should exist }
end
```

## Matchers

{{< readfile file="content/inspec/reusable/md/inspec_matchers_link.md" >}}

This resource has the following special matchers.

### exists

```ruby
# Should not exist if no bastion hots are in the resource group.

describe azure_ddos_protection_resources(resource_group: 'RESOURCE_GROUP') do
  it { should_not exist }
end
```

## Azure Permissions

{{% inspec-azure/azure_permissions_service_principal role="contributor" %}}
