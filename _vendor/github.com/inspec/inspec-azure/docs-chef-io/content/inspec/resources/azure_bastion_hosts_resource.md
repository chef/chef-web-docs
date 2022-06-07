+++
title = "azure_bastion_hosts_resource Resource"
platform = "azure"
draft = false
gh_repo = "inspec-azure"

[menu.inspec]
title = "azure_bastion_hosts_resource"
identifier = "inspec/resources/azure/azure_bastion_hosts_resource Resource"
parent = "inspec/resources/azure"
+++

Use the `azure_bastion_hosts_resource` InSpec audit resource to test properties related to a bastion hosts resource.

## Azure REST API Version, Endpoint, and HTTP Client Parameters

{{% inspec_azure_common_parameters %}}

## Installation

{{% inspec_azure_install %}}

## Syntax

`resource_group` and bastion hosts resource `name` or the `resource_id` must be given as a parameter.
```ruby
describe azure_bastion_hosts_resource(resource_group: 'MyResourceGroup', name: 'bastion_name') do
  it { should exist }
end
```

## Parameters

`resource_group`
: Azure resource group that the targeted resource resides in. `MyResourceGroup`.

`name`
: Name of the virtual network to test. `MyVNetwork`.

Both of the parameter sets should be provided for a valid query:
- `resource_group` and `name`


## Properties

`name`
: Name of the Azure resource to test. `MyBastionHostName`.

`tags`
: A list of `tag:value` pairs defined on the resources.

`type`
: type of BastionHostName.

`provisioning_state`
: State of BastionHostName creation.

Also, refer to [Azure documentation](https://docs.microsoft.com/en-us/rest/api/virtualnetwork/bastion-hosts/get) for other properties available. 
Any attribute in the response may be accessed with the key names separated by dots (`.`).

## Examples

**Ensure that the bastion hosts resource has is from same type.**

```ruby
describe azure_bastion_hosts_resource(resource_group: 'MyResourceGroup', name: 'bastion_name') do
  its('type') { should eq 'Microsoft.Network/bastionHosts' }
end
```
**Ensure that the bastion hosts resource is in successful state.**

```ruby
describe azure_bastion_hosts_resource(resource_group: 'MyResourceGroup', name: 'bastion_name') do
  its('provisioning_state') { should include('Succeeded') }
end
```

**Ensure that the bastion hosts resource is from same location.**

```ruby
describe azure_bastion_hosts_resource(resource_group: 'MyResourceGroup', name: 'bastion_name') do
  its('location') { should include df_location }
end
```

## Matchers

This InSpec audit resource has the following special matchers. For a full list of available matchers, please visit our [Universal Matchers page](/inspec/matchers/).

### exists

```ruby
# If a bastion hosts resource is found it will exist

describe azure_bastion_hosts_resource(resource_group: 'MyResourceGroup', name: 'MyBastionHostName') do
  it { should exist }
end

# bastion hosts resources that aren't found will not exist
describe azure_bastion_hosts_resource(resource_group: 'MyResourceGroup', name: 'DoesNotExist') do
  it { should_not exist }
end
```

## Azure Permissions

{{% azure_permissions_service_principal role="contributor" %}}
